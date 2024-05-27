import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.channel');
  String _message = 'Waiting for message from iOS...';

  @override
  void initState() {
    super.initState();
    fetchDataFromNative();
  }

  void fetchDataFromNative() async {
    final MethodChannel platformChannel = MethodChannel('banu');
    try {
      final String result =
          await platformChannel.invokeMethod('getDataFromNative');
      setState(() {
        _message = result;
      });
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Center(
          child: Text(_message),
        ),
      ),
    );
  }
}
