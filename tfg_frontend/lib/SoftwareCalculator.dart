import 'package:flutter/material.dart';

class SoftwareCalculator extends StatefulWidget {
  @override
  _SoftwareCalculator createState() => _SoftwareCalculator();
}

class _SoftwareCalculator extends State {
  String cpu = '';
  String minCPU = '';
  String maxCPU = '';

  String gpu = '';
  String minGPU = '';
  String maxGPU = '';

  String memoryGB = '';
  String minMemory = '';
  String maxMemory = '';

  String testingDuration = '';
  String testingErrors = '';
  String solvedErrors = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late TextEditingController _controller7;
  late TextEditingController _controller8;
  late TextEditingController _controller9;
  late TextEditingController _controller10;

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _controller7 = TextEditingController();
    _controller8 = TextEditingController();
    _controller9 = TextEditingController();
    _controller10 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    _controller8.dispose();
    _controller9.dispose();
    _controller10.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 150,
          ),
          Expanded(
              child: Column(
            children: [
              const Text('Quina es la CPU emprada en l\'execució?'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: cpu,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    cpu = newValue!;
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
              const Text('Quina es la GPU emprada en l\'execució?'),
              const SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: gpu,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    gpu = newValue!;
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
              const Text('Indica el tamany en GB de la mermòria:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller5,
                onChanged: (String value) async {
                  memoryGB = value;
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
              const Text('Indica el nombre de falles trobades en el testeig:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller8,
                onChanged: (String value) async {
                  testingErrors = value;
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
            children: [
              const Text(
                  'Indica el percentatge de CPU abans l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller,
                onChanged: (String value) async {
                  minCPU = value;
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
                  'Indica el percentatge de CPU abans l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller3,
                onChanged: (String value) async {
                  minGPU = value;
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
                  'Indica el percentatge de memòria abans l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller6,
                onChanged: (String value) async {
                  minMemory = value;
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
              const Text('Indica la duració del testeig en dies:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller8,
                onChanged: (String value) async {
                  testingDuration = value;
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
            children: [
              const Text(
                  'Indica el percentatge de CPU durant l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller2,
                onChanged: (String value) async {
                  maxCPU = value;
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
                  'Indica el percentatge de GPU durant l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller4,
                onChanged: (String value) async {
                  maxGPU = value;
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
                  'Indica el percentatge de memòria durant l\'execució del software:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller7,
                onChanged: (String value) async {
                  maxMemory = value;
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
              const Text('Indica el nombre de falles arreglades:'),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _controller10,
                onChanged: (String value) async {
                  solvedErrors = value;
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
