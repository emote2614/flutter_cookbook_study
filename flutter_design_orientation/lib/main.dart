import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Orientation Demo';

    return MaterialApp(
      title: appTitle,
      home: OrientationList(
        title: appTitle,
      ),
    );
  }
}

class OrientationList extends StatelessWidget {
  final String title;

  OrientationList({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                crossAxisSpacing: 10, // 가로 여백
                mainAxisSpacing: 10, // 세로 여백
                padding: EdgeInsets.all(15.0),
                children: <Widget>[
                  Container(color: Colors.blue,),
                  Container(color: Colors.blue,),
                  Container(color: Colors.blue,),
                  Container(color: Colors.blue,),
                  Container(color: Colors.blue,),
                  Container(color: Colors.blue,),
                ],
              );
            }
        ));
  }
}