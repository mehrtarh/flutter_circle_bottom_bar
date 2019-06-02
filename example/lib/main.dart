import 'package:flutter/material.dart';
import 'package:flutter_circle_bottombar/animation_circle_bottom_bar.dart';
import 'package:flutter_circle_bottombar/tab_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  CircularBottomNavigationController _navigationController =
      new CircularBottomNavigationController(0);
  String _text = "test";

  @override
  Widget build(BuildContext context) {


    List<TabItem> tabItems = List.of([
    new TabItem(Icons.access_alarm,normalColor: Colors.white,selectedColor: Colors.yellowAccent,shadowColor: Colors.yellowAccent),
      new TabItem(Icons.person_outline,normalColor: Colors.white,selectedColor: Colors.deepOrange,shadowColor: Colors.deepOrangeAccent),
      new TabItem(Icons.lightbulb_outline,normalColor: Colors.white,selectedColor: Colors.red,shadowColor: Colors.redAccent),
      new TabItem(Icons.home,normalColor: Colors.white,selectedColor: Color(0xFF433F3C),shadowColor: Colors.yellowAccent),
      new TabItem(Icons.phone_locked,normalColor: Colors.white,selectedColor: Colors.purple,shadowColor: Colors.purpleAccent),
      new TabItem(Icons.camera_front,normalColor: Colors.white,selectedColor: Colors.deepPurple,shadowColor: Colors.deepPurpleAccent),
      new TabItem(Icons.camera,normalColor: Colors.white,selectedColor: Colors.pink,shadowColor: Colors.pinkAccent),

    ]);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Circle bottom bar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(_text),
          ],
        ),
      ),
      bottomNavigationBar: CircularBottomNavigation(
        tabItems,
        selectedCallback: (int selectedPos) {
          setState(() {

            _text = "text " + selectedPos.toString();
          });
//          _navigationController.value = selectedPos;
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
      ),
    );
  }
}
