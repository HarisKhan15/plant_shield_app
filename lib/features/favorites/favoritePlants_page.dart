// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/favorites/Favplant_widget.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';

class favScreen extends StatefulWidget {
  final List<Plant> favoritedPlants;
  final Function(int) removeFromFavorites;
  const favScreen({
    Key? key,
    required this.favoritedPlants,
    required this.removeFromFavorites,
  }) : super(key: key);
  @override
  State<favScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<favScreen> {
  void removeFromFavorites(int index) {
    setState(() {
      widget.favoritedPlants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Container(
            height: 30,
            width: 30,
            child: Icon(
              Icons.arrow_back_rounded,
              color: Constants.primaryColor,
            ),
          ),
        ),
        title: Text(
          'Favorite Plants',
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
      body: widget.favoritedPlants.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/favorited.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Your favorited Plants',
                    style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
              height: size.height * 1.0,
              child: ListView.builder(
                itemCount: (widget.favoritedPlants.length / 2).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  int startIndex =
                      index * 2; // Calculate the starting index for each row
                  int endIndex =
                      (index + 1) * 2; // Calculate the end index for each row
                  endIndex = endIndex > widget.favoritedPlants.length
                      ? widget.favoritedPlants.length
                      : endIndex;

                  List<Plant> currentRow =
                      widget.favoritedPlants.sublist(startIndex, endIndex);

                  return Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      currentRow.length,
                      (i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: size.width * 0.41,
                          height: size.height * 0.25,
                          child: FavPlantWidget(
                            index: startIndex + i,
                            plantList: widget.favoritedPlants,
                            onRemove: (removedIndex) {
                              setState(() {
                                widget.favoritedPlants.removeAt(removedIndex);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
