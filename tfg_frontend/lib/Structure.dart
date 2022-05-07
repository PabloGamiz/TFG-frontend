import 'package:flutter/material.dart';
import 'APIValue.dart';
import 'Calculator.dart';

class Structure extends StatefulWidget {
  @override
  _Structure createState() => _Structure();
}

class _Structure extends State {
  int selectedIndex = 0;

  void initState() {
    super.initState();
  }

  static List<Widget> _AppFeatures = <Widget>[Calculator(), APIValue()];

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
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('icono-gris.png'),
                  fit: BoxFit.cover,
                ),
              ),*/
              child: _AppFeatures.elementAt(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }
}
