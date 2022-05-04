/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildingAPIInput extends StatefulWidget {
  final ValueChanged<Map<String, String>> getValues;
  BuildingAPIInput({required Key key, required this.getValues})
      : super(key: key);

  @override
  _BuildingAPIInput createState() => _BuildingAPIInput();
}

class _BuildingAPIInput extends State<BuildingAPIInput> {
  static String antiquity = '';
  static String value_type = '';
  static String indicator = '';
  static String building_type = '';
  static String climatic_zone = '';
  static String value1 = '';
  static String value2 = '';
  static String value3 = '';


  bool visible2 = false;
  bool visible3 = false;

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

  Future<void> storeValues(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
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
              const Text('Indica l\'antiguitat de l\'edifici:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: antiquity,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    antiquity = newValue!;
                  });
                  values.update('antiquity', (value) => antiquity);
                  widget.getValues(values);
                },
                items: ['', 'Nou', 'Existent']
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
              const Text('Indica el tipus de l\'indicador:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: indicator,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue == 'Demanda') {
                      visible2 = true;
                      visible3 = false;
                    } else if (newValue == 'Consum d\'energia' ||
                        newValue == 'Emissions') {
                      visible2 = visible3 = true;
                    }
                    indicator = newValue!;
                  });
                  values.update('indicator', (value) => indicator);
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
                  values.update('climatic_zone', (value) => climatic_zone);
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
              Visibility(
                  visible: visible2,
                  child: const Text('Introdueix el segon valor:')),
              Visibility(
                  visible: visible2,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                visible: visible2,
                child: TextField(
                    controller: _controller2,
                    onChanged: (String value) async {
                      value2 = value;
                      values.update('value2', (value) => value);
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 150,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Indica el tipus de valor que vols afegir o actualitzar:'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: value_type,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  if (newValue == 'Dispersió') {
                    visible2 = visible3 = false;
                  } else if (newValue == 'Valor mitjà') {
                    visible2 = visible3 = true;
                  }
                  setState(() {
                    value_type = newValue!;
                  });
                  values.update('value_type', (value) => value_type);
                },
                items: ['', 'Valor mitjà', 'Dispersió']
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
                  values.update('building_type', (value) => building_type);
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
              const Text('Introdueix el primer valor:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller,
                onChanged: (String value) async {
                  value1 = value;
                  values.update('value1', (value) => value);
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
              Visibility(
                  visible: visible3,
                  child: const Text('Introdueix el tercer valor:')),
              Visibility(
                  visible: visible3,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visible3,
                  child: TextField(
                    controller: _controller3,
                    onChanged: (String value) async {
                      value3 = value;
                      values.update('value3', (value) => value);
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(
          width: 150,
        ),
      ],
    ));
  }
}
*/