import 'package:fkera_app/pages.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: kBlueColor),
              child: Text(
                'sensors',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Temp',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnotherPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'PH',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnotherPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Turbidity',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnotherPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('Welcome'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
              child: Stack(
                children: [
                  // first one for temp
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
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
                  ),
                  // positioned for image
                  Positioned(
                    right: 0,
                    bottom: 50,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      height: 100,
                      width: 150,
                      child: Image.asset(
                        'images/temp.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // positioned for text
                  Positioned(
                    top: 30,
                    left: 0,
                    child: SizedBox(
                        height: 130,
                        child: SizedBox(
                          height: 130,
                          child: Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: Text(
                                  'Temperature',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
              child: Stack(
                children: [
                  // 2nd for ph
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
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
                        )),
                  ),
                  // positined for image
                  Positioned(
                    right: 0,
                    bottom: 50,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      height: 100,
                      width: 150,
                      child: Image.asset('images/phh.png'),
                    ),
                  ),
                  // positioned for text
                  Positioned(
                    top: 30,
                    left: 0,
                    child: SizedBox(
                      height: 130,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Text(
                              'PH',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
              child: Stack(
                children: [
                  //3rd for turb
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
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
                        )),
                  ),
                  // positioned for image
                  Positioned(
                    right: 0,
                    bottom: 50,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      height: 100,
                      width: 150,
                      child: Image.asset('images/trub.png'),
                    ),
                  ),
                  // positioned for text
                  Positioned(
                    top: 30,
                    left: 0,
                    child: SizedBox(
                      height: 130,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            child: Text(
                              'Turbidity',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
