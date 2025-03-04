// // ignore_for_file: library_private_types_in_public_api
//
// import 'package:example/Neumorphic/Module/accessibility/neumorphic_accessibility.dart';
// import 'package:example/Neumorphic/Module/playground/text_playground.dart';
// import 'package:example/Neumorphic/Module/samples/sample_home.dart';
// import 'package:example/Neumorphic/Module/tips/tips_home.dart';
// import 'package:example/Neumorphic/Module/widgets/widgets_home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
//
// class NeumorphicContainer extends StatefulWidget {
//   const NeumorphicContainer({super.key});
//
//   @override
//   _ButtonsPageState createState() => _ButtonsPageState();
// }
//
// class _ButtonsPageState extends State<NeumorphicContainer> {
//   Widget _buildButton({
//     required String text,
//     VoidCallback? onClick,
//     IconData? icon,
//   }) {
//     return NeumorphicButton(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.symmetric(
//         vertical: 18,
//         horizontal: 24,
//       ),
//       style: NeumorphicStyle(
//         depth: 4, // Subtle shadow effect
//         intensity: 0.8, // Soft effect
//         boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
//         color: NeumorphicColors.background,
//         shadowLightColor: Colors.white,
//         shadowDarkColor: Colors.grey.shade500,
//       ),
//       onPressed: onClick,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, color: Colors.blueGrey.shade800),
//             const SizedBox(width: 10),
//           ],
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.blueGrey.shade800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NeumorphicTheme(
//       theme: const NeumorphicThemeData(
//         depth: 4,
//         baseColor: NeumorphicColors.background,
//         lightSource: LightSource.topLeft,
//         intensity: 0.8,
//       ),
//       child: Scaffold(
//         appBar: const NeumorphicAppBar(
//           title: Text(
//             "Neumorphic Container Widgets",
//             style: TextStyle(fontSize: 20.0, color: Colors.white),
//           ),
//           centerTitle: true,
//           buttonStyle: NeumorphicStyle(
//             color: Colors.cyan,
//           ),
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   "Neumorphic Buttons",
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey.shade800,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//
//                 _buildButton(text: "Submit", icon: Icons.send, onClick: () {}),
//                 _buildButton(
//                   text: "Text Playground",
//                   icon: Icons.text_fields,
//                   onClick: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const NeumorphicTextPlayground(),
//                     ));
//                   },
//                 ),
//                 _buildButton(
//                   text: "Samples",
//                   icon: Icons.widgets,
//                   onClick: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const SamplesHome(),
//                     ));
//                   },
//                 ),
//                 _buildButton(
//                   text: "Widgets",
//                   icon: Icons.extension,
//                   onClick: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const WidgetsHome(),
//                     ));
//                   },
//                 ),
//                 _buildButton(
//                   text: "Tips",
//                   icon: Icons.lightbulb_outline,
//                   onClick: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const TipsHome(),
//                     ));
//                   },
//                 ),
//                 _buildButton(
//                   text: "Accessibility",
//                   icon: Icons.accessibility_new,
//                   onClick: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const NeumorphicAccessibility(),
//                     ));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
