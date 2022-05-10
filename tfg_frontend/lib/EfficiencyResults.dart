import 'package:flutter/material.dart';

class EfficiencyResults extends StatefulWidget {
  EfficiencyResults({Key? key}) : super(key: key);

  @override
  _EfficiencyResults createState() => _EfficiencyResults();
}

class _EfficiencyResults extends State<EfficiencyResults> {
  String resp = '';

  void initState() {
    super.initState();
  }

  Widget BuildingResults() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Calefacció', style: TextStyle(fontSize: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/demand.png',
                  width: 120,
                  height: 120,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.5', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/consumption.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.9', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/emissions.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.20', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text('Refrigeració', style: TextStyle(fontSize: 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/demand.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.2', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/consumption.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.20', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/emissions.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.20', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text('Aigua corrent sanitària', style: TextStyle(fontSize: 18)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/demand.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('0.20', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('A', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/consumption.png',
                  width: 120,
                  height: 120,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('1', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('D', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
            SizedBox(
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/emissions.png', width: 120, height: 120),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('1.5', style: TextStyle(fontSize: 25)),
                    Image(
                        image: AssetImage('images/right-arrow.png'),
                        width: 30,
                        height: 30),
                    const Text('E', style: TextStyle(fontSize: 25)),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget SoftwareResults() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/efficiency.png', width: 120, height: 120),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('0.3', style: TextStyle(fontSize: 25)),
                const SizedBox(
                  width: 5,
                ),
                Image(
                    image: AssetImage('images/right-arrow.png'),
                    width: 30,
                    height: 30),
                const SizedBox(
                  width: 5,
                ),
                const Text('A', style: TextStyle(fontSize: 25)),
              ],
            )
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/optimization.png', width: 120, height: 120),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('0.7', style: TextStyle(fontSize: 25)),
                const SizedBox(
                  width: 5,
                ),
                Image(
                    image: AssetImage('images/right-arrow.png'),
                    width: 30,
                    height: 30),
                const SizedBox(
                  width: 5,
                ),
                const Text('C', style: TextStyle(fontSize: 25)),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/perdurability.png', width: 120, height: 120),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('0.20', style: TextStyle(fontSize: 25)),
                const SizedBox(
                  width: 5,
                ),
                Image(
                    image: AssetImage('images/right-arrow.png'),
                    width: 30,
                    height: 30),
                const SizedBox(
                  width: 5,
                ),
                const Text('A', style: TextStyle(fontSize: 25)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    String element = 'Edifici';
    String text = '';
    bool building = true;
    if (element == 'Edifici') {
      text = 'L\'eficiència energètica de l\'edifici és...';
    } else {
      text = 'L\'eficiència energètica del sistema software és...';
      building = false;
    }
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 40,
        ),
        Visibility(child: SoftwareResults(), visible: !building),
        Visibility(child: BuildingResults(), visible: building),
      ],
    ));
  }
}
