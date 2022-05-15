class BuildingResult {
  final String demand;
  final String demand_class;
  final String consumption;
  final String consumption_class;
  final String emissions;
  final String emissions_class;

  const BuildingResult(
      {required this.demand,
      required this.demand_class,
      required this.consumption,
      required this.consumption_class,
      required this.emissions,
      required this.emissions_class});
}
