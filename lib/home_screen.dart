import 'package:fkera_app/fish_screen.dart';
import 'package:fkera_app/pages.dart';
import 'package:fkera_app/settings.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 1;
  PageController initialPageController = PageController();
  final _pageOptions = [
    const FishScreen(),
    const HomePage(),
    const Settings(),
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
    super.initState();
    initialPageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: const Text('Welcome'),
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
        currentIndex: currentPageIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.fish), label: 'Fish'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnotherPage(),
                      ),
                    );
                  },
                  child: Container(
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
                ),
                // positioned for image
                Positioned(
                  right: 0,
                  bottom: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnotherPage(),
                      ),
                    );
                  },
                  child: Container(
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
                ),
                // positined for image
                Positioned(
                  right: 0,
                  bottom: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Text(
                            'PH',
                            style: TextStyle(fontSize: 25, color: Colors.black),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnotherPage(),
                      ),
                    );
                  },
                  child: Container(
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
                ),
                // positioned for image
                Positioned(
                  right: 0,
                  bottom: 50,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Text(
                            'Turbidity',
                            style: TextStyle(fontSize: 25, color: Colors.black),
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
    );
  }
}
