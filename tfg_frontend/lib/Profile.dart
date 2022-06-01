import 'package:flutter/material.dart';
import 'package:tfg_frontend/Structure.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';

import 'endpoints/Objects/BuildingResult.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  bool file = false;

  void initState() {
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
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              CircleAvatar(
                child: Image.asset('images/profile-icon.png'),
                backgroundColor: Colors.grey,
                radius: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: Text('Nomnbre y apellido',
                          style: TextStyle(fontSize: 18)),
                      width: 500),
                  Container(
                      child: Text('email del usuario',
                          style: TextStyle(fontSize: 15)),
                      width: 500),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                color: Colors.red,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(13.0),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                /*BuildingResult br = BuildingResult(
                                    consumption_class: '',
                                    consumption: '',
                                    demand_class: '',
                                    demand: '',
                                    emissions_class: '',
                                    emissions: '',
                                    climatic_zone: '',
                                    in_consumption: '',
                                    in_demand: '',
                                    in_emissions: '',
                                    purpose: '',
                                    service: '',
                                    type: '');
                                SoftwareResult sr = SoftwareResult(
                                    efficiency: '',
                                    efficiency_class: '',
                                    consumption: '',
                                    consumption_class: '',
                                    perdurability: '',
                                    perdurability_class: '',
                                    CPU_percentatge: 0.0,
                                    GPU_percentatge: 0.0,
                                    mem_percentatge: 0.0,
                                    cpu_before: '',
                                    cpu_execution: '',
                                    cpu: '',
                                    gpu_before: '',
                                    gpu_execution: '',
                                    gpu: '',
                                    mem_before: '',
                                    mem_execution: '',
                                    mem_size: '',
                                    num_days: '',
                                    num_errors: '',
                                    PUE: '');
                                runApp(MaterialApp(
                                    home: Structure(br: br, sr: sr, tipus: 0)));*/
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      ),
                      width: 100),
                ],
              ),
              const SizedBox(width: 50),
            ],
          ),
          const SizedBox(
            height: 20,
          ),

          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Selecciona un fitxer:'),
                    Container(
                      height: 500,
                      width: 400,
                      child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                  horizontal: 4.0,
                                ),
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        file = true;
                                      });
                                    },
                                    title: Text('Nombre del objeto'),
                                  ),
                                ));
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 35,
                      width: 400,
                      child: ClipRRect(
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
                              onPressed: () {},
                              child: const Text('Afegeix un nova carpeta'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Selecciona un càlcul:'),
                    Container(
                      child: ListView.builder(
                          itemCount: 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                  horizontal: 4.0,
                                ),
                                child: Card(
                                  child: ListTile(
                                    onTap:
                                        () {}, //se muestra una alerta con la información del cálculo
                                    title: Column(children: [
                                      Row(
                                        children: [
                                          const Text('Objecte:'),
                                          Text('tipus d\'objecte'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Data:'),
                                          Text('Data de càlcul'),
                                        ],
                                      ),
                                    ]),
                                  ),
                                ));
                          }),
                      width: 400,
                      height: 500,
                    ),
                  ],
                ),
              ],
            ),
          ), //se obtienen los calculos y se ve la lista de calculos
        ],
      ),
    ));
  }
}
