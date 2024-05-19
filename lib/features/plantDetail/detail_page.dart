// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //Toggle Favorite button
  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  //Toggle add remove from cart
  bool toggleIsSelected(bool isSelected) {
    return !isSelected;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 3,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 25,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('favorite');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryColor.withOpacity(.15),
                    ),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            bool isFavorited = toggleIsFavorated(
                                _plantList[widget.plantId].isFavorated);
                            _plantList[widget.plantId].isFavorated =
                                isFavorited;
                          });
                        },
                        icon: Icon(
                          _plantList[widget.plantId].isFavorated == true
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Constants.primaryColor,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * .42,
            padding: const EdgeInsets.only(right: 15),
            child: Stack(
              children: [
                Positioned(
                  right: size.width * 0.3,
                  child: SizedBox(
                    height: 300,
                    child: Image.asset(_plantList[widget.plantId].imageURL),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 0,
                  child: SizedBox(
                    //  height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PlantFeature(
                          title: 'Sunlight',
                          plantFeature:
                              _plantList[widget.plantId].sunlightRequirement,
                        ),
                        PlantFeature(
                          title: 'Watering Frequency',
                          plantFeature:
                              _plantList[widget.plantId].wateringFrequency,
                        ),
                        PlantFeature(
                          title: 'Blooming Season',
                          plantFeature:
                              _plantList[widget.plantId].bloomingSeason,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 50),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _plantList[widget.plantId].plantName,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Constants.primaryColor.withOpacity(.9),
                    ),
                  ),
                  Text(
                    _plantList[widget.plantId].species,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 22,
                      color: Constants.primaryColor.withOpacity(.8),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    _plantList[widget.plantId].description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Constants.blackColor.withOpacity(.6),
                    ),
                  ),
                  SizedBox(height: 30),
                   _buildDetailRow(
                    attribute: 'Temprature',
                    value: _plantList[widget.plantId].temperature,
                  ),
                  SizedBox(height: 30), _buildDetailRow(
                    attribute: 'Humidity',
                    value: _plantList[widget.plantId].humidity,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Soil Type',
                    value: _plantList[widget.plantId].soilType,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Growth Rate',
                    value: _plantList[widget.plantId].growthRate,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Height',
                    value: _plantList[widget.plantId].height,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Spread',
                    value: _plantList[widget.plantId].spread,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Diseases',
                    value: _plantList[widget.plantId].diseases,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Fertilizer Requirements',
                    value: _plantList[widget.plantId].fertilizerRequirements,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Common Problems',
                    value: _plantList[widget.plantId].commonProblems,
                  ),
                  SizedBox(height: 30),
                  _buildDetailRow(
                    attribute: 'Uses',
                    value: _plantList[widget.plantId].uses,
                  ),
                ],
              ),
            ),
          )
        ])));
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Constants.blackColor,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 5),
          Text(
            plantFeature,
            style: TextStyle(
              color: Constants.primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

// Helper function to build each detail row
Widget _buildDetailRow({required String attribute, required String value}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          attribute,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 18,
            color: Constants.blackColor.withOpacity(.6),
          ),
        ),
      ),
    ],
  );
}
