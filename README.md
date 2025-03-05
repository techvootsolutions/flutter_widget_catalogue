# Flutter widget catalogue

Create an awesome apps very faster with Flutter's collection of visual, structural, platform, UI and interactive widgets. Its a open source package.
#### Buttons
All types of buttons set in this package. Auth Buttons for authenticating with the most popular social networks like: Google, Facebook, Apple and too other and add more buttons like (Rounded buttons, simple buttons, border color button, etc....).
#### Switch
An easy to implement custom switch created for Flutter. Give it a custom height and width, colors, size, border for the switch and toggle, border radius, colors, toggle size, a set to display an 'On' and 'Off' text and able to add custom icon inside the toggle.
#### Neumorphic
A complete, ready to use, Neumorphic ui kit for Flutter like(Buttons, switch, Container, Slider, Text, Icon, CheckBox, Toggle, Indicator, Range Slider, etc..).
### Installing

1.  Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on [pub.dev](https://pub.dev/packages/flutter_widget_catalogue)*

```dart
  dependencies:
      flutter_widget_catalogue: <latest-version>
```

2.  Import the package
```dart
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
```

#### 1) Neumorphic Widgets

Screenshot | Screenshot | Screenshot
------------ | ------------- | -------------
![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/1.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/2.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/3.jpg)

Screenshot | Screenshot | Screenshot
------------ | ------------- | -------------
![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/4.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/5.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/6.jpg)

#### 2) Buttons

Screenshot | Screenshot | Screenshot
------------ | ------------- | -------------
![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b1.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b2.jpg) | ![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/b3.jpg)

#### 3) Switch

Screenshot
-----------
![](https://raw.githubusercontent.com/techvootsolutions/TV_Flutter_Component/main/Images/s1.png)

### How to use Buttons

```
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catelogue.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Buttons',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Buttons(),
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
  ```
 #### Simple Buttons
 ```
              customContainer(
                  child: SuccessButton(
                title: "Success Button",
                onPressed: () {},
              )),

 ```
#### Icon Button
 ```
              customContainer(
                child: ButttonWithIcon(
                  icon: Icons.local_cafe,
                  title: "Icon Button",
                  color: Colors.white,
                  buttonColor: Colors.cyan,
                  onPressed: () {},
                ),
              ),
 ```
#### Floating Button
 ```
              Wrap(
                children: [
                  FloatingIconButton(
                    icon: Icons.home,
                    onPressed: () {},
                    buttonColor: Colors.orange,
                  ),
                  FloatingIconButton(
                    icon: Icons.home,
                    onPressed: () {},
                    buttonColor: Colors.cyan,
                    color: Colors.white,
                  )
                ],
              ),
 ```
#### Line Button
 ```
              customContainer(
                  child: PrimaryLineButton(
                onPressed: () {},
                title: "Line Button",
              )),
              customContainer(
                  child: InfoLineButton(
                textColor: Colors.black,
                onPressed: () {},
                title: "Info Line Button",
              )),
   ```
#### Rounded Button
 ```
              customContainer(
         child: RoundedButtonWithIcon(
                onPressed: () {},
                icon: Icons.title,
                title: "Rounded Button With Icon",
                buttonColor: Colors.green,
              )),
   ```
#### Social Button
 ```
              Wrap(
                children: <Widget>[
                  FacebookButton(
                    onPressed: () {},
                  ),
                  TwitterButton(
                    onPressed: () {},
                  ),
                ],
              ),
              SignInWithEmail(
                onPressed: () {},
              ),
              SignInWithGoogle(
                onPressed: () {},
              ),
              SignInWithMicrosoft(
                onPressed: () {},
              ),
              SignInWithApple(
                onPressed: () {},
              ),
             )),
   ```
#### Gradiant Button
 ```
              customContainer(
                  child: GradientButton(
                onPressed: () {},
                splashColor: Colors.orange,
                colors: const [
                  Colors.red,
                  Colors.orange,
                ],
                title: "Gradient Button",
              )),
            ],
          ),
        ),
      ),
    );
  }
}

```

### How to use Switch
```
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch"),
      ),
      body: Center(
        child: Container(
          child: FlutterSwitch(
            width: 125.0,
            height: 55.0,
            valueFontSize: 25.0,
            toggleSize: 45.0,
            value: status,
            borderRadius: 30.0,
            padding: 8.0,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                status = val;
              });
            },
          ),
        ),
      ),
    );
  }
}
```

### Changelog
<p>Please see <a href="https://github.com/techvootsolutions/flutter_widget_catalogue/blob/main/CHANGELOG.md"><b>CHANGELOG </b></a>for more information what has changed recently.</p>

### Main Contributors
<ul>
  <li><a href="https://github.com/tvPrincy"><b>Princy Varsani</b></a></li>
  <li><a href="https://github.com/techkevin">Kevin Baldha</a></li>
</ul>
