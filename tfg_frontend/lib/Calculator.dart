import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_frontend/EfficiencyResults.dart';
import 'package:tfg_frontend/endpoints/Objects/BuildingResult.dart';
import 'package:tfg_frontend/endpoints/Objects/ClassificationData.dart';
import 'package:tfg_frontend/endpoints/Objects/SoftwareResult.dart';
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

  String cpu = 'Escull la CPU';
  String minCPU = '';
  String maxCPU = '';

  String gpu = 'Escull la GPU';
  String minGPU = '';
  String maxGPU = '';

  String memoryGB = '';
  String minMemory = '';
  String maxMemory = '';

  String testingDuration = '';
  String testingErrors = '';
  String solvedErrors = '';

//Camps per als edificis

  static String building_type = 'Escull la finalitat';
  static String service = 'Escull el servei';
  static String climatic_zone = 'Escull la zona climàtica';
  static String type = 'Escull el tipus';
  String zone = 'Escull la zona';

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

  List<String> cpus = ['Escull la CPU'];
  List<String> gpus = ['Escull la GPU'];
  List<String> climatic_zones = [];

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
    getComponentNames();
    super.initState();
  }

  Future<void> getComponentNames() async {
    late List<CalculationData> calculation_data;
    await getCPUs().then((List<CalculationData> cd) {
      setState(() {
        calculation_data = cd;
      });
    });
    for (CalculationData c in calculation_data) {
      cpus.add(c.value_type);
    }
    await getGPUs().then((List<CalculationData> cd) {
      setState(() {
        calculation_data = cd;
      });
    });
    for (CalculationData c in calculation_data) {
      gpus.add(c.value_type);
    }
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
    if (element == 'Edifici') {
      String dispersion_cz = '';
      if (service == 'Calefacció') {
        dispersion_cz = climatic_zone.substring(0, 1);
      } else if (climatic_zone == 'Refrigeració') {
        dispersion_cz = climatic_zone.substring(1, 2);
      } else {
        dispersion_cz = climatic_zone;
      }
      late CalculationData newdemandData;
      //obtener el valor de la dispersion
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà', 'Demanda', type,
              climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          newdemandData = cd;
        });
      });
      late CalculationData newdemandDisperssionData;
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Demanda', type,
              dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          newdemandDisperssionData = cd;
        });
      });
      late CalculationData newconsumData;
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          newconsumData = cd;
        });
      });
      late CalculationData newconsumDisperssionData;
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Consum d\'energia',
              type, dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          newconsumDisperssionData = cd;
        });
      });
      late CalculationData newemissionsData;
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà', 'Emissions', type,
              climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          newemissionsData = cd;
        });
      });
      late CalculationData newemissionsDisperssionData;
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Emissions', type,
              dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          newemissionsDisperssionData = cd;
        });
      });

      late CalculationData existentdemandData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Demanda',
              type, climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          existentdemandData = cd;
        });
      });
      late CalculationData existentdemandDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Demanda', type,
              dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          existentdemandDisperssionData = cd;
        });
      });
      late CalculationData existentconsumData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          existentconsumData = cd;
        });
      });
      late CalculationData existentconsumDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió',
              'Consum d\'energia', type, dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          existentconsumDisperssionData = cd;
        });
      });
      late CalculationData existentemissionsData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Emissions',
              type, climatic_zone, zone)
          .then((CalculationData cd) {
        setState(() {
          existentemissionsData = cd;
        });
      });
      late CalculationData existentemissionsDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Emissions',
              type, dispersion_cz, 'default')
          .then((CalculationData cd) {
        setState(() {
          existentemissionsDisperssionData = cd;
        });
      });
      late double C1_demand;
      late double C2_demand;
      late double C1_consum;
      late double C2_consum;
      late double C1_emissions;
      late double C2_emissions;
      if (service == 'Calefacció') {
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
        late String demand_classification;
        late String consum_classification;
        late String emissions_classification;

        if (service != 'ACS') {
          await getClassificationData(
                  '2', C1_demand.toString(), C2_demand.toString())
              .then((ClassificationData cd) {
            setState(() {
              demand_classification = cd.calification;
            });
          });
        } else {
          demand_classification = '-';
        }
        await getClassificationData(
                '2', C1_consum.toString(), C2_consum.toString())
            .then((ClassificationData cd) {
          setState(() {
            consum_classification = cd.calification;
          });
        });
        await getClassificationData(
                '2', C1_emissions.toString(), C2_emissions.toString())
            .then((ClassificationData cd) {
          setState(() {
            emissions_classification = cd.calification;
          });
        });
        BuildingResult br = BuildingResult(
            demandC1: demand_classification == '-' ? '0' : C1_demand.toString(),
            demandC2: demand_classification == '-' ? '0' : C2_demand.toString(),
            demand_class: demand_classification,
            consumptionC1: C1_consum.toString(),
            consumptionC2: C2_consum.toString(),
            consumption_class: consum_classification,
            emissionsC1: C1_emissions.toString(),
            emissionsC2: C2_emissions.toString(),
            emissions_class: emissions_classification,
            climatic_zone: climatic_zone,
            in_consumption: _controller2.text,
            in_demand: _controller.text,
            in_emissions: _controller3.text,
            purpose: building_type,
            service: service,
            type: type,
            zone: zone);
        SoftwareResult sr = SoftwareResult(
            efficiency: '0.0',
            efficiency_class: '',
            consumption: '0.0',
            consumption_class: '',
            perdurability: '0.0',
            perdurability_class: '',
            CPU_percentatge: 0.0,
            GPU_percentatge: 0.0,
            mem_percentatge: 0.0,
            cpu_execution: '0.4',
            cpu_before: '0.5',
            cpu: '',
            gpu_before: '0.5',
            gpu_execution: '0.5',
            gpu: '',
            mem_before: '0.5',
            mem_execution: '0.5',
            mem_size: '10',
            num_days: '0',
            num_errors: '0',
            PUE: '0');
        Navigator.of(context).pushNamed('/calculeficiencia/resultat',
            arguments: {'tipus': 1, 'br': br, 'sr': sr});
      } else if (building_type == 'No residencial') {
        late String demand_classification;
        late String consum_classification;
        late String emissions_classification;
        if (service != 'ACS') {
          await getClassificationData(
                  '1', (C1_demand / C2_demand).toString(), '0.0')
              .then((ClassificationData cd) {
            setState(() {
              demand_classification = cd.calification;
            });
          });
        } else {
          demand_classification = '-';
        }
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
            demandC1: demand_classification == '-'
                ? '0'
                : (C1_demand / C2_demand).toString(),
            demandC2: '0',
            demand_class: demand_classification,
            consumptionC1: (C1_consum / C2_consum).toString(),
            consumptionC2: '0',
            consumption_class: consum_classification,
            emissionsC1: (C1_emissions / C2_emissions).toString(),
            emissionsC2: '0',
            emissions_class: emissions_classification,
            climatic_zone: climatic_zone,
            in_consumption: _controller2.text,
            in_demand: _controller.text,
            in_emissions: _controller3.text,
            purpose: building_type,
            service: service,
            type: type,
            zone: zone);
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
            gpu_before: '',
            cpu: '',
            gpu_execution: '',
            gpu: '',
            mem_before: '',
            mem_execution: '',
            mem_size: '',
            num_days: '',
            num_errors: '',
            PUE: '');
        Navigator.of(context).pushNamed('/calculeficiencia/resultat',
            arguments: {'tipus': 1, 'br': br, 'sr': sr});
      }
    } else if (element == 'Sistema software') {
      //----------------------------CALCULO EFICIENCIA--------------------------------

      late CalculationData CPU_data;
      await getBuildingData('Sistema software', '', cpu, '', 'CPU', '', '')
          .then((CalculationData cd) {
        setState(() {
          CPU_data = cd;
        });
      });

      late CalculationData GPU_data;
      await getBuildingData('Sistema software', '', gpu, '', 'GPU', '', '')
          .then((CalculationData cd) {
        setState(() {
          GPU_data = cd;
        });
      });
      //obtener la informacion de la CPU seleccionada
      //obtener informacion de la GPU seleccionada
      double efficiency_cpu =
          (double.parse(_controller2.text) - double.parse(_controller.text)) /
              double.parse(_controller2.text) *
              double.parse(CPU_data.value1);
      double efficiency_gpu =
          (double.parse(_controller4.text) - double.parse(_controller3.text)) /
              double.parse(_controller4.text) *
              double.parse(GPU_data.value1);
      double efficiency_mem =
          (double.parse(_controller7.text) - double.parse(_controller6.text)) /
              double.parse(_controller7.text) *
              0.3725;
      double efficiency = (efficiency_cpu + efficiency_gpu + efficiency_mem) *
          double.parse(_controller8.text) *
          0.001;
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
          (double.parse(_controller7.text) - double.parse(_controller6.text)) /
              double.parse(_controller7.text);
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
          double.parse(_controller9.text) / double.parse(_controller10.text);
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
          mem_percentatge: (double.parse(memoryGB) * w_GB / consum_total),
          cpu_before: _controller.text,
          cpu_execution: _controller2.text,
          cpu: cpu,
          gpu_before: _controller3.text,
          gpu_execution: _controller4.text,
          gpu: gpu,
          mem_before: _controller5.text,
          mem_execution: _controller6.text,
          mem_size: _controller7.text,
          num_days: _controller9.text,
          num_errors: _controller10.text,
          PUE: _controller8.text);

      BuildingResult br = const BuildingResult(
          consumption_class: '',
          demand_class: '',
          consumptionC1: '0',
          consumptionC2: '0',
          demandC1: '0',
          demandC2: '0',
          emissions_class: '',
          emissionsC1: '0',
          emissionsC2: '0',
          climatic_zone: '',
          in_consumption: '',
          in_demand: '',
          in_emissions: '',
          purpose: '',
          service: '',
          type: '',
          zone: '');
      //realizar llamada para obtener el valor de la classificacion para la perdurabilidad
      Navigator.of(context).pushNamed('/calculeficiencia/resultat',
          arguments: {'tipus': 2, 'br': br, 'sr': sr});
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
              items: ['Escull la finalitat', 'Residencial', 'No residencial']
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
              items: ['Escull el tipus', 'Unifamiliar', 'Bloc']
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
            const Text('Indica la zona d\'España on es troba:'),
            const SizedBox(
              height: 5,
            ),
            DropdownButton<String>(
              value: zone,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  zone = newValue!;
                });
              },
              items: [
                'Escull la zona',
                'Península, Ceuta, Melilla i Illes Balears',
                'Illes Canàries'
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
                labelText: 'Consum d\'energia',
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
                if (service == 'Calefacció') {
                  climatic_zones = [
                    'Escull la zona climàtica',
                    'A1',
                    'A2',
                    'A3',
                    'A4',
                    'B1',
                    'B2',
                    'B3',
                    'B4',
                    'C1',
                    'C2',
                    'C3',
                    'C4',
                    'D1',
                    'D2',
                    'D3',
                    'E1'
                  ];
                } else if (service == 'Refrigeració') {
                  climatic_zones = [
                    'Escull la zona climàtica',
                    'α2',
                    'α3',
                    'α4',
                    'A2',
                    'A3',
                    'A4',
                    'B2',
                    'B3',
                    'B4',
                    'C2',
                    'C3',
                    'C4',
                    'D2',
                    'D3'
                  ];
                } else if (service == 'ACS') {
                  climatic_zones = [
                    'Escull la zona climàtica',
                    'α1',
                    'α2',
                    'α3',
                    'α4',
                    'A1',
                    'A2',
                    'A3',
                    'A4',
                    'B1',
                    'B2',
                    'B3',
                    'B4',
                    'C1',
                    'C2',
                    'C3',
                    'C4',
                    'D1',
                    'D2',
                    'D3',
                    'E1'
                  ];
                } else {
                  climatic_zones = ['Escull la zona climàtica'];
                }
              },
              items: [
                'Escull el servei',
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
              items:
                  climatic_zones.map<DropdownMenuItem<String>>((String value) {
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
                labelText: 'Demanda',
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
                labelText: 'Emissions',
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
          width: 100,
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
              items: cpus.map<DropdownMenuItem<String>>((String value) {
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
              items: gpus.map<DropdownMenuItem<String>>((String value) {
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
                labelText: 'Tamany de memòria',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el valor del PUE:'),
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
          width: 100,
        ),
        Expanded(
            child: Column(
          children: [
            const Text('Indica el percentatge de CPU abans de l\'execució:'),
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
                labelText: 'Percentatge de CPU',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el percentatge de GPU abans de l\'execució:'),
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
                labelText: 'Percentatge de GPU',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Indica el percentatge de memòria abans de l\'execució:'),
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
                labelText: 'Percentatge de memòria',
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
              controller: _controller9,
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
          width: 100,
        ),
        Expanded(
            child: Column(
          children: [
            const Text('Indica el percentatge de CPU durant l\'execució:'),
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
                labelText: 'Percentatge de CPU',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Indica el percentatge de GPU durant l\'execució:'),
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
                labelText: 'Percentatge de GPU',
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
                labelText: 'Percentatge de memòria',
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
          width: 100,
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            Container(
              color: Colors.lightGreen,
              width: 200,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Image(
                  image: AssetImage('images/icono-blanco.png'),
                  width: 125,
                  height: 125,
                ),
                SizedBox(width: 1, height: 75),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                  child: Text(
                    'Inici',
                    style: TextStyle(color: Colors.grey.shade300),
                  ),
                  /*style: ButtonStyle(
                    backgroundColor:
                   MaterialStateProperty.all<Color>(Colors.lightGreen))*/
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Calcula l\'eficiència',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  /*style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightGreen))*/
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/introduirvalors');
                  },
                  child: Text(
                    'Introdueix valors',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                    ),
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
                          items: [
                            'Escull l\'objecte',
                            'Edifici',
                            'Sistema software'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
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
                              if (element == 'Edifici' &&
                                  building_type != 'Escull la finalitat' &&
                                  service != 'Escull el servei' &&
                                  climatic_zone != 'Escull la zona climàtica' &&
                                  type != 'Escull el tipus') {
                                if (service == 'Calefacció' &&
                                    climatic_zone != 'α1' &&
                                    climatic_zone != 'α2' &&
                                    climatic_zone != 'α3') {
                                  calculateEfficiency();
                                } else if (service == 'Refrigeració' &&
                                    climatic_zone != 'α1' &&
                                    climatic_zone != 'A1' &&
                                    climatic_zone != 'B1' &&
                                    climatic_zone != 'C1' &&
                                    climatic_zone != 'D1' &&
                                    climatic_zone != 'E1') {
                                  calculateEfficiency();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                              'Falten valors per introduir'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: const Text('Continuar'),
                                            )
                                          ],
                                        );
                                      });
                                }
                              } else if (element == 'Sistema software' &&
                                  cpu != 'Escull la CPU' &&
                                  gpu != 'Escull la GPU' &&
                                  _controller.text != '' &&
                                  _controller2.text != '' &&
                                  _controller3.text != '' &&
                                  _controller4.text != '' &&
                                  _controller5.text != '' &&
                                  _controller6.text != '' &&
                                  _controller7.text != '' &&
                                  _controller8.text != '' &&
                                  _controller9.text != '' &&
                                  _controller10.text != '') {
                                calculateEfficiency();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title:
                                            Text('Falten valors per introduir'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: const Text('Continuar'),
                                          )
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text('Continuar'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
