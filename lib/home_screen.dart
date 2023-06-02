import 'dart:ffi';
import 'dart:math';
import 'dart:io';

import 'package:FISHBOT/MQTTClientManager.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'package:FISHBOT/fish_screen.dart';
import 'package:FISHBOT/ph_page.dart';
import 'package:FISHBOT/settings.dart';
import 'package:FISHBOT/temp_page.dart';
import 'package:FISHBOT/saved.dart';
import 'package:FISHBOT/turb_page.dart';
import 'package:FISHBOT/waterlevel_page.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MQTTClientManager mqttClientManager = MQTTClientManager();
  final String temp_topic = "fishbot/temp";
  final String pH_topic = "fishbot/pH";
  final String turbidity_topic = "fishbot/turbidity";
  final String water_level_topic = "fishbot/water_level";

  var temp = 0.0;
  var pH = 0.0;
  var turbidity = 0.0;
  var water_level = 0.0;

  int currentPageIndex = 1;
  PageController initialPageController = PageController();
  final _pageOptions = [
    const FishScreen(),
    const HomePage(),
    const Saved(),
    const settings(),
  ];
  onTapped(int selectedIndex) {
    setState(() {
      currentPageIndex = selectedIndex;
    });
    initialPageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }

  @override
  void initState() {
    setupMqttClient();
    setupUpdatesListener();
    super.initState();
    initialPageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.5,
        title: const Text(
          'FISHBOT',
          style: TextStyle(
              color: kDefaultIconDarkColor, fontWeight: FontWeight.w300),
        ),
      ),
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
        backgroundColor: kPrimaryColor,
        selectedItemColor: kBackgroundColor,
        unselectedItemColor: kTextLightColor,
        currentIndex: currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.list), label: 'Fish'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'saved'),
        ],
      ),
    );
  }

  Future<void> setupMqttClient() async {
    await mqttClientManager.connect();
    mqttClientManager.subscribe(temp_topic);
    mqttClientManager.subscribe(pH_topic);
    mqttClientManager.subscribe(turbidity_topic);
    mqttClientManager.subscribe(water_level_topic);
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
      if (topic == "fishbot/pH") {
        pH = double.parse(pt);
      }
      if (topic == "fishbot/turbidity") {
        turbidity = double.parse(pt);
      }
      if (topic == "fishbot/water_level") {
        water_level = double.parse(pt);
      }
      print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
    });
  }

  @override
  void dispose() {
    mqttClientManager.disconnect();
    super.dispose();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
                  height: 170,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text
                      const SizedBox(
                        height: 50,
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: Text(
                                  'Temperature',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.black),
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
                        width: 150,
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
                    builder: (context) => const Phpage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text
                      const SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Text(
                                    'PH',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black),
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
                        width: 150,
                        child: Image.asset(
                          'images/phh.png',
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
                  height: 170,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text
                      const SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Text(
                                    'Turbidity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black),
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
                        width: 150,
                        child: Image.asset(
                          'images/turb.png',
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
                    builder: (context) => const Waterlevelpage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text
                      const SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Text(
                                    'Water level',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
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
                        width: 150,
                        child: Image.asset(
                          'images/liqued-level.png',
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
            )
          ],
        ),
      ),
    );
  }
}
