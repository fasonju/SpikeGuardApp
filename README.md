# prototype_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

add .env containing api endpoint

Make sure to add the API_URL env variable in prod and include in flutter build by running
```bash
flutter build apk --dart-define=API_URL={your api url} --dart-define=ENV=prod
```
```