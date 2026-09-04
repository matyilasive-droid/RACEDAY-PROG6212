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

INSERT INTO EventTypes (EventTypeName, Description)
VALUES
    (N'Road Race', N'Road-running events held on paved public or private roads.'),
    (N'Trail Run', N'Off-road running events held on natural trails and paths.'),
    (N'Fun Run', N'Community running events designed for recreational participation.');
GO


INSERT INTO Users
    (FirstName, LastName, Email, PasswordHash, Role)
VALUES
    (N'Lerato', N'Mokoena', 'lerato.mokoena@raceday.co.za',
     'HASHED_PASSWORD_ORGANISER_001', N'Organiser'),

    (N'Jason', N'Naidoo', 'jason.naidoo@raceday.co.za',
     'HASHED_PASSWORD_ORGANISER_002', N'Organiser'),

    (N'Nomsa', N'Dlamini', 'nomsa.dlamini@example.com',
     'HASHED_PASSWORD_PARTICIPANT_001', N'Participant'),

    (N'Thabo', N'Van Wyk', 'thabo.vanwyk@example.com',
     'HASHED_PASSWORD_PARTICIPANT_002', N'Participant');
GO

INSERT INTO Event
    (Organised, EventName, EventType, EventDate, Location, Province, Status)
VALUES
    (1, 'Johannesburg City 10K', N'Road Race',
     '2026-10-18', 'Mary Fitzgerald Square, Johannesburg',
     N'Gauteng', N'Open'),

    (2, 'Cape Winelands Trail Challenge', N'Trail Run',
     '2026-11-07', 'Paarl Mountain Nature Reserve, Paarl',
     N'Western Cape', N'Upcoming'),

    (1, 'Durban Beach Fun Run', N'Fun Run',
     '2026-12-06', 'Moses Mabhida Stadium, Durban',
     N'KwaZulu-Natal', N'Upcoming');
GO

INSERT INTO Categories
    (EventID, Name, DistanceKm, MaxParticipant, EntryFee)
VALUES
    (1, N'10 km Open', 10.00, 500, 180.00),
    (1, N'5 km Social Run', 5.00, 800, 100.00),

    (2, N'21 km Trail Challenge', 21.00, 300, 350.00),
    (2, N'10 km Trail Run', 10.00, 500, 220.00),

    (3, N'10 km Beach Run', 10.00, 600, 150.00),
    (3, N'5 km Family Fun Run', 5.00, 1000, 80.00);
GO

INSERT INTO Enrolments
    (UserID, CategoryID, EnrolmentDate, Status)
VALUES
    (3, 1, '2026-09-01 08:30:00', 'Confirmed'),
    (4, 1, '2026-09-01 09:15:00', 'Confirmed'),
    (3, 3, '2026-09-02 10:00:00', 'Registered'),
    (4, 4, '2026-09-02 10:30:00', 'Registered'),
    (3, 6, '2026-09-03 11:00:00', 'Registered'),
    (4, 6, '2026-09-03 11:30:00', 'Registered');
GO

INSERT INTO Result
    (Enrolment, FinishTime, Position, RecordedAt)
VALUES
    (1, '00:48:32', 1, '2026-09-04 07:45:00'),
    (2, '00:52:18', 2, '2026-09-04 07:46:00');
GO

SELECT 'Users' AS TableName, COUNT(*) AS RowCount FROM Users
UNION ALL
SELECT 'EventTypes', COUNT(*) FROM EventTypes
UNION ALL
SELECT 'Event', COUNT(*) FROM Event
UNION ALL
SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL
SELECT 'Enrolments', COUNT(*) FROM Enrolments
UNION ALL
SELECT 'Result', COUNT(*) FROM Result;
GO




