import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String password2 = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/icono-gris.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              const Text('Signup', style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 100,
              ),
              Container(
                  child: const Text(
                    'Nom',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  width: 400),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: _controller,
                  onChanged: (String value) async {
                    name = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nom',
                  ),
                ),
                width: 400,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: const Text(
                    'Cognoms',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  width: 400),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: _controller2,
                  onChanged: (String value) async {
                    surname = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cognoms',
                  ),
                ),
                width: 400,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: const Text(
                    'Correu electrònic',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18),
                  ),
                  width: 400),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: _controller3,
                  onChanged: (String value) async {
                    email = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correu electrònic',
                  ),
                ),
                width: 400,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: const Text(
                  'Contrasenya',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                ),
                width: 400,
              ),
              SizedBox(height: 10),
              Container(
                  child: TextField(
                    controller: _controller4,
                    onChanged: (String value) async {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contrasenya',
                    ),
                  ),
                  width: 400),
              SizedBox(
                height: 30,
              ),
              Container(
                child: const Text(
                  'Repeteix la contrasenya',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                ),
                width: 400,
              ),
              SizedBox(height: 10),
              Container(
                  child: TextField(
                    controller: _controller5,
                    onChanged: (String value) async {
                      password2 = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contrasenya',
                    ),
                  ),
                  width: 400),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        color: Colors.green.shade400,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(13.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_controller5.text != _controller4.text) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const AlertDialog(
                                  title:
                                      Text("Les contrasenyes no coincideixen"),
                                );
                              });
                        } else if (_controller.text == '' ||
                            _controller2.text == '' ||
                            _controller3.text == '' ||
                            _controller4.text == '' ||
                            _controller5.text == '') {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return const AlertDialog(
                                  title: Text(
                                      "Falten camps per omplir. Sisplau, omple'ls per poder continuar"),
                                );
                              });
                        }
                        //runApp(MaterialApp(home: Structure()));
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
