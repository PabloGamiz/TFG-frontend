class BuildingResult {
  final String purpose;
  final String type;
  final String service;
  final String climatic_zone;
  final String zone;
  final String in_demand;
  final String in_consumption;
  final String in_emissions;
  final String demandC1;
  final String demandC2;
  final String demand_class;
  final String consumptionC1;
  final String consumptionC2;
  final String consumption_class;
  final String emissionsC1;
  final String emissionsC2;
  final String emissions_class;

  const BuildingResult(
      {required this.purpose,
      required this.type,
      required this.service,
      required this.climatic_zone,
      required this.in_demand,
      required this.in_consumption,
      required this.in_emissions,
      required this.demandC1,
      required this.demandC2,
      required this.demand_class,
      required this.consumptionC1,
      required this.consumptionC2,
      required this.consumption_class,
      required this.emissionsC1,
      required this.emissionsC2,
      required this.emissions_class,
      required this.zone});
}
