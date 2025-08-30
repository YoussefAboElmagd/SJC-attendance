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

flutter packages pub run intl_utils:generate

flutter run --release -t lib/main.dart

flutter build apk -t lib/main.dart
flutter build apk --release --split-per-abi
flutter build appbundle -t lib/main.dart

dart pub global activate flutterfire_cli
flutterfire configure
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

org.gradle.java.home=C:\\Program Files\\Java\\jdk-17.0.1

git fetch --all
git checkout -b mac-version origin/mac-version

package com.sjc.mdarj

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity()

ios work manager
وفي Xcode:

افتح ios/Runner.xcworkspace

اختر Runner → Signing & Capabilities

اضف Capability اسمها Background Modes

فعل الخيار Background fetch

هل تحب أشرح لك كيف تختبر الخلفية في iOS من الـ Xcode؟

make this for me with the full script =>
make this model usign flutter and json serilizable and don't use final and required in code as may all the keys come with null
and use json key
put the attribute in the constructor

i want to make a clean code for this code and divide it into stateless widgets
and not use widget function
in one script

1-dart pub global activate flutterfire_cli
2-flutterfire configure
add firebase_core pack

await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)

keytool -genkey -v -keystore D:\work\madarj\android\app\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
