import 'package:flutter/material.dart';

import 'package:FISHBOT/MQTTClientManager.dart';

import 'package:mqtt_client/mqtt_client.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your
        // application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class phpage extends StatefulWidget {
  phpage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _phpageState createState() => _phpageState();
}

class _phpageState extends State<phpage> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  MQTTClientManager mqttClientManager = MQTTClientManager("dd");

  final String ph_topic = "fishbot/temp";
  var temp = 0.0;

  @override
  void initState() {
    setupMqttClient();
    setupUpdatesListener();
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(ph_topic);
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final topic = c[0].topic;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (topic == "fishbot/temp") {
        temp = double.parse(pt);
      }
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
                series: <LineSeries<LiveData, int>>[
          LineSeries<LiveData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: chartData,
            color: const Color.fromRGBO(192, 108, 132, 1),
            xValueMapper: (LiveData sales, _) => sales.time,
            yValueMapper: (LiveData sales, _) => sales.speed,
          )
        ],
                primaryXAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(width: 0),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  title: AxisTitle(text: 'Time (minutes)'),
                ),
                primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Temp (celsius)')))));
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(1) + 3)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
