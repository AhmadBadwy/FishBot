import 'package:FISHBOT/Data/ph_data.dart';
import 'package:FISHBOT/Data/temp_data.dart';
import 'package:FISHBOT/Data/turb_data.dart';
import 'package:FISHBOT/Data/waterlevel_data.dart';
import 'package:flutter/material.dart';

import 'package:FISHBOT/constant.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgray,
      appBar: AppBar(
          title: Text(
            "History Data",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          shadowColor: kgray,
          backgroundColor: kgray),
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
                    builder: (context) => tempdata(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.height,
                  height: 70,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text temp
                      SizedBox(
                        height: 50,
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding, vertical: 15),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Temprature",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black),
                                    ),
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
                    builder: (context) => const phdata(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // positioned for text ph
                      const SizedBox(
                          height: 50,
                          child: SizedBox(
                            height: 50,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        "PH",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.black),
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
                    builder: (context) => const turbdata(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
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
                                      horizontal: kDefaultPadding,
                                      vertical: 15),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Turbidity",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.black),
                                      ),
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
                    builder: (context) => const waterleveldata(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 15,
                          color: kTextColor),
                    ],
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
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
                                      horizontal: kDefaultPadding,
                                      vertical: 15),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Water level",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.black),
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
