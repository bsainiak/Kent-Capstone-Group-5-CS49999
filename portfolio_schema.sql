-- Photography Portfolio Database
-- Generated from ERD

CREATE DATABASE IF NOT EXISTS photography_portfolio;
USE photography_portfolio;

-- --------------------------------------------------------
-- Users
-- --------------------------------------------------------
CREATE TABLE Users (
    UserID      INTEGER         NOT NULL AUTO_INCREMENT,
    UserName    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (UserID),
    UNIQUE KEY uq_UserName (UserName)
);

-- --------------------------------------------------------
-- Transactions
-- (separated from Orders as a one-to-one log table)
-- --------------------------------------------------------
CREATE TABLE Transactions (
    TransactionID           INTEGER         NOT NULL AUTO_INCREMENT,
    TransactionRequest      CHAR(255)       NOT NULL,
    TransactionConfirmation CHAR(255)       NOT NULL,
    TransactionTime         DATETIME        NOT NULL,
    TransactionAmount       DECIMAL(5,2)    NOT NULL,
    PRIMARY KEY (TransactionID),
    UNIQUE KEY uq_TransactionID (TransactionID)
);

-- --------------------------------------------------------
-- Event
-- --------------------------------------------------------
CREATE TABLE Event (
    EventID     INTEGER         NOT NULL AUTO_INCREMENT,
    Series      ENUM('HSR', 'IMSA', 'SRO', 'SVRA', 'Trans-AM') NOT NULL,
    Date        DATETIME        NOT NULL,
    Location    VARCHAR(255)    NOT NULL,
    PRIMARY KEY (EventID)
);

-- --------------------------------------------------------
-- Images
-- --------------------------------------------------------
CREATE TABLE Images (
    ImageID     INTEGER         NOT NULL AUTO_INCREMENT,
    EventID     INTEGER         NOT NULL,
    FilePath    VARCHAR(255)    NOT NULL,
    Checksum    BINARY(64)      NOT NULL,
    Cost        DECIMAL(5,2)    NOT NULL,
    PRIMARY KEY (ImageID),
    UNIQUE KEY uq_FilePath (FilePath),
    CONSTRAINT fk_Images_Event
        FOREIGN KEY (EventID) REFERENCES Event(EventID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- Subject
-- --------------------------------------------------------
CREATE TABLE Subject (
    SubjectID   INTEGER         NOT NULL AUTO_INCREMENT,
    Team        VARCHAR(255),
    Driver      VARCHAR(255),
    Car         VARCHAR(255),
    PRIMARY KEY (SubjectID)
);

-- --------------------------------------------------------
-- PhotoSubjects (junction table: Images <-> Subject)
-- --------------------------------------------------------
CREATE TABLE PhotoSubjects (
    ImageID     INTEGER         NOT NULL,
    SubjectID   INTEGER         NOT NULL,
    Role        TEXT,
    PRIMARY KEY (ImageID, SubjectID),
    CONSTRAINT fk_PhotoSubjects_Image
        FOREIGN KEY (ImageID) REFERENCES Images(ImageID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_PhotoSubjects_Subject
        FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------
-- Orders
-- --------------------------------------------------------
CREATE TABLE Orders (
    OrderID         INTEGER     NOT NULL AUTO_INCREMENT,
    OrderDate       DATE        NOT NULL,
    TransactionID   INTEGER     NOT NULL,
    UserID          INTEGER     NOT NULL,
    ImageID         INTEGER     NOT NULL,
    PRIMARY KEY (OrderID),
    UNIQUE KEY uq_TransactionID (TransactionID),   -- enforces one-to-one with Transactions
    CONSTRAINT fk_Orders_Transaction
        FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Orders_User
        FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Orders_Image
        FOREIGN KEY (ImageID) REFERENCES Images(ImageID)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
