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
          width: 200,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image(
              image: AssetImage('images/icono-blanco.png'),
              width: 125,
              height: 125,
            ),
            SizedBox(width: 1, height: 75),
            FlatButton(
              onPressed: () {},
              child: Text(
                'Inici',
                style: TextStyle(color: Colors.white, fontSize: 20),
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
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/introduirvalors');
              },
              child: Text(
                'Introdueix valors',
                style: TextStyle(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('Green Id Card', style: TextStyle(fontSize: 50)),
                const SizedBox(height: 200),
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
                              size: 100,
                            ),
                            SizedBox(width: 1, height: 20),
                            Text(
                              'Calcula l\'eficiencia d\'un edifici',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'o sistema software i visualitza',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'els resultats dels càlculs',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 1,
                      width: 100,
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
                              size: 100,
                            ),
                            SizedBox(width: 1, height: 20),
                            Text(
                              'Actualitza els valors que es',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'troben a la base de dades per',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'realitzar càlculs actuals',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 1,
                      width: 100,
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
                              size: 100,
                            ),
                            SizedBox(width: 1, height: 20),
                            Text(
                              'Genera un informe amb els resultatd',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'obtinguts i una representació de',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'certificat energètic',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
