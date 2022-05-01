import 'package:flutter/material.dart';

class BuildingCalculator extends StatefulWidget {
  @override
  _BuildingCalculator createState() => _BuildingCalculator();
}

class _BuildingCalculator extends State {
  static String building_type = '';
  static String service = '';
  static String climatic_zone = '';
  static String type = '';

  static String value1 = '';
  static String value2 = '';
  static String value3 = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  static Map<String, String> _getValues() {
    return {
      'building_type': building_type,
      'service': service,
      'climatic_zone': climatic_zone,
      'type': type,
      'value1': value1,
      'value2': value2,
      'value3': value3
    };
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Indica el tipus d\'edifici:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: building_type,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    building_type = newValue!;
                  });
                },
                items: ['', 'Unifamiliar', 'Bloc']
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
              const Text('Indica el tipus d\'edifici:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: type,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    type = newValue!;
                  });
                },
                items: ['', 'Unifamiliar', 'Bloc']
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
              const Text(
                  'Introdueix el valor de la demanda pel servei seleccionat:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller,
                onChanged: (String value) async {
                  value1 = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introdueix un valor',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'Introdueix el valor de la emissions pel servei seleccionat:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller3,
                onChanged: (String value) async {
                  value3 = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introdueix un valor',
                ),
              ),
            ],
          )),
          const SizedBox(
            width: 150,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Indica el servei per al que vols calcular l\'eficiència:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: service,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    service = newValue!;
                  });
                },
                items: [
                  '',
                  'Calefacció',
                  'Refrigeració',
                  'Aigua corrent sanitària'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Indica la zona climàtica:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: climatic_zone,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    climatic_zone = newValue!;
                  });
                },
                items: ['', 'Demanda', 'Consum d\'energia', 'Emissions']
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'Introdueix el valor del consum d\'energia pel servei seleccionat:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller2,
                onChanged: (String value) async {
                  value2 = value;
                },
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Introdueix un valor',
                ),
              ),
            ],
          )),
          const SizedBox(
            width: 150,
          ),
        ],
      ),
    );
  }
}
