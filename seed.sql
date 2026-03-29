
-- basic table for sql lite
CREATE TABLE IF NOT EXISTS Event (
    EventID  INTEGER PRIMARY KEY AUTOINCREMENT,
    Series   TEXT NOT NULL,
    Date     DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

-- creates a database table
CREATE TABLE IF NOT EXISTS Images (
    ImageID  INTEGER PRIMARY KEY AUTOINCREMENT,
    EventID  INTEGER NOT NULL,
    FilePath VARCHAR(255) NOT NULL,
    Checksum BINARY(64), 
    Cost     DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- test data not final
-- gives photos values that can be searched for in the html
INSERT INTO Event (Series, Date, Location) 
VALUES ('Race Series 1', '2026-03-29', 'Location');

INSERT INTO Images (EventID, FilePath, Cost) 
VALUES (1, 'images/_DSC5696.jpg', 10.00),
       (1, 'images/_DSC5703.jpg', 15.00),
       (1, 'images/_DSC5719.jpg', 20.00);
