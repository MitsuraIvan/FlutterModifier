import 'package:flutter/material.dart';
import 'package:flutter_modifier/WidgetModifier.dart';

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
        modifier: Modifier()
            .onClick(onClick: () {})
            .background(color: Colors.red)
            .padding(edgeInsets: const EdgeInsets.all(80))
            .background(color: Colors.blue)
            .padding(edgeInsets: const EdgeInsets.all(80)),
        child: Text("Literally nothing"),
      ),
    );
  }
}
