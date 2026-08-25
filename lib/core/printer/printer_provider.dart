import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

import 'printer_service.dart';

final printerServiceProvider = Provider<PrinterService>((ref) {
  return PrinterService.instance;
});

final printerDevicesProvider =
    StreamProvider<List<Printer>>((ref) {
  final printerService =
      ref.watch(printerServiceProvider);

  return printerService.printersStream;
});