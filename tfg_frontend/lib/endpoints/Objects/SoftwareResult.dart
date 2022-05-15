class SoftwareResult {
  final String efficiency;
  final String efficiency_class;
  final String consumption;
  final String consumption_class;
  final String perdurability;
  final String perdurability_class;
  final double CPU_percentatge;
  final double GPU_percentatge;
  final double mem_percentatge;

  const SoftwareResult(
      {required this.efficiency,
      required this.efficiency_class,
      required this.consumption,
      required this.consumption_class,
      required this.perdurability,
      required this.perdurability_class,
      required this.CPU_percentatge,
      required this.GPU_percentatge,
      required this.mem_percentatge});
}
