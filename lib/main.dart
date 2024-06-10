import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Restriction App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      MethodChannel('com.example.youtube_configuration_app/accessibility');
  bool _isAccessibilityEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkAccessibility();
  }

  Future<void> _checkAccessibility() async {
    bool isEnabled;
    try {
      isEnabled = await platform.invokeMethod('isAccessibilityServiceEnabled');
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      isEnabled = false;
    }
    setState(() {
      _isAccessibilityEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YouTube Restriction App"),
      ),
      body: Center(
        child: _isAccessibilityEnabled
            ? Text("Accessibility Service is Enabled")
            : ElevatedButton(
                onPressed: _openAccessibilitySettings,
                child: Text("Enable Accessibility Service"),
              ),
      ),
    );
  }

  void _openAccessibilitySettings() {
    platform.invokeMethod('requestAccessibilityServicePermission');
  }
}
