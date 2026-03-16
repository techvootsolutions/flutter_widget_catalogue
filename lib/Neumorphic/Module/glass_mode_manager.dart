import 'package:flutter/material.dart';

class GlassModeManager {
  static final GlassModeManager instance = GlassModeManager._internal();

  factory GlassModeManager() {
    return instance;
  }

  GlassModeManager._internal();

  final ValueNotifier<bool> isGlassMode = ValueNotifier<bool>(false);

  void setGlassMode(bool value) {
    isGlassMode.value = value;
  }

  void toggleGlassMode() {
    isGlassMode.value = !isGlassMode.value;
  }
}
