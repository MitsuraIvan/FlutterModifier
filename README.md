# FlutterModifier

![image](https://user-images.githubusercontent.com/7251389/176548087-5307b3ab-6772-4007-9866-8be30953c4f7.png)

No more beign mentalleakleklrahekrhakle. Swap this

      child: InkWell(
        onTap: () {},
        child: Container(
          height: 100,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text("Literally nothing"),
            ),
          ),
        ),
      ),
      
 With this
 
       child: WidgetModifier(
        modifier: Modifier()
            .onClick(onClick: () {})
            .background(height: 100, width: 300)
            .padding(edgeInsets: const EdgeInsets.all(8)),
        child: Text("Literally nothing"),
      ),
      
Stop with smiling get some help ),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),),
 
**Chains are thing, btw:**

            .background(color: Colors.red)
            .padding(edgeInsets: const EdgeInsets.all(80))
            .background(color: Colors.blue)
            .padding(edgeInsets: const EdgeInsets.all(80))

**Add you custom modifier:**
 
```
//I have no fantasy for example here, but you can literally combine any Widgets in any way and form you want to reuse in single line way:
extension EXT_MODIFIER on Modifier {
  static Widget myCustomBuilder(dynamic element, Widget child) {
    if (element == _MyCustomTag) {
      return Card(
        color: (element as _MyCustomTag).someParam,
        child: child,
      );
    }
    if (element == _MySweattyTag) {
      final sweatyItem = element as _MySweattyTag;
      return Padding(
        padding: EdgeInsets.all(sweatyItem.number3),
        child: SizedBox(
          height: sweatyItem.number1,
          width: sweatyItem.number2,
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

```
