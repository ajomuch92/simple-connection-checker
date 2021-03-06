import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple Connection Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';
  StreamSubscription? subscription;
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress('pub.dev');
  
  @override
  void initState() {
    super.initState();
    subscription = _simpleConnectionChecker.onConnectionChange.listen((connected) {
      setState(() {
        _message = connected? 'Connected': 'Not connected';
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                bool _isConnected = await SimpleConnectionChecker.isConnectedToInternet();
                setState(() {
                  _message = _isConnected? 'Connected': 'Not connected';
                });
              }, 
              child: Text('Check connection')
            ),
            Text(
              _message,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
