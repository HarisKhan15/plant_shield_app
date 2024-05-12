// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/models/create-user-plant.dart';
import 'package:plant_shield_app/models/plant-detection.dart';
import 'package:plant_shield_app/models/user-plant-detail.dart';
import 'package:plant_shield_app/services/user-plant-service.dart';
import 'package:tuple/tuple.dart';
import 'package:plant_shield_app/features/Components/constants.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SelectedImageScreen extends StatefulWidget {
  final PlantDetection detectedPlantDetails;
  final String username;
  final File imageFile;
  final bool fromMyPlants;
  final UserPlantDetail userPlantDetail;
  const SelectedImageScreen(
      {Key? key,
      required this.username,
      required this.detectedPlantDetails,
      required this.imageFile,
      required this.fromMyPlants,
      required this.userPlantDetail})
      : super(key: key);

  @override
  _SelectedImageScreenState createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  bool isButtonClicked = false;
  String? selectedButton;
  PlantDetection? plantDetection;
  String? username;
  File? imageFile;
  bool? fromMyPlants;
  UserPlantDetail? userPlantDetail;
  UserPlantService _userPlantService = UserPlantService();

  @override
  void initState() {
    super.initState();
    selectedButton = 'Details';
    setState(() {
      plantDetection = widget.detectedPlantDetails;
      username = widget.username;
      imageFile = widget.imageFile;
      fromMyPlants = widget.fromMyPlants;
      userPlantDetail = widget.userPlantDetail;
    });
  }

  CreateUserPlant _constructUserPlantObject() {
    return CreateUserPlant(
        username: username!,
        plantId: plantDetection!.plantId,
        currentDisease: plantDetection!.diseaseName);
  }

  void addIntoUserPlant() async {
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);
      CreateUserPlant userPlant = _constructUserPlantObject();

      response = await _userPlantService.addDetectedPlantIntoUserPlant(
          imageFile!, userPlant);

      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Plant added successfully into my plants.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error. Please try again.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      Navigator.of(context).pop();
    }
  }

  Widget _waterUpdate(
      BuildContext context, String messageForWatering, DateTime lastWatered) {
    bool _buttonClicked = false;
    int selectedIndex = 0;

    if (fromMyPlants!) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last water',
                    style: TextStyle(
                      fontFamily: 'Mulish-VariableFont_wght',
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(lastWatered),
                    style: TextStyle(
                      fontFamily: 'Lato-Bold',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Constants.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Next Watering',
                    style: TextStyle(
                      fontFamily: 'Mulish-VariableFont_wght',
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    messageForWatering,
                    style: TextStyle(
                      fontFamily: 'Lato-Bold',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Constants.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Plant care tip",
                style: TextStyle(
                  fontFamily: 'Lato-Bold',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Constants.primaryColor.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Did your plant receive its recent watering?",
                style: TextStyle(
                  fontFamily: 'Lato-Bold',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Constants.primaryColor.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _buttonClicked
                        ? null
                        : () {
                            setState(() {
                              _buttonClicked = true;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Constants.primaryColor.withOpacity(0.7),
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: _buttonClicked
                                ? Colors.grey
                                : Constants.primaryColor),
                      ),
                    ),
                    child: Text(
                      'Watering Done',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget waterUpdate = SizedBox.shrink();
    if (selectedButton == 'Water update') {
      String messageForWatering = "";
      DateTime currentTime = DateTime.now();
      DateTime nextWateringTime = userPlantDetail!.lastWatered!
          .add(Duration(hours: int.parse(plantDetection!.wateringSchedule)));

      if (currentTime.isBefore(nextWateringTime)) {
        Duration timeLeft = nextWateringTime.difference(currentTime);
        int hoursLeft = timeLeft.inHours;
        messageForWatering = "${hoursLeft} hours left";
      } else {
        messageForWatering = "Time for watering!";
      }
      waterUpdate = _waterUpdate(
          context, messageForWatering, userPlantDetail!.lastWatered!);
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    width: size.width,
                    child: ClipPath(
                      clipper: CurvedClipper(),
                      child: Container(
                        color: Constants.primaryColor,
                        height: size.height * 0.34,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            !(fromMyPlants!)
                                ? Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.memory(
                                    Uint8List.fromList(base64.decode(
                                        userPlantDetail!.userPlantImage)),
                                    fit: BoxFit.cover,
                                  ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: size.width < 600 ? 24 : 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 11.0, right: 10, bottom: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 7),
                              Text(
                                plantDetection!.plantName,
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(1, 2),
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 9),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  plantDetection!.species,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Mulish-VariableFont_wght',
                                    fontWeight: FontWeight.w900,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.1,
                            bottom: 10,
                          ),
                          child: ElevatedButton(
                            onPressed: isButtonClicked
                                ? null
                                : () {
                                    setState(() {
                                      isButtonClicked = true;
                                      addIntoUserPlant();
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Colors.white,
                              onPrimary: Colors.green,
                              padding: EdgeInsets.all(8),
                              elevation: 7,
                              shadowColor: Colors.grey,
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/plant.png',
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 39,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildButtonWithSpacingBefore(
                          text: 'Water update',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Water update';
                            });
                          },
                          isVisible: fromMyPlants!,
                        ),
                        _buildButtonWithSpacingBefore(
                          text: 'Details',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Details';
                            });
                          },
                        ),
                        _buildButtonWithSpacingBefore(
                          text: 'Health',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Health';
                            });
                          },
                        ),
                        _buildButtonWithSpacingBefore(
                          text: 'Care',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Care Instructions';
                            });
                          },
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildExpandableSection(
                          iconAssetPath: 'assets/edit-info.png',
                          imageSize: 35,
                          header: 'Description',
                          simpleContent: [
                            plantDetection!.description,
                          ],
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/lab.png',
                          imageSize: 40,
                          header: 'Species',
                          simpleContent: [
                            plantDetection!.speciesDetail,
                          ],
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/life.png',
                          imageSize: 40,
                          header: 'Max Life',
                          simpleContent: [plantDetection!.maxLife],
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/virus.png',
                          imageSize: 40,
                          header: 'Diseases',
                          tupleContent: [
                            Tuple2('Disease Name', plantDetection!.diseaseName),
                          ],
                          simpleContent: [plantDetection!.diseaseDescription],
                          expanded: selectedButton == 'Health',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/preven.png',
                          imageSize: 40,
                          header: 'Prevention',
                          simpleContent: [
                            plantDetection!.diseasePossibleSteps,
                          ],
                          expanded: selectedButton == 'Health',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/water.png',
                          imageSize: 40,
                          header: 'Watering Schedule',
                          tupleContent: [
                            Tuple2('Frequency',
                                '${plantDetection!.wateringSchedule} hours'),
                          ],
                          simpleContent: [
                            plantDetection!.wateringScheduleDetail
                          ],
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/sun.png',
                          imageSize: 40,
                          header: 'Sunlight Requirement',
                          tupleContent: [
                            Tuple2('Direct Sunlight',
                                plantDetection!.sunlightRequirements),
                          ],
                          simpleContent: [
                            plantDetection!.sunlightRequirementsDetail
                          ],
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/temp.png',
                          imageSize: 40,
                          header: 'Temperature',
                          tupleContent: [
                            Tuple2('Optimal',
                                plantDetection!.temperatureRequirements),
                          ],
                          simpleContent: [
                            plantDetection!.temperatureRequirementsDetail
                          ],
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/humidity.png',
                          imageSize: 40,
                          header: 'Humidity',
                          tupleContent: [
                            Tuple2('Preferred Level', plantDetection!.humidity),
                          ],
                          simpleContent: [plantDetection!.humidityDetail],
                          expanded: selectedButton == 'Care Instructions',
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: waterUpdate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String iconAssetPath,
    required double imageSize,
    required String header,
    List<Tuple2<String, String>>? tupleContent,
    List<String>? simpleContent,
    required bool expanded,
  }) {
    if (!expanded) {
      return SizedBox.shrink();
    }

    List<Widget> contentWidgets = [];
    if (tupleContent != null) {
      contentWidgets.addAll(_buildTupleContent(tupleContent));
    }
    if (simpleContent != null) {
      contentWidgets.addAll(_buildSimpleContent(simpleContent));
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        title: Text(
          header,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 0.5),
                blurRadius: 2,
              )
            ],
          ),
        ),
        leading: SizedBox(
          width: imageSize,
          height: imageSize,
          child: Image(
            image: AssetImage(iconAssetPath),
            fit: BoxFit.contain,
          ),
        ),
        iconColor: Constants.primaryColor,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 8.0,
              runSpacing: 8.0,
              children: contentWidgets,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildTupleContent(List<Tuple2<String, String>> tupleContent) {
    return tupleContent.map((tuple) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.only(top: 14, left: 10, right: 10, bottom: 4),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                tuple.item1,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Mulish-VariableFont_wght',
                  fontWeight: FontWeight.w900,
                  height: 1.4,
                  fontSize: 16.5,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  tuple.item2,
                  style: TextStyle(
                    fontFamily: 'Lato-Bold',
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                    fontSize: 16,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildSimpleContent(List<String>? simpleContent) {
    if (simpleContent == null) return [];
    return simpleContent.map((content) {
      return Text(
        content,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Mulish-VariableFont_wght',
          fontWeight: FontWeight.w600,
          height: 1.4,
          fontSize: 15,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  Widget _buildHorizontalButton({
    required String text,
    required VoidCallback onPressed,
    bool isVisible = true,
  }) {
    if (!isVisible) {
      return SizedBox.shrink();
    }

    return SizedBox(
      width: 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonWithSpacingBefore({
    required String text,
    required VoidCallback onPressed,
    bool isVisible = true,
  }) {
    return Row(
      children: [
        SizedBox(width: 10),
        _buildHorizontalButton(
          text: text,
          onPressed: onPressed,
          isVisible: isVisible,
        ),
      ],
    );
  }
}
