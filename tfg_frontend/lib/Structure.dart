import 'package:flutter/material.dart';
import 'package:tfg_frontend/Signup.dart';
import 'APIValue.dart';
import 'Calculator.dart';
import 'Login.dart';

class Structure extends StatefulWidget {
  @override
  _Structure createState() => _Structure();
}

class _Structure extends State {
  int selectedIndex = 0;

  void initState() {
    super.initState();
  }

  static List<Widget> _AppFeatures = <Widget>[
    Signup(),
    Calculator(),
    APIValue()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.lightGreen,
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
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
                icon: Icon(Icons.person, color: Colors.white, size: 30),
                label: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
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
