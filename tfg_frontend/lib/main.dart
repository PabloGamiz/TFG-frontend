import 'package:flutter/material.dart';
import 'package:tfg_frontend/APIValue.dart';
import 'package:tfg_frontend/Calculator.dart';
import 'package:tfg_frontend/EfficiencyResults.dart';
import 'package:tfg_frontend/Home.dart';
import 'endpoints/Objects/BuildingResult.dart';
import 'endpoints/Objects/SoftwareResult.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Green Id Card',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: '/home',
        routes: {
          '/calculeficiencia': (context) => Calculator(),
          '/calculeficiencia/resultat': (context) => EfficiencyResults(),
          '/home': (context) => Home(),
          '/introduirvalors': (context) => APIValue(),
        },
        home: Home());
  }
}
