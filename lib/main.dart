import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();
    _checkInternetPermission();
  }

  Future<void> _checkInternetPermission() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectivityResult = connectivityResult;
    });

    if (_connectivityResult == ConnectivityResult.none) {
      // No internet
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NoInternetPage()),
      );
    } else {
      // Internet available
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NextPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Permission Check'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: _connectivityResult == null
            ? CircularProgressIndicator()
            : Text(
          _connectivityResult == ConnectivityResult.none
              ? 'No Internet Connection'
              : 'Internet Available',
        ),
      ),
    );
  }
}

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NO INTERNET'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('No internet connection. Please check your connection.'),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INTERNET AVAILABLE'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('You have internet connection.'),
      ),
    );
  }
}
