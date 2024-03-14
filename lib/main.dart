import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          BluetoothScreen(), // Gebruik BluetoothScreen hier als het startscherm van de app
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus();
  List<ScanResult> devicesList = [];
  bool isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
  }

  Future<void> _checkBluetoothStatus() async {
    bool bluetoothOn = await FlutterBluePlus.isOn;
    setState(() {
      isBluetoothOn = bluetoothOn;
    });
  }

  Future<void> _toggleBluetooth() async {
    if (isBluetoothOn) {
      await FlutterBluePlus.turnOff();
    } else {
      await FlutterBluePlus.turnOn();
    }
    await _checkBluetoothStatus(); // Opnieuw controleren van de Bluetooth-status na in-/uitschakelen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _toggleBluetooth,
            child: Text(
                isBluetoothOn ? 'Turn Bluetooth Off' : 'Turn Bluetooth On'),
          ),
          SizedBox(height: 20),
          Text('Bluetooth is ${isBluetoothOn ? 'on' : 'off'}'),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devicesList[index].device.name),
                  subtitle: Text(devicesList[index].device.id.toString()),
                  onTap: () {
                    // Implementeer hier de logica om verbinding te maken met het geselecteerde apparaat
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
