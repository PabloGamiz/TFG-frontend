import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/BuildingCalculator.dart';
import 'package:tfg_frontend/EfficiencyResults.dart';
import 'package:tfg_frontend/StructureConnected.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'package:tfg_frontend/endpoints/Objects/ClassificationData.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';
import 'BuildingCalculator.dart';
import 'SoftwareCalculator.dart';
import 'Structure.dart';
import 'endpoints/Calls/CalculationData.dart';
import 'endpoints/Calls/Classification.dart';
import 'endpoints/Objects/CalculationData.dart';

class Calculator extends StatefulWidget {
  @override
  _Calculator createState() => _Calculator();
}

class _Calculator extends State<Calculator> {
  String action = '';
  int actionNumber = 0;
  String element = 'Escull l\'objecte';

  //Camps relacionats amb el software

  String cpu = '';
  String minCPU = '';
  String maxCPU = '';

  String gpu = '';
  String minGPU = '';
  String maxGPU = '';

  String memoryGB = '';
  String minMemory = '';
  String maxMemory = '';

  String testingDuration = '';
  String testingErrors = '';
  String solvedErrors = '';

//Camps per als edificis

  static String building_type = '';
  static String service = '';
  static String climatic_zone = '';
  static String type = '';

  static String value1 = '';
  static String value2 = '';
  static String value3 = '';

  bool visibleBuilding = false;
  bool visibleSoftware = false;

  late TextEditingController _controller;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  late TextEditingController _controller5;
  late TextEditingController _controller6;
  late TextEditingController _controller7;
  late TextEditingController _controller8;
  late TextEditingController _controller9;
  late TextEditingController _controller10;

  void initState() {
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    _controller5 = TextEditingController();
    _controller6 = TextEditingController();
    _controller7 = TextEditingController();
    _controller8 = TextEditingController();
    _controller9 = TextEditingController();
    _controller10 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    _controller8.dispose();
    _controller9.dispose();
    _controller10.dispose();
    super.dispose();
  }

  Future<bool> userConnected() async {
    final prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    if (email != null) {
      return true;
    }
    return false;
  }

  void calculateEfficiency() async {
    print('al principio del calculo');
    if (element == 'Edifici') {
      print('dentro de calculo de edificio');
      print('dentro de calculo residencial');
      late CalculationData newdemandData;
      //obtener el valor de la dispersion
      print('dentro de primera llamada');
      await getBuildingData(
              'Edifici', 'Nou', 'Valor mitjà', 'Demanda', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newdemandData = cd;
        });
      });
      late CalculationData newdemandDisperssionData;
      print('dentro de primera llamada');
      await getBuildingData(
              'Edifici', 'Nou', 'Dispersió', 'Demanda', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newdemandDisperssionData = cd;
        });
      });
      late CalculationData newconsumData;
      print('dentro de primera llamada');
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newconsumData = cd;
        });
      });
      late CalculationData newconsumDisperssionData;
      print('dentro de primera llamada');
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Consum d\'energia',
              type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newconsumDisperssionData = cd;
        });
      });
      late CalculationData newemissionsData;
      print('dentro de primera llamada');
      await getBuildingData(
              'Edifici', 'Nou', 'Valor mitjà', 'Emissions', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newemissionsData = cd;
        });
      });
      late CalculationData newemissionsDisperssionData;
      print('dentro de primera llamada');
      await getBuildingData(
              'Edifici', 'Nou', 'Dispersió', 'Emissions', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          newemissionsDisperssionData = cd;
        });
      });

      late CalculationData existentdemandData;
      //obtener el valor de la dispersion
      print('dentro de primera llamada');
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Demanda',
              type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentdemandData = cd;
        });
      });
      late CalculationData existentdemandDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Demanda', type,
              climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentdemandDisperssionData = cd;
        });
      });
      late CalculationData existentconsumData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentconsumData = cd;
        });
      });
      late CalculationData existentconsumDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió',
              'Consum d\'energia', type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentconsumDisperssionData = cd;
        });
      });
      late CalculationData existentemissionsData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Emissions',
              type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentemissionsData = cd;
        });
      });
      late CalculationData existentemissionsDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Emissions',
              type, climatic_zone)
          .then((CalculationData cd) {
        setState(() {
          existentemissionsDisperssionData = cd;
        });
      });
      print('despues de las llamadas para obtener la informacion');
      late double C1_demand;
      late double C2_demand;
      late double C1_consum;
      late double C2_consum;
      late double C1_emissions;
      late double C2_emissions;
      if (service == 'Calefacció') {
        print('dentro del calculo  de calefaccion');
        //CALCULO DE LA EFICIENCIA DE LA DEMANDA
        C1_demand = (((double.parse(newdemandDisperssionData.value1) *
                        double.parse(_controller.text) /
                        double.parse(newdemandData.value1)) -
                    1) /
                2 *
                (double.parse(newdemandDisperssionData.value1) - 1)) +
            0.6;
        C2_demand = (((double.parse(existentdemandDisperssionData.value1) *
                        double.parse(_controller.text) /
                        double.parse(existentdemandData.value1)) -
                    1) /
                2 *
                (double.parse(existentdemandDisperssionData.value1) - 1)) +
            0.5;
        C1_consum = (((double.parse(newconsumDisperssionData.value1) *
                        double.parse(_controller2.text) /
                        double.parse(newconsumData.value1)) -
                    1) /
                2 *
                (double.parse(newconsumDisperssionData.value1) - 1)) +
            0.6;
        C2_consum = (((double.parse(existentconsumDisperssionData.value1) *
                        double.parse(_controller2.text) /
                        double.parse(existentconsumData.value1)) -
                    1) /
                2 *
                (double.parse(existentconsumDisperssionData.value1) - 1)) +
            0.5;

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES
        C1_emissions = (((double.parse(newemissionsDisperssionData.value1) *
                        double.parse(_controller3.text) /
                        double.parse(newemissionsData.value1)) -
                    1) /
                2 *
                (double.parse(newemissionsDisperssionData.value1) - 1)) +
            0.6;
        C2_emissions =
            (((double.parse(existentemissionsDisperssionData.value1) *
                            double.parse(_controller3.text) /
                            double.parse(existentemissionsData.value1)) -
                        1) /
                    2 *
                    (double.parse(existentemissionsDisperssionData.value1) -
                        1)) +
                0.5;
        print('despues del calculo de calefaccion');
      } else if (service == 'Refrigeració') {
        C1_demand = (((double.parse(newdemandDisperssionData.value2) *
                        double.parse(_controller.text) /
                        double.parse(newdemandData.value2)) -
                    1) /
                2 *
                (double.parse(newdemandDisperssionData.value2) - 1)) +
            0.6;
        C2_demand = (((double.parse(existentdemandDisperssionData.value2) *
                        double.parse(_controller.text) /
                        double.parse(existentdemandData.value2)) -
                    1) /
                2 *
                (double.parse(existentdemandDisperssionData.value2) - 1)) +
            0.5;

        C1_consum = (((double.parse(newconsumDisperssionData.value2) *
                        double.parse(_controller2.text) /
                        double.parse(newconsumData.value2)) -
                    1) /
                2 *
                (double.parse(newconsumDisperssionData.value2) - 1)) +
            0.6;
        C2_consum = (((double.parse(existentconsumDisperssionData.value2) *
                        double.parse(_controller2.text) /
                        double.parse(existentconsumData.value2)) -
                    1) /
                2 *
                (double.parse(existentconsumDisperssionData.value2) - 1)) +
            0.5;

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES
        C1_emissions = (((double.parse(newemissionsDisperssionData.value2) *
                        double.parse(_controller3.text) /
                        double.parse(newemissionsData.value2)) -
                    1) /
                2 *
                (double.parse(newemissionsDisperssionData.value2) - 1)) +
            0.6;
        C2_emissions =
            (((double.parse(existentemissionsDisperssionData.value1) *
                            double.parse(_controller3.text) /
                            double.parse(existentemissionsData.value1)) -
                        1) /
                    2 *
                    (double.parse(existentemissionsDisperssionData.value1) -
                        1)) +
                0.5;
      } else if (service == 'ACS') {
        /*C1_demand = (((double.parse(newdemandDisperssionData.value3) *
                        double.parse(_controller.text) /
                        double.parse(newdemandData.value3)) -
                    1) /
                2 *
                (double.parse(newdemandDisperssionData.value3) - 1)) +
            0.6;
        C2_demand = (((double.parse(existentdemandDisperssionData.value3) *
                        double.parse(_controller.text) /
                        double.parse(existentdemandData.value3)) -
                    1) /
                2 *
                (double.parse(existentdemandDisperssionData.value3) - 1)) +
            0.5;*/

        C1_consum = (((double.parse(newconsumDisperssionData.value3) *
                        double.parse(_controller2.text) /
                        double.parse(newconsumData.value3)) -
                    1) /
                2 *
                (double.parse(newconsumDisperssionData.value3) - 1)) +
            0.6;
        C2_consum = (((double.parse(existentconsumDisperssionData.value3) *
                        double.parse(_controller2.text) /
                        double.parse(existentconsumData.value3)) -
                    1) /
                2 *
                (double.parse(existentconsumDisperssionData.value3) - 1)) +
            0.5;

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES
        C1_emissions = (((double.parse(newemissionsDisperssionData.value3) *
                        double.parse(_controller3.text) /
                        double.parse(newemissionsData.value3)) -
                    1) /
                2 *
                (double.parse(newemissionsDisperssionData.value3) - 1)) +
            0.6;
        C2_emissions =
            (((double.parse(existentemissionsDisperssionData.value3) *
                            double.parse(_controller3.text) /
                            double.parse(existentemissionsData.value3)) -
                        1) /
                    2 *
                    (double.parse(existentemissionsDisperssionData.value3) -
                        1)) +
                0.5;
      }
      if (building_type == 'Residencial') {
        print(
            'dentro de obtencion de classificaciones de un edificio residencial');
        late String demand_classification;
        late String consum_classification;
        late String emissions_classification;

        print('antes de primera classificacion');
        await getClassificationData(
                '2', C1_demand.toString(), C2_demand.toString())
            .then((ClassificationData cd) {
          setState(() {
            demand_classification = cd.calification;
          });
        });
        print('antes de segunda clasificacion');
        await getClassificationData(
                '2', C1_consum.toString(), C2_consum.toString())
            .then((ClassificationData cd) {
          setState(() {
            consum_classification = cd.calification;
          });
        });
        print('antes de tercera clasificacion');
        await getClassificationData(
                '2', C1_emissions.toString(), C2_emissions.toString())
            .then((ClassificationData cd) {
          setState(() {
            emissions_classification = cd.calification;
          });
        });
        print(
            'despues de obtener todas las clasificaciones para un edificio residencial');
        BuildingResult br = BuildingResult(
            demand: _controller.text,
            demand_class: demand_classification,
            consumption: _controller2.text,
            consumption_class: consum_classification,
            emissions: _controller3.text,
            emissions_class: emissions_classification);
        print('despues de crear br');
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
        print('despues de crear sr');
        bool user = await userConnected();
        if (user) {
          print('usuario existe por lo que se llama a la estructura conectada');
          runApp(MaterialApp(
              home: StructureConnected(
            tipus: 1,
            br: br,
            sr: sr,
          )));
        } else {
          print(
              'usuario no existe por lo que se llama a la estructura no conectada');
          if (!mounted) return;
          runApp(MaterialApp(
              home: Structure(
            tipus: 1,
            br: br,
            sr: sr,
          )));
        }
      } else if (building_type == 'No residencial') {
        late String demand_classification;
        late String consum_classification;
        late String emissions_classification;

        await getClassificationData(
                '1', (C1_demand / C2_demand).toString(), '0.0')
            .then((ClassificationData cd) {
          setState(() {
            demand_classification = cd.calification;
          });
        });
        await getClassificationData(
                '1', (C1_consum / C2_consum).toString(), '0.0')
            .then((ClassificationData cd) {
          setState(() {
            consum_classification = cd.calification;
          });
        });
        await getClassificationData(
                '1', (C1_emissions / C2_emissions).toString(), '0.0')
            .then((ClassificationData cd) {
          setState(() {
            emissions_classification = cd.calification;
          });
        });
        BuildingResult br = BuildingResult(
            demand: _controller.text,
            demand_class: demand_classification,
            consumption: _controller2.text,
            consumption_class: consum_classification,
            emissions: _controller3.text,
            emissions_class: emissions_classification);

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

        bool user = await userConnected();
        if (user) {
          runApp(MaterialApp(
              home: StructureConnected(
            tipus: 1,
            br: br,
            sr: sr,
          )));
        } else {
          runApp(MaterialApp(
              home: Structure(
            tipus: 1,
            br: br,
            sr: sr,
          )));
        }
      }
    } else if (element == 'Sistema software') {
      //----------------------------CALCULO EFICIENCIA--------------------------------

      late CalculationData CPU_data;

      await getBuildingData('Sistema software', '', cpu, '', 'CPU', '')
          .then((CalculationData cd) {
        setState(() {
          CPU_data = cd;
        });
      });

      late CalculationData GPU_data;
      await getBuildingData('Sistema software', '', gpu, '', 'GPU', '')
          .then((CalculationData cd) {
        setState(() {
          GPU_data = cd;
        });
      });

      //obtener la informacion de la CPU seleccionada
      //obtener informacion de la GPU seleccionada
      double efficiency_cpu =
          (double.parse(_controller2.text) - double.parse(_controller.text)) /
              double.parse(_controller2.text);
      double efficiency_gpu =
          (double.parse(_controller4.text) - double.parse(_controller3.text)) /
              double.parse(_controller4.text);
      double efficiency_mem =
          (double.parse(_controller6.text) - double.parse(_controller5.text)) /
              double.parse(_controller6.text);
      double efficiency = (efficiency_cpu + efficiency_gpu + efficiency_mem);

      late String efficiency_classification;
      await getClassificationData('1', (efficiency).toString(), '0.0')
          .then((ClassificationData cd) {
        setState(() {
          efficiency_classification = cd.calification;
        });
      });

      //realizar llamada para obtener el valor de la classificacion para la eficiencia

      //-----------------------------CALCULO OPTIMIZACION RECURSOS---------------------

      double w_GB = 0.3725;
      double consum_total = double.parse(CPU_data.value1) +
          double.parse(GPU_data.value1) +
          double.parse(memoryGB) * w_GB;

      double op_consumption_cpu =
          (double.parse(_controller2.text) - double.parse(_controller.text)) /
              double.parse(_controller2.text);
      double op_consumption_gpu =
          (double.parse(_controller4.text) - double.parse(_controller3.text)) /
              double.parse(_controller4.text);
      double op_consumption_mem =
          (double.parse(_controller6.text) - double.parse(_controller5.text)) /
              double.parse(_controller6.text);
      double op_consumption = op_consumption_cpu *
              (double.parse(CPU_data.value1) / consum_total) +
          op_consumption_gpu * (double.parse(GPU_data.value1) / consum_total) +
          op_consumption_mem * (double.parse(memoryGB) * w_GB / consum_total);

      late String op_classification;
      await getClassificationData('1', (op_consumption).toString(), '0.0')
          .then((ClassificationData cd) {
        setState(() {
          op_classification = cd.calification;
        });
      });

      //----------------------------CALCULO PERDURABILIDAD----------------------------------------

      double testing =
          double.parse(_controller7.text) / double.parse(_controller8.text);
      late String testing_classification;
      await getClassificationData('1', (testing).toString(), '0.0')
          .then((ClassificationData cd) {
        setState(() {
          testing_classification = cd.calification;
        });
      });
      SoftwareResult sr = SoftwareResult(
          consumption_class: op_classification,
          consumption: op_consumption.toString(),
          efficiency_class: efficiency_classification,
          efficiency: efficiency.toString(),
          perdurability: testing.toString(),
          perdurability_class: testing_classification.toString(),
          CPU_percentatge: (double.parse(CPU_data.value1) / consum_total),
          GPU_percentatge: (double.parse(GPU_data.value1) / consum_total),
          mem_percentatge: (double.parse(memoryGB) * w_GB / consum_total));

      BuildingResult br = const BuildingResult(
          consumption_class: '',
          demand_class: '',
          consumption: '',
          demand: '',
          emissions_class: '',
          emissions: '');
      //realizar llamada para obtener el valor de la classificacion para la perdurabilidad
      bool user = await userConnected();
      if (user) {
        runApp(MaterialApp(
            home: StructureConnected(
          tipus: 2,
          br: br,
          sr: sr,
        )));
      } else {
        runApp(MaterialApp(
            home: Structure(
          tipus: 2,
          br: br,
          sr: sr,
        )));
      }
    }
  }

  Widget buildingCalculator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Indica la finalitat del edifici:'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: building_type,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  building_type = newValue!;
                });
              },
              items: ['', 'Residencial', 'No residencial']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el tipus d\'edifici:'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: type,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  type = newValue!;
                });
              },
              items: ['', 'Unifamiliar', 'Bloc']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Introdueix el valor de la demanda pel servei seleccionat:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller,
              onChanged: (String value) async {
                value1 = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Introdueix el valor de la emissions pel servei seleccionat:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller3,
              onChanged: (String value) async {
                value3 = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
          ],
        )),
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Indica el servei per al que vols calcular l\'eficiència:'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: service,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  service = newValue!;
                });
              },
              items: [
                '',
                'Calefacció',
                'Refrigeració',
                'Aigua corrent sanitària'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica la zona climàtica:'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: climatic_zone,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  climatic_zone = newValue!;
                });
              },
              items: ['', 'A1', 'A2', 'A3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Introdueix el valor del consum d\'energia pel servei seleccionat:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller2,
              onChanged: (String value) async {
                value2 = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
          ],
        )),
        const SizedBox(
          width: 150,
        ),
      ],
    );
  }

  Widget softwareCalculator() {
    return Row(
      children: [
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          children: [
            const Text('Quina es la CPU emprada en l\'execució?'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: cpu,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  cpu = newValue!;
                });
              },
              items: ['', 'Unifamiliar', 'Bloc']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Quina es la GPU emprada en l\'execució?'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: gpu,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  gpu = newValue!;
                });
              },
              items: ['', 'Unifamiliar', 'Bloc']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el tamany en GB de la mermòria:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller5,
              onChanged: (String value) async {
                memoryGB = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el valor del PUE (power usage effectiveness):'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller8,
              onChanged: (String value) async {
                testingErrors = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PUE',
              ),
            ),
          ],
        )),
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          children: [
            const Text(
                'Indica el percentatge de CPU abans l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller,
              onChanged: (String value) async {
                minCPU = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el percentatge de CPU abans l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller3,
              onChanged: (String value) async {
                minGPU = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el percentatge de memòria abans l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller6,
              onChanged: (String value) async {
                minMemory = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el nombre de falles totals desde el deployment:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller8,
              onChanged: (String value) async {
                testingDuration = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre de falles',
              ),
            ),
          ],
        )),
        const SizedBox(
          width: 150,
        ),
        Expanded(
            child: Column(
          children: [
            const Text(
                'Indica el percentatge de CPU durant l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller2,
              onChanged: (String value) async {
                maxCPU = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el percentatge de GPU durant l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller4,
              onChanged: (String value) async {
                maxGPU = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el percentatge de memòria durant l\'execució del software:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller7,
              onChanged: (String value) async {
                maxMemory = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Introdueix un valor',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el nombre de dies des del deployment:'),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controller10,
              onChanged: (String value) async {
                solvedErrors = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre de dies',
              ),
            ),
          ],
        )),
        const SizedBox(
          width: 150,
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Càlcul de l\'eficiència',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Indica el tipus d\'objecte per al que vols realitzar el càlcul: ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 20,
              ),
              DropdownButton<String>(
                value: element,
                style: TextStyle(color: Colors.green.shade700),
                underline: Container(
                  height: 2,
                  color: Colors.green.shade50,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    element = newValue!;
                  });
                  if (element == 'Escull l\'objecte') {
                    visibleBuilding = false;
                    visibleSoftware = false;
                  } else if (element == 'Edifici') {
                    visibleBuilding = true;
                    visibleSoftware = false;
                  } else if (element == 'Sistema software') {
                    visibleBuilding = false;
                    visibleSoftware = true;
                  }
                },
                items: ['Escull l\'objecte', 'Edifici', 'Sistema software']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            child: Expanded(
                child: Container(
              height: 300,
            )),
            visible: !visibleBuilding && !visibleSoftware,
          ),
          Visibility(
              child: Expanded(
                  child: Container(
                child: buildingCalculator(),
              )),
              visible: visibleBuilding),
          Visibility(
              child: Expanded(
                  child: Container(
                child: softwareCalculator(),
              )),
              visible: visibleSoftware),
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
                    calculateEfficiency();
                  },
                  child: const Text('Continuar'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
