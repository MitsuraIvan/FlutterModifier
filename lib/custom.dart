import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'WidgetModifier.dart';

//I have no fantasy here, but you can literally combine Widgets in any way and form you want or reuse a lot
extension EXT_MODIFIER on Modifier {
  static Widget myCustomBuilder(dynamic element, Widget child) {
    if (element is _MyCustomTag) {
      return Card(
        color: element.someParam,
        child: child,
      );
    }
    if (element is _MySweattyTag) {
      return Padding(
        padding: EdgeInsets.all(element.number3),
        child: SizedBox(
          height: element.number1,
          width: element.number2,
          child: child,
        ),
      );
    }
    throw Exception("Unprovided custom tag of $element");
  }

  Modifier myCustomDzen(Color someParam) {
    addCustomType(_MyCustomTag(someParam));
    return this;
  }

  Modifier myAnotherSweattyBuildUp(double number1, double number2, double number3) {
    addCustomType(_MySweattyTag(number1, number2, number3));
    return this;
  }
}

class _MyCustomTag {
  Color someParam;

  _MyCustomTag(this.someParam);
}

class _MySweattyTag {
  double number1;
  double number2;
  double number3;

  _MySweattyTag(this.number1, this.number2, this.number3);
}

class MyTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WidgetModifier(
        builder: EXT_MODIFIER.myCustomBuilder,
        modifier: Modifier()
            .onClick(onClick: () {})
            .background(color: Colors.red)
            .padding(edgeInsets: const EdgeInsets.all(80))
            .myCustomDzen(Colors.blue)
            .myAnotherSweattyBuildUp(40, 41, 42),
        child: Text("Literally nothing"),
      ),
    );
  }
}
