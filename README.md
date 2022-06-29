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
 
 Add you custom modifier:
 
 *TODO*
