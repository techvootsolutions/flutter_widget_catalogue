import 'dart:math';

import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class CirclePathProvider extends NeumorphicPathProvider {
  const CirclePathProvider({Listenable? reclip});

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    final middleHeight = size.height / 2;
    final middleWidth = size.width / 2;
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(middleWidth, middleHeight),
          radius: min(middleHeight, middleWidth)))
      ..close();
  }

  @override
  bool get oneGradientPerPath => false;
}
