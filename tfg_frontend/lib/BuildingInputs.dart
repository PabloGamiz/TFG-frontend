import 'dart:io';

import 'package:flutter/material.dart';

class BuildingInputs extends StatefulWidget {
  @override
  _BuildingInputs createState() => _BuildingInputs();
}

class _BuildingInputs extends State {
  String buildingVariable = '';
  String buildingVariableValue = '';
  String buildingPurpose = '';
  String buildingAntiquity = '';
  String variableFeature = '';
  String climaticZone = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget buttonWidget() {
    if (buildingVariable == '' ||
        buildingVariableValue == '' ||
        buildingPurpose == '' ||
        buildingAntiquity == '' ||
        variableFeature == '' ||
        climaticZone == '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                color: Colors.green.shade100,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(13.0),
                primary: Colors.white,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: null,
              child: const Text('Calcula l\'eficiència'),
            ),
          ],
        ),
      );
    } else {
      return ClipRRect(
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
              child: const Text('Calcula l\'eficiència'),
            ),
          ],
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Introdueix els següents valors per conèixer més sobre l\'edifici',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Escull la variable del edifici:',
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            value: buildingVariable,
            style: TextStyle(color: Colors.green.shade700),
            underline: Container(
              height: 2,
              color: Colors.green.shade50,
            ),
            onChanged: (String? newValue) {
              setState(() {
                buildingVariable = newValue!;
              });
            },
            items: ['', 'Calefacció', 'Refrigeració', 'Aigua corrent sanitària']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Escull la mètrica que vols calcular per aquesta variable:',
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton<String>(
            value: variableFeature,
            style: TextStyle(color: Colors.green.shade700),
            underline: Container(
              height: 2,
              color: Colors.green.shade50,
            ),
            onChanged: (String? newValue) {
              setState(() {
                variableFeature = newValue!;
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(
                child: Column(
                  children: [
                    Text('Introdueix el valor de la variable seleccionada:'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _controller,
                      onChanged: (String value) async {
                        buildingVariableValue = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor de la variable',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Container(child: Text('Quina és finalitat de l\'edifici?')),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: buildingPurpose,
                        style: TextStyle(color: Colors.green.shade700),
                        underline: Container(
                          height: 2,
                          color: Colors.green.shade50,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            buildingPurpose = newValue!;
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Container(
                        child: Text('Quina és l\'antiguitat de l\'edifici?')),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: DropdownButton<String>(
                        value: buildingAntiquity,
                        style: TextStyle(color: Colors.green.shade700),
                        underline: Container(
                          height: 2,
                          color: Colors.green.shade50,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            buildingAntiquity = newValue!;
                          });
                        },
                        items: ['', 'Nou', 'Existent']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IntrinsicWidth(
                child: Column(
                  children: [
                    Container(
                        child: Text(
                            'Indica la zona climàtica on es troba l\'edifici')),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller: _controller2,
                        onChanged: (String value2) async {
                          climaticZone = value2;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Valor de la zona climàtica',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          buttonWidget(),
        ],
      ),
    );
  }
}
