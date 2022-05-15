import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/EfficiencyResults.dart';
import 'package:tfg_frontend/Profile.dart';
import 'package:tfg_frontend/Signup.dart';
import 'APIValue.dart';
import 'Calculator.dart';
import 'Home.dart';
import 'Login.dart';
import 'endpoints/Objects/BuildingResult.dart';
import 'endpoints/Objects/SoftwareResult.dart';

class StructureConnected extends StatefulWidget {
  final int tipus;
  final BuildingResult br;
  final SoftwareResult sr;

  const StructureConnected(
      {Key? key, required this.tipus, required this.br, required this.sr})
      : super(key: key);

  @override
  _StructureConnected createState() => _StructureConnected();
}

class _StructureConnected extends State<StructureConnected> {
  late int selectedIndex;
  late String name;

  List<Widget> _AppFeatures = <Widget>[];

  bool isAdmin = false;

  void initState() {
    if (widget.tipus == 0) {
      selectedIndex = 0;
      _AppFeatures = <Widget>[Home(), Profile(), Calculator(), APIValue()];
    } else if (widget.tipus == 1) {
      selectedIndex = 2;
      _AppFeatures = <Widget>[
        Home(),
        Profile(),
        EfficiencyResults(br: widget.br, sr: widget.sr, tipus: widget.tipus),
        APIValue()
      ];
    } else if (widget.tipus == 2) {
      selectedIndex = 2;
      _AppFeatures = <Widget>[
        Home(),
        Profile(),
        EfficiencyResults(br: widget.br, sr: widget.sr, tipus: widget.tipus),
        APIValue()
      ];
    }
    super.initState();
  }

  /*Future<void> initState() async {
    final prefs = await SharedPreferences.getInstance();
    String? user_name = prefs.getString('name');
    String? user_surname = prefs.getString('surname');
    bool? admin = prefs.getBool('admin');
    if (user_name != null && user_surname != null) {
      name = user_name + ' ' + user_surname;
    }
    if (admin != null) {
      if (admin) {
        isAdmin = true;
        _AppFeatures = <Widget>[Home(), Profile(), Calculator(), APIValue()];
      } else {
        isAdmin = false;
        _AppFeatures = <Widget>[Home(), Profile(), Calculator()];
      }
    }
    super.initState();
  }*/

  Widget adminNavigation() {
    return NavigationRail(
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
            name,
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
    );
  }

  Widget notAdminNavigation() {
    return NavigationRail(
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
              name,
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
        ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Visibility(child: adminNavigation(), visible: isAdmin),
          //Visibility(child: notAdminNavigation(), visible: !isAdmin),
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
                  'Pablo Gamiz',
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
