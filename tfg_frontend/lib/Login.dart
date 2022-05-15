import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/StructureConnected.dart';

import 'endpoints/Calls/UserCalls.dart';
import 'endpoints/Objects/BuildingResult.dart';
import 'endpoints/Objects/SoftwareResult.dart';
import 'endpoints/Objects/User.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String email = '';
  String password = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;

  late User userInfo;

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

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await getUser(_controller.text).then((User u) {
      setState(() {
        userInfo = u;
      });
    });
    if (_controller.text == '' || _controller2.text == '') {
      showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              title: Text(
                  "Falten camps per omplir. Sisplau, omple'ls per poder fer el login"),
            );
          });
    } else if (userInfo.email == '' || userInfo.password != _controller2.text) {
      showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              title: Text('L\'email o la contrasenya no son correctes'),
            );
          });
    } else {
      await prefs.setString('email', userInfo.email);
      await prefs.setString('name', userInfo.name);
      await prefs.setString('surname', userInfo.surname);
      await prefs.setString('password', userInfo.password);
      await prefs.setBool('admin', userInfo.admin);
      BuildingResult br = BuildingResult(
          consumption_class: '',
          consumption: '',
          demand_class: '',
          demand: '',
          emissions_class: '',
          emissions: '');
      SoftwareResult sr = SoftwareResult(
          efficiency: '',
          efficiency_class: '',
          consumption: '',
          consumption_class: '',
          perdurability: '',
          perdurability_class: '',
          CPU_percentatge: 0.0,
          GPU_percentatge: 0.0,
          mem_percentatge: 0.0);
      runApp(MaterialApp(home: StructureConnected(br: br, sr: sr, tipus: 0)));
    }
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
                        BuildingResult br = BuildingResult(
                            consumption_class: '',
                            consumption: '',
                            demand_class: '',
                            demand: '',
                            emissions_class: '',
                            emissions: '');
                        SoftwareResult sr = SoftwareResult(
                            efficiency: '',
                            efficiency_class: '',
                            consumption: '',
                            consumption_class: '',
                            perdurability: '',
                            perdurability_class: '',
                            CPU_percentatge: 0.0,
                            GPU_percentatge: 0.0,
                            mem_percentatge: 0.0);
                        runApp(MaterialApp(
                            home:
                                StructureConnected(br: br, sr: sr, tipus: 0)));
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
