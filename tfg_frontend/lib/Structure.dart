import 'package:flutter/material.dart';
import 'package:tfg_frontend/EfficiencyResults.dart';
import 'package:tfg_frontend/Signup.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'APIValue.dart';
import 'Calculator.dart';
import 'Home.dart';
import 'Login.dart';
import 'endpoints/Objects/SoftwareResult.dart';

class Structure extends StatefulWidget {
  final int tipus;
  final BuildingResult br;
  final SoftwareResult sr;

  const Structure(
      {Key? key, required this.tipus, required this.br, required this.sr})
      : super(key: key);

  @override
  _Structure createState() => _Structure();
}

class _Structure extends State<Structure> {
  late SoftwareResult sr;
  late BuildingResult br;

  List<Widget> _AppFeatures = <Widget>[];

  int selectedIndex = 0;

  void initState() {
    if (widget.tipus == 0) {
      _AppFeatures = <Widget>[Home(), Calculator(), APIValue()];
    } else if (widget.tipus == 1) {
      selectedIndex = 1;
      _AppFeatures = <Widget>[
        Home(),
        EfficiencyResults(br: widget.br, sr: widget.sr, tipus: widget.tipus),
        APIValue()
      ];
    } else if (widget.tipus == 2) {
      selectedIndex = 1;
      _AppFeatures = <Widget>[
        Home(),
        EfficiencyResults(br: widget.br, sr: widget.sr, tipus: widget.tipus),
        APIValue()
      ];
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.lightGreen,
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              if (selectedIndex == 2 && index != selectedIndex) {
                _AppFeatures = <Widget>[Home(), Calculator(), APIValue()];
              }
              setState(() {
                selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Image(
                  image: AssetImage('images/icono-blanco.png'),
                  width: 125,
                  height: 125,
                ),
                label: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 1,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.calculate,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  'Calcula l\'eficiència',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(
                  Icons.api,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  'Introdueix valors',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1),
          Text((selectedIndex.toDouble()).toString()),
          Expanded(
            child: Container(
              child: _AppFeatures.elementAt(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
