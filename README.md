# madarj

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

flutter packages pub run build_runner build --delete-conflicting-outputs

flutter run --release -t lib/main.dart

flutter build apk -t lib/main.dart
flutter build apk --release --split-per-abi


dart pub global activate flutterfire_cli
flutterfire configure
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  

org.gradle.java.home=C:\\Program Files\\Java\\jdk-17.0.1



package com.example.madarj

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()
