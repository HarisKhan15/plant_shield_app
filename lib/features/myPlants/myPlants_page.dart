import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/favorites/Favplant_widget.dart';
import 'package:plant_shield_app/features/home/home_page.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';
import 'package:plant_shield_app/features/myPlants/Myplant_widget.dart';

class MyplantsScreen extends StatefulWidget {
  final List<Plant> favoritedPlants;
  const MyplantsScreen({Key? key, required this.favoritedPlants})
      : super(key: key);

  @override
  State<MyplantsScreen> createState() => _MyplantsScreenState();
}

class _MyplantsScreenState extends State<MyplantsScreen> {
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
      body: widget.favoritedPlants.isEmpty
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
                  itemCount: widget.favoritedPlants.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return MyPlantWidget(
                      index: index,
                      plantList: widget.favoritedPlants,
                    );
                  }),
            ),
    );
  }
}
