CREATE DATABASE RaceDay_PROG6212;
CREATE TABLE Users(
    UserID INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role NVARCHAR(30) NOT NULL
        CONSTRAINT CK_Users_Role
        CHECK (Role IN (N'Organiser', N'Participant', N'Admin')),
    CreatedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_Users_CreatedAt DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Users PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Email UNIQUE (Email)
);

CREATE TABLE EventTypes
(
    EventTypeID INT IDENTITY(1,1) NOT NULL,
    EventTypeName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,

    CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeID),
    CONSTRAINT UQ_EventTypes_EventTypeName UNIQUE (EventTypeName)
);


CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) NOT NULL,
    Organised INT NOT NULL,
    EventName VARCHAR(150) NOT NULL,
    EventType NVARCHAR(100) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(200) NOT NULL,
    CreatedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_Event_CreatedAt DEFAULT (SYSDATETIME()),
    Province NVARCHAR(50) NOT NULL,
    Status NVARCHAR(30) NOT NULL
        CONSTRAINT DF_Event_Status DEFAULT (N'Upcoming'),

    CONSTRAINT PK_Event PRIMARY KEY (EventID),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (Organised)
        REFERENCES dbo.Users(UserID),

    CONSTRAINT FK_Event_EventType
        FOREIGN KEY (EventType)
        REFERENCES EventTypes(EventTypeName),

    CONSTRAINT CK_Event_Status
        CHECK (Status IN (N'Upcoming', N'Open', N'Closed', N'Completed', N'Cancelled'))
);

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) NOT NULL,
    EventID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    MaxParticipant INT NULL,
    EntryFee DECIMAL(10,2) NOT NULL
        CONSTRAINT DF_Categories_EntryFee DEFAULT (0.00),

    CONSTRAINT PK_Categories PRIMARY KEY (CategoryID),

    CONSTRAINT FK_Categories_Event
        FOREIGN KEY (EventID)
        REFERENCES dbo.Event(EventID),

    CONSTRAINT UQ_Categories_Event_Name UNIQUE (EventID, Name),

    CONSTRAINT CK_Categories_DistanceKm
        CHECK (DistanceKm > 0),

    CONSTRAINT CK_Categories_MaxParticipant
        CHECK (MaxParticipant IS NULL OR MaxParticipant > 0),

    CONSTRAINT CK_Categories_EntryFee
        CHECK (EntryFee >= 0)
);

CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) NOT NULL,
    Enrolment INT NOT NULL,
    FinishTime TIME(0) NOT NULL,
    Position INT NOT NULL,
    RecordedAt DATETIME2(0) NOT NULL
        CONSTRAINT DF_Result_RecordedAt DEFAULT (SYSDATETIME()),

    CONSTRAINT PK_Result PRIMARY KEY (ResultID),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (Enrolment)
        REFERENCES Enrolments(EnrolmentID),

    CONSTRAINT UQ_Result_Enrolment UNIQUE (Enrolment),

    CONSTRAINT CK_Result_Position
        CHECK (Position > 0)
);

