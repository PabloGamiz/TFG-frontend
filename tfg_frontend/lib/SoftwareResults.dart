import 'package:flutter/material.dart';

class SoftwareResults extends StatefulWidget {
  @override
  _SoftwareResults createState() => _SoftwareResults();
}

class _SoftwareResults extends State {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text('Els valors obtinguts per al sistema software són... '),
        const SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Column(
              children: [
                const Text('Eficiència'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
            Column(
              children: [
                const Text('Optimització dels recursos'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
            Column(
              children: [
                const Text('Optimització de la capacitat'),
                //poner el valor calculado de la demanda
                //poner el valor de la eficiencia obtenido
              ],
            ),
            Column(
              children: [
                const Text('Perdurabilitat'),
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
