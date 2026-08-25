import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

class PrinterService {
  PrinterService._();

  static final PrinterService instance = PrinterService._();

  final FlutterThermalPrinter _printer =
      FlutterThermalPrinter.instance;

  // Stream of discovered printers.
  Stream<List<Printer>> get printersStream =>
      _printer.devicesStream;

  // Start scanning for Bluetooth/BLE printers.
  Future<void> startScan() async {
    await _printer.getPrinters(
      refreshDuration: const Duration(seconds: 3),
      connectionTypes: [
        ConnectionType.BLE,
      ],
    );
  }

  // Stop scanning.
  Future<void> stopScan() async {
    await _printer.stopScan();
  }

  // Connect to a printer.
  Future<void> connect(Printer printer) async {
    await _printer.connect(
      printer,
      connectionStabilizationDelay:
          const Duration(seconds: 3),
    );
  }

  // Disconnect from a printer.
  Future<void> disconnect(Printer printer) async {
    await _printer.disconnect(printer);
  }

  // Print raw ESC/POS bytes.
  Future<void> printData(
    Printer printer,
    List<int> bytes,
  ) async {
    await _printer.printData(
      printer,
      bytes,
      longData: true,
    );
  }
}