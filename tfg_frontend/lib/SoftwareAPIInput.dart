import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/main.dart';

class SoftwareAPIInput extends StatefulWidget {
  @override
  _SoftwareAPIInput createState() => _SoftwareAPIInput();
}

class _SoftwareAPIInput extends State {
  static String component = '';
  static String value1 = '';
  static String value2 = '';
  static String value3 = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;

  Future<void> storeValues(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }

  static Map<String, String> _getValues() {
    return {
      'component': component,
      'value1': value1,
      'value2': value2,
      'value3': value3
    };
  }

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
                const Text('Indica el tipus de component:'),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton<String>(
                  value: component,
                  style: TextStyle(color: Colors.green.shade700),
                  underline: Container(
                    height: 2,
                    color: Colors.green.shade50,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      component = newValue!;
                    });
                    storeValues('component', component);
                  },
                  items: ['', 'CPU', 'GPU']
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
                const Text('Introdueix el segon valor:'),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controller2,
                  onChanged: (String value) async {
                    storeValues('value2', value);
                    value2 = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Introdueix un valor',
                  ),
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
                const Text('Introdueix el primer valor:'),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controller,
                  onChanged: (String value) async {
                    storeValues('value1', value);
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
                const Text('Introdueix el tercer valor:'),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controller3,
                  onChanged: (String value) async {
                    storeValues('value3', value);
                    value3 = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Introdueix un valor',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 150,
          ),
        ],
      ),
    );
  }
}
