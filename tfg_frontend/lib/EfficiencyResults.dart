import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';

import 'endpoints/Objects/ChartData.dart';

class EfficiencyResults extends StatefulWidget {
  final int tipus;
  final BuildingResult br;
  final SoftwareResult sr;

  const EfficiencyResults(
      {Key? key, required this.tipus, required this.br, required this.sr})
      : super(key: key);

  @override
  _EfficiencyResults createState() => _EfficiencyResults();
}

class _EfficiencyResults extends State<EfficiencyResults> {
  String resp = '';

  late BuildingResult b_result;
  late SoftwareResult s_result;
  late TooltipBehavior _tooltipBehavior;

  List<ChartData> chartData = [];

  void initState() {
    super.initState();
    b_result = widget.br;
    s_result = widget.sr;
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = [
      ChartData('CPU', s_result.CPU_percentatge, Colors.yellow),
      ChartData('GPU', s_result.GPU_percentatge, Colors.blue),
      ChartData('mem', s_result.mem_percentatge, Colors.green)
    ];
    print(b_result.demand);
    print('---------------------');
  }

  Widget BuildingResults() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  Text(b_result.demand, style: TextStyle(fontSize: 25)),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30,
                      height: 30),
                  Text(b_result.demand_class, style: TextStyle(fontSize: 25)),
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
                  Text(b_result.consumption, style: TextStyle(fontSize: 25)),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30,
                      height: 30),
                  Text(b_result.consumption_class,
                      style: TextStyle(fontSize: 25)),
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
                  Text(b_result.emissions, style: TextStyle(fontSize: 25)),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30,
                      height: 30),
                  Text(b_result.emissions_class,
                      style: TextStyle(fontSize: 25)),
                ],
              )
            ],
          ),
        ],
      ),
    ]);
  }

  Widget SoftwareResults() {
    return Column(children: [
      Row(
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
                  Text(s_result.efficiency, style: TextStyle(fontSize: 25)),
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
                  Text(s_result.efficiency_class,
                      style: TextStyle(fontSize: 25)),
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
                  Text(s_result.consumption, style: TextStyle(fontSize: 25)),
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
                  Text(s_result.consumption_class,
                      style: TextStyle(fontSize: 25)),
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
                  Text(s_result.perdurability, style: TextStyle(fontSize: 25)),
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
                  Text(s_result.perdurability_class,
                      style: TextStyle(fontSize: 25)),
                ],
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          SfCircularChart(
              // Enables the tooltip for all the series in chart
              tooltipBehavior: _tooltipBehavior,
              title: ChartTitle(text: 'Proporció de consum per component'),
              series: <CircularSeries>[
                // Render pie chart
                PieSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ]),
        ],
      )
    ]);
  }

  Widget build(BuildContext context) {
    String text = '';
    if (widget.tipus == 1) {
      text =
          'L\'eficiència energètica del servei seleccionat de l\'edifici és...';
    } else {
      text = 'L\'eficiència energètica del sistema software és...';
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
        Visibility(child: SoftwareResults(), visible: widget.tipus == 2),
        Visibility(child: BuildingResults(), visible: widget.tipus == 1),
      ],
    ));
  }
}
