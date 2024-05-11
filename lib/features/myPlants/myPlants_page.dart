import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/plantDetail/detail_page.dart';

class MyPlantsScreen extends StatefulWidget {
  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  late List<Map<String, dynamic>> favoritedPlants;

  @override
  void initState() {
    super.initState();
    favoritedPlants = [
      {
        "category": "Outdoor",
        "name": "Apple",
        "image": "assets/userplant.png",
        "lastWatered": DateTime.now(),
        "wateringInterval": Duration(minutes: 1),
        "isOverdue": false,
      },
      {
        "category": "Indoor",
        "name": "Rose",
        "image": "assets/userplant.png",
        "lastWatered": DateTime.now(),
        "wateringInterval": Duration(hours: 2),
        "isOverdue": false,
      },
      {
        "category": "Indoor",
        "name": "Rose",
        "image": "assets/userplant.png",
        "lastWatered": DateTime.now(),
        "wateringInterval": Duration(hours: 2),
        "isOverdue": false,
      },
    ];

    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      _checkAndWaterPlants();
    });
  }

  void _checkAndWaterPlants() {
    DateTime currentTime = DateTime.now();
    setState(() {
      favoritedPlants.forEach((plant) {
        DateTime lastWatered = plant['lastWatered'];
        Duration wateringInterval = plant['wateringInterval'];
        DateTime nextWateringTime = lastWatered.add(wateringInterval);

        if (currentTime.isAfter(nextWateringTime)) {
          plant['lastWatered'] = DateTime.now();
          plant['isOverdue'] = false;
        } else {
          plant['isOverdue'] = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.width < 600 ? 56 : 65,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 30,
            width: 30,
            child: Icon(
              Icons.arrow_back_rounded,
              color: Constants.primaryColor,
              size: size.width < 600 ? 24 : 30,
            ),
          ),
        ),
        title: Text(
          'My Plants',
          style: TextStyle(
            color: Color(0xFF236419),
            fontSize: 22,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 2),
                blurRadius: 3,
              )
            ],
          ),
        ),
      ),
      body: favoritedPlants.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                    child: Image.asset('assets/favorited.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your Plants',
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: size.width < 600 ? 16 : 18,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * 1,
              child: ListView.builder(
                itemCount: favoritedPlants.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildPlantCard(index, size);
                },
              ),
            ),
    );
  }

  Widget _buildPlantCard(int index, Size size) {
    return GestureDetector(
      onTap: () {
      
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.11,
        margin: EdgeInsets.only(
            bottom: size.height * 0.01, top: size.height * 0.008),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    radius: size.height* 0.05,
                    backgroundImage: AssetImage(
                      favoritedPlants[index]["image"]!,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 17,
                  left: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                        favoritedPlants[index]["name"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 600 ? 20.0 : 18.0,
                          color: Constants.blackColor,
                        ),
                      ),
                       SizedBox(height: 2),
                      Text(
                        favoritedPlants[index]["category"]!,
                        style: TextStyle(
                          fontSize: size.width < 600 ? 18.0 : 20.0,
                          color: Constants.primaryColor,
                        ),
                      ),
                    
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: 13), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  favoritedPlants[index]['isOverdue']
                      ? Icon(Icons.warning, color: Colors.red.withOpacity(0.9), size: 30)
                      : Icon(Icons.check_circle, color: Colors.green, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
