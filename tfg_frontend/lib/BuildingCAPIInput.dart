import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildingCAPIInput extends StatefulWidget {
  @override
  _BuildingCAPIInput createState() => _BuildingCAPIInput();
}

class _BuildingCAPIInput extends State {
  static String purpose = '';
  static String classification = '';
  static String minC = '';
  static String maxC = '';
  static String minC1 = '';
  static String maxC1 = '';
  static String minC2 = '';
  static String maxC2 = '';

  bool visibleC = false;
  bool visibleC1C2 = false;

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
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
              const Text('Indica la finalitat de l\'edifici'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: purpose,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  if (newValue == 'Residencial') {
                    visibleC1C2 = true;
                    visibleC = false;
                  } else if (newValue == 'No residencial') {
                    visibleC1C2 = false;
                    visibleC = true;
                  }
                  setState(() {
                    purpose = newValue!;
                  });
                  storeValues('purpose', purpose);
                },
                items: ['', 'Residencial', 'No residencial']
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
                  visible: visibleC,
                  child: const Text('Introdueix el valor miním de C:')),
              Visibility(
                  visible: visibleC,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC,
                  child: TextField(
                    controller: _controller2,
                    onChanged: (String value) async {
                      storeValues('minC', value);
                      minC = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    ),
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: const Text('Introdueix el valor miním de C1:')),
              Visibility(
                  visible: visibleC1C2,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: TextField(
                    controller: _controller2,
                    onChanged: (String value) async {
                      minC1 = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: visibleC1C2,
                  child: const Text('Introdueix el valor miním de C2:')),
              Visibility(
                  visible: visibleC1C2,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: TextField(
                    controller: _controller4,
                    onChanged: (String value) async {
                      storeValues('minC2', value);
                      minC2 = value;
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
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Introdueix la lletra a la que pertanyarà o pertany el llindar:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller,
                onChanged: (String value) async {
                  storeValues('classification', value);
                  classification = value;
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
                  visible: visibleC,
                  child: const Text('Introdueix el valor màxim de C:')),
              Visibility(
                  visible: visibleC,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC,
                  child: TextField(
                    controller: _controller3,
                    onChanged: (String value) async {
                      storeValues('maxC', value);
                      maxC = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    ),
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: const Text('Introdueix el valor miním de C1:')),
              Visibility(
                  visible: visibleC1C2,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: TextField(
                    controller: _controller3,
                    onChanged: (String value) async {
                      storeValues('maxC1', value);
                      maxC1 = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Introdueix un valor',
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                  visible: visibleC1C2,
                  child: const Text('Introdueix el valor miním de C2:')),
              Visibility(
                  visible: visibleC1C2,
                  child: const SizedBox(
                    height: 5,
                  )),
              Visibility(
                  visible: visibleC1C2,
                  child: TextField(
                    controller: _controller5,
                    onChanged: (String value) async {
                      storeValues('maxC2', value);
                      maxC2 = value;
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
