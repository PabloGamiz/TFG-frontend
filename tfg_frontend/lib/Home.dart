import 'package:flutter/material.dart';
import 'APIValue.dart';
import 'Calculator.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
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
              onPressed: () {},
              child: Text(
                'Inici',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 * MediaQuery.of(context).size.width / 1536),
              ),
            ),
            SizedBox(
              height: 50,
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
            ),
            SizedBox(
              height: 50 * MediaQuery.of(context).size.height / 864,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/introduirvalors');
              },
              child: Text(
                'Introdueix valors',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536),
              ),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20 * MediaQuery.of(context).size.height / 864),
                Text(
                  'Green Id Card',
                  style: TextStyle(
                    fontSize: 50 * MediaQuery.of(context).size.width / 1536,
                  ),
                ),
                SizedBox(
                    height: 200 * MediaQuery.of(context).size.height / 864),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/calculeficiencia');
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.calculate,
                              color: Colors.black,
                              size: 100 *
                                  MediaQuery.of(context).size.height /
                                  864,
                            ),
                            SizedBox(
                                width: 1,
                                height: 20 *
                                    MediaQuery.of(context).size.height /
                                    864),
                            Text(
                              'Calcula l\'eficiencia d\'un edifici',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'o sistema software i visualitza',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'els resultats dels càlculs',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 1,
                      width: 100 * MediaQuery.of(context).size.width / 1536,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/introduirvalors');
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.update_rounded,
                              color: Colors.black,
                              size: 100 *
                                  MediaQuery.of(context).size.height /
                                  864,
                            ),
                            SizedBox(
                                width: 1,
                                height: 20 *
                                    MediaQuery.of(context).size.height /
                                    864),
                            Text(
                              'Actualitza els valors que es',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'troben a la base de dades per',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'realitzar càlculs actuals',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 1,
                      width: 100 * MediaQuery.of(context).size.width / 1536,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/calculeficiencia');
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.black,
                              size: 100 *
                                  MediaQuery.of(context).size.height /
                                  864,
                            ),
                            SizedBox(
                                width: 1,
                                height: 20 *
                                    MediaQuery.of(context).size.height /
                                    864),
                            Text(
                              'Genera un informe amb els resultatd',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'obtinguts i una representació de',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                            Text(
                              'certificat energètic',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20 *
                                    MediaQuery.of(context).size.width /
                                    1536,
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
