// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/home/selectedImage.dart';
import 'package:plant_shield_app/models/feedback-model.dart';
import 'package:plant_shield_app/models/plant-detection.dart';
import 'package:plant_shield_app/models/user-plant-detail.dart';
import 'package:plant_shield_app/models/user-plants.dart';
import 'package:plant_shield_app/services/detection_service.dart';
import 'package:plant_shield_app/services/user-plant-service.dart';

class MyPlantsScreen extends StatefulWidget {
  final String username;
  final List<UserPlant> userplants;
  const MyPlantsScreen(
      {Key? key, required this.username, required this.userplants})
      : super(key: key);
  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  List<UserPlant> userPlants = [];
  String? username;
  final UserPlantService _userPlantService = UserPlantService();
  final DetectionService _detectionService = DetectionService();
  @override
  void initState() {
    super.initState();
    setState(() {
      username = widget.username;
      userPlants = widget.userplants;
    });
    _checkAndWaterPlants();
    // Timer.periodic(Duration(minutes: 1), (Timer timer) {
    //   _checkAndWaterPlants();
    // });
  }

  void _openUserPlantDetails(int index) async {
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);
      response = await _userPlantService.fetchSpecificUserPlant(
          username!, userPlants[index].userPlantId);

      if (response != null && response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(response.body)['User Plant'];
        UserPlantDetail userPlantDetail = UserPlantDetail.fromJson(data);
        PlantDetection plantDetection =
            PlantDetection.fromJsonForDeatilView(data);
        File imageFile = File('');
        FeedBackObject? isFeedBackRequired = await _detectionService
            .fetchUserPlants(userPlantDetail.userPlantId);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SelectedImageScreen(
                      username: username!,
                      detectedPlantDetails: plantDetection,
                      imageFile: imageFile,
                      fromMyPlants: true,
                      userPlantDetail: userPlantDetail,
                      isFeedBackRequired: isFeedBackRequired!,
                    )));
      } else {
        Navigator.of(context).pop();
        Map<String, dynamic> errorJson = jsonDecode(response!.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorJson['error']),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _checkAndWaterPlants() {
    DateTime currentTime = DateTime.now();
    for (var plant in userPlants) {
      DateTime lastWatered = plant.lastWatered;
      Duration wateringInterval =
          Duration(hours: int.parse(plant.wateringSchedule));
      DateTime nextWateringTime = lastWatered.add(wateringInterval);

      if (currentTime.isBefore(nextWateringTime)) {
        setState(() {
          plant.isOverDue = false;
        });
      }
    }
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
      body: userPlants.isEmpty
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
                    'Plaese add Plants from Home screen',
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
                itemCount: userPlants.length,
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
    Uint8List bytes =
        Uint8List.fromList(base64.decode(userPlants[index].userPlantImage));
    return GestureDetector(
      onTap: () {
        _openUserPlantDetails(index);
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
                    radius: size.height * 0.05,
                    backgroundImage: Image.memory(
                      bytes,
                      width: 500,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                ),
                Positioned(
                  bottom: 17,
                  left: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userPlants[index].plantName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 600 ? 20.0 : 18.0,
                          color: Constants.blackColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        userPlants[index].species,
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
              padding: EdgeInsets.only(right: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  userPlants[index].currentDisease == Constants.HEALTHY_PLANT
                      ? Icon(Icons.health_and_safety_sharp,
                          color: Colors.green, size: 30)
                      : Icon(Icons.healing,
                          color: Color.fromARGB(255, 236, 21, 21), size: 30),
                  SizedBox(height: 13.0),
                  userPlants[index].isOverDue
                      ? Icon(Icons.warning,
                          color: Colors.red.withOpacity(0.9), size: 30)
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
