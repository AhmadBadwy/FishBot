import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_container.dart';

class FishScreen extends StatefulWidget {
  const FishScreen({super.key});

  @override
  State<FishScreen> createState() => _FishScreenState();
}

class _FishScreenState extends State<FishScreen> {
  bool? feedToggle;
  bool? valvetogle;
  // ignore: non_constant_identifier_names
  bool? Airventtogle;

  @override
  void initState() {
    feedToggle = false;
    valvetogle = false;
    Airventtogle = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        CustomContainer(
          child: ListTile(
            leading: const Text(
              'Feed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  feedToggle = !feedToggle!;
                });
              },
              icon: Icon(feedToggle == false
                  ? FontAwesomeIcons.toggleOff
                  : FontAwesomeIcons.toggleOn),
              color: feedToggle == true ? Colors.lightGreen : Colors.grey,
              iconSize: 30,
            ),
          ),
        ),
        // this for timer
        const SizedBox(height: 12.0),
        const CustomContainer(
          child: ListTile(
            leading: Text(
              'Timer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: Text('00:15'),
          ),
        ),

        //this for valve
        const SizedBox(height: 100.0),
        CustomContainer(
          child: ListTile(
            leading: const Text(
              'Valve',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  valvetogle = !valvetogle!;
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
    );
  }
}
