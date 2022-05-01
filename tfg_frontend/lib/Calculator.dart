import 'package:flutter/material.dart';
import 'package:tfg_frontend/BuildingCalculator.dart';
import 'BuildingCalculator.dart';
import 'SoftwareCalculator.dart';

class Calculator extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State {
  String action = '';
  int actionNumber = 0;
  String element = '';

  void initState() {
    super.initState();
  }

  static List<Widget> _CalculatorFeatures = <Widget>[
    Container(
      height: 5,
    ),
    BuildingCalculator(),
    SoftwareCalculator()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Càlcul de l\'eficiència',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text('De quin objecte vols calcular l\'eficiència?'),
          const SizedBox(
            height: 5,
          ),
          DropdownButton<String>(
            value: element,
            style: TextStyle(color: Colors.green.shade700),
            underline: Container(
              height: 2,
              color: Colors.green.shade50,
            ),
            onChanged: (String? newValue) {
              setState(() {
                if (newValue == '') {
                  actionNumber = 0;
                } else if (newValue == 'Edifici') {
                  actionNumber = 1;
                } else if (newValue == 'Sistema software') {
                  actionNumber = 2;
                }
                element = newValue!;
              });
            },
            items: ['', 'Edifici', 'Sistema software']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            child: _CalculatorFeatures.elementAt(actionNumber),
          )),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    color: Colors.green.shade300,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(13.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
