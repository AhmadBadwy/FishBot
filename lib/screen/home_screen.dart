// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';
import 'dart:math';
import 'dart:io';
import 'package:FISHBOT/MQTTClientManager.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:FISHBOT/screen/fish_screen.dart';
import 'package:FISHBOT/src/ph_page.dart';
import 'package:FISHBOT/src/temp_page.dart';
import 'package:FISHBOT/screen/saved.dart';
import 'package:FISHBOT/src/turb_page.dart';
import 'package:FISHBOT/src/waterlevel_page.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 1;
  String Title_name = "fishbot";
  PageController initialPageController = PageController();
  final _pageOptions = [
    const FishScreen(),
    const HomePage(),
    const Saved(),
  ];
  onTapped(int selectedIndex) {
    setState(() {
      currentPageIndex = selectedIndex;
    });
    initialPageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    // setupMqttClient();
    // setupUpdatesListener();
    super.initState();
    initialPageController = PageController(initialPage: 1);
  }

  // Fishscreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kblack,
      body: PageView(
        controller: initialPageController,
        children: _pageOptions,
        onPageChanged: (page) {
          setState(() {
            currentPageIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          onTapped(index);
        },
        backgroundColor: kgray,
        selectedItemColor: Colors.white,
        unselectedItemColor: klightgray,
        currentIndex: currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list), label: 'Fish'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_sharp,
              ),
              label: 'saved'),
        ],
      ),
    );
  }

  Future printIps() async {
    for (var interface in await NetworkInterface.list()) {
      print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        print(
            '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }
  }

  @override
  void dispose() {
    // mqttClientManager.disconnect();
    super.dispose();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MQTTClientManager mqttClientManager = MQTTClientManager("rec");
  final String temp_topic = "fishbot/temp";
  final String pH_topic = "fishbot/pH";
  final String turbidity_topic = "fishbot/turbidity";
  final String water_level_low_topic = "fishbot/water_level_low";
  final String water_level_high_topic = "fishbot/water_level_high";

  double temp = 0;
  double pH = 0;
  double turbidity = 0;
  bool water_level_high = false;
  bool water_level_low = false;
  String Water_level = "";

  @override
  void initState() {
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
  }

  Future<void> setupMqttClient() async {
    try {
      await mqttClientManager.connect();
      mqttClientManager.subscribe(temp_topic);
      mqttClientManager.subscribe(pH_topic);
      mqttClientManager.subscribe(turbidity_topic);
      mqttClientManager.subscribe(water_level_low_topic);
      mqttClientManager.subscribe(water_level_high_topic);
    } catch (e) {
      print("no connection");
    }
  }

  void setupUpdatesListener() {
    mqttClientManager
        .getMessagesStream()!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      print("hello");
      final recMess = c![0].payload as MqttPublishMessage;
      final topic = c[0].topic;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (topic == "fishbot/temp") {
        setState(() {
          temp = double.parse(pt);
        });
      }
      if (topic == "fishbot/pH") {
        setState(() {
          pH = double.parse(pt);
        });
      }
      if (topic == "fishbot/turbidity") {
        setState(() {
          turbidity = double.parse(pt);
          // if (turbidity < 0) {
          //   turbidity = 0.0;
          // } else {
          //   turbidity = turbidity;
          // }
        });
      }
      if (topic == water_level_low_topic) {
        setState(() {
          if (pt == " False") {
            water_level_low = false;
          } else if (pt == " True") {
            water_level_low = true;
          }
        });
      }
      if (topic == water_level_high_topic) {
        setState(() {
          if (pt == " False") {
            water_level_high = false;
          } else if (pt == " True") {
            water_level_high = true;
          }
        });
      }
      if ((water_level_low && !water_level_high)) {
        setState(() {
          Water_level = "";
        });
      } else if (!(water_level_low && water_level_high)) {
        setState(() {
          Water_level = "LOW";
        });
      } else if (water_level_low && water_level_high) {
        setState(() {
          Water_level = "HIGH";
        });
      }
      print("${water_level_low}, ${water_level_high}, ${Water_level}");
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgray,
      appBar: AppBar(
        title: Text(
          "HOME",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kgray,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Temppage(title: 'Flutter Demo'),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: klightgray2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text temp
                      SizedBox(
                        height: 50,
                        child: SizedBox(
                          height: 40,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Temprature",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "${temp} °C",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    if (temp > 30)
                                      Text(
                                        "High ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 147, 10, 0)),
                                      ),
                                    if (temp < 20)
                                      Text("low",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: const Color.fromARGB(
                                                  255, 183, 13, 1))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // positioned for image
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding,
                        ),
                        height: 100,
                        width: 120,
                        child: Image.asset(
                          'images/temp.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => phpage(title: 'f'),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 20,
                          color: kTextColor),
                    ],
                    color: klightgray2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text ph
                      SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "PH",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${pH}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      if (pH > 9)
                                        Text("High",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 183, 13, 1))),
                                      if (pH < 6)
                                        Text("low",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 183, 13, 1)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // positioned for image
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        height: 100,
                        width: 120,
                        child: Image.asset(
                          'images/ph.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Turbpage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: klightgray2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text turbidity
                      SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Turbidity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${turbidity}",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      if (turbidity > 70)
                                        Text("High",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: const Color.fromARGB(
                                                    255, 183, 13, 1))),
                                      // if (turbidity < )
                                      //   Text("low",
                                      //       style: TextStyle(
                                      //           fontSize: 12,
                                      //           color: const Color.fromARGB(
                                      //               255, 183, 13, 1)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // positioned for image turb
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        height: 100,
                        width: 120,
                        child: Image.asset(
                          'images/turb.png',
                          //fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Waterlevelpage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: klightgray2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text
                      SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Water level",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        '${Water_level}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: const Color.fromARGB(
                                                255, 155, 12, 1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      // positioned for image
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        height: 100,
                        width: 120,
                        child: Image.asset(
                          'images/liqued-level.png',
                          //fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            )
          ],
        ),
      ),
    );
  }
}
