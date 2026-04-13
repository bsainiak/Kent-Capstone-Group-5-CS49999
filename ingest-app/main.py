import os
import sys
import sqlite3
import hashlib
from pathlib import Path
from PyQt5.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QListWidget, QListWidgetItem, QLabel, QFileDialog,
    QMessageBox, QProgressBar, QLineEdit, QComboBox,
    QFormLayout, QScrollArea, QFrame, QToolButton, QDialog, QDialogButtonBox
)
from PyQt5.QtCore import Qt, QThread, pyqtSignal
from PIL import Image, ImageDraw, TiffImagePlugin
import rawpy


SERIES_OPTIONS = ('HSR', 'IMSA', 'SRO', 'SVRA', 'Trans-AM')


class CollapsibleSection(QFrame):
    """A collapsible section with a header and content area."""
    def __init__(self, title, parent=None):
        super().__init__(parent)
        self.setFrameShape(QFrame.StyledPanel)

        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(0)

        # Header with toggle arrow
        header_layout = QHBoxLayout()
        header_layout.setContentsMargins(4, 2, 4, 2)

        self.toggle_btn = QToolButton()
        self.toggle_btn.setText(title)
        self.toggle_btn.setCheckable(True)
        self.toggle_btn.setChecked(False)
        self.toggle_btn.setToolButtonStyle(Qt.ToolButtonTextBesideIcon)
        self.toggle_btn.setArrowType(Qt.RightArrow)
        self.toggle_btn.setStyleSheet("QToolButton { border: none; font-weight: bold; font-size: 13px; }")
        self.toggle_btn.clicked.connect(self.toggle)
        header_layout.addWidget(self.toggle_btn)
        header_layout.addStretch()

        layout.addLayout(header_layout)

        # Content area
        self.content = QWidget()
        self.content.setVisible(False)
        layout.addWidget(self.content)

    def toggle(self):
        checked = self.toggle_btn.isChecked()
        self.content.setVisible(checked)
        self.toggle_btn.setArrowType(Qt.DownArrow if checked else Qt.RightArrow)

    def setContentLayout(self, layout):
        self.content.setLayout(layout)


class SubjectRoleDialog(QDialog):
    """Popup dialog to select a subject and enter a role."""
    def __init__(self, subjects, parent=None):
        super().__init__(parent)
        self.setWindowTitle("Add Subject")
        self.setModal(True)
        self.resize(300, 140)

        layout = QFormLayout(self)

        self.subject_combo = QComboBox()
        for sid, team, driver, car, desc in subjects:
            parts = []
            if team:
                parts.append(team)
            if car:
                parts.append(car)
            info = f" ({', '.join(parts)})" if parts else ""
            label = f"{driver or 'Unnamed'}{info}"
            self.subject_combo.addItem(label, sid)
        layout.addRow("Subject:", self.subject_combo)

        self.role_input = QLineEdit()
        self.role_input.setPlaceholderText("Role description")
        layout.addRow("Role:", self.role_input)

        buttons = QDialogButtonBox(QDialogButtonBox.Ok | QDialogButtonBox.Cancel)
        buttons.accepted.connect(self.accept)
        buttons.rejected.connect(self.reject)
        layout.addRow("", buttons)

    def get_result(self):
        """Returns (subject_id, role_text) or None."""
        if self.exec_() == QDialog.Accepted:
            sid = self.subject_combo.currentData()
            role = self.role_input.text().strip()
            return (sid, role or None)
        return None


class DatabaseManager:
    def __init__(self, db_path):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.execute("PRAGMA foreign_keys = ON")

    def initialize(self, sql_file_path):
        """Run the generate.sql script to create tables if they don't exist."""
        sql_path = Path(sql_file_path)
        if not sql_path.exists():
            return
        with open(sql_path, 'r') as f:
            sql = f.read()
        self.conn.executescript(sql)
        self.conn.commit()

    def add_event(self, name, series, date, location):
        """Insert a new event and return its EventID."""
        cursor = self.conn.execute(
            "INSERT INTO Events (EventName, Series, EventDate, Location) VALUES (?, ?, ?, ?)",
            (name, series, date, location)
        )
        self.conn.commit()
        return cursor.lastrowid

    def list_events(self):
        """Return list of (EventID, EventName, Series, EventDate, Location)."""
        return self.conn.execute(
            "SELECT EventID, EventName, Series, EventDate, Location FROM Events ORDER BY EventDate DESC"
        ).fetchall()

    def add_subject(self, team_name, driver_name, car_type, description):
        """Insert a new subject and return its SubjectID."""
        cursor = self.conn.execute(
            "INSERT INTO Subjects (TeamName, DriverName, CarType, Description) VALUES (?, ?, ?, ?)",
            (team_name, driver_name, car_type, description)
        )
        self.conn.commit()
        return cursor.lastrowid

    def list_subjects(self):
        """Return list of (SubjectID, TeamName, DriverName, CarType, Description)."""
        return self.conn.execute(
            "SELECT SubjectID, TeamName, DriverName, CarType, Description FROM Subjects ORDER BY SubjectID"
        ).fetchall()

    def close(self):
        self.conn.close()


class ConvertWorker(QThread):
    progress = pyqtSignal(int, str)
    finished = pyqtSignal(int, int)

    def __init__(self, files, output_dir, archive_dir, metadata=None):
        super().__init__()
        self.files = files
        self.output_dir = output_dir
        self.archive_dir = archive_dir
        self.metadata = metadata or {}
        logo_path = Path(__file__).parent / "logo.png"
        if logo_path.exists():
            self.logo = Image.open(logo_path).convert("RGBA")
        else:
            self.logo = None

    def apply_logo(self, img):
        """Paste logo at bottom-right corner with 10px padding."""
        if self.logo is None:
            return img
        img = img.convert("RGBA")
        # Scale logo to 15% of image width
        logo_ratio = 0.15 * img.width / self.logo.width
        logo = self.logo.resize(
            (int(self.logo.width * logo_ratio), int(self.logo.height * logo_ratio)),
            Image.LANCZOS
        )
        # Position: bottom-right with 10px padding
        x = img.width - logo.width - 10
        y = img.height - logo.height - 10
        img.paste(logo, (x, y), logo)
        return img

    def apply_watermark(self, img, spacing=80, line_width=2, opacity=15):
        """Apply diagonal X-pattern watermark with transparent lines."""
        img = img.convert("RGBA")
        overlay = Image.new("RGBA", img.size, (0, 0, 0, 0))
        draw = ImageDraw.Draw(overlay)

        w, h = img.size
        diagonal = int((w**2 + h**2)**0.5)

        # Draw diagonal lines in both directions
        for i in range(-diagonal, diagonal, spacing):
            # Top-left to bottom-right
            draw.line([(i, 0), (i + diagonal, diagonal)], fill=(255, 255, 255, opacity), width=line_width)
            # Bottom-left to top-right
            draw.line([(i, diagonal), (i + diagonal, 0)], fill=(255, 255, 255, opacity), width=line_width)

        return Image.alpha_composite(img, overlay)

    def run(self):
        success = 0
        failed = 0
        total = len(self.files)

        for i, file_path in enumerate(self.files):
            try:
                self.progress.emit(i, f"Converting: {Path(file_path).name}")
                orig_stem = Path(file_path).stem
                ext = Path(file_path).suffix.lower()

                # Use renamed stem from metadata if available
                meta = self.metadata.get(file_path, {})
                rename = meta.get("rename", "").strip()
                stem = rename if rename else orig_stem

                if ext in ('.jpg', '.jpeg'):
                    # JPG input - pass through with metadata
                    img = Image.open(file_path)
                    source_exif = img.getexif()
                else:
                    # RAW input - develop to full-resolution image
                    with rawpy.imread(file_path) as raw:
                        rgb = raw.postprocess(
                            use_camera_wb=True,
                            half_size=False,
                            no_auto_bright=False,
                            output_bps=8
                        )
                    img = Image.fromarray(rgb)
                    source_exif = None

                # Save TIFF to archive at original size with EXIF as TIFF tags (use original stem)
                tiff_path = self.archive_dir / f"{orig_stem}.tiff"
                tiff_tags = TiffImagePlugin.ImageFileDirectory_v2()
                if source_exif:
                    for tag_id, value in source_exif.items():
                        try:
                            # EXIF keys can be ExifTag enums, convert to int
                            tiff_tags[int(tag_id)] = value
                        except Exception:
                            pass
                img.save(tiff_path, format="TIFF", tiffinfo=tiff_tags)

                # Save JPG at original size with metadata and logo
                img_with_logo = self.apply_logo(img)
                jpg_path = self.output_dir / f"{stem}.jpg"
                save_kwargs = {"format": "JPEG", "quality": 100}
                if source_exif:
                    save_kwargs["exif"] = source_exif.tobytes()
                # Convert to RGB for JPEG
                img_for_jpg = img_with_logo.convert("RGB")
                img_for_jpg.save(jpg_path, **save_kwargs)

                # Scale longest edge to 800px with BICUBIC resampling for AVIF
                w, h = img.size
                if max(w, h) > 800:
                    ratio = 800 / max(w, h)
                    new_w = int(w * ratio)
                    new_h = int(h * ratio)
                    img = img.resize((new_w, new_h), Image.BICUBIC)

                # Apply logo to scaled image for AVIF
                img_scaled_with_logo = self.apply_logo(img)
                # Apply X-pattern watermark
                img_watermarked = self.apply_watermark(img_scaled_with_logo)
                avif_path = self.output_dir / f"{stem}.avif"
                img_watermarked.save(avif_path, format="AVIF", quality=45)
                success += 1
            except Exception as e:
                print(f"Failed to convert {file_path}: {e}")
                failed += 1

        self.finished.emit(success, failed)


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Image Converter")
        self.resize(900, 500)

        self.base_dir = Path(__file__).parent
        self.photos_dir = self.base_dir / "photos"
        self.photos_dir.mkdir(exist_ok=True)
        self.archive_dir = self.base_dir / "archive"
        self.archive_dir.mkdir(exist_ok=True)

        # Initialize database
        sql_path = self.base_dir / "generate.sql"
        self.db_path = self.base_dir / "metadata.db"
        self.db = DatabaseManager(self.db_path)
        self.db.initialize(sql_path)

        self.selected_files = []

        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        main_layout = QHBoxLayout(central_widget)

        # Left panel - file list and controls
        left_panel = QWidget()
        left_layout = QVBoxLayout(left_panel)

        self.file_list = QListWidget()
        self.file_list.currentItemChanged.connect(self.on_file_selected)
        left_layout.addWidget(self.file_list)

        btn_layout = QHBoxLayout()
        self.add_btn = QPushButton("Add Image Files")
        self.add_btn.clicked.connect(self.add_files)
        btn_layout.addWidget(self.add_btn)
        self.remove_btn = QPushButton("Remove Selected")
        self.remove_btn.clicked.connect(self.remove_selected)
        btn_layout.addWidget(self.remove_btn)
        self.clear_btn = QPushButton("Clear All")
        self.clear_btn.clicked.connect(self.clear_all)
        btn_layout.addWidget(self.clear_btn)
        left_layout.addLayout(btn_layout)

        self.convert_btn = QPushButton("Convert Format")
        self.convert_btn.clicked.connect(self.start_conversion)
        self.convert_btn.setStyleSheet(
            "QPushButton { background-color: #9E9E9E; color: white; font-weight: bold; padding: 8px; }"
            "QPushButton:hover { background-color: #757575; }"
        )
        left_layout.addWidget(self.convert_btn)

        self.full_btn = QPushButton("Convert & Generate SQL")
        self.full_btn.clicked.connect(self.start_full_process)
        self.full_btn.setStyleSheet(
            "QPushButton { background-color: #4CAF50; color: white; font-weight: bold; padding: 8px; }"
            "QPushButton:hover { background-color: #45a049; }"
        )
        left_layout.addWidget(self.full_btn)

        self.progress_bar = QProgressBar()
        self.progress_bar.setVisible(False)
        left_layout.addWidget(self.progress_bar)

        self.status_label = QLabel("")
        left_layout.addWidget(self.status_label)

        # Right panel - sidebar
        sidebar = QWidget()
        sidebar.setMinimumWidth(380)
        sidebar.setMaximumWidth(380)
        sidebar_layout = QVBoxLayout(sidebar)
        sidebar_layout.setAlignment(Qt.AlignTop)

        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QScrollArea.NoFrame)
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)
        scroll_layout.setAlignment(Qt.AlignTop)

        # === Events Section ===
        events_section = CollapsibleSection("Events")
        events_layout = QFormLayout()
        events_layout.setContentsMargins(8, 4, 8, 8)

        self.event_name_input = QLineEdit()
        self.event_name_input.setPlaceholderText("Event name")
        events_layout.addRow("Name:", self.event_name_input)

        self.event_series_combo = QComboBox()
        self.event_series_combo.addItems(SERIES_OPTIONS)
        events_layout.addRow("Series:", self.event_series_combo)

        self.event_date_input = QLineEdit()
        self.event_date_input.setPlaceholderText("YYYY-MM-DD")
        events_layout.addRow("Date:", self.event_date_input)

        self.event_location_input = QLineEdit()
        self.event_location_input.setPlaceholderText("Location")
        events_layout.addRow("Location:", self.event_location_input)

        self.add_event_btn = QPushButton("Add Event")
        self.add_event_btn.clicked.connect(self.add_event)
        events_layout.addRow("", self.add_event_btn)

        events_layout.addRow(QLabel("Existing Events:"))
        self.events_list = QComboBox()
        self.events_list.addItem("-- select --")
        self.refresh_events_list()
        events_layout.addRow(self.events_list)

        events_section.setContentLayout(events_layout)
        scroll_layout.addWidget(events_section)

        # === Subjects Section ===
        subjects_section = CollapsibleSection("Subjects")
        subjects_layout = QFormLayout()
        subjects_layout.setContentsMargins(8, 4, 8, 8)

        self.subject_team_input = QLineEdit()
        self.subject_team_input.setPlaceholderText("Team name")
        subjects_layout.addRow("Team:", self.subject_team_input)

        self.subject_driver_input = QLineEdit()
        self.subject_driver_input.setPlaceholderText("Driver name")
        subjects_layout.addRow("Driver:", self.subject_driver_input)

        self.subject_car_input = QLineEdit()
        self.subject_car_input.setPlaceholderText("Car type")
        subjects_layout.addRow("Car:", self.subject_car_input)

        self.subject_desc_input = QLineEdit()
        self.subject_desc_input.setPlaceholderText("Description")
        subjects_layout.addRow("Desc:", self.subject_desc_input)

        self.add_subject_btn = QPushButton("Add Subject")
        self.add_subject_btn.clicked.connect(self.add_subject)
        subjects_layout.addRow("", self.add_subject_btn)

        subjects_layout.addRow(QLabel("Existing Subjects:"))
        self.subjects_list = QComboBox()
        self.subjects_list.addItem("-- select --")
        self.refresh_subjects_list()
        subjects_layout.addRow(self.subjects_list)

        subjects_section.setContentLayout(subjects_layout)
        scroll_layout.addWidget(subjects_section)

        # === Image Metadata Section ===
        self.image_meta_section = CollapsibleSection("Image Metadata")
        meta_layout = QVBoxLayout()
        meta_layout.setContentsMargins(8, 4, 8, 8)
        meta_layout.setSpacing(6)

        self.image_meta_filename = QLabel("No image selected")
        self.image_meta_filename.setWordWrap(True)
        self.image_meta_filename.setStyleSheet("font-style: italic; color: gray;")
        meta_layout.addWidget(self.image_meta_filename)

        meta_form = QFormLayout()
        meta_form.setContentsMargins(0, 4, 0, 4)
        meta_form.setSpacing(4)

        self.meta_rename_input = QLineEdit()
        self.meta_rename_input.setPlaceholderText("New filename (no extension)")
        self.meta_rename_input.textChanged.connect(self._save_meta_rename)
        meta_form.addRow("Rename:", self.meta_rename_input)

        self.meta_cost_input = QLineEdit()
        self.meta_cost_input.setPlaceholderText("0.00")
        self.meta_cost_input.textChanged.connect(self._save_meta_cost)
        meta_form.addRow("Cost:", self.meta_cost_input)

        self.meta_event_combo = QComboBox()
        self.meta_event_combo.addItem("-- none --", None)
        self.meta_event_combo.currentIndexChanged.connect(self._save_meta_event)
        meta_form.addRow("Event:", self.meta_event_combo)

        meta_layout.addLayout(meta_form)

        # Subjects row
        subjects_header = QHBoxLayout()
        subjects_label = QLabel("Subjects:")
        subjects_label.setStyleSheet("font-weight: bold;")
        subjects_header.addWidget(subjects_label)
        subjects_header.addStretch()

        self.meta_add_subject_btn = QPushButton("Add")
        self.meta_add_subject_btn.setMaximumWidth(50)
        self.meta_add_subject_btn.clicked.connect(self.meta_add_subject)
        subjects_header.addWidget(self.meta_add_subject_btn)

        self.meta_remove_subject_btn = QPushButton("Remove")
        self.meta_remove_subject_btn.setMaximumWidth(70)
        self.meta_remove_subject_btn.clicked.connect(self.meta_remove_subject)
        subjects_header.addWidget(self.meta_remove_subject_btn)
        meta_layout.addLayout(subjects_header)

        self.meta_subjects_list = QListWidget()
        self.meta_subjects_list.setMaximumHeight(100)
        meta_layout.addWidget(self.meta_subjects_list)

        self.image_meta_section.setContentLayout(meta_layout)
        scroll_layout.addWidget(self.image_meta_section)

        # Track per-image metadata
        self.image_metadata = {}
        self.current_file = None

        # Track new events and subjects added during session for SQL generation on close
        self.new_events = []  # list of (eid, name, series, date, location)
        self.new_subjects = []  # list of (sid, team, driver, car, desc)

        scroll_layout.addStretch()
        scroll.setWidget(scroll_widget)
        sidebar_layout.addWidget(scroll)

        main_layout.addWidget(left_panel, 1)
        main_layout.addWidget(sidebar)

    def refresh_events_list(self):
        """Populate the events dropdown from the database."""
        current = self.events_list.currentText()
        self.events_list.clear()
        self.events_list.addItem("-- select --")
        for eid, name, series, date, location in self.db.list_events():
            label = f"{name} ({series}, {date or 'no date'})" if name else f"{series} ({date or 'no date'})"
            self.events_list.addItem(label, eid)
        idx = self.events_list.findText(current)
        if idx >= 0:
            self.events_list.setCurrentIndex(idx)

    def add_event(self):
        name = self.event_name_input.text().strip()
        series = self.event_series_combo.currentText()
        date = self.event_date_input.text().strip()
        location = self.event_location_input.text().strip()

        if not name and not location and not date:
            QMessageBox.warning(self, "Missing Info", "Please enter at least a name or location for the event.")
            return

        eid = self.db.add_event(name or None, series, date or None, location or None)
        self.new_events.append((eid, name or None, series, date or None, location or None))
        self.refresh_events_list()
        self.event_name_input.clear()
        self.event_date_input.clear()
        self.event_location_input.clear()
        QMessageBox.information(self, "Event Added", f"Event added (ID: {eid}).")

    def refresh_subjects_list(self):
        """Populate the subjects dropdown from the database."""
        current = self.subjects_list.currentText()
        self.subjects_list.clear()
        self.subjects_list.addItem("-- select --")
        for sid, team, driver, car, desc in self.db.list_subjects():
            parts = []
            if team:
                parts.append(team)
            if car:
                parts.append(car)
            info = f" ({', '.join(parts)})" if parts else ""
            label = f"{driver or 'Unnamed'}{info}"
            self.subjects_list.addItem(label, sid)
        idx = self.subjects_list.findText(current)
        if idx >= 0:
            self.subjects_list.setCurrentIndex(idx)

    def add_subject(self):
        team = self.subject_team_input.text().strip()
        driver = self.subject_driver_input.text().strip()
        car = self.subject_car_input.text().strip()
        desc = self.subject_desc_input.text().strip()

        if not team and not driver and not car and not desc:
            QMessageBox.warning(self, "Missing Info", "Please enter at least one field for the subject.")
            return

        sid = self.db.add_subject(team or None, driver or None, car or None, desc or None)
        self.new_subjects.append((sid, team or None, driver or None, car or None, desc or None))
        self.refresh_subjects_list()
        self.subject_team_input.clear()
        self.subject_driver_input.clear()
        self.subject_car_input.clear()
        self.subject_desc_input.clear()
        QMessageBox.information(self, "Subject Added", f"Subject added (ID: {sid}).")

    def on_file_selected(self, current, previous):
        """Called when a file is selected in the list."""
        if current is None:
            self.current_file = None
            self._clear_meta_form()
            return

        filepath = current.data(Qt.UserRole) or current.text()
        # Find full path from selected_files
        for f in self.selected_files:
            if Path(f).name == current.text():
                filepath = f
                break

        self.current_file = filepath
        self.image_meta_filename.setText(Path(filepath).name)

        # Load existing metadata or init
        if filepath not in self.image_metadata:
            self.image_metadata[filepath] = {
                "rename": "",
                "cost": "",
                "event_id": None,
                "subjects": []  # list of (subject_id, role) tuples
            }
        data = self.image_metadata[filepath]

        # Populate form
        self.meta_rename_input.setText(data["rename"])
        self.meta_cost_input.setText(data["cost"])

        # Refresh events combo
        self.refresh_meta_events(data["event_id"])

        # Refresh subjects list
        self.refresh_meta_subjects()

    def refresh_meta_events(self, selected_eid=None):
        """Populate the event dropdown in the image metadata section."""
        current_text = self.meta_event_combo.currentText()
        self.meta_event_combo.clear()
        self.meta_event_combo.addItem("-- none --", None)
        for eid, name, series, date, location in self.db.list_events():
            label = f"{name} ({series}, {date or 'no date'})" if name else f"{series} ({date or 'no date'})"
            self.meta_event_combo.addItem(label, eid)
        # Select saved event
        if selected_eid is not None:
            for i in range(self.meta_event_combo.count()):
                if self.meta_event_combo.itemData(i) == selected_eid:
                    self.meta_event_combo.setCurrentIndex(i)
                    break

    def refresh_meta_subjects(self):
        """Populate the subjects list widget for the current image."""
        if self.current_file is None:
            return
        data = self.image_metadata.get(self.current_file, {})
        subjects = data.get("subjects", [])
        self.meta_subjects_list.clear()
        all_subjects = self.db.list_subjects()
        subject_map = {sid: (team, driver, car) for sid, team, driver, car, desc in all_subjects}

        for sid, role in subjects:
            info = subject_map.get(sid)
            if info:
                team, driver, car = info
                parts = []
                if team:
                    parts.append(team)
                if car:
                    parts.append(car)
                info_str = f" ({', '.join(parts)})" if parts else ""
                label = f"{driver or 'Subject'}{info_str}"
            else:
                label = f"Subject #{sid}"
            role_str = f" — {role}" if role else ""
            item = QListWidgetItem(f"{label}{role_str}")
            item.setData(Qt.UserRole, (sid, role))
            self.meta_subjects_list.addItem(item)

    def meta_add_subject(self):
        """Open dialog to add a subject-role pair to the current image."""
        if self.current_file is None:
            QMessageBox.warning(self, "No Image", "Select an image first.")
            return

        all_subjects = self.db.list_subjects()
        if not all_subjects:
            QMessageBox.information(self, "No Subjects", "Add subjects first in the Subjects section.")
            return

        dialog = SubjectRoleDialog(all_subjects, self)
        result = dialog.get_result()
        if result:
            sid, role = result
            data = self.image_metadata[self.current_file]
            # Don't add duplicates
            if not any(s == sid for s, r in data["subjects"]):
                data["subjects"].append((sid, role))
                self.refresh_meta_subjects()

    def meta_remove_subject(self):
        """Remove the selected subject-role pair from the current image."""
        selected = self.meta_subjects_list.selectedItems()
        if not selected:
            return
        if self.current_file is None:
            return

        row = self.meta_subjects_list.row(selected[0])
        data = self.image_metadata[self.current_file]
        data["subjects"].pop(row)
        self.meta_subjects_list.takeItem(row)

    def _save_meta_rename(self, text):
        if self.current_file and self.current_file in self.image_metadata:
            self.image_metadata[self.current_file]["rename"] = text.strip()

    def _save_meta_cost(self, text):
        if self.current_file and self.current_file in self.image_metadata:
            self.image_metadata[self.current_file]["cost"] = text.strip()

    def _save_meta_event(self, index):
        if self.current_file and self.current_file in self.image_metadata:
            eid = self.meta_event_combo.itemData(index)
            self.image_metadata[self.current_file]["event_id"] = eid

    def _clear_meta_form(self):
        """Clear the image metadata form."""
        self.image_meta_filename.setText("No image selected")
        self.image_meta_filename.setStyleSheet("font-style: italic; color: gray;")
        self.meta_rename_input.clear()
        self.meta_cost_input.clear()
        self.meta_event_combo.clear()
        self.meta_event_combo.addItem("-- none --", None)
        self.meta_subjects_list.clear()

    def add_files(self):
        files, _ = QFileDialog.getOpenFileNames(
            self, "Select JPG or RAW Files", "",
            "Image Files (*.jpg *.jpeg *.cr2 *.cr3 *.nef *.arw *.raf *.dng *.orf *.rw2 *.pef *.srw *.erf)"
        )
        for f in files:
            if f not in self.selected_files:
                self.selected_files.append(f)
                item = QListWidgetItem(Path(f).name)
                item.setData(Qt.UserRole, f)
                self.file_list.addItem(item)

    def remove_selected(self):
        selected = self.file_list.selectedItems()
        for item in sorted(selected, key=lambda i: self.file_list.row(i), reverse=True):
            row = self.file_list.row(item)
            filepath = item.data(Qt.UserRole)
            self.file_list.takeItem(row)
            self.selected_files.pop(row)
            self.image_metadata.pop(filepath, None)
            if filepath == self.current_file:
                self.current_file = None
                self._clear_meta_form()

    def clear_all(self):
        self.file_list.clear()
        self.selected_files.clear()
        self.image_metadata.clear()
        self.current_file = None
        self._clear_meta_form()

    def start_conversion(self):
        if not self.selected_files:
            QMessageBox.warning(self, "No Files", "Please add files to convert.")
            return

        self.convert_btn.setEnabled(False)
        self.add_btn.setEnabled(False)
        self.progress_bar.setVisible(True)
        self.progress_bar.setMaximum(0)
        self.status_label.setText("Converting...")

        self.worker = ConvertWorker(self.selected_files, self.photos_dir, self.archive_dir, self.image_metadata)
        self.worker.progress.connect(self.update_progress)
        self.worker.finished.connect(self.on_finished)
        self.worker.start()

    def start_full_process(self):
        """Convert files AND generate SQL load script."""
        if not self.selected_files:
            QMessageBox.warning(self, "No Files", "Please add files to convert.")
            return

        self.convert_btn.setEnabled(False)
        self.full_btn.setEnabled(False)
        self.add_btn.setEnabled(False)
        self.progress_bar.setVisible(True)
        self.progress_bar.setMaximum(0)
        self.status_label.setText("Converting...")

        self.worker = ConvertWorker(self.selected_files, self.photos_dir, self.archive_dir, self.image_metadata)
        self.worker.progress.connect(self.update_progress)
        self.worker.finished.connect(self.on_full_finished)
        self.worker.start()

    def on_full_finished(self, success, failed):
        """Called when conversion is done, then generate SQL."""
        self.progress_bar.setVisible(False)
        self.convert_btn.setEnabled(True)
        self.full_btn.setEnabled(True)
        self.add_btn.setEnabled(True)

        self.status_label.setText("Generating SQL...")
        sql_path = self.generate_sql()

        self.status_label.setText(f"Done: {success} succeeded, {failed} failed.")
        QMessageBox.information(
            self, "Complete",
            f"Successfully converted: {success}\nFailed: {failed}\n\n"
            f"JPG/AVIF saved to: {self.photos_dir}\n"
            f"TIFF saved to: {self.archive_dir}\n"
            f"SQL script saved to: {sql_path}"
        )

    def update_progress(self, current, filename):
        self.status_label.setText(f"{filename}")

    def on_finished(self, success, failed):
        self.progress_bar.setVisible(False)
        self.convert_btn.setEnabled(True)
        self.add_btn.setEnabled(True)
        self.status_label.setText(f"Done: {success} succeeded, {failed} failed. Saved to: {self.photos_dir}")
        QMessageBox.information(
            self, "Conversion Complete",
            f"Successfully converted: {success}\nFailed: {failed}\n\nJPG/AVIF saved to: {self.photos_dir}\nTIFF saved to: {self.archive_dir}"
        )

    def generate_load_events_sql(self):
        """Generate a SQL load script for new events added during this session."""
        if not self.new_events:
            return None

        lines = []
        lines.append("-- Auto-generated load script for new events")
        lines.append(f"-- Generated: {self._now()}")
        lines.append("")
        lines.append("PRAGMA foreign_keys = ON;")
        lines.append("")

        for eid, name, series, date, location in self.new_events:
            name_sql = f"'{name}'" if name else "NULL"
            date_sql = f"'{date}'" if date else "NULL"
            location_sql = f"'{location}'" if location else "NULL"
            lines.append(
                f"INSERT INTO Events (EventID, EventName, Series, EventDate, Location) "
                f"VALUES ({eid}, {name_sql}, '{series}', {date_sql}, {location_sql});"
            )

        sql_path = self.base_dir / "load_events.sql"
        sql_text = "\n".join(lines) + "\n"
        sql_path.write_text(sql_text)
        return sql_path

    def generate_load_subjects_sql(self):
        """Generate a SQL load script for new subjects added during this session."""
        if not self.new_subjects:
            return None

        lines = []
        lines.append("-- Auto-generated load script for new subjects")
        lines.append(f"-- Generated: {self._now()}")
        lines.append("")
        lines.append("PRAGMA foreign_keys = ON;")
        lines.append("")

        for sid, team, driver, car, desc in self.new_subjects:
            team_sql = f"'{team}'" if team else "NULL"
            driver_sql = f"'{driver}'" if driver else "NULL"
            car_sql = f"'{car}'" if car else "NULL"
            desc_sql = f"'{desc}'" if desc else "NULL"
            lines.append(
                f"INSERT INTO Subjects (SubjectID, TeamName, DriverName, CarType, Description) "
                f"VALUES ({sid}, {team_sql}, {driver_sql}, {car_sql}, {desc_sql});"
            )

        sql_path = self.base_dir / "load_subjects.sql"
        sql_text = "\n".join(lines) + "\n"
        sql_path.write_text(sql_text)
        return sql_path

    def generate_sql(self):
        """Generate a SQL load script from collected image metadata and run it on the local DB."""
        lines = []
        lines.append("-- Auto-generated load script")
        lines.append(f"-- Generated: {self._now()}")
        lines.append("")
        lines.append("PRAGMA foreign_keys = ON;")
        lines.append("")

        missing_events = []
        inserted_count = 0

        # Get next available ImageID
        result = self.db.conn.execute("SELECT COALESCE(MAX(ImageID), 0) FROM Images").fetchone()
        next_image_id = result[0] + 1 if result else 1

        for filepath in self.selected_files:
            meta = self.image_metadata.get(filepath, {})
            orig_stem = Path(filepath).stem
            name = meta.get("rename", "").strip() or orig_stem
            file_path = f"./images/photos/{name}"
            cost_str = meta.get("cost", "").strip()
            cost = float(cost_str) if cost_str else 0.0
            event_id = meta.get("event_id")

            # Use renamed name for checksum lookup
            jpg_path = self.photos_dir / f"{name}.jpg"
            checksum = b""
            if jpg_path.exists():
                checksum = hashlib.sha256(jpg_path.read_bytes()).digest()
            checksum_hex = checksum.hex()

            if event_id is None:
                missing_events.append(name)
                lines.append(f"-- WARNING: No event assigned for {name}")
                lines.append(f"-- INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES ({next_image_id}, NULL, '{file_path}', X'{checksum_hex}', {cost});")
                continue

            current_id = next_image_id
            lines.append(f"INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES ({current_id}, {event_id}, '{file_path}', X'{checksum_hex}', {cost});")

            for sid, role in meta.get("subjects", []):
                role_sql = f"'{role}'" if role else "NULL"
                lines.append(f"INSERT INTO PhotoSubjects (ImageID, SubjectID, RoleDescription) VALUES ({current_id}, {sid}, {role_sql});")

            next_image_id += 1
            inserted_count += 1
            lines.append("")

        sql_path = self.base_dir / "load.sql"
        sql_text = "\n".join(lines) + "\n"
        sql_path.write_text(sql_text)

        # Run the SQL script on the local database (skip warning/commented lines)
        runnable_lines = []
        for line in lines:
            if line.startswith("-- WARNING"):
                continue
            runnable_lines.append(line)
        runnable_sql = "\n".join(runnable_lines)
        if runnable_sql.strip():
            self.db.conn.executescript(runnable_sql)
            self.db.conn.commit()

        # Write log file if any images were skipped
        if missing_events:
            log_dir = self.base_dir / "log"
            log_dir.mkdir(exist_ok=True)
            log_path = log_dir / "missing_events.log"
            with open(log_path, "a") as f:
                f.write(f"[{self._now()}] The following images were not added to the database (no event assigned):\n")
                for name in missing_events:
                    f.write(f"  - {name}\n")
                f.write("\n")
            warning_msg = "\n".join(f"  - {n}" for n in missing_events)
            QMessageBox.warning(
                self, "Missing Events",
                f"{len(missing_events)} image(s) were not added to the database because no event was assigned:\n\n{warning_msg}\n\n"
                f"See: {log_path}"
            )

        return sql_path

    @staticmethod
    def _now():
        import datetime
        return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    def closeEvent(self, event):
        # Generate SQL load scripts for any new events or subjects added during this session
        events_path = self.generate_load_events_sql()
        subjects_path = self.generate_load_subjects_sql()

        if events_path:
            print(f"Events load script saved to: {events_path}")
        if subjects_path:
            print(f"Subjects load script saved to: {subjects_path}")

        self.db.close()
        event.accept()


def main():
    # Suppress Wayland focus request warnings
    os.environ["QT_LOGGING_RULES"] = "qt.qpa.wayland.warning=false"
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
