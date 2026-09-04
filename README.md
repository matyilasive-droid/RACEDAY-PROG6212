# RACEDAY-PROG6212
RaceDay is a web-based event management system designed for South African
road running, walking and cycling events.

The system allows event organisers to create and manage events, categories,
participant enrolments and race results. Participants can view events,
enrol in categories and view their results.

## Features

- User management
- Event type management
- Event management
- Category management
- Participant enrolments
- Race results
- Role-based access for Participants, Organisers and Administrators
- SQL Server database
- REST API endpoint design

## System Entities

The RaceDay database consists of the following six main entities:

1. User
2. EventType
3. Event
4. Categories
5. Enrolment
6. Result

## User Roles

### Participant
- View available events
- View event categories
- Enrol in events
- View personal results

### Organiser
- Create events
- Update events
- Manage event categories
- View enrolments
- Manage race results

### Administrator
- Manage users
- Manage event types
- Manage system data

## Database

The project uses Microsoft SQL Server.

Database name:

`RaceDayDB`

The SQL database script is located in:

`/docs/RaceDay_Database.sql`

The script creates the database tables, primary keys, foreign keys,
constraints and sample seed data.

## API

The API endpoint plan is available in:

`/docs/RaceDay_API_Endpoint_Plan.docx`

The API covers:

- Authentication
- User management
- Event types
- Events
- Categories
- Enrolments
- Results

## ERD

The Entity Relationship Diagram is available in:

`/docs/RaceDay_ERD.png`

The ERD shows the relationships between the six database entities.

## Project Documentation

All planning and documentation files are stored in the `/docs` folder.

The `/docs` folder contains:

- ERD
- API Endpoint Plan
- SQL Database Script
- Other project documentation

## Technologies Used

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- REST API
- Git
- GitHub
- GitHub Actions

## Repository Structure

API PLAN.pdf
