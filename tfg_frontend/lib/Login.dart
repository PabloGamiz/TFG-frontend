import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String email = '';
  String password = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
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
              const Text('Login', style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 100,
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
                  controller: _controller,
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
                    controller: _controller2,
                    onChanged: (String value) async {
                      password = value;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contrasenya',
                    ),
                  ),
                  width: 400),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Row(
                    children: [
                      const Text('No tens cap compte? '),
                      const InkWell(
                        child: Text('Dona\'t d\'alta',
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline)),
                      ),
                    ],
                  ),
                  width: 400),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    const Text('T\'has oblidat de la contrasenya?'),
                    const InkWell(
                      child: Text('Recupera la contrasenya',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
                width: 400,
              ),
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
                        //runApp(MaterialApp(home: Structure()));
                      },
                      child: const Text('Log in'),
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
