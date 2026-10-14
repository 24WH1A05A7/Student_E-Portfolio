# Student E-Portfolio App

## Overview
A Flutter-based student e-portfolio that presents academic details, certifications, activities, and achievements in one place.

## Features
- Login screen with basic form validation
- Academic details in a horizontally scrollable table
- Certifications list
- Extracurricular activities list
- Automatically advancing achievements slideshow
- Navigation between sections and logout

## Technology
- Flutter
- Dart
- Material Design

## Run locally
Install the Flutter SDK, then run from the project directory:

```bash
flutter pub get
flutter run
```

## Notes
- Login is a demo and is not connected to backend authentication. Any non-empty roll number and password pass the form.
- Certificate buttons are placeholders until certificate URLs are added.
- Carnatic vocal training is listed as an activity; audio playback is not included.
- The academic CGPA is shown as 9.43 up to IV semester, based on the details provided.

This source package includes the Dart app code, package configuration, and README. It does not include generated Android/iOS platform folders. To create a full runnable Flutter project after installing Flutter, run `flutter create .` in this folder, then run `flutter pub get`.
