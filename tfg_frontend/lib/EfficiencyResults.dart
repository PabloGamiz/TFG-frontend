import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tfg_frontend/endpoints/Calls/CalculationData.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:tfg_frontend/main.dart';

import 'endpoints/Objects/BarChartData.dart';
import 'endpoints/Objects/CalculationData.dart';
import 'endpoints/Objects/ChartData.dart';

import 'dart:html' as html;

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

  String direction = '';
  String municipi = '';
  String zip_code = '';
  String comunitat = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;

  List<CalculationData> calculation_data = [];
  CalculationData cd_maxdemand = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');
  CalculationData cd_mindemand = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');
  CalculationData cd_maxconsump = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');
  CalculationData cd_minconsump = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');
  CalculationData cd_maxemissions = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');
  CalculationData cd_minemissions = CalculationData(
      object: '',
      antiquity: '',
      value_type: '',
      indicator: '',
      building_type: '',
      climatic_zone: '',
      value1: '0.0',
      value2: '0.0',
      value3: '0.0',
      zone: '',
      classification: '');

  List<ChartData> chartData = [];
  List<ChartData> chartDataCPU = [];
  List<ChartData> chartDataGPU = [];

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
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
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  Future<void> getComponentsData() async {
    print('dentro de obtener los resultados');
    if (widget.tipus == 1) {
      print('dentro de obtener los resultados de los edificios');
      if (widget.br.demand != '0') {
        print('el servicio no es ACS');
        await getMaximumClass(
                'Edifici',
                'Nou',
                'Màxim',
                'Demanda',
                widget.br.type,
                widget.br.climatic_zone,
                widget.br.zone,
                widget.br.demand_class)
            .then((CalculationData calcdata) {
          cd_maxdemand = calcdata;
        });
        await getMaximumClass(
                'Edifici',
                'Nou',
                'Màxim',
                'Demanda',
                widget.br.type,
                widget.br.climatic_zone,
                widget.br.zone,
                String.fromCharCode(widget.br.demand_class.codeUnitAt(0) - 1))
            .then((CalculationData calcdata) {
          cd_mindemand = calcdata;
        });
      }
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Consum d\'energia',
              widget.br.type,
              widget.br.climatic_zone,
              widget.br.zone,
              widget.br.consumption_class)
          .then((CalculationData calcdata) {
        cd_maxconsump = calcdata;
      });
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Consum d\'energia',
              widget.br.type,
              widget.br.climatic_zone,
              widget.br.zone,
              String.fromCharCode(
                  widget.br.consumption_class.codeUnitAt(0) - 1))
          .then((CalculationData calcdata) {
        cd_minconsump = calcdata;
      });
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Emissions',
              widget.br.type,
              widget.br.climatic_zone,
              widget.br.zone,
              widget.br.emissions_class)
          .then((CalculationData calcdata) {
        cd_maxemissions = calcdata;
      });
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Emissions',
              widget.br.type,
              widget.br.climatic_zone,
              widget.br.zone,
              String.fromCharCode(widget.br.emissions_class.codeUnitAt(0) - 1))
          .then((CalculationData calcdata) {
        cd_minemissions = calcdata;
      });
      print('despues de obtener la informacion de los edificios');
    } else {
      print('antes de obtener la informacion de los sistemas software');
      await getCPUs().then((List<CalculationData> cd) {
        setState(() {
          print(
              'se ha obtenido la lista de cpus y se guarda para poder usarla');
          calculation_data = cd;
        });
      });
      print('antes de obtener los valores de cada una de las cpus');
      for (CalculationData c in calculation_data) {
        if (c.value_type != widget.sr.cpu) {
          print('valor de c.value---->');
          print(c.value1);
          chartDataCPU.add(ChartData(
              c.value_type, double.parse(c.value1), Colors.green.shade700));
        } else {
          print('valor de c.value (igual)---->');
          print(c.value1);
          chartDataCPU.add(
              ChartData(c.value_type, double.parse(c.value1), Colors.lime));
        }
      }
      print(chartDataCPU);
      print('entre las dos llamadas me encuentro');
      await getGPUs().then((List<CalculationData> cd) {
        setState(() {
          calculation_data = cd;
        });
      });
      for (CalculationData c in calculation_data) {
        if (c.value_type != widget.sr.gpu) {
          print('valor de c.value---->');
          print(c.value1);
          chartDataGPU.add(
              ChartData(c.value_type, double.parse(c.value1), Colors.green));
        } else {
          print('valor de c.value---->');
          print(c.value1);
          chartDataGPU.add(
              ChartData(c.value_type, double.parse(c.value1), Colors.yellow));
        }
      }
      print(chartDataGPU);
      print('despues de obtener la informacion de los sistemas software');
    }
  }

  Future<void> createInform() async {
    print('empieza el fichero');
    final pdf = pw.Document();
    if (widget.tipus == 1) {
      final img = Image.network(
          'https://www.remica.es/wp-content/uploads/2014/10/modelo-etiqueta-energetica.jpg');
      ByteData bytes = await rootBundle.load('images/building-certificate.jpg');
      print('pagina 1 de edificio');
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text('Green Id Card', style: pw.TextStyle(fontSize: 30)),
              pw.SizedBox(height: 5),
              pw.Text('Informe de resultats',
                  style: pw.TextStyle(fontSize: 25)),
              pw.SizedBox(height: 30),
              pw.Text('Dades introduides',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Text('Variable introduida', textAlign: pw.TextAlign.left),
                  pw.Text('Valor introduit', textAlign: pw.TextAlign.left)
                ]),
              ]),
              pw.Table(
                  border: pw.TableBorder(
                      top: pw.BorderSide(),
                      bottom: pw.BorderSide(),
                      right: pw.BorderSide(),
                      left: pw.BorderSide()),
                  children: [
                    pw.TableRow(children: [
                      pw.Text('Tipus d\'objecte', textAlign: pw.TextAlign.left),
                      pw.Text('Edifici', textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Finalitat de l\'edifici',
                          textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.purpose, textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Tipus d\'edifici', textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.type, textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Servei', textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.service, textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Zona climàtica', textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.climatic_zone,
                          textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Valor de demanda introduït',
                          textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.in_demand, textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Valor del consum d\'energia introduït',
                          textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.in_consumption,
                          textAlign: pw.TextAlign.left)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Valor de les emissions introduït',
                          textAlign: pw.TextAlign.left),
                      pw.Text(widget.br.in_emissions,
                          textAlign: pw.TextAlign.left)
                    ]),
                  ]),
              pw.SizedBox(height: 30),
              pw.Text('Resultats obtinguts',
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              pw.Table(children: [
                pw.TableRow(
                    children: [pw.Text('Mètrica'), pw.Text('Classificació')]),
              ]),
              pw.Table(
                  border: pw.TableBorder(
                      top: pw.BorderSide(),
                      bottom: pw.BorderSide(),
                      right: pw.BorderSide(),
                      left: pw.BorderSide()),
                  children: [
                    pw.TableRow(children: [
                      pw.Text('Demanda'),
                      pw.Text(widget.br.demand_class)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Consum d\'energia'),
                      pw.Text(widget.br.consumption_class)
                    ]),
                    pw.TableRow(children: [
                      pw.Text('Emissions'),
                      pw.Text(widget.br.emissions_class)
                    ]),
                  ]),
            ],
          ),
        ),
      );
      double consumption_row =
          double.parse(widget.br.consumption_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double emissions_row =
          double.parse(widget.br.emissions_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Stack(children: [
                      pw.Image(pw.MemoryImage(bytes.buffer.asUint8List())),
                      pw.Column(children: [
                        pw.SizedBox(height: 95),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(widget.br.purpose,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 115),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 135),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller2.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 155),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller3.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 175),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller4.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 240 + 35 * consumption_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 310),
                          pw.Text(widget.br.in_consumption,
                              style: const pw.TextStyle(fontSize: 30)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 240 + 35 * emissions_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 385),
                          pw.Text(widget.br.in_emissions,
                              style: const pw.TextStyle(fontSize: 30)),
                        ]),
                      ]),
                    ]),
                  ])));
      // Encode our file in base64
      /* Uint8List pdfInBytes = await pdf.save();
      final _base64 = base64Encode(pdfInBytes);
      // Create the link with the file
      final anchor =
          AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
            ..target = 'blank';
      // add the name

      anchor.download = 'InformeResultado';
      // trigger download
      document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      return;*/
      Uint8List pdfInBytes = await pdf.save();
      final blob = html.Blob([pdfInBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, 'Placeholdername');
      return;
      /*var anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'pdf.pdf';
      html.document.body?.children.add(anchor);
      document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      return;*/
      /*final ui.Image data1 =
          await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes1 =
          await data1.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes1 =
          bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);
      final ui.Image data2 =
          await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes2 =
          await data2.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes2 =
          bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);
      final ui.Image data3 =
          await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes3 =
          await data3.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes1 =
          bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);*/

    } else {
      /*final ui.Image data1 =
          await _DemandChart.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes1 =  
          await data1.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes1 =
          bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);
      final ui.Image data2 =
          await _ConsumptionChart.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes2 =
          await data2.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes2 =
          bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);
      final ui.Image data3 =
          await _EmissionsChart.currentState!.toImage(pixelRatio: 3.0);
        final ByteData? bytes3 =
          await data3.toByteData(format: ui.ImageByteFormat.png);
        final Uint8List imageBytes3 =
          bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);*/

      ByteData bytes = await rootBundle.load('images/software-certificate.jpg');
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text('Informe de resultats',
                  style: pw.TextStyle(fontSize: 40)),
              pw.SizedBox(height: 30),
              pw.Text('Dades introduides',
                  style: const pw.TextStyle(
                      fontSize: 20, decoration: pw.TextDecoration.underline)),
              pw.SizedBox(height: 10),
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Text('Tipus d\'objecte'),
                  pw.Text('Sistema software')
                ]),
                pw.TableRow(children: [pw.Text('CPU'), pw.Text(widget.sr.cpu)]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de CPU abans de l\'execució'),
                  pw.Text(widget.sr.cpu_before)
                ]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de CPU en l\'execució'),
                  pw.Text(widget.sr.cpu_execution)
                ]),
                pw.TableRow(children: [pw.Text('GPU'), pw.Text(widget.sr.gpu)]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de GPU abans de l\'execució'),
                  pw.Text(widget.sr.gpu_before)
                ]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de GPU en l\'execució'),
                  pw.Text(widget.sr.gpu_execution)
                ]),
                pw.TableRow(children: [
                  pw.Text('Tamany de la memòria'),
                  pw.Text(widget.sr.mem_size)
                ]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de memòria abans de l\'execució'),
                  pw.Text(widget.sr.mem_before)
                ]),
                pw.TableRow(children: [
                  pw.Text('Percentatge de memòria en l\'execució'),
                  pw.Text(widget.sr.mem_execution)
                ]),
                pw.TableRow(children: [pw.Text('PUE'), pw.Text(widget.sr.PUE)]),
                pw.TableRow(children: [
                  pw.Text('Nombre d\'errors des del deployment'),
                  pw.Text(widget.sr.num_errors)
                ]),
                pw.TableRow(children: [
                  pw.Text('Nombre de dies des del deployment'),
                  pw.Text(widget.sr.num_days)
                ]),
              ]),
              pw.SizedBox(height: 30),
              pw.Text('Resultats obtinguts',
                  style: const pw.TextStyle(
                      fontSize: 20, decoration: pw.TextDecoration.underline)),
              pw.SizedBox(height: 10),
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Text('Eficiència energètica'),
                  pw.Text(widget.sr.efficiency),
                  pw.Text(widget.sr.efficiency_class)
                ]),
                pw.TableRow(children: [
                  pw.Text('Optimització de recursos'),
                  pw.Text(widget.sr.consumption),
                  pw.Text(widget.sr.consumption_class)
                ]),
                pw.TableRow(children: [
                  pw.Text('Perdurabilitat'),
                  pw.Text(widget.sr.perdurability),
                  pw.Text(widget.sr.perdurability_class)
                ]),
              ]),
            ],
          ),
        ),
      );
      double efficiency_row =
          double.parse(widget.sr.efficiency_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double optimization_row =
          double.parse(widget.sr.consumption_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double perdurability_row =
          double.parse(widget.sr.perdurability_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Stack(children: [
                      pw.Image(pw.MemoryImage(bytes.buffer.asUint8List())),
                      pw.Column(children: [
                        pw.SizedBox(height: 110 + 32 * efficiency_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 245),
                          pw.Text(
                              double.parse(widget.sr.efficiency)
                                  .toStringAsFixed(2),
                              style: const pw.TextStyle(fontSize: 20)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 110 + 32 * optimization_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 320),
                          pw.Text(
                              double.parse(widget.sr.consumption)
                                  .toStringAsFixed(2),
                              style: const pw.TextStyle(fontSize: 20)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 110 + 32 * perdurability_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 385),
                          pw.Text(
                              double.parse(widget.sr.perdurability)
                                  .toStringAsFixed(2),
                              style: const pw.TextStyle(fontSize: 20)),
                        ]),
                      ]),
                    ]),
                  ])));
      Uint8List pdfInBytes = await pdf.save();
      final blob = html.Blob([pdfInBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, 'Placeholdername');
      return;
    }
  }

  Widget BuildingResults() {
    print(cd_mindemand.value1);
    print(cd_maxdemand.value1);
    print('dentro de los resultados del edificio');
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
      SizedBox(
        height: 40,
      ),
      FutureBuilder(
          future: getComponentsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                  height: 300,
                  width: 1000,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SfCartesianChart(
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            RangeColumnSeries<BarChartData, String>(
                                dataSource: [
                                  BarChartData('', 0, 0, Colors.green),
                                  BarChartData(
                                      'Demanda',
                                      double.parse(cd_mindemand.value1),
                                      double.parse(cd_maxdemand.value1),
                                      Colors.green),
                                  BarChartData(' ', 0, 0, Colors.green),
                                ],
                                xValueMapper: (BarChartData data, _) => data.x,
                                lowValueMapper: (BarChartData data, _) =>
                                    data.y,
                                highValueMapper: (BarChartData data, _) =>
                                    data.y2,
                                pointColorMapper: (BarChartData data, _) =>
                                    data.color),
                            LineSeries<ChartData, String>(
                              dataSource: [
                                // Bind data source
                                ChartData('', double.parse(widget.br.in_demand),
                                    Colors.yellow),
                                ChartData(
                                    'Demanda',
                                    double.parse(widget.br.in_demand),
                                    Colors.yellow),
                                ChartData(
                                    ' ',
                                    double.parse(widget.br.in_demand),
                                    Colors.yellow),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                          ]),
                      SizedBox(
                        width: 30,
                      ),
                      SfCartesianChart(
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            RangeColumnSeries<BarChartData, String>(
                              dataSource: [
                                BarChartData('', 0, 0, Colors.green),
                                BarChartData(
                                    'Consum d\'energia',
                                    double.parse(cd_minconsump.value1),
                                    double.parse(cd_maxconsump.value1),
                                    Colors.green),
                                BarChartData(' ', 0, 0, Colors.green),
                              ],
                              xValueMapper: (BarChartData data, _) => data.x,
                              lowValueMapper: (BarChartData data, _) => data.y,
                              highValueMapper: (BarChartData data, _) =>
                                  data.y2,
                              pointColorMapper: (BarChartData data, _) =>
                                  data.color,
                            ),
                            LineSeries<ChartData, String>(
                              dataSource: [
                                // Bind data source
                                ChartData(
                                    '',
                                    double.parse(widget.br.in_consumption),
                                    Colors.yellow),
                                ChartData(
                                    'Consum d\'energia',
                                    double.parse(widget.br.in_consumption),
                                    Colors.yellow),
                                ChartData(
                                    ' ',
                                    double.parse(widget.br.in_consumption),
                                    Colors.yellow),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                          ]),
                      SizedBox(
                        width: 30,
                      ),
                      SfCartesianChart(
                          // Initialize category axis
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            RangeColumnSeries<BarChartData, String>(
                              dataSource: [
                                BarChartData('', 0, 0, Colors.green),
                                BarChartData(
                                    'Emissions',
                                    double.parse(cd_minemissions.value1),
                                    double.parse(cd_maxemissions.value1),
                                    Colors.green),
                                BarChartData(' ', 0, 0, Colors.green),
                              ],
                              xValueMapper: (BarChartData data, _) => data.x,
                              lowValueMapper: (BarChartData data, _) => data.y,
                              highValueMapper: (BarChartData data, _) =>
                                  data.y2,
                              pointColorMapper: (BarChartData data, _) =>
                                  data.color,
                            ),
                            LineSeries<ChartData, String>(
                              dataSource: [
                                // Bind data source
                                ChartData(
                                    '',
                                    double.parse(widget.br.in_emissions),
                                    Colors.yellow),
                                ChartData(
                                    'Emissions',
                                    double.parse(widget.br.in_emissions),
                                    Colors.yellow),
                                ChartData(
                                    ' ',
                                    double.parse(widget.br.in_emissions),
                                    Colors.yellow),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                          ])
                    ],
                  ));
            } else {
              return CircularProgressIndicator();
            }
          })
    ]);
  }

  Widget SoftwareResults() {
    print('dentro de los resultados del software');
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
                  Text(double.parse(s_result.efficiency).toStringAsFixed(2),
                      style: TextStyle(fontSize: 25)),
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
                  Text(double.parse(s_result.consumption).toStringAsFixed(2),
                      style: TextStyle(fontSize: 25)),
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
                  Text(double.parse(s_result.perdurability).toStringAsFixed(2),
                      style: TextStyle(fontSize: 25)),
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
      SizedBox(
        height: 40,
      ),
      FutureBuilder(
          future: getComponentsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                  height: 300,
                  width: 1000,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SfCircularChart(
                          // Enables the tooltip for all the series in chart
                          tooltipBehavior: _tooltipBehavior,
                          title: ChartTitle(
                              text: 'Proporció de consum per component'),
                          series: <CircularSeries>[
                            // Render pie chart
                            PieSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
                          ]),
                      SizedBox(
                        width: 30,
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'Consum de la CPU'),
                        primaryXAxis: CategoryAxis(
                            // Axis will be rendered based on the index values
                            arrangeByIndex: true),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                              // Binding the chartData to the dataSource of the column series.
                              dataSource: chartDataCPU,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'Consum de la GPU'),
                        primaryXAxis: CategoryAxis(
                            // Axis will be rendered based on the index values
                            arrangeByIndex: true),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                              // Binding the chartData to the dataSource of the column series.
                              dataSource: chartDataGPU,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color),
                        ],
                      ),
                    ],
                  ));
            } else {
              return CircularProgressIndicator();
            }
          })
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
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  color: Colors.green.shade300,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(13.0),
                  primary: Colors.white,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  if (widget.tipus == 1) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text(
                                'Introdueix la següent informació sobre l\'edifici:'),
                            content: new Container(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text('Indica la direcció de l\'edifici:'),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        child: TextField(
                                          controller: _controller,
                                          onChanged: (String value) async {
                                            direction = value;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Direcció',
                                          ),
                                        ),
                                        height: 40,
                                        width: 200),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Indica el municipi:'),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        child: TextField(
                                          controller: _controller2,
                                          onChanged: (String value) async {
                                            municipi = value;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Municipi',
                                          ),
                                        ),
                                        height: 40,
                                        width: 200),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Indica el codi postal:'),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        child: TextField(
                                          controller: _controller3,
                                          onChanged: (String value) async {
                                            zip_code = value;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Codi postal',
                                          ),
                                        ),
                                        height: 40,
                                        width: 200),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text('Indica la comunitat autònoma:'),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                    ),
                                    Container(
                                        child: TextField(
                                          controller: _controller4,
                                          onChanged: (String value) async {
                                            comunitat = value;
                                          },
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Comunitat autònoma',
                                          ),
                                        ),
                                        height: 40,
                                        width: 200),
                                  ],
                                ),
                              ]),
                              height: 250,
                              width: 425,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  createInform();
                                },
                                child: const Text('Continuar'),
                              )
                            ],
                          );
                        });
                  } else {
                    createInform();
                  }
                },
                child: const Text('Generar informe'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
