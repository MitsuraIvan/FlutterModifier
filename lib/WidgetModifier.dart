import 'package:flutter/material.dart';

// int VERSION = 4;

class _OnClick {
  Function() onClick;
  bool inkWell;
  bool coloredParent;

  _OnClick({
    required this.onClick,
    required this.inkWell,
    required this.coloredParent,
  });
}

class _Expanded {
  int flex;

  _Expanded({required this.flex});
}

class _Card {
  double elevation;
  ShapeBorder? shape;

  _Card({required this.elevation, required this.shape});
}

class _Container {
  double? width;
  double? height;

  double? minWidth;
  double? minHeight;

  double? maxWidth;
  double? maxHeight;

  Color? color;
  Alignment? alignment;

  _Container({
    required this.width,
    required this.height,
    required this.minWidth,
    required this.maxWidth,
    required this.minHeight,
    required this.maxHeight,
    required this.color,
    required this.alignment,
  });
}

class _OverScroll {
  bool enabled;
  Color color;

  _OverScroll(this.enabled, this.color);
}

class _Alignment {
  Alignment alignment;

  _Alignment(this.alignment);
}

class Modifier {
  final List<dynamic> _list = [];

  Modifier overscroll({bool enabled = true, Color color = Colors.transparent}) {
    _list.add(_OverScroll(enabled, color));
    return this;
  }

  Modifier card({double elevation = 5, ShapeBorder? shape}) {
    _list.add(_Card(elevation: elevation, shape: shape));
    return this;
  }

  Modifier expanded({int flex = 1}) {
    _list.add(_Expanded(flex: flex));
    return this;
  }

  //height+width will be ignored inside Container without alignment
  //priority of width/height > min/max width/height
  Modifier background({
    Color? color,
    double? width,
    double? minWidth = 0,
    double? maxWidth = double.infinity,
    double? height,
    double? minHeight = 0,
    double? maxHeight = double.infinity,
    Alignment? alignment,
  }) {
    _list.add(
      _Container(
        color: color,
        height: height,
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        width: width,
        alignment: alignment,
      ),
    );
    return this;
  }

  Modifier padding({required EdgeInsets edgeInsets}) {
    _list.add(edgeInsets);
    return this;
  }

  //todo longClick, onTouch, move, etc
  Modifier onClick({
    required Function() onClick,
    bool inkWell = false,
    bool coloredParent = false,
  }) {
    for (var element in _list) {
      if (element is _OnClick) throw Exception("You can't have few onClick in one modifier");
    }
    _list.add(
      _OnClick(
        onClick: onClick,
        inkWell: inkWell,
        coloredParent: coloredParent,
      ),
    );
    return this;
  }

  Modifier alignment(Alignment alignment) {
    _list.add(_Alignment(alignment));
    return this;
  }

  void addCustomType(dynamic type) {
    _list.add(type);
  }
}

class WidgetModifier extends StatefulWidget {
  Modifier modifier;
  Widget child;
  Widget Function(dynamic element, Widget child)? builder;

  WidgetModifier({
    Key? key,
    required this.modifier,
    required this.child,
    this.builder,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WidgetModifier> {
  @override
  Widget build(BuildContext context) {
    final list = widget.modifier._list;
    if (list.isEmpty) return widget.child;
    return buildChain(list.iterator);
  }

  Widget buildChain(Iterator iterator) {
    if (iterator.moveNext() == false) return widget.child;
    final element = iterator.current;

    if (element is _Container) {
      return Container(
        alignment: element.alignment,
        constraints: BoxConstraints(
          minHeight: element.height ?? element.minHeight ?? 0,
          maxHeight: element.height ?? element.maxHeight ?? double.infinity,
          minWidth: element.width ?? element.minWidth ?? 0,
          maxWidth: element.width ?? element.maxWidth ?? double.infinity,
        ),
        color: element.color,
        child: buildChain(iterator),
      );
    }

    if (element is EdgeInsets) {
      return Padding(
        padding: element,
        child: buildChain(iterator),
      );
    }

    if (element is _Expanded) {
      return Expanded(
        child: buildChain(iterator),
        flex: element.flex,
      );
    }

    if (element is _OnClick) {
      return element.inkWell
          ? element.coloredParent
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: element.onClick,
                    child: buildChain(iterator),
                  ),
                )
              : InkWell(
                  onTap: element.onClick,
                  child: buildChain(iterator),
                )
          : GestureDetector(
              onTap: element.onClick,
              child: buildChain(iterator),
            );
    }

    if (element is _Card) {
      return Card(
        elevation: element.elevation,
        shape: element.shape,
        child: buildChain(iterator),
      );
    }

    if (element is _Alignment) {
      return Align(
        alignment: element.alignment,
        child: buildChain(iterator),
      );
    }

    if (element is _OverScroll) {
      return ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: element.enabled),
        child: element.enabled
            ? GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: element.color,
                child: buildChain(iterator),
              )
            : buildChain(iterator),
      );
    }

    final builder = widget.builder;
    if (builder != null) {
      return builder(element, buildChain(iterator));
    }

    throw Exception("Unknown param: $element."
        "You either forgot to add custom 'builder' or something is super broken in lib");
  }
}
