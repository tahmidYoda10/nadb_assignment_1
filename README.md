# Student Grade Tracker

A Flutter application that allows students to manage subjects, track marks, view grades, and monitor overall academic performance.

## Features

* Add subjects with marks (0–100)
* Automatic grade calculation (A, B, C, F)
* View all subjects in a list
* Delete subjects using swipe-to-delete
* Live summary updates when subjects are added or removed
* Average mark calculation
* Overall grade calculation
* Light and dark theme support
* Form validation for subject name and marks
* State management using Provider
* No use of setState

## Grade Scale

| Grade | Marks Range |
| ----- | ----------- |
| A     | 80 – 100    |
| B     | 65 – 79     |
| C     | 50 – 64     |
| F     | 0 – 49      |

## Technologies Used

* Flutter
* Dart
* Provider

## Project Structure

```text
lib/
├── main.dart
├── models/
│   └── subject.dart
├── providers/
│   ├── subject_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── add_subject_screen.dart
│   ├── subject_list_screen.dart
│   └── summary_screen.dart
├── widgets/
│   └── subject_tile.dart
└── themes/
    └── app_themes.dart
```

## How to Run

```bash
git clone https://github.com/tahmidYoda10/nadb_assignment_1.git

cd student_grade_tracker

flutter pub get

flutter run
```

## Assignment Requirements Covered

* Subject class with private `_mark` field
* Grade getter implementation
* Use of `.map()` and/or `.where()`
* Form validation
* ListView.builder for displaying subjects
* Dismissible for deleting subjects
* BottomNavigationBar navigation
* Live summary updates
* Custom light and dark themes
* Provider state management
* Zero `setState` usage

## Author

Tahmid Al Mamun
