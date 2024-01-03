// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/constants.dart';
import 'package:plant_shield_app/features/home/infocard.dart';
import 'package:plant_shield_app/features/myPlants/myPlants_page.dart';
import 'package:plant_shield_app/features/plantDetail/detail_page.dart';
import 'package:plant_shield_app/features/home/plant_widget.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    List<Plant> _plantList = Plant.plantList;

    //Plants category
    List<String> _plantTypes = [
      'Recommended',
      'Indoor',
      'Outdoor',
      'Garden',
      'Supplement',
    ];

    //Toggle Favorite button
    bool toggleIsFavorated(bool isFavorited) {
      return !isFavorited;
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
//sidebar
            leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Color(0xFF236419),
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                }),
            //title
            title: Text('Plant Shield',
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
                )),
// //logo
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/PS logo.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
              ),
            ]),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child:
                          infocard(Username: 'wania', FullName: 'wania jamal'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //1
              ListTile(
                leading: Icon(Icons.home_outlined,
                    color: Color(0xFF449636), size: 30),
                title: Text(
                  'Home',
                  style: TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              Divider(
                color: Color(0xFF78A55A),
                thickness: 0.6,
              ),
              //2
              ListTile(
                  leading: Image.asset(
                    'assets/plant.png',
                    color: Color(0xFF78A55A),
                    width: 30,
                    height: 30,
                  ),
                  title: Text(
                    'My Plants',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    List<Plant> favoritedPlants =
                        _plantList.where((plant) => plant.isFavorated).toList();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            MyplantsScreen(favoritedPlants: favoritedPlants)));
                  }),
              Divider(
                color: Color(0xFF78A55A),
                thickness: 0.6,
              ),
              //3
              ListTile(
                  leading: Icon(Icons.group_outlined,
                      color: Color(0xFF449636), size: 30),
                  title: Text(
                    'Community',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {}),
              //4

              Divider(
                color: Color(0xFF78A55A),
                thickness: 0.6,
              ),
              //5
              ListTile(
                  leading: Icon(Icons.settings_outlined,
                      color: Color(0xFF449636), size: 30),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {}),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      width: size.width * .9,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                              child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search Plant',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          )),
                          Icon(
                            Icons.search,
                            color: Colors.black54.withOpacity(.6),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                height: 50.0,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _plantTypes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Text(
                            _plantTypes[index],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                              color: selectedIndex == index
                                  ? Constants.primaryColor
                                  : Constants.blackColor,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: size.height * .3,
                child: ListView.builder(
                    itemCount: _plantList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: DetailPage(
                                    plantId: _plantList[index].plantId,
                                  ),
                                  type: PageTransitionType.bottomToTop));
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bool isFavorited = toggleIsFavorated(
                                            _plantList[index].isFavorated);
                                        _plantList[index].isFavorated =
                                            isFavorited;
                                      });
                                    },
                                    icon: Icon(
                                      _plantList[index].isFavorated == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Constants.primaryColor,
                                    ),
                                    iconSize: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 50,
                                right: 50,
                                top: 50,
                                bottom: 50,
                                child: Image.asset(_plantList[index].imageURL),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _plantList[index].category,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      _plantList[index].plantName,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 20,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    r'$' + _plantList[index].price.toString(),
                                    style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'New Plants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                height: size.height * .5,
                child: ListView.builder(
                    itemCount: _plantList.length,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: DetailPage(
                                        plantId: _plantList[index].plantId),
                                    type: PageTransitionType.bottomToTop));
                          },
                          child:
                              PlantWidget(index: index, plantList: _plantList));
                    }),
              ),
            ],
          ),
        ));
  }
}
