import 'package:flutter/material.dart';
import 'package:flutter_modifier/WidgetModifier.dart';
import 'package:flutter_modifier/custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTestWidget(),
    );
  }
}

class MyTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WidgetModifier(
        builder: EXT_MODIFIER.myCustomBuilder,
        modifier: Modifier().onClick(onClick: () {}).myCustomDzen(Colors.blue).myAnotherSweattyBuildUp(40, 41, 42),
        child: Text("Literally nothing"),
      ),
    );
  }
}
