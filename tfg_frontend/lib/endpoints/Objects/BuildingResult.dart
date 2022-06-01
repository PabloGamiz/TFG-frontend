class BuildingResult {
  final String purpose;
  final String type;
  final String service;
  final String climatic_zone;
  final String zone;
  final String in_demand;
  final String in_consumption;
  final String in_emissions;
  final String demand;
  final String demand_class;
  final String consumption;
  final String consumption_class;
  final String emissions;
  final String emissions_class;

  const BuildingResult(
      {required this.purpose,
      required this.type,
      required this.service,
      required this.climatic_zone,
      required this.in_demand,
      required this.in_consumption,
      required this.in_emissions,
      required this.demand,
      required this.demand_class,
      required this.consumption,
      required this.consumption_class,
      required this.emissions,
      required this.emissions_class,
      required this.zone});
}
