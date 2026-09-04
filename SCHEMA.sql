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

CREATE TABLE dbo.EventTypes
(
    EventTypeID INT IDENTITY(1,1) NOT NULL,
    EventTypeName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,

    CONSTRAINT PK_EventTypes PRIMARY KEY (EventTypeID),
    CONSTRAINT UQ_EventTypes_EventTypeName UNIQUE (EventTypeName)
);
