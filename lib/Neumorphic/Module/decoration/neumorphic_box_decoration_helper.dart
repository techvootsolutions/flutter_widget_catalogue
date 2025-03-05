import 'package:flutter/widgets.dart';

import '../theme/theme.dart';

Shader getGradientShader(
    {required Rect gradientRect,
    required LightSource source,
    double intensity = 0.25}) {
  var sourceInvert = source.invert();

  final currentIntensity = intensity * (3 / 5);

  final Gradient gradient = LinearGradient(
    begin: Alignment(source.dx, source.dy),
    end: Alignment(sourceInvert.dx, sourceInvert.dy),
    colors: <Color>[
      NeumorphicColors.gradientShaderDarkColor(intensity: currentIntensity),
      NeumorphicColors.gradientShaderWhiteColor(
          intensity: currentIntensity * (2 / 5)),
    ],
    stops: const [
      0,
      0.75,
    ],
  );

  return gradient.createShader(gradientRect);
}
