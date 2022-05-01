import 'package:flutter/material.dart';
import 'package:tfg_frontend/main.dart';
import 'BuildingInputs.dart';

class EfficiencyCalculator extends StatefulWidget {
  @override
  _EfficiencyCalculator createState() => _EfficiencyCalculator();
}

class _EfficiencyCalculator extends State {
  String element = '';
  String buildingVariable = '';
  String buildingVariableValue = '';
  String buildingPurpose = '';
  String buildingAntiquity = '';

  late TextEditingController _controller;

  void initState() {
    super.initState();
  }

  static List<Widget> _widgetOptionsIfRegistered = <Widget>[
    BuildingInputs(),
  ];

  void calculateEfficiency() {
    if (buildingPurpose == 'Residencial') {
      //obtener el valor de la dispersion
      //obtener el valor del parque de edificios
      //Float C1 = (((r * i_o / i_r) - 1) / 2 * (r - 1)) + 0.6;
      //Float C2 = (((r_2 * i_o / i_s) - 1) / 2 * (r_2 - 1)) + 0.5;
      //pasar valores al endpoint correspondiente
    } else if (buildingPurpose == 'No residencial') {
      //obtener el valor de la dispersion
      //obtener el valor del parque de edificios
      //Float C1 = (((r * i_o / i_r) - 1) / 2 * (r - 1)) + 0.6;
      //Float C2 = (((r_2 * i_o / i_s) - 1) / 2 * (r_2 - 1)) + 0.5;
      //Float C = C1/C2;
      //pasar valor de C al endpoint correspondiente
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Calculadora de l\'eficiència',
          style: TextStyle(fontSize: 40),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 60,
        ),
        const Text('De quin element vols calcular l\'eficiència?'),
        const SizedBox(
          height: 5,
        ),
        DropdownButton(
          value: element,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: <String>[
            '',
            'Sistema software',
            'Edifici',
            'Cotxe',
            'Electrodomèstic'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newvalue) {
            setState(() {
              element = newvalue!;
            });
          },
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 500,
          child: _widgetOptionsIfRegistered.elementAt(0),
        ),
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
      ]),
    );
  }
}
