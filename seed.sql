-- basic table for sql lite
CREATE TABLE IF NOT EXISTS Event (
    EventID  INTEGER PRIMARY KEY AUTOINCREMENT,
    Series   TEXT NOT NULL,
    Date     DATETIME NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Images (
    ImageID  INTEGER PRIMARY KEY AUTOINCREMENT,
    EventID  INTEGER NOT NULL,
    FilePath VARCHAR(255) NOT NULL,
    Checksum BINARY(64), 
    Cost     DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

-- test data not final
INSERT INTO Event (Series, Date, Location) 
VALUES ('IMSA', '2025-09-01', 'Daytona International Speedway');

INSERT INTO Images (EventID, FilePath, Cost) 
VALUES (1, 'images/_DSC5696.jpg', 10.00),
       (1, 'images/_DSC5700.jpg', 15.00),
       (1, 'images/_DSC5701.jpg', 20.00);