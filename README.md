# Troopers: Diver Edition - Character Sheet

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-target-3DDC84?logo=android&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-target-FCC624?logo=linux&logoColor=black)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A mobile character sheet app for the **Troopers: Diver Edition** tabletop RPG, built with Flutter.

## Features

- Tracks all character stats: attributes (Body, Agility, Mind, Presence, Luck), hit points, armor, and skills
- Three weapon slots with ammo counters
- Psionics resource tracking via Usage Dice
- Vehicle stats, gear inventory with Usage Dice, and contacts
- Auto-computed skill totals and attribute modifiers
- All data persists locally on-device between sessions

## Building

Requires Flutter 3.x with the Android SDK configured.

```bash
flutter pub get
flutter run           # Android device
flutter run -d linux  # Linux desktop
flutter build apk     # Release APK
```

## License

The app code is released under the [MIT License](LICENSE).

The **Troopers: Diver Edition** ruleset, game mechanics, and associated creative content reflected in this app are the original
work of the rulebook author and are used here by permission. This app does not reproduce the rulebook text.

> This character sheet app is an independent creation by Matt Boulanger that is compatible with **Troppers: Diver Edition** by Petros Moros.
