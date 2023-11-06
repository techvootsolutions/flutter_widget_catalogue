// ignore_for_file: overridden_fields

import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

export 'theme.dart';
export 'theme_wrapper.dart';

typedef NeumorphicThemeUpdater = NeumorphicThemeData Function(
    NeumorphicThemeData? current);

class NeumorphicThemeInherited extends InheritedWidget {
  @override
  final Widget child;
  final ThemeWrapper value;
  final ValueChanged<ThemeWrapper> onChanged;

  const NeumorphicThemeInherited(
      {Key? key,
      required this.child,
      required this.value,
      required this.onChanged})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(NeumorphicThemeInherited old) => value != old.value;

  NeumorphicThemeData? get current {
    return value.current;
  }

  bool get isUsingDark {
    return value.useDark;
  }

  ThemeMode get themeMode => value.themeMode;

  set themeMode(ThemeMode currentTheme) {
    onChanged(value.copyWith(currentTheme: currentTheme));
  }

  void updateCurrentTheme(NeumorphicThemeData update) {
    if (value.useDark) {
      final newValue = value.copyWith(darkTheme: update);
      onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      onChanged(newValue);
    }
  }

  void update(NeumorphicThemeUpdater themeUpdater) {
    final update = themeUpdater(value.current);
    if (value.useDark) {
      final newValue = value.copyWith(darkTheme: update);
      onChanged(newValue);
    } else {
      final newValue = value.copyWith(theme: update);
      onChanged(newValue);
    }
  }
}
