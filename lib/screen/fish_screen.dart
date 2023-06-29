import 'package:FISHBOT/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../custom_container.dart';
import 'package:FISHBOT/MQTTClientManager.dart';
//import 'dart:async';

class FishScreen extends StatefulWidget {
  const FishScreen({super.key});

  @override
  State<FishScreen> createState() => _FishScreenState();
}

class _FishScreenState extends State<FishScreen> {
  MQTTClientManager mqttClientManager = MQTTClientManager("sender");
  // ignore: non_constant_identifier_names
  final motor_topic = "fishbot/feeder";

  bool feedToggle = false;
  bool valvetogle = false;
  // ignore: non_constant_identifier_names
  bool? Airventtogle;
  //bool isStopped = true;
  //global

  //sec30Timer() {
  //Timer.periodic(Duration(seconds: 30), (timer) {
  //if (isStopped) {
  //timer.cancel();
  //}
  //print("done");
  //});
  //}

  @override
  void initState() {
    setupMqttClient();
    //setupUpdatesListener();
    feedToggle = false;
    valvetogle = false;
    Airventtogle = false;
    super.initState();
  }

  // void setupUpdatesListener() {
  //   mqttClientManager
  //       .getMessagesStream()!
  //       .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     final recMess = c![0].payload as MqttPublishMessage;
  //     final topic = c[0].topic;
  //     final pt =
  //         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //     if (topic == motor_topic) {
  //       setState(() {
  //         temp = int.parse(pt);
  //       });
  //     }
  //     print("${water_level_low}, ${water_level_high}, ${Water_level}");
  //     print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
  //   });
  // }

  Future<void> setupMqttClient() async {
    try {
      await mqttClientManager.connect();
    } catch (e) {
      print("no connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgray,
      appBar: AppBar(
        backgroundColor: kgray,
        elevation: 0.5,
        title: const Text(
          'LIST',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      // feeder ON,OFF
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            CustomContainer(
              child: ListTile(
                leading: const Text(
                  'Feeder',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(
                      () {
                        feedToggle = !feedToggle;
                        if (feedToggle) {
                          mqttClientManager.publishMessage(motor_topic, "on");
                        } else {
                          mqttClientManager.publishMessage(motor_topic, "off");
                        }
                      },
                    );
                    // setState(() {
                    // if (isStopped) {}
                    //});
                  },
                  icon: Icon(feedToggle == false
                      ? FontAwesomeIcons.toggleOff
                      : FontAwesomeIcons.toggleOn),
                  color: feedToggle == true ? Colors.lightGreen : Colors.grey,
                  iconSize: 40,
                ),
              ),
            ),
            // this for timer
            const SizedBox(height: 12.0),
            const CustomContainer(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListTile(
                  leading: Text(
                    'Timer',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text('00:15'),
                ),
              ),
            ),

            //this for valve
            const SizedBox(height: 100.0),

            CustomContainer(
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 0),
                child: ListTile(
                  leading: const Text(
                    'Valve',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        valvetogle = !valvetogle;
                      });
                    },
                    icon: Icon(valvetogle == false
                        ? FontAwesomeIcons.toggleOff
                        : FontAwesomeIcons.toggleOn),
                    color: valvetogle == true ? Colors.lightGreen : Colors.grey,
                    iconSize: 30,
                  ),
                ),
              ),
            ),
            //this for air vent
            const SizedBox(height: 12.0),
            CustomContainer(
              child: ListTile(
                leading: const Text(
                  'Air vent',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      Airventtogle = !Airventtogle!;
                    });
                  },
                  icon: Icon(Airventtogle == false
                      ? FontAwesomeIcons.toggleOff
                      : FontAwesomeIcons.toggleOn),
                  color: Airventtogle == true ? Colors.lightGreen : Colors.grey,
                  iconSize: 30,
                ),
              ),
            ),
            // this for camera
            const SizedBox(height: 12.0),
            CustomContainer(
              child: ListTile(
                leading: const Text(
                  "Camera",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.camera,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
