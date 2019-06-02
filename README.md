# Circle bottom bar

Flutter circle bottom bar


#### how to use:

##### 1. add dependencies to pubspec.yaml:

```yaml
flutter_circle_bottombar: ^1.0.0
```

##### 2. create tabs:
```dart
List<TabItem> tabItems = List.of([
    new TabItem(Icons.access_alarm,normalColor: Colors.white,selectedColor: Colors.yellowAccent,shadowColor: Colors.yellowAccent),
      new TabItem(Icons.person_outline,normalColor: Colors.white,selectedColor: Colors.deepOrange,shadowColor: Colors.deepOrangeAccent),
      new TabItem(Icons.lightbulb_outline,normalColor: Colors.white,selectedColor: Colors.red,shadowColor: Colors.redAccent),
      new TabItem(Icons.home,normalColor: Colors.white,selectedColor: Color(0xFF433F3C),shadowColor: Colors.yellowAccent),
      new TabItem(Icons.phone_locked,normalColor: Colors.white,selectedColor: Colors.purple,shadowColor: Colors.purpleAccent),
      new TabItem(Icons.camera_front,normalColor: Colors.white,selectedColor: Colors.deepPurple,shadowColor: Colors.deepPurpleAccent),
      new TabItem(Icons.camera,normalColor: Colors.white,selectedColor: Colors.pink,shadowColor: Colors.pinkAccent),
    ]);
```

##### 3. create bottombar:

```dart
bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        selectedCallback: (int selectedPos) {
          setState(() {

            _text = "text " + selectedPos.toString();
          });
          print("clicked on $selectedPos");
        },
        controller: _navigationController,
        barBackgroundColor: Colors.orange.shade500,
        iconsSize: 24,
        animationDuration: Duration(milliseconds: 500),
        circleStrokeWidth: 5,
        circleSelectedStrokeColor:Colors.orange.shade700,
        circleUnSelectedStrokeColor: Colors.orange.shade900,
        circleUnSelectedColor: Colors.orange.shade700,
        circleSelectedColor:  Color(0xFF433F3C),
        circlePosition:3,
        barShadowSize: 10.0,
        barLineColor: Colors.red.shade900,
        barLineSize: 2.0,
        barShowLine: true,
      )
```