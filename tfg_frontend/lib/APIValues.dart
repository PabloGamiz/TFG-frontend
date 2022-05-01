import 'package:flutter/material.dart';

class APIValues extends StatefulWidget {
  @override
  _APIValues createState() => _APIValues();
}

class _APIValues extends State {
  String dropdownAction = '';
  String dropdownInfo = '';
  String dropdownVariable = '';
  bool actionChoosen = false;
  bool dimensionChoosen = false;
  String action = '';
  String typeValue = '';
  String climaticZoneValue = '';

  String classificationValue = '';
  String minC1Value = '';
  String maxC1Value = '';
  String minC2Value = '';
  String maxC2Value = '';
  String minCValue = '';
  String maxCValue = '';

  String heatingValue = '';
  String refrigerationValue = '';
  String acsValue = '';
  String dispersionValue = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;

  List<DropdownMenuItem<String>> actionItems = [
    DropdownMenuItem(child: Text(''), value: ''),
    DropdownMenuItem(
        child: Text('Introduir un registre'), value: 'Introduir un registre'),
    DropdownMenuItem(
        child: Text('Actualitzar un registre'),
        value: 'Actualitzar un registre')
  ];

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
  }

  List<String> variablesValue() {
    List<String> menuItems = [''];
    if (dropdownInfo ==
            'Valors mitjans del parc d\'edificis per un edifici nou' ||
        dropdownInfo ==
            'Valors mitjans del parc d\'edificis per un edifici existent') {
      menuItems = [
        '',
        'Demanda',
        'Consum d\'energia',
        'Emissions',
      ];
    } else if (dropdownInfo ==
            'Dispersions de les variables per a edificis nous' ||
        dropdownInfo ==
            'Dispersions de les variables per a edificis existents') {
      menuItems = [
        '',
        'Demanda',
        'Consum d\'energia i emissions',
      ];
    }

    return menuItems;
  }

  Widget buttonWidget() {
    if ((classificationValue != '' &&
            minC1Value != '' &&
            maxC1Value != '' &&
            minC2Value != '' &&
            maxC2Value != '') ||
        (classificationValue != '' && minCValue != '' && maxCValue != '') ||
        (typeValue != '' &&
            climaticZoneValue != '' &&
            heatingValue != '' &&
            refrigerationValue != '') ||
        (typeValue != '' &&
            climaticZoneValue != '' &&
            heatingValue != '' &&
            refrigerationValue != '' &&
            acsValue != '') ||
        (typeValue != '' && climaticZoneValue != '' && dispersionValue != '')) {
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
              child: const Text('Continuar'),
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
              child: const Text('Continuar'),
            ),
          ],
        ),
      );
    }
  }

  Widget valuestoIntroduce() {
    if (dropdownInfo == 'Classificació d\'un edifici residencial') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Lletra representativa de la clase:'),
                TextField(
                  controller: _controller,
                  onChanged: (String value) async {
                    classificationValue = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lletra representativa',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor mínim de la variable C1'),
                TextField(
                  controller: _controller2,
                  onChanged: (String value) async {
                    minC1Value = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de C1',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor màxim de la variable C1'),
                TextField(
                  controller: _controller3,
                  onChanged: (String value) async {
                    maxC1Value = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de V1',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor mínim de la variable C2'),
                TextField(
                  controller: _controller4,
                  onChanged: (String value) async {
                    minC2Value = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de C2',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor màxim de la variable C2'),
                TextField(
                  controller: _controller5,
                  onChanged: (String value) async {
                    maxC2Value = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor de C2',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (dropdownInfo == 'Classificació d\'un edifici no residencial') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Lletra representativa de la clase:'),
                TextField(
                  controller: _controller,
                  onChanged: (String value) async {
                    classificationValue = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lletra representativa',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor mínim de la variable C'),
                TextField(
                  controller: _controller2,
                  onChanged: (String value) async {
                    minCValue = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lletra representativa',
                  ),
                ),
              ],
            ),
          ),
          IntrinsicWidth(
            child: Column(
              children: [
                const Text('Valor màxim de la variable C'),
                TextField(
                  controller: _controller3,
                  onChanged: (String value) async {
                    maxCValue = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lletra representativa',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if ((dropdownInfo ==
                'Valors mitjans del parc d\'edificis per un edifici nou' ||
            dropdownInfo ==
                'Valors mitjans del parc d\'edificis per un edifici existent') &&
        dimensionChoosen) {
      if (dropdownVariable == 'Demanda') {
        return Row(
          children: [
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Tipus d\'edifici:'),
                  Text('Dentro de demanda'),
                  DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        typeValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Zona climatica on es troba l\'edifici:'),
                  DropdownButton<String>(
                    value: climaticZoneValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        climaticZoneValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor mitjà de la calefacció:'),
                  TextField(
                    controller: _controller,
                    onChanged: (String value) async {
                      heatingValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la demanda de calefacció',
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor mitjà de la refrigeració:'),
                  TextField(
                    controller: _controller2,
                    onChanged: (String value) async {
                      classificationValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la refrigeració',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (dropdownVariable == 'Consum d\'energia' ||
          dropdownVariable == 'Emissions') {
        return Row(
          children: [
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Tipus d\'edifici:'),
                  Text('Dentro de consumo y emisiones'),
                  DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        typeValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Zona climatica on es troba l\'edifici:'),
                  DropdownButton<String>(
                    value: climaticZoneValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        climaticZoneValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor mitjà de la calefacció:'),
                  TextField(
                    controller: _controller,
                    onChanged: (String value) async {
                      heatingValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la calefacció',
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor mitjà de la refrigeració:'),
                  TextField(
                    controller: _controller2,
                    onChanged: (String value) async {
                      refrigerationValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la refrigeració',
                    ),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor mitjà de l\'aigua corrent sanitària:'),
                  TextField(
                    controller: _controller3,
                    onChanged: (String value) async {
                      classificationValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de l\'aigua corrent sanitària',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    } else if (dropdownInfo ==
            'Dispersions de les variables per a edificis nous' ||
        dropdownInfo ==
            'Dispersions de les variables per a edificis existents') {
      if (dropdownVariable == 'Demanda') {
        return Row(
          children: [
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Tipus d\'edifici:'),
                  DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        typeValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Zona climatica on es troba l\'edifici:'),
                  DropdownButton<String>(
                    value: climaticZoneValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        climaticZoneValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor de la dispersió:'),
                  TextField(
                    controller: _controller,
                    onChanged: (String value) async {
                      dispersionValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la dispersió',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (dropdownVariable == 'Consum d\'energia' ||
          dropdownVariable == 'Emissions') {
        return Row(
          children: [
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Tipus d\'edifici:'),
                  DropdownButton<String>(
                    value: typeValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        typeValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Zona climatica on es troba l\'edifici:'),
                  DropdownButton<String>(
                    value: climaticZoneValue,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        climaticZoneValue = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Casa individual',
                      'Edifici',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IntrinsicWidth(
              child: Column(
                children: [
                  const Text('Valor de dispersió pel consum i emissions:'),
                  TextField(
                    controller: _controller,
                    onChanged: (String value) async {
                      dispersionValue = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Valor de la dispersió',
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    }
    return const Scaffold(
      body: SizedBox(
        height: 5,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Text(
                    'Quina operació vols realitzar?',
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton(
                    value: dropdownAction,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: actionItems,
                    onChanged: (String? newvalue) {
                      setState(() {
                        dropdownAction = newvalue!;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Escull la informació que es vol introduir:',
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<String>(
                    value: dropdownInfo,
                    style: TextStyle(color: Colors.green.shade700),
                    underline: Container(
                      height: 2,
                      color: Colors.green.shade200,
                    ),
                    onChanged: (String? newValue) {
                      actionChoosen = false;
                      if (newValue != '' &&
                          newValue !=
                              'Classificació d\'un edifici residencial' &&
                          newValue !=
                              'Classificació d\'un edifici no residencial') {
                        actionChoosen = true;
                      }
                      setState(() {
                        dropdownInfo = newValue!;
                      });
                    },
                    items: <String>[
                      '',
                      'Classificació d\'un edifici residencial',
                      'Classificació d\'un edifici no residencial',
                      'Valors mitjans del parc d\'edificis per un edifici nou',
                      'Valors mitjans del parc d\'edificis per un edifici existent',
                      'Dispersions de les variables per a edificis nous',
                      'Dispersions de les variables per a edificis existents'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Visibility(
                    child: Column(
                      children: [
                        const Text(
                          'Escull la variable del edifici:',
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButton<String>(
                          value: dropdownVariable,
                          style: TextStyle(color: Colors.green.shade700),
                          underline: Container(
                            height: 2,
                            color: Colors.green.shade200,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              dimensionChoosen = true;
                              if (newValue != '') dimensionChoosen = true;
                              dropdownVariable = newValue!;
                            });
                          },
                          items: variablesValue()
                              .map<DropdownMenuItem<String>>((String value) {
                            action = value;
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    visible: actionChoosen,
                  ),
                ],
              )),
          Text(dropdownVariable),
          Container(height: 300, child: valuestoIntroduce()),
          buttonWidget(),
        ],
      ),
    ));
  }
}
