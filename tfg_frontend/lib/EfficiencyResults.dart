import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:async/async.dart';

import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pdf/pdf.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tfg_frontend/endpoints/Calls/CalculationData.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:tfg_frontend/main.dart';

import 'endpoints/Objects/CalculationData.dart';
import 'endpoints/Objects/ChartData.dart';

import 'dart:html' as html;

class EfficiencyResults extends StatefulWidget {
  //final int tipus;
  //final BuildingResult br;
  //final SoftwareResult sr;

  /*const EfficiencyResults(
      {Key? key, required this.tipus, required this.br, required this.sr})
      : super(key: key);*/

  @override
  _EfficiencyResults createState() => _EfficiencyResults();
}

class _EfficiencyResults extends State<EfficiencyResults> {
  //SuperTooltip? tooltip;

  String resp = '';

  late BuildingResult br;
  late SoftwareResult sr;
  late TooltipBehavior _tooltipBehavior;

  String direction = '';
  String municipi = '';
  String zip_code = '';
  String comunitat = '';

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;

  Map arguments = {};

  List<CalculationData> calculation_dataCPU = [];
  List<CalculationData> calculation_dataGPU = [];

  late AsyncMemoizer _memoizer;

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

    _tooltipBehavior = TooltipBehavior(enable: true);

    _memoizer = AsyncMemoizer();
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

  _fetchdata() async {
    return _memoizer.runOnce(() async {
      await getComponentsData();
      return;
    });
  }

  Future<void> getComponentsData() async {
    if (arguments['tipus'] == 1) {
      if (br.demandC1 != '0') {
        await getMaximumClass('Edifici', 'Nou', 'Màxim', 'Demanda', br.type,
                br.climatic_zone, br.zone, br.demand_class)
            .then((CalculationData calcdata) {
          cd_maxdemand = calcdata;
        });
        await getMaximumClass(
                'Edifici',
                'Nou',
                'Màxim',
                'Demanda',
                br.type,
                br.climatic_zone,
                br.zone,
                String.fromCharCode(br.demand_class.codeUnitAt(0) - 1))
            .then((CalculationData calcdata) {
          cd_mindemand = calcdata;
        });
      }
      await getMaximumClass('Edifici', 'Nou', 'Màxim', 'Consum d\'energia',
              br.type, br.climatic_zone, br.zone, br.consumption_class)
          .then((CalculationData calcdata) {
        cd_maxconsump = calcdata;
      });
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Consum d\'energia',
              br.type,
              br.climatic_zone,
              br.zone,
              String.fromCharCode(br.consumption_class.codeUnitAt(0) - 1))
          .then((CalculationData calcdata) {
        cd_minconsump = calcdata;
      });
      await getMaximumClass('Edifici', 'Nou', 'Màxim', 'Emissions', br.type,
              br.climatic_zone, br.zone, br.emissions_class)
          .then((CalculationData calcdata) {
        cd_maxemissions = calcdata;
      });
      await getMaximumClass(
              'Edifici',
              'Nou',
              'Màxim',
              'Emissions',
              br.type,
              br.climatic_zone,
              br.zone,
              String.fromCharCode(br.emissions_class.codeUnitAt(0) - 1))
          .then((CalculationData calcdata) {
        cd_minemissions = calcdata;
      });
    } else if (arguments['tipus'] == 2) {
      await getCPUs().then((List<CalculationData> cd) {
        calculation_dataCPU = cd;
      });
      await getGPUs().then((List<CalculationData> cd) {
        calculation_dataGPU = cd;
      });
    }
  }

  Future<void> createInform() async {
    final pdf = pw.Document();
    if (arguments['tipus'] == 1) {
      ByteData bytes = await rootBundle.load('images/building-certificate.jpg');
      ByteData logobytes = await rootBundle.load('images/icono-negro.png');
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Image(pw.MemoryImage(logobytes.buffer.asUint8List())),
              pw.Text('Informe de resultats',
                  style: pw.TextStyle(fontSize: 30)),
              pw.SizedBox(height: 30),
              pw.SizedBox(
                height: 30,
                width: 485,
                child: pw.Text('Dades introduïdes',
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 18)),
              ),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Table(
                    border: pw.TableBorder(
                        top: pw.BorderSide(),
                        bottom: pw.BorderSide(),
                        right: pw.BorderSide(),
                        left: pw.BorderSide()),
                    children: [
                      pw.TableRow(children: [
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Tipus d\'objecte',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Finalitat de l\'edifici',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Tipus d\'edifici',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child:
                              pw.Text('Servei', textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Zona climàtica',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Valor de demanda introduït',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text(
                              'Valor del consum d\'energia introduït',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Valor de les emissions introduït',
                              textAlign: pw.TextAlign.left),
                        ),
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
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text('Edifici',
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.purpose,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child:
                                pw.Text(br.type, textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.service,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.climatic_zone,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.in_demand,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.in_consumption,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.in_emissions,
                                textAlign: pw.TextAlign.left)),
                      ]),
                    ])
              ]),
              pw.SizedBox(height: 30),
              pw.SizedBox(
                height: 30,
                width: 485,
                child: pw.Text('Resultats obtinguts',
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 18)),
              ),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Table(
                    border: pw.TableBorder(
                        top: pw.BorderSide(),
                        bottom: pw.BorderSide(),
                        right: pw.BorderSide(),
                        left: pw.BorderSide()),
                    children: [
                      pw.TableRow(children: [
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child:
                              pw.Text('Demanda', textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Consum d\'energia',
                              textAlign: pw.TextAlign.left),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Emissions',
                              textAlign: pw.TextAlign.left),
                        ),
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
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.demand_class,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.consumption_class,
                                textAlign: pw.TextAlign.left)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(br.emissions_class,
                                textAlign: pw.TextAlign.left)),
                      ]),
                    ]),
              ]),
            ],
          ),
        ),
      );
      double consumption_row =
          double.parse(br.consumption_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double emissions_row =
          double.parse(br.emissions_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Stack(children: [
                      pw.Image(pw.MemoryImage(bytes.buffer.asUint8List())),
                      pw.Column(children: [
                        pw.SizedBox(height: 97),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(br.purpose,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 117),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 137),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller2.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 157),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller3.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 177),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller4.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 240 + 37 * consumption_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 310),
                          pw.Text(br.in_consumption,
                              style: const pw.TextStyle(fontSize: 30)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 240 + 37 * emissions_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 385),
                          pw.Text(br.in_emissions,
                              style: const pw.TextStyle(fontSize: 30)),
                        ]),
                      ]),
                    ]),
                  ])));
      Uint8List pdfInBytes = await pdf.save();
      final blob = html.Blob([pdfInBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, 'Placeholdername');
      return;
    } else {
      ByteData bytes = await rootBundle.load('images/software-certificate.png');
      ByteData logobytes = await rootBundle.load('images/icono-negro.png');

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Image(pw.MemoryImage(logobytes.buffer.asUint8List())),
              pw.Text('Informe de resultats',
                  style: pw.TextStyle(fontSize: 40)),
              pw.SizedBox(height: 30),
              pw.SizedBox(
                height: 30,
                width: 485,
                child: pw.Text('Dades introduides',
                    style: const pw.TextStyle(fontSize: 20)),
              ),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Table(
                    border: pw.TableBorder(
                        top: pw.BorderSide(),
                        bottom: pw.BorderSide(),
                        right: pw.BorderSide(),
                        left: pw.BorderSide()),
                    children: [
                      pw.TableRow(children: [
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Tipus d\'objecte'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text('CPU')),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text(
                              'Percentatge de CPU abans de l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Percentatge de CPU en l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text('GPU')),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text(
                              'Percentatge de GPU abans de l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Percentatge de GPU en l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Tamany de la memòria'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 30,
                          width: 235,
                          child: pw.Text(
                              'Percentatge de memòria abans de l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child:
                              pw.Text('Percentatge de memòria en l\'execució'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text('PUE')),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Nombre d\'errors des del deployment'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Nombre de dies des del deployment'),
                        ),
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
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text('Sistema software')),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text(sr.cpu)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.cpu_before)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.cpu_execution)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text(sr.gpu)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.gpu_before)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.gpu_execution)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.mem_before)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 30, width: 5),
                        pw.SizedBox(
                            height: 30,
                            width: 235,
                            child: pw.Text(sr.mem_execution)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.mem_size)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20, width: 235, child: pw.Text(sr.PUE)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.num_days)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.num_errors)),
                      ]),
                    ]),
              ]),
              pw.SizedBox(height: 30),
              pw.SizedBox(
                height: 30,
                width: 485,
                child: pw.Text('Resultats obtinguts',
                    style: const pw.TextStyle(fontSize: 20)),
              ),
              pw.SizedBox(height: 10),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Table(
                    border: pw.TableBorder(
                        top: pw.BorderSide(),
                        bottom: pw.BorderSide(),
                        right: pw.BorderSide(),
                        left: pw.BorderSide()),
                    children: [
                      pw.TableRow(children: [
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Eficiència energètica'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Optimització de recursos'),
                        ),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                          height: 20,
                          width: 235,
                          child: pw.Text('Perdurabilitat'),
                        ),
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
                        pw.SizedBox(height: 5, width: 5),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.efficiency_class)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.consumption_class)),
                      ]),
                      pw.TableRow(children: [
                        pw.SizedBox(height: 20, width: 5),
                        pw.SizedBox(
                            height: 20,
                            width: 235,
                            child: pw.Text(sr.perdurability_class)),
                      ]),
                    ]),
              ]),
            ],
          ),
        ),
      );
      double efficiency_row =
          double.parse(sr.efficiency_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double optimization_row =
          double.parse(sr.consumption_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      double perdurability_row =
          double.parse(sr.perdurability_class.codeUnitAt(0).toString()) -
              'A'.codeUnitAt(0);
      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Stack(children: [
                      pw.Image(pw.MemoryImage(bytes.buffer.asUint8List())),
                      pw.Column(children: [
                        pw.SizedBox(height: 97),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 117),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller2.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 137),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller3.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 157),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 290),
                          pw.Text(_controller4.text,
                              style: const pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 265 + 32 * efficiency_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 245),
                          pw.Text(
                              double.parse(sr.efficiency).toStringAsFixed(2),
                              style: const pw.TextStyle(fontSize: 20)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 265 + 32 * optimization_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 320),
                          pw.Text(
                              double.parse(sr.consumption).toStringAsFixed(2),
                              style: const pw.TextStyle(fontSize: 20)),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 265 + 32 * perdurability_row),
                        pw.Row(children: [
                          pw.SizedBox(height: 1, width: 385),
                          pw.Text(
                              double.parse(sr.perdurability).toStringAsFixed(2),
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
    print(br.demandC1);
    print(br.demandC2);
    print(br.consumptionC1);
    print(br.consumptionC2);
    print(br.emissionsC1);
    print(br.emissionsC2);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'images/demand.png',
              width: 120 * MediaQuery.of(context).size.width / 1536,
              height: 120 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
              height: 10 * MediaQuery.of(context).size.height / 864,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              (arguments['tipus'] == 1 && br.purpose == 'No residencial')
                  ? Text(double.parse(br.demandC1).toStringAsFixed(2),
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536))
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text('C1: ',
                                style: TextStyle(
                                    fontSize: 25 *
                                        MediaQuery.of(context).size.width /
                                        1536)),
                            Text(double.parse(br.demandC1).toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 25 *
                                        MediaQuery.of(context).size.width /
                                        1536)),
                          ],
                        ),
                        SizedBox(
                          height: 10 * MediaQuery.of(context).size.height / 864,
                          width: 1,
                        ),
                        Row(
                          children: [
                            Text('C2: ',
                                style: TextStyle(
                                    fontSize: 25 *
                                        MediaQuery.of(context).size.width /
                                        1536)),
                            Text(double.parse(br.demandC2).toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 25 *
                                        MediaQuery.of(context).size.width /
                                        1536)),
                          ],
                        ),
                      ],
                    ),
              Image(
                  image: AssetImage('images/right-arrow.png'),
                  width: 30 * MediaQuery.of(context).size.width / 1536,
                  height: 30 * MediaQuery.of(context).size.height / 864),
              Text(br.demand_class,
                  style: TextStyle(
                      fontSize: 25 * MediaQuery.of(context).size.width / 1536)),
            ]),
          ]),
          SizedBox(
            width: 50 * MediaQuery.of(context).size.width / 1536,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/consumption.png',
                  width: 120 * MediaQuery.of(context).size.width / 1536,
                  height: 120 * MediaQuery.of(context).size.height / 864),
              SizedBox(
                height: 10 * MediaQuery.of(context).size.height / 864,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                (arguments['tipus'] == 1 && br.purpose == 'No residencial')
                    ? Text(double.parse(br.consumptionC1).toStringAsFixed(2),
                        style: TextStyle(
                            fontSize:
                                25 * MediaQuery.of(context).size.width / 1536))
                    : Column(
                        children: [
                          Row(
                            children: [
                              Text('C1: ',
                                  style: TextStyle(
                                      fontSize: 25 *
                                          MediaQuery.of(context).size.width /
                                          1536)),
                              Text(
                                  double.parse(br.consumptionC1)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 25 *
                                          MediaQuery.of(context).size.width /
                                          1536)),
                            ],
                          ),
                          SizedBox(
                            height:
                                10 * MediaQuery.of(context).size.height / 864,
                            width: 1,
                          ),
                          Row(
                            children: [
                              Text('C2: ',
                                  style: TextStyle(
                                      fontSize: 25 *
                                          MediaQuery.of(context).size.width /
                                          1536)),
                              Text(
                                  double.parse(br.consumptionC2)
                                      .toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 25 *
                                          MediaQuery.of(context).size.width /
                                          1536)),
                            ],
                          ),
                        ],
                      ),
                Image(
                    image: AssetImage('images/right-arrow.png'),
                    width: 30 * MediaQuery.of(context).size.width / 1536,
                    height: 30 * MediaQuery.of(context).size.height / 864),
                Text(br.consumption_class,
                    style: TextStyle(
                        fontSize:
                            25 * MediaQuery.of(context).size.width / 1536)),
              ]),
            ],
          ),
          SizedBox(
            width: 50 * MediaQuery.of(context).size.width / 1536,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/emissions.png',
                  width: 120 * MediaQuery.of(context).size.width / 1536,
                  height: 120),
              SizedBox(
                height: 10 * MediaQuery.of(context).size.height / 864,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (arguments['tipus'] == 1 && br.purpose == 'No residencial')
                      ? Text(double.parse(br.emissionsC1).toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 25 *
                                  MediaQuery.of(context).size.width /
                                  1536))
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text('C1: ',
                                    style: TextStyle(
                                        fontSize: 25 *
                                            MediaQuery.of(context).size.width /
                                            1536)),
                                Text(
                                    double.parse(br.emissionsC1)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 25 *
                                            MediaQuery.of(context).size.width /
                                            1536)),
                              ],
                            ),
                            SizedBox(
                              height:
                                  10 * MediaQuery.of(context).size.height / 864,
                              width: 1,
                            ),
                            Row(
                              children: [
                                Text('C2: ',
                                    style: TextStyle(
                                        fontSize: 25 *
                                            MediaQuery.of(context).size.width /
                                            1536)),
                                Text(
                                    double.parse(br.emissionsC2)
                                        .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 25 *
                                            MediaQuery.of(context).size.width /
                                            1536)),
                              ],
                            ),
                          ],
                        ),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30 * MediaQuery.of(context).size.width / 1536,
                      height: 30 * MediaQuery.of(context).size.height / 864),
                  Text(br.emissions_class,
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                ],
              )
            ],
          ),
          /*SizedBox(width: 20, height: 1),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.info, size: 30, color: Colors.black),
          ),*/
        ],
      ),
      SizedBox(
        height: 40 * MediaQuery.of(context).size.height / 864,
      ),
      FutureBuilder(
          future: getComponentsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                arguments['tipus'] == 1) {
              return SizedBox(
                  height: 300 * MediaQuery.of(context).size.height / 864,
                  width: 1000 * MediaQuery.of(context).size.width / 1536,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SfCartesianChart(
                          // Initialize category axis
                          title: ChartTitle(
                              text:
                                  'Rang de la demanda per la classificació obtenida'),
                          legend: Legend(isVisible: true),
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                name: 'màxim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_maxdemand.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_maxdemand.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                            LineSeries<ChartData, String>(
                              name: 'demanda',
                              color: Colors.lightGreen,
                              dataSource: [
                                // Bind data source
                                ChartData('', double.parse(br.in_demand),
                                    Colors.lightGreen),
                                ChartData(' ', double.parse(br.in_demand),
                                    Colors.lightGreen),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                            LineSeries<ChartData, String>(
                                name: 'mínim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_mindemand.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_mindemand.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                          ]),
                      SizedBox(
                        width: 30 * MediaQuery.of(context).size.width / 1536,
                      ),
                      SfCartesianChart(
                          // Initialize category axis
                          title: ChartTitle(
                              text:
                                  'Rang del consum per la classificació obtenida'),
                          legend: Legend(isVisible: true),
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                name: 'màxim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_maxconsump.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_maxconsump.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                            LineSeries<ChartData, String>(
                              name: 'consum',
                              color: Colors.lightGreen,
                              dataSource: [
                                // Bind data source
                                ChartData('', double.parse(br.in_consumption),
                                    Colors.lightGreen),
                                ChartData(' ', double.parse(br.in_consumption),
                                    Colors.lightGreen),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                            LineSeries<ChartData, String>(
                                name: 'mínim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_minconsump.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_minconsump.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                          ]),
                      SizedBox(
                        width: 30 * MediaQuery.of(context).size.width / 1536,
                      ),
                      SfCartesianChart(
                          // Initialize category axis
                          title: ChartTitle(
                              text:
                                  'Rang de les emissions per la classificació obtenida'),
                          legend: Legend(isVisible: true),
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            LineSeries<ChartData, String>(
                                name: 'màxim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_maxemissions.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_maxemissions.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                            LineSeries<ChartData, String>(
                              name: 'emissions',
                              color: Colors.lightGreen,
                              dataSource: [
                                // Bind data source
                                ChartData('', double.parse(br.in_emissions),
                                    Colors.lightGreen),
                                ChartData(' ', double.parse(br.in_emissions),
                                    Colors.lightGreen),
                              ],
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                            ),
                            LineSeries<ChartData, String>(
                                name: 'mínim',
                                color: Colors.green.shade900,
                                dataSource: [
                                  ChartData(
                                      '',
                                      double.parse(cd_minemissions.value1),
                                      Colors.green.shade900),
                                  ChartData(
                                      ' ',
                                      double.parse(cd_minemissions.value1),
                                      Colors.green.shade900),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color),
                          ])
                    ],
                  ));
            } else if (arguments['tipus'] == 1) {
              return CircularProgressIndicator();
            } else
              return SizedBox();
          })
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
              Image.asset('images/efficiency.png',
                  width: 120 * MediaQuery.of(context).size.width / 1536,
                  height: 120 * MediaQuery.of(context).size.height / 864),
              SizedBox(
                height: 5 * MediaQuery.of(context).size.height / 864,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      arguments['tipus'] == 2
                          ? double.parse(sr.efficiency).toStringAsFixed(2)
                          : '0',
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30,
                      height: 30 * MediaQuery.of(context).size.height / 864),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Text(sr.efficiency_class,
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                ],
              )
            ],
          ),
          SizedBox(
            width: 50 * MediaQuery.of(context).size.width / 1536,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/optimization.png',
                  width: 120 * MediaQuery.of(context).size.width / 1536,
                  height: 120 * MediaQuery.of(context).size.height / 864),
              SizedBox(
                height: 10 * MediaQuery.of(context).size.height / 864,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      arguments['tipus'] == 2
                          ? double.parse(sr.consumption).toStringAsFixed(2)
                          : '0',
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30 * MediaQuery.of(context).size.width / 1536,
                      height: 30 * MediaQuery.of(context).size.height / 864),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Text(sr.consumption_class,
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 50 * MediaQuery.of(context).size.width / 1536,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/perdurability.png',
                  width: 120,
                  height: 120 * MediaQuery.of(context).size.height / 864),
              SizedBox(
                height: 10 * MediaQuery.of(context).size.height / 864,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      arguments['tipus'] == 2
                          ? double.parse(sr.perdurability).toStringAsFixed(2)
                          : '0',
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Image(
                      image: AssetImage('images/right-arrow.png'),
                      width: 30,
                      height: 30 * MediaQuery.of(context).size.height / 864),
                  SizedBox(
                    width: 5 * MediaQuery.of(context).size.width / 1536,
                  ),
                  Text(sr.perdurability_class,
                      style: TextStyle(
                          fontSize:
                              25 * MediaQuery.of(context).size.width / 1536)),
                ],
              ),
            ],
          ),
          /*SizedBox(width: 20, height: 1),
          GestureDetector(
            onTap: onTap,
            child: Icon(Icons.info, size: 30, color: Colors.black),
          ),*/
        ],
      ),
      SizedBox(
        height: 40 * MediaQuery.of(context).size.height / 864,
      ),
      FutureBuilder(
          future: _fetchdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<ChartData> cpus = [];
              List<ChartData> gpus = [];
              late ChartData aux;
              for (CalculationData c in calculation_dataCPU) {
                if (c.value_type != sr.cpu) {
                  cpus.add(ChartData(c.value_type, double.parse(c.value1),
                      Colors.green.shade700));
                } else {
                  aux = ChartData(
                      c.value_type, double.parse(c.value1), Colors.lime);
                  cpus.add(aux);
                }
              }
              cpus.sort((a, b) => a.y.compareTo(b.y));
              int index_cpu = cpus.indexOf(aux);
              print('despues de obtener el indice de cpu');
              List<ChartData> cpus_aux = [];
              print('despues de crear las cpus');
              print(cpus.length - index_cpu);
              if (cpus.length - index_cpu < 3) {
                print('dentro de cpus cerca del final');
                int diference = 3 + cpus.length - index_cpu;
                print(diference);
                cpus_aux = cpus.sublist(index_cpu - diference, cpus.length);
              } else if (cpus.length - index_cpu > cpus.length - 3) {
                int diference = 7 - index_cpu;
                print(diference);
                cpus_aux = cpus.sublist(1, index_cpu + diference);
              } else {
                print('dentro de cpus no cerca del final');
                print(index_cpu);
                cpus_aux = cpus.sublist(index_cpu - 3, index_cpu + 3);
              }
              for (CalculationData c in calculation_dataGPU) {
                if (c.value_type != sr.gpu) {
                  gpus.add(ChartData(c.value_type, double.parse(c.value1),
                      Colors.green.shade700));
                } else {
                  aux = ChartData(
                      c.value_type, double.parse(c.value1), Colors.lime);
                  gpus.add(aux);
                }
              }
              gpus.sort((a, b) => a.y.compareTo(b.y));
              int index_gpu = gpus.indexOf(aux);
              print(index_gpu);
              List<ChartData> gpus_aux = [];

              if (gpus.length - index_gpu < 3) {
                int diference = 3 + gpus.length - index_gpu;
                print(diference);
                gpus_aux = gpus.sublist(index_gpu - diference, gpus.length);
              } else if (gpus.length - index_gpu > gpus.length - 3) {
                int diference = 7 - index_gpu;
                print(diference);
                gpus_aux = gpus.sublist(1, index_gpu + diference);
              } else {
                gpus_aux = gpus.sublist(index_gpu - 3, index_gpu + 3);
              }
              return SizedBox(
                  height: 300 * MediaQuery.of(context).size.height / 864,
                  width: 1000 * MediaQuery.of(context).size.width / 1536,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SfCircularChart(
                          // Enables the tooltip for all the series in chart
                          title: ChartTitle(
                              text: 'Proporció de consum per component'),
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            // Render pie chart
                            PieSeries<ChartData, String>(
                                dataSource: chartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                                dataLabelSettings: DataLabelSettings(
                                    // Renders the data label
                                    isVisible: true)),
                          ]),
                      SizedBox(
                        width: 30 * MediaQuery.of(context).size.width / 1536,
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'Consum de la CPU'),
                        primaryXAxis: CategoryAxis(
                            // Axis will be rendered based on the index values
                            arrangeByIndex: true,
                            labelRotation: 90,
                            labelStyle: TextStyle(fontSize: 10)),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                              // Binding the chartData to the dataSource of the column series.
                              dataSource: cpus_aux,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color),
                        ],
                      ),
                      SizedBox(
                        width: 30 * MediaQuery.of(context).size.width / 1536,
                      ),
                      SfCartesianChart(
                        title: ChartTitle(text: 'Consum de la GPU'),
                        primaryXAxis: CategoryAxis(
                            // Axis will be rendered based on the index values
                            arrangeByIndex: true,
                            labelRotation: 90,
                            labelStyle: TextStyle(fontSize: 10)),
                        series: <ChartSeries<ChartData, String>>[
                          ColumnSeries<ChartData, String>(
                              // Binding the chartData to the dataSource of the column series.
                              dataSource: gpus_aux,
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
    if (ModalRoute.of(context)?.settings.arguments == Null) {
      return Scaffold(
          body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No s\'ha trobat cap informació de càlcul.',
              style: TextStyle(
                  fontSize: 20 * MediaQuery.of(context).size.width / 1536)),
          Text(
            'Sisplau, torna a la pantalla de càlcul ',
            style: TextStyle(
                fontSize: 20 * MediaQuery.of(context).size.width / 1536),
          ),
          Text(
            'i realitza el procés correctament.',
            style: TextStyle(
                fontSize: 20 * MediaQuery.of(context).size.width / 1536),
          )
        ],
      ));
    }
    arguments = ModalRoute.of(context)?.settings.arguments as Map;
    br = arguments['br'];
    sr = arguments['sr'];
    chartData = [
      ChartData(
          'CPU',
          double.parse((sr.CPU_percentatge * 100).toStringAsFixed(2)),
          Colors.yellow),
      ChartData(
          'GPU',
          double.parse((sr.GPU_percentatge * 100).toStringAsFixed(2)),
          Colors.blue),
      ChartData(
          'mem',
          double.parse((sr.mem_percentatge * 100).toStringAsFixed(2)),
          Colors.green)
    ];
    String text = '';
    if (arguments['tipus'] == 1) {
      text =
          'L\'eficiència energètica del servei seleccionat de l\'edifici és...';
    } else {
      text = 'L\'eficiència energètica del sistema software és...';
    }
    return Scaffold(
      body: Row(children: [
        Container(
          color: Colors.lightGreen,
          width: 200 * MediaQuery.of(context).size.width / 1536,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image(
              image: AssetImage('images/icono-blanco.png'),
              width: 125 * MediaQuery.of(context).size.width / 1536,
              height: 125 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
                width: 1,
                height: 75 * MediaQuery.of(context).size.height / 864),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: Text(
                'Inici',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
            SizedBox(
              height: 50 * MediaQuery.of(context).size.height / 864,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/calculeficiencia');
              },
              child: Text(
                'Calcula l\'eficiència',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20 * MediaQuery.of(context).size.width / 1536,
                ),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
            SizedBox(
              height: 50 * MediaQuery.of(context).size.height / 864,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/introduirvalors');
              },
              child: Text(
                'Introdueix valors',
                style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536),
              ),
              /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
            ),
          ]),
        ),
        Expanded(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                height: 10 * MediaQuery.of(context).size.height / 864,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 25 * MediaQuery.of(context).size.width / 1536),
              ),
              SizedBox(
                height: 40 * MediaQuery.of(context).size.height / 864,
              ),
              Visibility(
                  child: SoftwareResults(), visible: arguments['tipus'] == 2),
              Visibility(
                  child: BuildingResults(), visible: arguments['tipus'] == 1),
              SizedBox(
                height: 20 * MediaQuery.of(context).size.height / 864,
                width: 1,
              ),
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
                        textStyle: TextStyle(
                            fontSize:
                                20 * MediaQuery.of(context).size.width / 1536),
                      ),
                      onPressed: () {
                        if (arguments['tipus'] == 1) {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      'Introdueix la següent informació sobre l\'edifici:'),
                                  content: new Container(
                                    child: Column(children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Indica la direcció de l\'edifici:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller,
                                                  onChanged:
                                                      (String value) async {
                                                    direction = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Direcció',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Indica el municipi:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller2,
                                                  onChanged:
                                                      (String value) async {
                                                    municipi = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Municipi',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Indica el codi postal:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller3,
                                                  onChanged:
                                                      (String value) async {
                                                    zip_code = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Codi postal',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Indica la comunitat autònoma:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller4,
                                                  onChanged:
                                                      (String value) async {
                                                    comunitat = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Comunitat autònoma',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    height: 250 *
                                        MediaQuery.of(context).size.height /
                                        864,
                                    width: 475 *
                                        MediaQuery.of(context).size.width /
                                        1536,
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
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      'Introdueix la següent informació sobre el sistema:'),
                                  content: new Container(
                                    child: Column(children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('Indica el nom del sistema:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller,
                                                  onChanged:
                                                      (String value) async {
                                                    direction = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Nom',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Indica l\'empresa desenvolupadora:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller2,
                                                  onChanged:
                                                      (String value) async {
                                                    municipi = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Empresa',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Indica el municipi de l\'empresa:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller3,
                                                  onChanged:
                                                      (String value) async {
                                                    zip_code = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Municipi',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20 *
                                            MediaQuery.of(context).size.height /
                                            864,
                                        width: 10 *
                                            MediaQuery.of(context).size.width /
                                            1536,
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Indica la comunitat autònoma de l\'empresa:'),
                                            SizedBox(
                                              width: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1536,
                                              height: 10 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  864,
                                            ),
                                            Container(
                                                child: TextField(
                                                  controller: _controller4,
                                                  onChanged:
                                                      (String value) async {
                                                    comunitat = value;
                                                  },
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Comunitat autònoma',
                                                  ),
                                                ),
                                                height: 40 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    864,
                                                width: 200 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536),
                                          ],
                                        ),
                                      ),
                                    ]),
                                    height: 250 *
                                        MediaQuery.of(context).size.height /
                                        864,
                                    width: 540 *
                                        MediaQuery.of(context).size.width /
                                        1536,
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
                        }
                      },
                      child: const Text('Generar informe'),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ]),
    );
  }
}
