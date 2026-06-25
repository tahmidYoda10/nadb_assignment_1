# Student Grade Tracker

A Flutter application that helps students manage subjects, track marks, calculate grades, and view academic performance summaries.

## Features

* Add subjects with marks
* Automatic grade calculation
* View all subjects in a list
* Swipe to delete subjects
* Live summary updates
* Average mark calculation
* Overall grade calculation
* Light and dark theme support
* Form validation
* Provider state management

## Grade Scale

| Grade | Marks Range |
| ----- | ----------- |
| A     | 80 - 100    |
| B     | 65 - 79     |
| C     | 50 - 64     |
| F     | 0 - 49      |

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

cd nadb_assignment_1

flutter pub get

flutter run
```

## Assignment Requirements Covered

* Private `_mark` field in Subject class
* Grade getter implementation
* Use of `.map()` or `.where()`
* Form validation
* Dismissible delete
* ListView.builder
* BottomNavigationBar navigation
* Provider state management
* Custom light and dark themes
* No use of setState

## Author

Tahmid Al Mamun
