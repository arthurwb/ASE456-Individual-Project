# Time Tracker App

## Overview

The Time Tracker App is a mobile application built with Flutter and Firebase, designed to help users manage and track their time efficiently. This app allows users to record their activities, query time usage, generate reports, and identify the most time spent on specific activities.

## Features

- **Recording Time:**
  - Enter date, start time, end time, task, and tag to record your activities.

- **Querying Time Usage:**
  - Search for activities based on date, task, or tag criteria.

- **Generating Reports:**
  - Generate time usage reports for a specific date range.

- **Finding Most Time Spent:**
  - Identify the activities you spend the most time on.

## Prerequisites

Before running the app, ensure you have the following:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase Project](https://console.firebase.google.com/)

## Installation

1. Clone the repository:

```bash
    git clone https://github.com/your-username/time-tracker-app.git
```

2. Navigate to the project directory:

```bash
    cd time-tracker-app
```

3. Run the app:

```bash
    flutter run
```

## Firebase Configuration

1. Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).

2. Add your Firebase configuration to the `firebase_options.dart` file:

   ```dart
   // firebase_options.dart

   import 'package:firebase_core/firebase_core.dart';

   class FirebaseOptions {
     static FirebaseOptions currentPlatform = FirebaseOptions(
       apiKey: 'YOUR_API_KEY',
       appId: 'YOUR_APP_ID',
       messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
       projectId: 'YOUR_PROJECT_ID',
       authDomain: 'YOUR_AUTH_DOMAIN',
       databaseURL: 'YOUR_DATABASE_URL',
       storageBucket: 'YOUR_STORAGE_BUCKET',
     );
   }
    ```
    Enable Firestore in your Firebase project.

## Usage

Run the app on an emulator or physical device:

```bash
    flutter run
```

Explore and test the app's features.