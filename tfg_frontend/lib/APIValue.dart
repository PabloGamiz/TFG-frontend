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
  String action = '';
  int actionNumber = 0;
  int infoNumber = 0;
  String info = '';
  String element = '';

  bool noClassification = false;
  bool building = false;
  bool software = false;
  bool initial = true;

  //Classification fields

  String number_metrics = '';
  static String purpose = '';
  static String classification = '';
  static String minC = '';
  static String maxC = '';
  static String minC1 = 'valor de minC1';
  static String maxC1 = '';
  static String minC2 = '';
  static String maxC2 = '';

  bool visibleC = false;
  bool visibleC1C2 = false;

  //Building API values input fields
  static String antiquity = '';
  static String value_type = '';
  static String indicator = '';
  static String building_type = '';
  static String climatic_zone = '';
  static String value1 = '';
  static String value2 = '';
  static String value3 = '';

  bool visible1 = true;
  bool visible2 = false;
  bool visible3 = false;

  //Software API values input fields

  static String component = '';

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
                  'Edfici',
                  antiquity,
                  value_type,
                  indicator,
                  building_type,
                  climatic_zone,
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
          await createBuildingData('Sistema software', '', _controller.text, '',
                  component, '', _controller2.text, _controller3.text, '')
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
                  'Edfici',
                  antiquity,
                  value_type,
                  indicator,
                  building_type,
                  climatic_zone,
                  _controller.text,
                  _controller2.text,
                  _controller3.text)
              .then((String result) {
            setState(() {
              response = result;
            });
          });
        } else if (element == 'Sistema software') {
          await updateBuildingData('Sistema software', '', _controller.text, '',
                  component, '', _controller2.text, _controller3.text, '')
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
          await deleteBuildingData('Edfici', antiquity, value_type, indicator,
                  building_type, climatic_zone)
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
    print(response);

    if (!mounted) return;
    runApp(MaterialApp(home: APIResponse(response: response)));
  }

/*  static List<Widget> _APIInfo = <Widget>[
    Container(
      height: 5,
    ),
    classificationInputs(),
  ];

  static List<Widget> _APIFeatures = <Widget>[
    Container(
      height: 5,
    ),
    buildingInputs(),
    softwareInputs()
  ];*/

  Widget buildingInputs() {
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
                  if (newValue == 'Dispersió' && action != 'DELETE') {
                    visible2 = visible3 = false;
                  } else if (newValue == 'Valor mitjà' && action != 'DELETE') {
                    visible2 = visible3 = true;
                  }
                  setState(() {
                    value_type = newValue!;
                  });
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
                items: ['', 'A1', 'A2', 'A3']
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
                    if (newValue == 'Demanda' && action != 'DELETE') {
                      visible2 = true;
                      visible3 = false;
                    } else if ((newValue == 'Consum d\'energia' ||
                            newValue == 'Emissions') &&
                        action != 'DELETE') {
                      visible2 = visible3 = true;
                    }
                    indicator = newValue!;
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
              Visibility(
                child: Text('Introdueix el primer valor:'),
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
                    labelText: 'Introdueix un valor',
                  ),
                ),
                visible: visible1,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        const SizedBox(
          width: 150,
        ),
      ],
    );
  }

  Widget classificationInputs() {
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
              const Text(
                  'Indica la finalitat el nombre de mètriques que es faran servir per obtenir la classificació:'),
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
                items: ['', '1', '2']
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
    );
  }

  Widget softwareInputs() {
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
              Visibility(
                  child: const Text('Introdueix el segon valor:'),
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
                      labelText: 'Introdueix un valor',
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
              const Text('Introdueix el primer valor:'),
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
              Visibility(
                  child: const Text('Introdueix el tercer valor:'),
                  visible: visible1),
              Visibility(
                  child: const SizedBox(
                    height: 5,
                  ),
                  visible: visible1),
              Visibility(
                  child: TextField(
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
                  visible: visible1),
            ],
          ),
        ),
        const SizedBox(
          width: 150,
        ),
      ],
    );
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
          const Text('Quin tipus d\'acció vols realitzar?'),
          const SizedBox(
            height: 5,
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
                visible1 = visible2 = visible3 = visibleC = visibleC1C2 = false;
              }
            },
            items: ['', 'POST', 'PUT', 'DELETE']
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
          const Text('Quin tipus d\'informació vols introduir o modificar?'),
          const SizedBox(
            height: 5,
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
                if (newValue == '') {
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
            items: ['', 'Classificació', 'Dades de càlcul']
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
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
              child: Expanded(
                  child: Container(
                height: 100,
              )),
              visible: initial),
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
