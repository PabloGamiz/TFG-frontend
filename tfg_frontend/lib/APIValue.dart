import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/endpoints/Calls/CalculationData.dart';
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
  bool maxvalue = false;

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
    if (action == 'POST') {
      if (info == 'Classificació') {
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
            title: Text(response,
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Continuar',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
              )
            ],
          );
        });
  }

  Widget buildingInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        'Introdueix els valors següents dels edificis per poder realitzar l\'acció:',
        style:
            TextStyle(fontSize: 18 * MediaQuery.of(context).size.width / 1536),
      ),
      SizedBox(
        height: 20 * MediaQuery.of(context).size.height / 864,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Indica l\'antiguitat de l\'edifici:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: antiquity,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Text('Indica el tipus d\'edifici:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: building_type,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                  child: Text('Indica la classificació del valor màxim:',
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                  visible: maxvalue,
                ),
                Visibility(
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    visible: maxvalue),
                Visibility(
                    child: DropdownButton<String>(
                      iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                      value: max_classification,
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536),
                      underline: Container(
                        height: 2 * MediaQuery.of(context).size.height / 864,
                        color: Colors.green.shade50,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          max_classification = newValue!;
                        });
                      },
                      items: [
                        'Escull la classificació',
                        'A',
                        'B',
                        'C',
                        'D',
                        'E',
                        'F',
                        'G'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 14 *
                                      MediaQuery.of(context).size.width /
                                      1536)),
                        );
                      }).toList(),
                    ),
                    visible: maxvalue),
                Visibility(
                  child: SizedBox(
                    height: 20 * MediaQuery.of(context).size.height / 864,
                  ),
                  visible: maxvalue && action != 'DELETE',
                ),
                Visibility(
                    visible: maxvalue && action != 'DELETE',
                    child: Text('Introdueix el valor de ACS:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: maxvalue && action != 'DELETE',
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: maxvalue && action != 'DELETE',
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller3,
                        onChanged: (String value) async {
                          value3 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'ACS',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                Visibility(
                  child: Text('Introdueix el valor de la calefacció:',
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                  visible: visible1 &&
                      action != 'DELETE' &&
                      value_type != 'Dispersió',
                ),
                Visibility(
                  child: SizedBox(
                    height: 5 * MediaQuery.of(context).size.height / 864,
                  ),
                  visible: visible1 &&
                      action != 'DELETE' &&
                      value_type != 'Dispersió',
                ),
                Visibility(
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller,
                        onChanged: (String value) async {
                          value1 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Calefacció',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                  visible: visible1 &&
                      action != 'DELETE' &&
                      value_type != 'Dispersió',
                ),
                Visibility(
                  child: Text('Introdueix el valor de la dispersió:',
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                  visible: value_type == 'Dispersió',
                ),
                Visibility(
                  child: SizedBox(
                    height: 5 * MediaQuery.of(context).size.height / 864,
                  ),
                  visible: value_type == 'Dispersió',
                ),
                Visibility(
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller,
                        onChanged: (String value) async {
                          value1 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Dispersió',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                  visible: value_type == 'Dispersió',
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Indica el tipus de valor:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: value_type,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                        '4',
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
                    } else if (newValue == 'Valor mitjà' ||
                        newValue == 'Màxim') {
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
                    if (newValue == 'Màxim') {
                      visible1 =
                          visible2 = visible3 = visibleC = visibleC1C2 = false;
                      maxvalue = true;
                    } else {
                      maxvalue = false;
                      visible1 = true;
                    }
                  },
                  items: [
                    'Escull el tipus de valors',
                    'Valor mitjà',
                    'Dispersió',
                    'Màxim'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Text('Indica la zona d\'España on es troba:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: zone,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
                    color: Colors.green.shade50,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      zone = newValue!;
                    });
                  },
                  items: [
                    'Escull la zona',
                    'Península',
                    'Ceuta, Melilla i Illes Balears',
                    'Illes Canàries'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: visible2,
                    child: Text('Introdueix el valor de la refrigeració:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visible2,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visible2,
                  child: SizedBox(
                      child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller2,
                          onChanged: (String value) async {
                            value2 = value;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Refrigeració',
                          )),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                Visibility(
                  child: Text('Introdueix el valor de la calefacció:',
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                  visible: maxvalue && action != 'DELETE',
                ),
                Visibility(
                  child: SizedBox(
                    height: 5 * MediaQuery.of(context).size.height / 864,
                  ),
                  visible: maxvalue && action != 'DELETE',
                ),
                Visibility(
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller,
                        onChanged: (String value) async {
                          value1 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Calefacció',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                  visible: maxvalue && action != 'DELETE',
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              children: [
                Text('Indica el tipus de l\'indicador:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: indicator,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Text('Indica la zona climàtica:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: climatic_zone,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: visible3,
                    child: Text('Introdueix el valor de ACS:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visible3,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visible3,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller3,
                        onChanged: (String value) async {
                          value3 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'ACS',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                Visibility(
                    visible: maxvalue && action != 'DELETE',
                    child: Text('Introdueix el valor de la refrigeració:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: maxvalue && action != 'DELETE',
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: maxvalue && action != 'DELETE',
                  child: SizedBox(
                      child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller2,
                          onChanged: (String value) async {
                            value2 = value;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Refrigeració',
                          )),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
        ],
      )
    ]);
  }

  Widget classificationInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        'Introdueix els valors següents de la classificació per poder realitzar l\'acció:',
        style:
            TextStyle(fontSize: 18 * MediaQuery.of(context).size.width / 1536),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Text(
                    'Indica el nombre de mètriques necessàries per obtenir la classificació:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: number_metrics,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  underline: Container(
                    height: 2 * MediaQuery.of(context).size.height / 864,
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                  visible: visibleC,
                  child: Text('Introdueix el valor miním de C:',
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                ),
                Visibility(
                    visible: visibleC,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller2,
                        onChanged: (String value) async {
                          minC = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor mínim de C',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                Visibility(
                    visible: visibleC1C2,
                    child: Text('Introdueix el valor miním de C1:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visibleC1C2,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC1C2,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller2,
                        onChanged: (String value) async {
                          minC1 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor mínim de C1',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: visibleC1C2,
                    child: Text('Introdueix el valor miním de C2:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visibleC1C2,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC1C2,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller4,
                        onChanged: (String value) async {
                          minC2 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor mínim de C2',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Introdueix la lletra a la que pertanyarà o pertany el llindar:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                SizedBox(
                    child: TextField(
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536),
                      controller: _controller,
                      onChanged: (String value) async {
                        classification = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        border: OutlineInputBorder(),
                        labelText: 'Indica la lletra de classificació',
                      ),
                    ),
                    height: 45 * MediaQuery.of(context).size.height / 864),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: visibleC,
                    child: Text('Introdueix el valor màxim de C:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visibleC,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller3,
                        onChanged: (String value) async {
                          maxC = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor màxim de C',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                Visibility(
                    visible: visibleC1C2,
                    child: Text('Introdueix el valor màxim de C1:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visibleC1C2,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC1C2,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller3,
                        onChanged: (String value) async {
                          maxC1 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor màxim de C1',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: visibleC1C2,
                    child: Text('Introdueix el valor màxim de C2:',
                        style: TextStyle(
                            fontSize: 14 *
                                MediaQuery.of(context).size.width /
                                1536))),
                Visibility(
                    visible: visibleC1C2,
                    child: SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    )),
                Visibility(
                  visible: visibleC1C2,
                  child: SizedBox(
                      child: TextField(
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        controller: _controller5,
                        onChanged: (String value) async {
                          maxC2 = value;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          border: OutlineInputBorder(),
                          labelText: 'Valor màxim de C2',
                        ),
                      ),
                      height: 45 * MediaQuery.of(context).size.height / 864),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
        ],
      ),
    ]);
  }

  Widget softwareInputs() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        'Introdueix els valors següents dels sistemes software per poder realitzar l\'acció:',
        style:
            TextStyle(fontSize: 18 * MediaQuery.of(context).size.width / 1536),
      ),
      SizedBox(height: 30 * MediaQuery.of(context).size.height / 864),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Text('Indica el tipus de component:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                DropdownButton<String>(
                  iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                  value: component,
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
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
                      child: Text(value,
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536)),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    child: Text('Introdueix el consum màxim del component:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    visible: visible1),
                Visibility(
                  child: SizedBox(
                    height: 5 * MediaQuery.of(context).size.height / 864,
                  ),
                  visible: visible1,
                ),
                Visibility(
                    child: SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller2,
                          onChanged: (String value) async {
                            value2 = value;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Consum màxim',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    visible: visible1),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Introdueix el nom del component:',
                    style: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536)),
                SizedBox(
                  height: 5 * MediaQuery.of(context).size.height / 864,
                ),
                SizedBox(
                    child: TextField(
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536),
                      controller: _controller,
                      onChanged: (String value) async {
                        value1 = value;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536),
                        labelText: 'Nom',
                      ),
                    ),
                    height: 45 * MediaQuery.of(context).size.height / 864),
              ],
            ),
          ),
          SizedBox(
            width: 120 * MediaQuery.of(context).size.width / 1536,
          ),
        ],
      ),
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Container(
          color: Colors.lightGreen,
          width: 200 * MediaQuery.of(context).size.width / 1536,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image(
              image: AssetImage('images/icono-blanco.png'),
              width: 125 * MediaQuery.of(context).size.width / 1536,
              height: 125 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
                width: 1,
                height: 75 * MediaQuery.of(context).size.height / 864),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: Text(
                'Inici',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
            SizedBox(
              height: 50 * MediaQuery.of(context).size.height / 864,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/calculeficiencia');
              },
              child: Text(
                'Calcula l\'eficiència',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
            SizedBox(
              height: 50 * MediaQuery.of(context).size.height / 864,
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Introdueix valors',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 * MediaQuery.of(context).size.width / 1536,
                ),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
          ]),
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
                Text(
                  'Modificació de la API',
                  style: TextStyle(
                      fontSize: 30 * MediaQuery.of(context).size.width / 1536),
                ),
                SizedBox(
                  height: 50 * MediaQuery.of(context).size.height / 864,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Indica el tipus d\'acció que vols realitzar: ',
                      style: TextStyle(
                          fontSize:
                              18 * MediaQuery.of(context).size.width / 1536),
                    ),
                    SizedBox(
                      width: 20 * MediaQuery.of(context).size.width / 1536,
                    ),
                    DropdownButton<String>(
                      iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                      value: action,
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536),
                      underline: Container(
                        height: 2 * MediaQuery.of(context).size.height / 864,
                        color: Colors.green.shade50,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          action = newValue!;
                        });
                        if (action == 'DELETE') {
                          visible1 = visible2 = visible3 =
                              visibleC = maxvalue = visibleC1C2 = false;
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
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Indica el tipus d\'informació per al que vols realitzar l\'acció: ',
                      style: TextStyle(
                          fontSize:
                              18 * MediaQuery.of(context).size.width / 1536),
                    ),
                    SizedBox(
                      width: 20 * MediaQuery.of(context).size.width / 1536,
                    ),
                    DropdownButton<String>(
                      iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                      value: info,
                      style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536),
                      underline: Container(
                        height: 2 * MediaQuery.of(context).size.height / 864,
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
                      items: [
                        'Escull el tipus',
                        'Classificació',
                        'Dades de càlcul'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    visible: noClassification && !initial,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Indica l\'objecte per al que vols introduir, actualitzar o esborrar dades:',
                          style: TextStyle(
                              fontSize: 18 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                        ),
                        SizedBox(
                          width: 20 * MediaQuery.of(context).size.width / 1536,
                        ),
                        DropdownButton<String>(
                          iconSize:
                              14 * MediaQuery.of(context).size.width / 1536,
                          value: element,
                          style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          underline: Container(
                            height:
                                2 * MediaQuery.of(context).size.height / 864,
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
                          items: [
                            'Escull l\'objecte',
                            'Edifici',
                            'Sistema software'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                    child: Expanded(child: Container()),
                    visible: initial ||
                        (!initial &&
                            !building &&
                            !software &&
                            noClassification)),
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
                          textStyle: TextStyle(
                              fontSize: 20 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                        ),
                        onPressed: () {
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
                                        _controller5.text != '') ||
                                    action == 'DELETE')) {
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
                                        _controller3.text != '') ||
                                    (max_classification !=
                                            'Escull la classificació' &&
                                        value_type == 'Màxim' &&
                                        _controller.text != '' &&
                                        _controller2.text != '' &&
                                        _controller3.text != '') ||
                                    (max_classification !=
                                            'Escull la classificació' &&
                                        value_type == 'Màxim' &&
                                        action == 'DELETE'))) {
                              realizarCrida();
                            } else if (info == 'Dades de càlcul' &&
                                element == 'Sistema software' &&
                                component != 'Escull el tipus' &&
                                ((_controller.text != '' &&
                                        _controller2.text != '') ||
                                    (action == 'DELETE' &&
                                        _controller.text != ''))) {
                              realizarCrida();
                            } else {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text('Falten valors per introduir',
                                        style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1536)),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text('Continuar',
                                            style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536)),
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text('Falten valors per introduir',
                                      style: TextStyle(
                                          fontSize: 14 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1536)),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: Text('Continuar',
                                          style: TextStyle(
                                              fontSize: 14 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536)),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('Continuar'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
