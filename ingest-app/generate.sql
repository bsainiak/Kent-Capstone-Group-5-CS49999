-- Generate Script for Local Database

PRAGMA foreign_keys = ON;

-- Events
CREATE TABLE IF NOT EXISTS Events(
    EventID INTEGER PRIMARY KEY,
    EventName TEXT,
    Series TEXT NOT NULL CHECK(Series IN ('HSR', 'IMSA', 'SRO', 'SVRA', 'Trans-AM')),
    EventDate TEXT,
    Location TEXT
);

-- Images
CREATE TABLE IF NOT EXISTS Images(
    ImageID INTEGER PRIMARY KEY,
    EventID INTEGER NOT NULL,
    FilePath TEXT NOT NULL UNIQUE,
    Checksum BLOB NOT NULL UNIQUE,
    Cost REAL NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Events(EventID)
);

-- Subjects
CREATE TABLE IF NOT EXISTS Subjects(
    SubjectID INTEGER PRIMARY KEY,
    TeamName TEXT,
    DriverName TEXT,
    CarType TEXT,
    Description TEXT
);

-- PhotoSubjects (junction table)
CREATE TABLE IF NOT EXISTS PhotoSubjects(
    ImageID INTEGER NOT NULL,
    SubjectID INTEGER NOT NULL,
    RoleDescription TEXT,
    PRIMARY KEY (ImageID, SubjectID),
    FOREIGN KEY (ImageID) REFERENCES Images(ImageID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);
