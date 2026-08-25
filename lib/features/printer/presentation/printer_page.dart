import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';

import '../../../../core/printer/printer_provider.dart';

class PrinterPage extends ConsumerStatefulWidget {
  const PrinterPage({super.key});

  @override
  ConsumerState<PrinterPage> createState() =>
      _PrinterPageState();
}

class _PrinterPageState
    extends ConsumerState<PrinterPage> {
  bool _isScanning = false;
  Printer? _connectedPrinter;

  @override
  void dispose() {
    ref
        .read(printerServiceProvider)
        .stopScan();

    super.dispose();
  }

  Future<void> _scanPrinters() async {
    setState(() {
      _isScanning = true;
    });

    try {
      await ref
          .read(printerServiceProvider)
          .startScan();
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Failed to scan printers: $e',
      );
    }
  }

  Future<void> _stopScan() async {
    await ref
        .read(printerServiceProvider)
        .stopScan();

    if (!mounted) return;

    setState(() {
      _isScanning = false;
    });
  }

  Future<void> _connectPrinter(
  Printer printer,
) async {
  try {
    _showMessage(
      'Connecting to ${printer.name ?? 'printer'}...',
    );

    await ref
        .read(printerServiceProvider)
        .connect(printer);

    if (!mounted) return;

    setState(() {
      _connectedPrinter = printer;
    });

    _showMessage(
      'Printer connected successfully',
    );
  } catch (e) {
    if (!mounted) return;

    _showMessage(
      'Connection failed: $e',
    );
  }
}

  Future<void> _disconnectPrinter() async {
    final printer = _connectedPrinter;

    if (printer == null) return;

    try {
      await ref
          .read(printerServiceProvider)
          .disconnect(printer);

      if (!mounted) return;

      setState(() {
        _connectedPrinter = null;
      });

      _showMessage(
        'Printer disconnected',
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        'Failed to disconnect printer: $e',
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final printersAsync =
        ref.watch(printerDevicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thermal Printer'),
      ),
      body: Column(
        children: [
          _buildScanButton(),

          const Divider(height: 1),

          Expanded(
            child: printersAsync.when(
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (error, stackTrace) {
                return _buildErrorState(
                  error.toString(),
                );
              },
              data: (printers) {
                return _buildPrinterList(
                  printers,
                );
              },
            ),
          ),

          if (_connectedPrinter != null)
            _buildConnectedPrinter(),
        ],
      ),
    );
  }

  Widget _buildScanButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed:
              _isScanning ? _stopScan : _scanPrinters,
          icon: Icon(
            _isScanning
                ? Icons.stop
                : Icons.bluetooth_searching,
          ),
          label: Text(
            _isScanning
                ? 'Stop Scan'
                : 'Scan Printers',
          ),
        ),
      ),
    );
  }

  Widget _buildPrinterList(
    List<Printer> printers,
  ) {
    if (printers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.print_disabled,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              'No printers found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Turn on your thermal printer\n'
              'and tap Scan Printers.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: printers.length,
      separatorBuilder: (_, __) =>
          const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final printer = printers[index];

        return _PrinterCard(
          printer: printer,
          isConnected:
              _connectedPrinter == printer,
          onConnect: () {
            _connectPrinter(printer);
          },
          onDisconnect: _disconnectPrinter,
        );
      },
    );
  }

  Widget _buildConnectedPrinter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        top: false,
        child: OutlinedButton.icon(
          onPressed: _disconnectPrinter,
          icon: const Icon(Icons.bluetooth_disabled),
          label: const Text('Disconnect Printer'),
        ),
      ),
    );
  }

  Widget _buildErrorState(
    String error,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          error,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _PrinterCard extends StatelessWidget {
  const _PrinterCard({
    required this.printer,
    required this.isConnected,
    required this.onConnect,
    required this.onDisconnect,
  });

  final Printer printer;
  final bool isConnected;
  final VoidCallback onConnect;
  final VoidCallback onDisconnect;

  @override
  Widget build(BuildContext context) {
    final printerName =
        printer.name?.trim().isNotEmpty == true
            ? printer.name!
            : 'Unknown Printer';

    final address =
        printer.address?.trim().isNotEmpty == true
            ? printer.address!
            : 'Bluetooth printer';

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const CircleAvatar(
          child: Icon(Icons.print),
        ),
        title: Text(
          printerName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(address),
        trailing: isConnected
            ? const Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : ElevatedButton(
                onPressed: onConnect,
                child: const Text('Connect'),
              ),
      ),
    );
  }
}