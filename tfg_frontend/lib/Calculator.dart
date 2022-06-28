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
import 'package:async/async.dart';

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
  bool calculation = false;

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

  late AsyncMemoizer _memoizer;

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
    _memoizer = AsyncMemoizer();
    super.initState();
  }

  _fetchdata() async {
    return _memoizer.runOnce(() async {
      await getComponentNames();
      return;
    });
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
      print('dentro de calculo para edificio');
      String dispersion_cz = '';
      if (service == 'Calefacció') {
        dispersion_cz = climatic_zone.substring(0, 1);
      } else if (service == 'Refrigeració') {
        dispersion_cz = climatic_zone.substring(1, 2);
      } else {
        dispersion_cz = climatic_zone;
      }
      late CalculationData newdemandData;
      late CalculationData newdemandDisperssionData;
      //obtener el valor de la dispersion
      if (service != 'ACS') {
        await getBuildingData('Edifici', 'Nou', 'Valor mitjà', 'Demanda', type,
                climatic_zone, zone, context)
            .then((CalculationData cd) {
          setState(() {
            newdemandData = cd;
          });
        });
        print('despues de primera llamada');
        await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Demanda', type,
                dispersion_cz, zone, context)
            .then((CalculationData cd) {
          setState(() {
            newdemandDisperssionData = cd;
          });
        });
      }
      print('despues de segunda llamada');
      late CalculationData newconsumData;
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone, zone, context)
          .then((CalculationData cd) {
        setState(() {
          newconsumData = cd;
        });
      });
      print('despues de tercera llamada');
      late CalculationData newconsumDisperssionData;
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Consum d\'energia',
              type, dispersion_cz, zone, context)
          .then((CalculationData cd) {
        setState(() {
          newconsumDisperssionData = cd;
        });
      });
      print('despues de cuarta llamada');
      late CalculationData newemissionsData;
      await getBuildingData('Edifici', 'Nou', 'Valor mitjà', 'Emissions', type,
              climatic_zone, zone, context)
          .then((CalculationData cd) {
        setState(() {
          newemissionsData = cd;
        });
      });
      late CalculationData newemissionsDisperssionData;
      await getBuildingData('Edifici', 'Nou', 'Dispersió', 'Emissions', type,
              dispersion_cz, zone, context)
          .then((CalculationData cd) {
        setState(() {
          newemissionsDisperssionData = cd;
        });
      });

      late CalculationData existentdemandData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Demanda',
              type, climatic_zone, zone, context)
          .then((CalculationData cd) {
        setState(() {
          existentdemandData = cd;
        });
      });
      late CalculationData existentdemandDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Demanda', type,
              dispersion_cz, zone, context)
          .then((CalculationData cd) {
        setState(() {
          existentdemandDisperssionData = cd;
        });
      });
      late CalculationData existentconsumData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà',
              'Consum d\'energia', type, climatic_zone, zone, context)
          .then((CalculationData cd) {
        setState(() {
          existentconsumData = cd;
        });
      });
      late CalculationData existentconsumDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió',
              'Consum d\'energia', type, dispersion_cz, zone, context)
          .then((CalculationData cd) {
        setState(() {
          existentconsumDisperssionData = cd;
        });
      });
      late CalculationData existentemissionsData;
      await getBuildingData('Edifici', 'Existent', 'Valor mitjà', 'Emissions',
              type, climatic_zone, zone, context)
          .then((CalculationData cd) {
        setState(() {
          existentemissionsData = cd;
        });
      });
      late CalculationData existentemissionsDisperssionData;
      await getBuildingData('Edifici', 'Existent', 'Dispersió', 'Emissions',
              type, dispersion_cz, zone, context)
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
        /*C1_demand = (((double.parse(newdemandDisperssionData.value1) *
                        double.parse(_controller.text) /
                        double.parse(newdemandData.value1)) -
                    1) /
                2 *
                (double.parse(newdemandDisperssionData.value1) - 1)) +
            0.6;*/

        double C1_demand_top = ((double.parse(newdemandDisperssionData.value1) *
                double.parse(_controller.text) /
                double.parse(newdemandData.value1)) -
            1);
        double C1_demand_bot =
            2 * (double.parse(newdemandDisperssionData.value1) - 1);
        C1_demand = C1_demand_top / C1_demand_bot;
        C1_demand = C1_demand + 0.6;

        double C2_demand_top =
            ((double.parse(existentdemandDisperssionData.value1) *
                    double.parse(_controller.text) /
                    double.parse(existentdemandData.value1)) -
                1);
        print(C2_demand_top);
        double C2_demand_bot =
            2 * (double.parse(existentdemandDisperssionData.value1) - 1);
        print(C2_demand_bot);
        C2_demand = C2_demand_top / C2_demand_bot;
        print(C2_demand);
        C2_demand = C2_demand + 0.5;
        print(C2_demand);
        /*C2_demand = (((double.parse(existentdemandDisperssionData.value1) *
                        double.parse(_controller.text) /
                        double.parse(existentdemandData.value1)) -
                    1) /
                2 *
                (double.parse(existentdemandDisperssionData.value1) - 1)) +
            0.5;*/
        double C1_consum_top = (double.parse(newconsumDisperssionData.value1) *
                double.parse(_controller2.text) /
                double.parse(newconsumData.value1)) -
            1;
        double C1_consum_bot =
            2 * (double.parse(newconsumDisperssionData.value1) - 1);
        C1_consum = C1_consum_top / C1_consum_bot;
        C1_consum = C1_consum + 0.6;
        /*C1_consum = (((double.parse(newconsumDisperssionData.value1) *
                        double.parse(_controller2.text) /
                        double.parse(newconsumData.value1)) -
                    1) /
                2 *
                (double.parse(newconsumDisperssionData.value1) - 1)) +
            0.6;*/
        print('---------------------------------------');
        print(2 * (double.parse(newconsumDisperssionData.value1) - 1));
        print('_______________________');
        print((((double.parse(newconsumDisperssionData.value1) *
                    double.parse(_controller2.text) /
                    double.parse(newconsumData.value1)) -
                1) /
            2 *
            (double.parse(newconsumDisperssionData.value1) - 1)));
        double C2_consum_top =
            ((double.parse(existentconsumDisperssionData.value1) *
                    double.parse(_controller2.text) /
                    double.parse(existentconsumData.value1)) -
                1);
        double C2_consum_bot =
            2 * (double.parse(existentconsumDisperssionData.value1) - 1);
        C2_consum = C2_consum_top / C2_consum_bot;
        C2_consum = C2_consum + 0.5;
        /*C2_consum = (((double.parse(existentconsumDisperssionData.value1) *
                        double.parse(_controller2.text) /
                        double.parse(existentconsumData.value1)) -
                    1) /
                2 *
                (double.parse(existentconsumDisperssionData.value1) - 1)) +
            0.5;*/

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES
        double C1_emissions_top =
            ((double.parse(newemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(newemissionsData.value1)) -
                1);
        double C1_emissions_bot =
            2 * (double.parse(newemissionsDisperssionData.value1) - 1);
        C1_emissions = C1_emissions_top / C1_emissions_bot;
        C1_emissions = C1_emissions + 0.6;
        /*C1_emissions = (((double.parse(newemissionsDisperssionData.value1) *
                        double.parse(_controller3.text) /
                        double.parse(newemissionsData.value1)) -
                    1) /
                2 *
                (double.parse(newemissionsDisperssionData.value1) - 1)) +
            0.6;*/

        double C2_emissions_top =
            ((double.parse(existentemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(existentemissionsData.value1)) -
                1);
        double C2_emissions_bot =
            2 * (double.parse(existentemissionsDisperssionData.value1) - 1);
        C2_emissions = C2_emissions_top / C2_emissions_bot;
        C2_emissions = C2_emissions + 0.5;
        /*C2_emissions =
            (((double.parse(existentemissionsDisperssionData.value1) *
                            double.parse(_controller3.text) /
                            double.parse(existentemissionsData.value1)) -
                        1) /
                    2 *
                    (double.parse(existentemissionsDisperssionData.value1) -
                        1)) +
                0.5;*/
      } else if (service == 'Refrigeració') {
        print(newdemandData.value2);
        print(newdemandDisperssionData.value2);
        print(newconsumData.value2);
        print(newemissionsData.value2);
        double C1_demand_top = ((double.parse(newdemandDisperssionData.value1) *
                double.parse(_controller.text) /
                double.parse(newdemandData.value2)) -
            1);
        double C1_demand_bot =
            2 * (double.parse(newdemandDisperssionData.value1) - 1);
        C1_demand = C1_demand_top / C1_demand_bot;
        C1_demand = C1_demand + 0.6;

        double C2_demand_top =
            ((double.parse(existentdemandDisperssionData.value1) *
                    double.parse(_controller.text) /
                    double.parse(existentdemandData.value2)) -
                1);
        double C2_demand_bot =
            2 * (double.parse(existentdemandDisperssionData.value1) - 1);
        C2_demand = C2_demand_top / C2_demand_bot;
        C2_demand = C2_demand + 0.5;

        /*C1_demand = (((double.parse(newdemandDisperssionData.value2) *
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
            0.5;*/
        double C1_consum_top = (double.parse(newconsumDisperssionData.value1) *
                double.parse(_controller2.text) /
                double.parse(newconsumData.value2)) -
            1;
        double C1_consum_bot =
            2 * (double.parse(newconsumDisperssionData.value1) - 1);
        C1_consum = C1_consum_top / C1_consum_bot;
        C1_consum = C1_consum + 0.6;

        double C2_consum_top =
            ((double.parse(existentconsumDisperssionData.value1) *
                    double.parse(_controller2.text) /
                    double.parse(existentconsumData.value2)) -
                1);
        double C2_consum_bot =
            2 * (double.parse(existentconsumDisperssionData.value1) - 1);
        C2_consum = C2_consum_top / C2_consum_bot;
        C2_consum = C2_consum + 0.5;
        print(C1_consum_bot);
        print(C2_consum_top);
        /*C1_consum = (((double.parse(newconsumDisperssionData.value2) *
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
            0.5;*/

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES

        double C1_emissions_top =
            ((double.parse(newemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(newemissionsData.value2)) -
                1);
        double C1_emissions_bot =
            2 * (double.parse(newemissionsDisperssionData.value1) - 1);
        C1_emissions = C1_emissions_top / C1_emissions_bot;
        print('<-------------------------------->');
        print(C1_emissions_bot);
        C1_emissions = C1_emissions + 0.6;
        print(C1_emissions_top);

        double C2_emissions_top =
            ((double.parse(existentemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(existentemissionsData.value2)) -
                1);
        double C2_emissions_bot =
            2 * (double.parse(existentemissionsDisperssionData.value1) - 1);
        C2_emissions = C2_emissions_top / C2_emissions_bot;
        print(C2_emissions_bot);
        print(C2_emissions_top);
        C2_emissions = C2_emissions + 0.5;

        /* C1_emissions = (((double.parse(newemissionsDisperssionData.value2) *
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
                0.5;*/
      } else if (service == 'ACS') {
        double C1_consum_top = (double.parse(newconsumDisperssionData.value1) *
                double.parse(_controller2.text) /
                double.parse(newconsumData.value3)) -
            1;
        double C1_consum_bot =
            2 * (double.parse(newconsumDisperssionData.value1) - 1);
        C1_consum = C1_consum_top / C1_consum_bot;
        C1_consum = C1_consum + 0.6;

        double C2_consum_top =
            ((double.parse(existentconsumDisperssionData.value1) *
                    double.parse(_controller2.text) /
                    double.parse(existentconsumData.value3)) -
                1);
        double C2_consum_bot =
            2 * (double.parse(existentconsumDisperssionData.value1) - 1);
        C2_consum = C2_consum_top / C2_consum_bot;
        C2_consum = C2_consum + 0.5;
        /*C1_consum = (((double.parse(newconsumDisperssionData.value3) *
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
            0.5;*/

        //CALCULO DE LA EFICIENCIA DE LAS EMISIONES

        double C1_emissions_top =
            ((double.parse(newemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(newemissionsData.value2)) -
                1);
        double C1_emissions_bot =
            2 * (double.parse(newemissionsDisperssionData.value1) - 1);
        C1_emissions = C1_emissions_top / C1_emissions_bot;
        C1_emissions = C1_emissions + 0.6;

        double C2_emissions_top =
            ((double.parse(existentemissionsDisperssionData.value1) *
                    double.parse(_controller3.text) /
                    double.parse(existentemissionsData.value3)) -
                1);
        double C2_emissions_bot =
            2 * (double.parse(existentemissionsDisperssionData.value1) - 1);
        C2_emissions = C2_emissions_top / C2_emissions_bot;
        C2_emissions = C2_emissions + 0.5;

        /*C1_emissions = (((double.parse(newemissionsDisperssionData.value3) *
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
                0.5;*/
      }
      if (building_type == 'Residencial') {
        late String demand_classification;
        late String consum_classification;
        late String emissions_classification;

        if (service != 'ACS') {
          print('antes de primera llamada para obtener classificacion');
          await getClassificationData(
                  '2', C1_demand.toString(), C2_demand.toString(), context)
              .then((ClassificationData cd) {
            setState(() {
              demand_classification = cd.calification;
            });
          });
        } else {
          demand_classification = '-';
        }
        print('antes de segunda llamada');
        await getClassificationData(
                '2', C1_consum.toString(), C2_consum.toString(), context)
            .then((ClassificationData cd) {
          setState(() {
            consum_classification = cd.calification;
          });
        });
        print('antes tercera llamada');
        await getClassificationData(
                '2', C1_emissions.toString(), C2_emissions.toString(), context)
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
                  '1', (C1_demand / C2_demand).toString(), '0.0', context)
              .then((ClassificationData cd) {
            setState(() {
              demand_classification = cd.calification;
            });
          });
        } else {
          demand_classification = '-';
        }
        await getClassificationData(
                '1', (C1_consum / C2_consum).toString(), '0.0', context)
            .then((ClassificationData cd) {
          setState(() {
            consum_classification = cd.calification;
          });
        });
        await getClassificationData(
                '1', (C1_emissions / C2_emissions).toString(), '0.0', context)
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
            efficiency: '0',
            efficiency_class: '',
            consumption: '0',
            consumption_class: '',
            perdurability: '0',
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
      await getBuildingData(
              'Sistema software', '', cpu, '', 'CPU', '', '', context)
          .then((CalculationData cd) {
        setState(() {
          CPU_data = cd;
        });
      });

      late CalculationData GPU_data;
      await getBuildingData(
              'Sistema software', '', gpu, '', 'GPU', '', '', context)
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
      await getClassificationData('1', (efficiency).toString(), '0.0', context)
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

      print(consum_total);

      double op_consumption_cpu =
          (double.parse(_controller2.text) - double.parse(_controller.text)) /
              double.parse(_controller2.text);
      print(op_consumption_cpu);
      double op_consumption_gpu =
          (double.parse(_controller4.text) - double.parse(_controller3.text)) /
              double.parse(_controller4.text);
      print(op_consumption_gpu);
      double op_consumption_mem =
          (double.parse(_controller7.text) - double.parse(_controller6.text)) /
              double.parse(_controller7.text);
      print(op_consumption_mem);
      double op_consumption = op_consumption_cpu *
              (double.parse(CPU_data.value1) / consum_total) +
          op_consumption_gpu * (double.parse(GPU_data.value1) / consum_total) +
          op_consumption_mem * (double.parse(memoryGB) * w_GB / consum_total);
      print(op_consumption);
      late String op_classification;
      await getClassificationData(
              '1', (op_consumption).toString(), '0.0', context)
          .then((ClassificationData cd) {
        setState(() {
          op_classification = cd.calification;
        });
      });

      //----------------------------CALCULO PERDURABILIDAD----------------------------------------

      double testing =
          double.parse(_controller9.text) / double.parse(_controller10.text);
      late String testing_classification;
      await getClassificationData('1', (testing).toString(), '0.0', context)
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
        SizedBox(
          width: 150 * MediaQuery.of(context).size.width / 1536,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Indica la finalitat del edifici:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            DropdownButton<String>(
              iconSize: 14 * MediaQuery.of(context).size.width / 1536,
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
                  child: Text(value,
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text('Indica el tipus d\'edifici:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            DropdownButton<String>(
              iconSize: 14 * MediaQuery.of(context).size.width / 1536,
              value: type,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2 * MediaQuery.of(context).size.height / 864,
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
                  child: Text(value,
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text('Indica la zona d\'España on es troba:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            DropdownButton<String>(
              iconSize: 14 * MediaQuery.of(context).size.width / 1536,
              value: zone,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2 * MediaQuery.of(context).size.height / 864,
                color: Colors.green.shade50,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  zone = newValue!;
                });
              },
              items: [
                'Escull la zona',
                'Península',
                'Ceuta, Melilla i Illes Balears',
                'Illes Canàries'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text(
                'Introdueix el valor del consum d\'energia pel servei seleccionat:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
                child: TextField(
                  style: TextStyle(
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  controller: _controller2,
                  onChanged: (String value) async {
                    value2 = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536),
                    border: OutlineInputBorder(),
                    labelText: 'Consum d\'energia',
                  ),
                ),
                height: 45 * MediaQuery.of(context).size.height / 864),
          ],
        )),
        SizedBox(
          width: 150 * MediaQuery.of(context).size.width / 1536,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Indica el servei per al que vols calcular l\'eficiència:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            DropdownButton<String>(
              iconSize: 14 * MediaQuery.of(context).size.width / 1536,
              value: service,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2 * MediaQuery.of(context).size.height / 864,
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
              items: ['Escull el servei', 'Calefacció', 'Refrigeració', 'ACS']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text('Indica la zona climàtica:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            DropdownButton<String>(
              iconSize: 14 * MediaQuery.of(context).size.width / 1536,
              value: climatic_zone,
              style: TextStyle(color: Colors.green.shade700),
              underline: Container(
                height: 2 * MediaQuery.of(context).size.height / 864,
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
                  child: Text(value,
                      style: TextStyle(
                          fontSize:
                              14 * MediaQuery.of(context).size.width / 1536)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text('Introdueix el valor de la demanda pel servei seleccionat:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
                child: TextField(
                  style: TextStyle(
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  controller: _controller,
                  onChanged: (String value) async {
                    value1 = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536),
                    border: OutlineInputBorder(),
                    labelText: 'Demanda',
                  ),
                ),
                height: 45 * MediaQuery.of(context).size.height / 864),
            SizedBox(
              height: 20 * MediaQuery.of(context).size.height / 864,
            ),
            Text('Introdueix el valor de la emissions pel servei seleccionat:',
                style: TextStyle(
                    fontSize: 14 * MediaQuery.of(context).size.width / 1536)),
            SizedBox(
              height: 5 * MediaQuery.of(context).size.height / 864,
            ),
            SizedBox(
                child: TextField(
                  style: TextStyle(
                      fontSize: 14 * MediaQuery.of(context).size.width / 1536),
                  controller: _controller3,
                  onChanged: (String value) async {
                    value3 = value;
                  },
                  obscureText: false,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        fontSize:
                            14 * MediaQuery.of(context).size.width / 1536),
                    border: OutlineInputBorder(),
                    labelText: 'Emissions',
                  ),
                ),
                height: 45 * MediaQuery.of(context).size.height / 864),
          ],
        )),
        SizedBox(
          width: 150 * MediaQuery.of(context).size.width / 1536,
        ),
      ],
    );
  }

  Widget softwareCalculator() {
    return FutureBuilder(
        future: _fetchdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<String> cpu_names = [];
            cpu_names = cpus;
            List<String> gpu_names = [];
            gpu_names = gpus;
            return Row(
              children: [
                SizedBox(
                  width: 100 * MediaQuery.of(context).size.width / 1536,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text('Quina es la CPU emprada en l\'execució?',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    DropdownButton<String>(
                      iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                      value: cpu,
                      style: TextStyle(color: Colors.green.shade700),
                      underline: Container(
                        height: 2 * MediaQuery.of(context).size.height / 864,
                        color: Colors.green.shade50,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          cpu = newValue!;
                        });
                      },
                      items: cpu_names
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 14 *
                                      MediaQuery.of(context).size.width /
                                      1536)),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Quina es la GPU emprada en l\'execució?',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    DropdownButton<String>(
                      iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                      value: gpu,
                      style: TextStyle(color: Colors.green.shade700),
                      underline: Container(
                        height: 2 * MediaQuery.of(context).size.height / 864,
                        color: Colors.green.shade50,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          gpu = newValue!;
                        });
                      },
                      items: gpu_names
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 14 *
                                      MediaQuery.of(context).size.width /
                                      1536)),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Indica el tamany en GB de la mermòria:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller5,
                          onChanged: (String value) async {
                            memoryGB = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Tamany de memòria',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Indica el valor del PUE:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller8,
                          onChanged: (String value) async {
                            testingErrors = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'PUE',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                  ],
                )),
                SizedBox(
                  width: 100 * MediaQuery.of(context).size.width / 1536,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text('Indica el percentatge de CPU abans de l\'execució:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller,
                          onChanged: (String value) async {
                            minCPU = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de CPU',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Indica el percentatge de GPU abans de l\'execució:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller3,
                          onChanged: (String value) async {
                            minGPU = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de GPU',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text(
                        'Indica el percentatge de memòria abans de l\'execució:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller6,
                          onChanged: (String value) async {
                            minMemory = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de memòria',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text(
                        'Indica el nombre de falles totals desde el deployment:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller9,
                          onChanged: (String value) async {
                            testingDuration = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Nombre de falles',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                  ],
                )),
                SizedBox(
                  width: 100 * MediaQuery.of(context).size.width / 1536,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text('Indica el percentatge de CPU durant l\'execució:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller2,
                          onChanged: (String value) async {
                            maxCPU = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de CPU',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Indica el percentatge de GPU durant l\'execució:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller4,
                          onChanged: (String value) async {
                            maxGPU = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de GPU',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text(
                        'Indica el percentatge de memòria durant l\'execució del software:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller7,
                          onChanged: (String value) async {
                            maxMemory = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Percentatge de memòria',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                    SizedBox(
                      height: 20 * MediaQuery.of(context).size.height / 864,
                    ),
                    Text('Indica el nombre de dies des del deployment:',
                        style: TextStyle(
                            fontSize:
                                14 * MediaQuery.of(context).size.width / 1536)),
                    SizedBox(
                      height: 5 * MediaQuery.of(context).size.height / 864,
                    ),
                    SizedBox(
                        child: TextField(
                          style: TextStyle(
                              fontSize: 14 *
                                  MediaQuery.of(context).size.width /
                                  1536),
                          controller: _controller10,
                          onChanged: (String value) async {
                            solvedErrors = value;
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                fontSize: 14 *
                                    MediaQuery.of(context).size.width /
                                    1536),
                            border: OutlineInputBorder(),
                            labelText: 'Nombre de dies',
                          ),
                        ),
                        height: 45 * MediaQuery.of(context).size.height / 864),
                  ],
                )),
                SizedBox(
                  width: 100 * MediaQuery.of(context).size.width / 1536,
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget build(BuildContext context) {
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
              onPressed: () {},
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                  child: Text(
                    'Càlcul de l\'eficiència',
                    style: TextStyle(
                        fontSize:
                            30 * MediaQuery.of(context).size.width / 1536),
                  ),
                  visible: !calculation,
                ),
                SizedBox(
                  height: 50 * MediaQuery.of(context).size.height / 864,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      child: Text(
                        'Indica el tipus d\'objecte per al que vols realitzar el càlcul: ',
                        style: TextStyle(
                            fontSize:
                                18 * MediaQuery.of(context).size.width / 1536),
                      ),
                      visible: !calculation,
                    ),
                    SizedBox(
                      width: 20 * MediaQuery.of(context).size.width / 1536,
                    ),
                    Visibility(
                      child: DropdownButton<String>(
                        iconSize: 14 * MediaQuery.of(context).size.width / 1536,
                        value: element,
                        style: TextStyle(color: Colors.green.shade700),
                        underline: Container(
                          height: 2 * MediaQuery.of(context).size.height / 864,
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
                            child: Text(value,
                                style: TextStyle(
                                    fontSize: 14 *
                                        MediaQuery.of(context).size.width /
                                        1536)),
                          );
                        }).toList(),
                      ),
                      visible: !calculation,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40 * MediaQuery.of(context).size.height / 864,
                ),
                Visibility(
                  child: Expanded(
                      child: Container(
                    height: 300 * MediaQuery.of(context).size.height / 864,
                  )),
                  visible: !visibleBuilding && !visibleSoftware && !calculation,
                ),
                Visibility(
                    child: Expanded(
                        child: Container(
                      child: buildingCalculator(),
                    )),
                    visible: visibleBuilding && !calculation),
                Visibility(
                    child: Expanded(
                        child: Container(
                      child: softwareCalculator(),
                    )),
                    visible: visibleSoftware && !calculation),
                Visibility(
                    child: CircularProgressIndicator(), visible: calculation),
                Visibility(
                    child: ClipRRect(
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
                                  fontSize: 20 *
                                      MediaQuery.of(context).size.width /
                                      1536),
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
                                  calculation = true;
                                  calculateEfficiency();
                                } else if (service == 'Refrigeració' &&
                                    climatic_zone != 'α1' &&
                                    climatic_zone != 'A1' &&
                                    climatic_zone != 'B1' &&
                                    climatic_zone != 'C1' &&
                                    climatic_zone != 'D1' &&
                                    climatic_zone != 'E1') {
                                  calculation = true;
                                  calculateEfficiency();
                                } else if (service == 'ACS') {
                                  calculation = true;
                                  calculateEfficiency();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                              'Falten valors per introduir',
                                              style: TextStyle(
                                                  fontSize: 14 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1536)),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                              child: Text('Continuar',
                                                  style: TextStyle(
                                                      fontSize: 14 *
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          1536)),
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
                                calculation = true;
                                calculateEfficiency();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text(
                                            'Falten valors per introduir',
                                            style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1536)),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: Text('Continuar',
                                                style: TextStyle(
                                                    fontSize: 14 *
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1536)),
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
                    visible: !calculation),
                SizedBox(
                  height: 10 * MediaQuery.of(context).size.height / 864,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
