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

  //Camps relacionats amb el software

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

//Camps per als edificis

  static String building_type = '';
  static String service = '';
  static String climatic_zone = '';
  static String type = '';

  static String value1 = '';
  static String value2 = '';
  static String value3 = '';

  bool visibleBuilding = false;
  bool visibleSoftware = false;

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

  void calculateEfficiency() {
    if (element == 'Edifici') {
      if (building_type == 'Residencial') {
        //obtener el valor de la dispersion
        //obtener el valor del parque de edificios
        //obtener el valor de la dispersion para
        //Float C1 = (((r * i_o / i_r) - 1) / 2 * (r - 1)) + 0.6;
        //Float C2 = (((r_2 * i_o / i_s) - 1) / 2 * (r_2 - 1)) + 0.5;
        //pasar valores al endpoint correspondiente
      } else if (building_type == 'No residencial') {
        //obtener el valor de la dispersion
        //obtener el valor del parque de edificios
        //Float C1 = (((r * i_o / i_r) - 1) / 2 * (r - 1)) + 0.6;
        //Float C2 = (((r_2 * i_o / i_s) - 1) / 2 * (r_2 - 1)) + 0.5;
        //Float C = C1/C2;
        //pasar valor de C al endpoint correspondiente
      }
    } else if (element == 'Sistema software') {
      //----------------------------CALCULO EFICIENCIA--------------------------------

      //obtener la informacion de la CPU seleccionada
      //obtener informacion de la GPU seleccionada

      //double efficiency_cpu = (numero_nucleos*gasto_nucleo*(_controller2.text-_controller.text))/(numero_nucleos*gasto_nucleo*_controller2.text);
      //double efficiency_gpu = (numero_nucleos*gasto_nucleo*(_controller4.text-_controller3.text))/(numero_nucleos*gasto_nucleo*_controller4.text);
      //double efficiency_mem = (energia_GB * (_controller6.text-_controller5.text))/(energia_GB * _controller6.text);
      //double efficiency = efficiency_cpu + efficiency_gpu + efficiency_mem;

      //realizar llamada para obtener el valor de la classificacion para la eficiencia

      //-----------------------------CALCULO OPTIMIZACION RECURSOS---------------------

      //double cpu_optimization = (_controller2.text-_controller.text)/_controller2.text;
      //double gpu_optimization = (_controller4.text-_controller3.text)/_controller4.text;
      //double mem_optimization = (_controller6.text-_controller5.text)/_controller6.text;

      //double optimization = cpu_optimization + gpu_optimization + mem_optimization;

      //realizar llamada para obtener el valor de la classificacion para la optimizacion

      //-----------------------------CALCULO OPTIMIZACION DE CAPACIDAD---------------------------

      //double op_consumption_cpu = (numero_nucleos*gasto_nucleo*(_controller2.text-_controller.text))/(numero_nucleos*gasto_nucleo*_controller2.text);
      //double op_consumption_gpu = (numero_nucleos*gasto_nucleo*(_controller4.text-_controller3.text))/(numero_nucleos*gasto_nucleo*_controller4.text);
      //double op_consumption_mem = (energia_GB * (_controller6.text-_controller5.text))/(energia_GB * _controller6.text);
      //double op_consumption = efficiency_cpu + efficiency_gpu + efficiency_mem;

      //----------------------------CALCULO PERDURABILIDAD----------------------------------------

    }
  }

  Widget buildingCalculator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Indica la finalitat del edifici:'),
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
    );
  }

  Widget softwareCalculator() {
    return Row(
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
    );
  }

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
                element = newValue!;
              });
              if (element == '') {
                visibleBuilding = false;
                visibleSoftware = false;
              } else if (element == 'Edifici') {
                visibleBuilding = true;
                visibleSoftware = false;
              } else if (element == 'Sistema software') {
                visibleBuilding = false;
                visibleSoftware = true;
              }
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
          Visibility(
            child: Expanded(
                child: Container(
              height: 300,
            )),
            visible: !visibleBuilding && !visibleSoftware,
          ),
          Visibility(
              child: Expanded(
                  child: Container(
                child: buildingCalculator(),
              )),
              visible: visibleBuilding),
          Visibility(
              child: Expanded(
                  child: Container(
                child: softwareCalculator(),
              )),
              visible: visibleSoftware),
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
