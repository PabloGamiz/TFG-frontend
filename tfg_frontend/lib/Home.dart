import 'package:flutter/material.dart';
import 'package:tfg_frontend/Signup.dart';
import 'APIValue.dart';
import 'Calculator.dart';
import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Text('Pantalla de inicio'),
        ],
      ),
    );
  }
}
