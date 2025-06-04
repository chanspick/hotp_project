# hotp_project

This repository contains a sample Flutter app modeled after the KREAM marketplace. It uses Firebase for authentication and data storage and serves as a learning project for building e‑commerce style applications with Flutter.

## Requirements

- Flutter **3.27** or later
- Dart **3.6** or later

## Getting Started

Inside the Flutter project directory, install dependencies and run the app:

```bash
cd flutter_application_1
flutter pub get
flutter run
```

## Preparing iOS Dependencies

Run the following commands before building the iOS version of the app:

```bash
flutter pub get
flutter precache --ios  # downloads Flutter.xcframework needed for CocoaPods
cd ios
pod install
cd ..
```
