# Flutter Widget Catalogue

[![pub package](https://img.shields.io/pub/v/flutter_widget_catalogue.svg)](https://pub.dev/packages/flutter_widget_catalogue)
[![GitHub stars](https://img.shields.io/github/stars/techvootsolutions/flutter_widget_catalogue?style=social)](https://github.com/techvootsolutions/flutter_widget_catalogue)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/techvootsolutions/flutter_widget_catalogue/blob/main/LICENSE)
[![Flutter Compatible](https://img.shields.io/badge/flutter-compatible-brightgreen.svg)](https://flutter.dev)
[![Platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev)

---

A collection of visual, structural, platform-adaptive, and interactive widgets to help you build beautiful and functional Flutter apps faster.  
🎯 100% Dart | 💙 Flutter-ready | ✅ Easy to use | 🧩 Modular components

---

## ✨ Features

### 🔘 Buttons
- Social Auth Buttons (Google, Facebook, Apple, etc.)
- Rounded Buttons
- Icon Buttons
- Line Buttons
- Gradient Buttons
- Many more…

### 🔄 Custom Switch
Highly customizable Flutter switch widget:
- Adjustable height, width, toggle size
- Borders, colors, radius, icons, labels

### 💠 Neumorphic UI Kit
Ready-to-use Neumorphic-styled widgets:
- Buttons, Switches, Containers, Sliders, Texts, Icons
- Checkboxes, Toggles, Indicators, Range Sliders, and more

---

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_widget_catalogue: <latest-version>
```

Then import it:

```dart
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
```

---

## 🖼️ Screenshots

### Neumorphic Widgets

| | | |
|---|---|---|
| ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/1.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/2.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/3.jpg) |
| ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/4.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/5.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/6.jpg) |

### Buttons

| | | |
|---|---|---|
| ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b1.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b2.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b3.jpg) |

### Switch

| |
|--|
| ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/s1.jpg) |

---

## 🧪 Usage

### Buttons Example

```dart
SuccessButton(title: "Success Button", onPressed: () {});
ButtonWithIcon(
  icon: Icons.local_cafe,
  title: "Icon Button",
  color: Colors.white,
  buttonColor: Colors.cyan,
  onPressed: () {},
);
GradientButton(
  onPressed: () {},
  splashColor: Colors.orange,
  colors: [Colors.red, Colors.orange],
  title: "Gradient Button",
);
```

### Switch Example

```dart
FlutterSwitch(
  width: 90.0,
  height: 45.0,
  toggleSize: 38.0,
  value: status,
  borderRadius: 24.0,
  padding: 2.0,
  toggleColor: Colors.white,
  switchBorder: Border.all(color: Colors.blueAccent, width: 3.0),
  activeColor: Colors.cyan,
  inactiveColor: Colors.grey.shade400,
  onToggle: (val) {
    setState(() {
      status = val;
    });
  },
);
```

---

## ✅ Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅         |
| iOS      | ✅         |
| Web      | ✅         |

---

## 📌 Changelog

Please see the [CHANGELOG.md](https://github.com/techvootsolutions/flutter_widget_catalogue/blob/main/CHANGELOG.md) for a list of recent changes.

---

## 👨‍💻 Contributors

- [**Princy Varsani**](https://github.com/tvPrincy)
- [Kevin Baldha](https://github.com/techkevin)

---

## 📃 License

This project is licensed under the [MIT License](https://github.com/techvootsolutions/flutter_widget_catalogue/blob/main/LICENSE).
