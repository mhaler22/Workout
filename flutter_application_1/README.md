# PUMP UP! App

Welcome to **PUMP UP!**, your ultimate workout companion built with Flutter. This README will guide you through the app's features, setup, and usage.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Dependencies](#dependencies)
- [Getting Started](#getting-started)
- [File Structure](#file-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

**PUMP UP!** helps users manage and track their workout routines. Built with Flutter, it uses Hive for local storage and Provider for state management.

## Features

- **User Authentication**: Secure login.
- **Workout Management**: Store and manage workout data.
- **Navigation**: Smooth transitions between pages.

## Dependencies

- `flutter/material.dart`: Core Flutter framework.
- `hive_flutter`: For local data storage.
- `provider`: For state management.
- Custom imports for managing data and UI.

## Getting Started

### Prerequisites

- Flutter SDK installed.
- Code editor (e.g., VS Code, Android Studio).

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/flutter-application-1.git
   cd flutter-application-1
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## File Structure

```plaintext
lib/
│
├── data/
│   └── workout_data.dart  # Manages workout data
│
├── pages/
│   ├── LoginPage.dart     # Login page UI
│   ├── home_page.dart     # Home page UI
│   └── welcome_page.dart  # Welcome page UI
│
├── main.dart              # Entry point
│
pubspec.yaml               # Dependencies and metadata
```

## Usage

- **Login Page**: Initial route for user authentication.
- **Welcome Page**: Displayed after login with a navigation button to the home page.
- **Home Page**: Manage and track workouts.

### Navigation

- **Login Page**: `/`
- **Welcome Page**: `/welcome`
- **Home Page**: `/home`

## Contributing

Contributions are welcome! Fork the repository and submit a pull request with detailed descriptions of your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

### Component Specific READMEs

#### Login Page

Handles user authentication and displays a motivational quote.

**Features**:
- User Authentication
- Inspirational Quotes
- Loading Indicator

**File Structure**:
```plaintext
lib/
├── pages/
│   └── LoginPage.dart
pubspec.yaml
```

**Usage**:
- Authentication logic with predefined username/password.
- Displays a new quote on each load.

#### Welcome Page

Welcomes users with a motivational quote and a button to navigate to the home page.

**Features**:
- Welcome Message
- Inspirational Quote
- Navigation Button

**File Structure**:
```plaintext
lib/
├── pages/
│   └── WelcomePage.dart
pubspec.yaml
```

**Usage**:
- Includes an AppBar, background image, and navigation button.

#### Workout Page

Tracks and manages exercises within a workout.

**Features**:
- Add Exercises
- Track Progress
- Detailed View

**File Structure**:
```plaintext
lib/
├── components/
│   └── exercise_tile.dart
├── data/
│   └── workout_data.dart
├── pages/
│   └── WorkoutPage.dart
pubspec.yaml
```

**Usage**:
- Add exercises with the floating action button.
- Track progress by checking off exercises.

#### Exercise Class

Models an individual exercise with details like name, weight, reps, sets, and completion status.

**Class Definition**:
```dart
class Exercise {
  final String name;
  final String weight;
  final String reps;
  final String sets;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.weight,
    required this.reps,
    required this.sets,
    this.isCompleted = false,
  });
}
```

**Usage**:
- Instantiate with parameters and update completion status.

#### Workout Data Manager

Manages workout routines and exercises with persistent storage using Hive and state management via Provider.

**Features**:
- Workout Management
- Exercise Tracking

**Class Definition**:
```dart
class WorkoutData extends ChangeNotifier {
  // Implementation here
}
```

**Usage**:
- Use methods like `addWorkout` and `checkOffExercise` to manage data.

---

### Exercise Screen README

Describes the `ExerciseScreen` and `ExerciseTile` widgets for displaying exercise details.

**Features**:
- Gradient Background
- Exercise Information
- Completion Checkbox

**Class Definitions**:
```dart
class ExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 234, 234),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.red[300]!, Colors.red[200]!.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: ExerciseTile(
            exerciseName: "Exercise Name",
            weight: "50",
            reps: "10",
            sets: "3",
            isCompleted: false,
            onCheckBoxChanged: (value) => print("Checkbox changed: $value"),
          ),
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 157, 177, 186),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow[200]!.withOpacity(0.3),
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(children: [
          Chip(label: Text("$weight kg")),
          Chip(label: Text("$reps reps")),
          Chip(label: Text("$sets sets")),
        ]),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}
```

**Getting Started**:
1. **Add Classes**: Create `exercise_screen.dart` in `lib/screens`.

**Usage**:
- Display the `ExerciseScreen` and customize `ExerciseTile` as needed.

#### HiveDatabase README

Overview and instructions for the `HiveDatabase` class for managing workout data persistence.

**Features**:
- Persistent Storage
- Completion Status Tracking

**Class Definition**:
```dart
class HiveDatabase {
  final _myBox = Hive.box("workout_database1");

  bool previousDataExist() {
    if (_myBox.isEmpty) {
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  void saveToDatabase(List<Workout> workouts) {
    // Implementation
  }

  List<Workout> readFromDataBase() {
    // Implementation
  }

  int getCompletionStatus(String yyyymmdd) {
    return _myBox.get("COMPLETION_STATUS$yyyymmdd") ?? 0;
  }

  bool exerciseCompleted(List<Workout> workouts) {
    // Implementation
  }

  List<String> convertObjectToWorkoutList(List<Workout> workouts) {
    return workouts.map((workout) => workout.name).toList();
  }

  List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
    // Implementation
  }
}
```

**Getting Started**:
1. **Add Class**: Create `hive_database.dart` in `lib/data`.
2. **Setup Hive**: Initialize Hive in `main.dart`.

**Usage**:
- Save and read workouts, and get completion status.

---

