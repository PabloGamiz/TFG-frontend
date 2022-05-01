import 'package:flutter/material.dart';

class BuildingResults extends StatefulWidget {
  @override
  _BuildingResults createState() => _BuildingResults();
}

class _BuildingResults extends State {
  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text('El valors obtinguts per als valors de '),
        const Text(' introduits són...'),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Column(
              children: [
                const Text('Demanda'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
            Column(
              children: [
                const Text('Consum d\'energia'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
            Column(
              children: [
                const Text('Emissions'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
          ],
        )
      ]),
    );
  }
}
