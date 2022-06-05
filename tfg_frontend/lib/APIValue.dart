import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/APIResponse.dart';
import 'package:tfg_frontend/BuildingCAPIInput.dart';
import 'package:tfg_frontend/endpoints/Calls/CalculationData.dart';
import 'BuildingAPIInput.dart';
import 'SoftwareAPIInput.dart';
import 'endpoints/Objects/CalculationData.dart';
import 'endpoints/Calls/Classification.dart';

class APIValue extends StatefulWidget {
  @override
  _APIValue createState() => _APIValue();
}

class _APIValue extends State {
  //APIValue fields
  String action = 'Escull l\'acció';
  int actionNumber = 0;
  int infoNumber = 0;
  String info = 'Escull el tipus';
  String element = 'Escull l\'objecte';

  bool noClassification = false;
  bool building = false;
  bool software = false;
  bool initial = true;

  //Classification fields

  String number_metrics = 'Escull el nombre de mètriques';
  static String purpose = '';
  static String classification = '';
  static String minC = '0.0';
  static String maxC = '0.0';
  static String minC1 = '0.0';
  static String maxC1 = '0.0';
  static String minC2 = '0.0';
  static String maxC2 = '0.0';

  bool visibleC = false;
  bool visibleC1C2 = false;

  //Building API values input fields
  static String antiquity = 'Escull l\'antiguitat';
  static String value_type = 'Escull el tipus de valors';
  static String indicator = 'Escull l\'indicador';
  static String building_type = 'Escull el tipus d\'edifici';
  static String climatic_zone = 'Escull la zona climàtica';
  String max_classification = 'Escull la classificació';
  String zone = 'Escull la zona';
  static String value1 = '0.0';
  static String value2 = '0.0';
  static String value3 = '0.0';

  bool visible1 = true;
  bool visible2 = false;
  bool visible3 = false;

  //Software API values input fields

  static String component = 'Escull el tipus';

  List<String> climaticZones = [];

  ////////////////////////////////

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

  void realizarCrida() async {
    String response = '';
    print(
        '-----------------------------Antes de hacer las llamadas------------------------------');
    if (action == 'POST') {
      print('dentro del post');
      if (info == 'Classificació') {
        print('classification');
        await createClassificationData(
                number_metrics,
                classification,
                _controller2.text,
                _controller3.text,
                _controller4.text,
                _controller5.text)
            .then((String result) {
          setState(() {
            response = result;
          });
        });
      } else if (info == 'Dades de càlcul') {
        if (element == 'Edifici') {
          print('no classificacion dentro de edificio');
          await createBuildingData(
                  'Edifici',
                  antiquity,
                  value_type,
                  indicator,
                  building_type,
                  climatic_zone,
                  zone,
                  max_classification,
                  _controller.text,
                  _controller2.text,
                  _controller3.text)
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        } else if (element == 'Sistema software') {
          print('no clasificacion dentro de sistema software');
          await createBuildingData(
                  'Sistema software',
                  '',
                  _controller.text,
                  '',
                  component,
                  '',
                  '',
                  '',
                  _controller2.text,
                  _controller3.text,
                  '')
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        }
      }
    } else if (action == 'PUT') {
      if (info == 'Classificació') {
        print('dentro de actualizar clasificacion');
        await updateClassificationData(
                number_metrics,
                classification,
                _controller2.text,
                _controller3.text,
                _controller4.text,
                _controller5.text)
            .then((String result) {
          setState(() {
            response = result;
          });
        });
      } else if (info == 'Dades de càlcul') {
        if (element == 'Edifici') {
          await updateBuildingData(
                  'Edifici',
                  antiquity,
                  value_type,
                  indicator,
                  building_type,
                  climatic_zone,
                  zone,
                  max_classification,
                  _controller.text,
                  _controller2.text,
                  _controller3.text)
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        } else if (element == 'Sistema software') {
          await updateBuildingData(
                  'Sistema software',
                  '',
                  _controller.text,
                  '',
                  component,
                  '',
                  '',
                  '',
                  _controller2.text,
                  _controller3.text,
                  '')
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        }
      }
    } else if (action == 'DELETE') {
      if (info == 'Classificació') {
        await deleteClassificationData(number_metrics, classification)
            .then((String result) {
          setState(() {
            response = result;
          });
        });
      } else if (info == 'Dades de càlcul') {
        if (element == 'Edifici') {
          await deleteBuildingData('Edifici', antiquity, value_type, indicator,
                  building_type, climatic_zone, zone, max_classification)
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        } else if (element == 'Sistema software') {
          await deleteSoftwareData(
                  'Sistema software', _controller.text, component)
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        }
      }
    }
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(response),
          );
        });
  }

  Widget buildingInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        'Introdueix els valors següents dels edificis per poder realitzar l\'acció:',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
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
                  },
                  items: ['Escull l\'antiguitat', 'Nou', 'Existent']
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
                  },
                  items: ['Escull el tipus d\'edifici', 'Unifamiliar', 'Bloc']
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
                  child: Text('Introdueix el valor de la calefacció:'),
                  visible: visible1,
                ),
                Visibility(
                  child: const SizedBox(
                    height: 5,
                  ),
                  visible: visible1,
                ),
                Visibility(
                  child: TextField(
                    controller: _controller,
                    onChanged: (String value) async {
                      value1 = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Calefacció',
                    ),
                  ),
                  visible: visible1,
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
                    if (newValue == 'Dispersió' && action != 'DELETE') {
                      visible2 = visible3 = false;
                    } else if (newValue == 'Valor mitjà' &&
                        action != 'DELETE') {
                      visible2 = visible3 = true;
                    }
                    if (newValue == 'Dispersió') {
                      climaticZones = [
                        'Escull la zona climàtica',
                        'α',
                        'A',
                        'B',
                        'C',
                        'D',
                        'E',
                        '1',
                        '2',
                        '3',
                        '4'
                      ];
                    } else if (newValue == 'Valor mitjà') {
                      climaticZones = [
                        'Escull la zona climàtica',
                        'α1',
                        'α2',
                        'α3',
                        'α4',
                        'A1',
                        'A2',
                        'A3',
                        'A4',
                        'B1',
                        'B2',
                        'B3',
                        'B4',
                        'C1',
                        'C2',
                        'C3',
                        'C4',
                        'D1',
                        'D2',
                        'D3',
                        'E1'
                      ];
                    }
                    setState(() {
                      value_type = newValue!;
                    });
                  },
                  items: [
                    'Escull el tipus de valors',
                    'Valor mitjà',
                    'Dispersió',
                    'Màxim'
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
                const Text('Indica la zona d\'España on es troba:'),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton<String>(
                  value: zone,
                  style: TextStyle(color: Colors.green.shade700),
                  underline: Container(
                    height: 2,
                    color: Colors.green.shade50,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      zone = newValue!;
                    });
                  },
                  items: [
                    'Escull la zona',
                    'Península, Ceuta, Melilla i Illes Balears',
                    'Illes Canàries'
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
                Visibility(
                    visible: visible2,
                    child:
                        const Text('Introdueix el valor de la refrigeració:')),
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
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Refrigeració',
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
              children: [
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
                      if (newValue == 'Demanda' &&
                          action != 'DELETE' &&
                          value_type == 'Valor mitjà') {
                        visible2 = true;
                        visible3 = false;
                      } else if ((newValue == 'Consum d\'energia' ||
                              newValue == 'Emissions') &&
                          action != 'DELETE' &&
                          value_type == 'Valor mitjà') {
                        visible2 = visible3 = true;
                      }
                      indicator = newValue!;
                    });
                  },
                  items: [
                    'Escull l\'indicador',
                    'Demanda',
                    'Consum d\'energia',
                    'Emissions'
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
                  items: climaticZones
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
                    visible: visible3,
                    child: const Text('Introdueix el valor de ACS:')),
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
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ACS',
                      ),
                    )),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          const SizedBox(
            width: 150,
          ),
        ],
      )
    ]);
  }

  Widget classificationInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        'Introdueix els valors següents de la classificació per poder realitzar l\'acció:',
        style: TextStyle(fontSize: 18),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                    'Indica el nombre de mètriques necessàries per obtenir la classificació:'),
                const SizedBox(
                  height: 5,
                ),
                DropdownButton<String>(
                  value: number_metrics,
                  style: TextStyle(color: Colors.green.shade700),
                  underline: Container(
                    height: 2,
                    color: Colors.green.shade50,
                  ),
                  onChanged: (String? newValue) {
                    if (newValue == '2' && action != 'DELETE') {
                      visibleC1C2 = true;
                      visibleC = false;
                    } else if (newValue == '1' && action != 'DELETE') {
                      visibleC1C2 = false;
                      visibleC = true;
                    }
                    setState(() {
                      number_metrics = newValue!;
                    });
                  },
                  items: ['Escull el nombre de mètriques', '1', '2']
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
                        minC = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor mínim de C',
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
                        labelText: 'Valor mínim de C1',
                      ),
                    )),
                Text(_controller2.text),
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
                        minC2 = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor mínim de C2',
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
                    classification = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Indica la lletra de classificació',
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
                        maxC = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor màxim de C',
                      ),
                    )),
                Visibility(
                    visible: visibleC1C2,
                    child: const Text('Introdueix el valor màxim de C1:')),
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
                        maxC1 = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor màxim de C1',
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: visibleC1C2,
                    child: const Text('Introdueix el valor màxim de C2:')),
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
                        maxC2 = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor màxim de C2',
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            width: 150,
          ),
        ],
      ),
    ]);
  }

  Widget softwareInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text(
        'Introdueix els valors següents dels sistemes software per poder realitzar l\'acció:',
        style: TextStyle(fontSize: 18),
      ),
      SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                  },
                  items: ['Escull el tipus', 'CPU', 'GPU']
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
                    child: const Text('Introdueix el valor de TDP:'),
                    visible: visible1),
                Visibility(
                  child: const SizedBox(
                    height: 5,
                  ),
                  visible: visible1,
                ),
                Visibility(
                    child: TextField(
                      controller: _controller2,
                      onChanged: (String value) async {
                        value2 = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'TDP',
                      ),
                    ),
                    visible: visible1),
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
                const Text('Introdueix el nom del component:'),
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
                    labelText: 'Nom',
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
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Modificació de la API',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Indica el tipus d\'acció que vols realitzar: ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: action,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    action = newValue!;
                  });
                  if (action == 'DELETE') {
                    visible1 =
                        visible2 = visible3 = visibleC = visibleC1C2 = false;
                  }
                },
                items: ['Escull l\'acció', 'POST', 'PUT', 'DELETE']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Indica el tipus d\'informació per al que vols realitzar l\'acció: ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: info,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue == 'Escull el tipus') {
                      noClassification = false;
                      initial = true;
                    } else if (newValue == 'Classificació') {
                      noClassification = false;
                      initial = false;
                    } else if (newValue == 'Dades de càlcul') {
                      noClassification = true;
                      initial = false;
                    }
                    info = newValue!;
                  });
                },
                items: ['Escull el tipus', 'Classificació', 'Dades de càlcul']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
              visible: noClassification && !initial,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Indica l\'objecte per al que vols introduir, actualitzar o esborrar dades:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 20,
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
                        if (newValue == 'Escull l\'objecte') {
                          building = false;
                          software = false;
                        } else if (newValue == 'Edifici') {
                          building = true;
                          software = false;
                        } else if (newValue == 'Sistema software') {
                          building = false;
                          software = true;
                        }
                        element = newValue!;
                      });
                    },
                    items: ['Escull l\'objecte', 'Edifici', 'Sistema software']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              )),
          /*Visibility(
              child: const Text(
                  'Indica l\'element per al que vols realitzar l\'acció:'),
              visible: noClassification && !initial),
          Visibility(
            child: const SizedBox(
              height: 5,
            ),
            visible: noClassification && !initial,
          ),
          Visibility(
            child: DropdownButton<String>(
              value: element,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue == '') {
                    building = false;
                    software = false;
                  } else if (newValue == 'Edifici') {
                    building = true;
                    software = false;
                  } else if (newValue == 'Sistema software') {
                    building = false;
                    software = true;
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
            visible: noClassification && !initial,
          ),*/
          const SizedBox(
            height: 20,
          ),
          Visibility(
              child: Expanded(child: Container()),
              visible: initial ||
                  (!initial && !building && !software && noClassification)),
          Visibility(
              child: Expanded(
                  child: Container(
                child: classificationInputs(),
              )),
              visible: !noClassification && !initial),
          Visibility(
              child: Expanded(
                  child: Container(
                child: buildingInputs(),
              )),
              visible: noClassification && building && !initial),
          Visibility(
              child: Expanded(
                  child: Container(
                child: softwareInputs(),
              )),
              visible: noClassification && software && !initial),
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
                  onPressed: () {
                    //if ((number_metrics != '' && classification != '' && ((minC != '' && maxC != '') || (minC1 != '' && maxC1 != '') || (minC1 != '' && maxC1 != '' && minC2 != '' && maxC2 != ''))) {
                    if (action != 'Escull l\'acció' &&
                        info != 'Escull el tipus') {
                      if (info == 'Classificació' &&
                          number_metrics != '' &&
                          _controller.text != '' &&
                          ((_controller2.text != '' &&
                                  _controller3.text != '') ||
                              (_controller2.text != '' &&
                                  _controller3.text != '' &&
                                  _controller4.text != '' &&
                                  _controller5.text != ''))) {
                        realizarCrida();
                      } else if (info == 'Dades de càlcul' &&
                          element == 'Edifici' &&
                          antiquity != 'Escull l\'antiguitat' &&
                          value_type != 'Escull el tipus de valors' &&
                          indicator != 'Escull l\'indicador' &&
                          building_type != 'Escull el tipus d\'edifici' &&
                          climatic_zone != 'Escull la zona climàtica' &&
                          zone != 'Escull la zona' &&
                          ((value_type == 'Dispersió' &&
                                  _controller.text != '') ||
                              (value_type == 'Valor mitjà' &&
                                  indicator == 'Demanda' &&
                                  _controller.text != '' &&
                                  _controller2.text != '') ||
                              (value_type == 'Valor mitjà' &&
                                  _controller.text != '' &&
                                  _controller2.text != '' &&
                                  _controller3.text != ''))) {
                        realizarCrida();
                      } else if (info == 'Dades de càlcul' &&
                          element == 'Sistema software' &&
                          component != 'Escull el tipus' &&
                          _controller.text != '' &&
                          _controller2.text != '' &&
                          _controller3.text != '') {
                        realizarCrida();
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const AlertDialog(
                              title: Text('Falten valors per introduir'),
                            );
                          });
                    }
                    realizarCrida();
                  },
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
