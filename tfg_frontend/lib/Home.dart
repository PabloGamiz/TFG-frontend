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
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/icono-gris.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text('Green Id Card', style: TextStyle(fontSize: 50)),
            const SizedBox(height: 150),
            const Text(
                '\u2192 Calcula l\'eficiència energètica per a un edifici o sistema software',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text(
                '\u2192 Veu la classificació energètica per a cadascun del valors calculats',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('\u2192 Visualitza les dades en forma de gràfic',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('\u2192 Genera un informe dels resultats obtinguts',
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
