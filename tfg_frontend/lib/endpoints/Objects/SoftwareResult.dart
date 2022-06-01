class SoftwareResult {
  final String cpu;
  final String cpu_before;
  final String cpu_execution;
  final String gpu;
  final String gpu_before;
  final String gpu_execution;
  final String mem_size;
  final String mem_before;
  final String mem_execution;
  final String PUE;
  final String num_errors;
  final String num_days;
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
      {required this.cpu,
      required this.cpu_before,
      required this.cpu_execution,
      required this.gpu,
      required this.gpu_before,
      required this.gpu_execution,
      required this.mem_size,
      required this.mem_before,
      required this.mem_execution,
      required this.PUE,
      required this.num_errors,
      required this.num_days,
      required this.efficiency,
      required this.efficiency_class,
      required this.consumption,
      required this.consumption_class,
      required this.perdurability,
      required this.perdurability_class,
      required this.CPU_percentatge,
      required this.GPU_percentatge,
      required this.mem_percentatge});
}
