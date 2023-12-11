# User Requirements Document

## 1. Introduction

### 1.1 Purpose
The purpose of this document is to outline the user requirements for a time management application that will help Jack record, track, and query his time usage efficiently.

### 1.2 Scope
The application is intended for use on both iPhone and Android platforms, providing a flexible mobile GUI interface for Jack to record and query his time-related activities.

## 2. User Profile

### 2.1 User Description
- Name: Jack
- Objective: Manage time by recording and tracking activities.
- Platform Familiarity: iPhone and Android.

## 3. Features

### 3.1 Time Recording

#### 3.1.1 Data Input Fields
The application shall provide a user-friendly GUI screen for time recording with the following input fields or dialog boxes:
- **DATE**: Allow date input in flexible formats (e.g., YYYY/MM/DD).
- **FROM, TO**: Capture time intervals with support for both 24-hour and AM/PM formats.
- **TASK**: Provide a field to enter the specific activity or task.
- **TAG**: Include a tag field for categorizing activities (e.g., STUDY).

#### 3.1.2 Flexibility in Data Input
The application shall support flexible input formats, allowing Jack to specify date and time in various ways, such as 2022/09/23 or by adding AM or PM to the FROM or TO fields.

### 3.2 Querying Time Usage

#### 3.2.1 Query Parameters
The application shall include a query screen/page/dialog box enabling Jack to retrieve time-related activities based on the following parameters:
- **DATE**: Jack can input a specific date to retrieve activities for that day.
- **TASK**: Jack can input a specific task to retrieve all related activities.
- **TAG**: Jack can input a tag to retrieve activities associated with that tag.

#### 3.2.2 Query Execution
Upon providing input to the query screen, the application shall display relevant activities meeting the specified criteria, offering an efficient means for Jack to review his time usage.

## 4. User Expectations

### 4.1 Intuitive User Interface
The application shall offer an intuitive and user-friendly interface on both iPhone and Android devices, ensuring ease of use for Jack.

### 4.2 Data Accuracy and Reliability
Recorded time data shall be accurately stored and retrievable, maintaining reliability for Jack to make informed decisions about his time management.

### 4.3 Customization and Flexibility
Jack expects the application to allow customization of date and time formats, providing the flexibility to adapt the tool to his preferences.

### 4.4 Efficient Querying
The querying feature shall execute swiftly, providing Jack with prompt and accurate results based on specified parameters.

## 5. Constraints

### 5.1 Platform Compatibility
The application must be compatible with both iPhone and Android devices to meet Jack's platform preferences.

## 6. Assumptions

### 6.1 Database Integration
It is assumed that the application will have a robust backend database to store and manage time-related data effectively.