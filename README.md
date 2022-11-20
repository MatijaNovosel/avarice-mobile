<h1 align=center>Avarice mobile</h1>
<p align=center>
  <a href="https://github.com/MatijaNovosel/avarice">Avarice</a> mobile, an app for tracking personal finances.
</p>

<p align="center">
  <samp>
    <a href="https://github.com/MatijaNovosel/avarice">🌟 Web</a> |
    <a href="https://github.com/MatijaNovosel/avarice-backend">📱 Backend</a>
  </samp>
</p>

<p align=center>
  <img src="https://user-images.githubusercontent.com/36193643/192747548-dddc6563-5e43-4cfa-8d26-520d64d4b01a.png" />
</p>

## 🔨 Built With

- [Flutter](https://flutter.dev/)

## Requirements

Flutter: 3.0.0
Dart SDK: 2.17.0

## Installation

- Add [Flutter](https://flutter.dev/docs/get-started/install "Flutter") to your machine
- Open this project folder with Terminal/CMD
- Ensure there's no cache/build leftover by running `flutter clean` in the Terminal
- Run in the Terminal `flutter packages get`

## ⚠️ Additional notes

- To generate models run `flutter pub run build_runner build --delete-conflicting-outputs`
- To generate translations run `flutter gen-l10n`

## Additional steps for iOS

- Open ios folder inside Terminal/CMD
- Run in the Terminal `pod install`
- Run in the Terminal `pod update`

## Running the App

- Open Android Emulator or iOS Simulator
- Run `flutter run --flavor {RELEASE_TYPE} --dart-define flavor={RELEASE_TYPE}`
- Supported release type: `development`, `staging`, and `production`

## Build an APK

- Run `flutter build apk --flavor {RELEASE_TYPE} --dart-define flavor={RELEASE_TYPE}`
- The apk will be saved under this location: `[project]/build/app/outputs/flutter-apk/`
- We can also build appbundle (.aab) by running this command: `flutter build appbundle --flavor {RELEASE_TYPE} --dart-define flavor={RELEASE_TYPE}`

## Build for iOS

- Follow the tutorial from this link: https://flutter.dev/docs/deployment/ios#create-a-build-archive-with-xcode
- Don't forget to add the release type behind the build command
- For example `flutter build ipa --flavor {RELEASE_TYPE} --dart-define flavor={RELEASE_TYPE}`

For more information, check out the [official documentation](https://flutter.dev/docs "documentation")
