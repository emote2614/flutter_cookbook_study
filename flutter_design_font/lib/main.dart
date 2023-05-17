import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Fonts',
      //기본 폰트 : Raleway
      theme: ThemeData(fontFamily: 'Raleway'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar 의 기본폰트 변경
      appBar: AppBar(title: Text('Package Fonts')),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //기본 폰트 적용
            Text('Raleway',style: TextStyle(fontSize: 50),),
            //특정 폰트 적용
            Text('RobotoMono',style: TextStyle(fontFamily: 'RobotoMono',fontSize: 50),)
          ],
        )
      ),
    );
  }
}