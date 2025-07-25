# hackathon_todo_app

A new Flutter project.

This project is a part of a hackathon run by https://www.katomaran.com

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Clear Explanation
---

## 📦 Building the APK

To generate a release APK for this Flutter app, run the following command in your project root:

```sh
flutter build apk --release
```

- The generated APK will be located at:  
  `build/app/outputs/flutter-apk/app-release.apk`

You can install this APK on your Android device for production or distribution.

---

## 🐞 Debug APK Build Issues

If you try to build a debug APK with:

```sh
flutter build apk --debug
```

and see errors like:

```
Could not resolve io.flutter:armeabi_v7a_debug:...
Could not GET 'https://storage.googleapis.com/download.flutter.io/io/flutter/armeabi_v7a_debug/...
No such host is known (storage.googleapis.com)
```

**This means your computer cannot reach the Flutter artifact server (storage.googleapis.com).**  
This is usually caused by:

- No internet connection
- A firewall or proxy blocking access to Google Cloud Storage
- Network restrictions in your environment

### **How to Fix**

- Ensure you have a stable internet connection.
- Make sure your firewall or proxy allows access to `https://storage.googleapis.com`.
- If you are behind a corporate proxy, configure your proxy settings for Gradle and Flutter.

> **Note:**  
> The release APK (`flutter build apk --release`) does not require downloading debug artifacts, so it may succeed even if the debug build fails.

---

## 📝 Troubleshooting

- If you see warnings about `source value 8 is obsolete`, you can safely ignore them for now. They are related to Java compatibility and do not affect the APK build.
- If you see `RenderBox was not laid out` or similar errors at runtime, ensure your widget tree is correctly structured (see the code for proper usage of Rows, Columns, and Slidables).

---

If you have any issues building or running the app, please open an issue on this repository with your error log and environment details.

---
Android application can be installed through this link:
https://drive.google.com/file/d/1pIwqXIGwVywr6rSi2V6dgIFmQ-yPbPca/view?usp=sharing

Working of the application watch using the below link:
https://drive.google.com/file/d/1MO4CIl5EAkfCi3Z-D1IIMInJUttlK2Un/view?usp=sharing
