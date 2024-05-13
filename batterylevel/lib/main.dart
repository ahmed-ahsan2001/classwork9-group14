import 'package:flutter/material.dart';
import 'package:battery/battery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery Percentage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BatteryPercentageScreen(),
    );
  }
}

class BatteryPercentageScreen extends StatefulWidget {
  @override
  _BatteryPercentageScreenState createState() => _BatteryPercentageScreenState();
}

class _BatteryPercentageScreenState extends State<BatteryPercentageScreen> {
  Battery _battery = Battery();
  int _batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      _getBatteryLevel();
    });
  }

  Future<void> _getBatteryLevel() async {
    int batteryLevel = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Percentage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Battery Level:',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              '$_batteryLevel%',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
