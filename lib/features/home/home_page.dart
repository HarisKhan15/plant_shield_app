// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/favorites/favoritePlants_page.dart';
import 'package:plant_shield_app/features/home/homePlant_widget.dart';
import 'package:plant_shield_app/features/home/selectedImage.dart';
import 'package:plant_shield_app/features/home/infocard.dart';
import 'package:plant_shield_app/features/home/user-plant-loader.dart';
import 'package:plant_shield_app/features/login/login_page.dart';
import 'package:plant_shield_app/features/myPlants/myPlants_page.dart';
import 'package:plant_shield_app/features/plantDetail/detail_page.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_shield_app/features/settings/Settings_page.dart';
import 'package:plant_shield_app/models/feedback-model.dart';
import 'package:plant_shield_app/models/plant-detection.dart';
import 'package:plant_shield_app/models/user-plant-detail.dart';
import 'package:plant_shield_app/models/user-plants.dart';
import 'package:plant_shield_app/models/user.dart';
import 'package:plant_shield_app/services/user-plant-service.dart';
import 'package:plant_shield_app/services/user-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpanded = false;
  File? imageFile;
  SharedPreferences? logindata;
  String? username;
  User? currentUser;
  UserService userService = UserService();
  UserPlantService userPlantService = UserPlantService();
  PlantDetection? plantDetection;

  @override
  void initState() {
    super.initState();
    initializeVariables();
  }

  void initializeVariables() async {
    logindata = await SharedPreferences.getInstance();
    final String? userObj = logindata?.getString("userObj");
    if (userObj != null) {
      User user = User.fromJson(jsonDecode(userObj));
      setState(() {
        username = user.username;
        currentUser = user;
      });
    }
  }

  Future<void> _getImageToIdentifyPlantAndPredictPlantDisease(
      bool isCamera) async {
    final picker = ImagePicker();
    final PickedFile? pickedFile;
    if (isCamera) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile!.path);
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return UserPlantLoader();
        },
      );
      await Future.delayed(Duration(seconds: 7), () async {
        try {
          plantDetection = await userPlantService
              .detectPlantInformationAndDisease(imageFile);
        } catch (e) {
          print(e);
        }
      });
      Navigator.pop(context);
      if (plantDetection != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedImageScreen(
              username: username!,
              detectedPlantDetails: plantDetection!,
              imageFile: imageFile!,
              fromMyPlants: false,
              userPlantDetail: UserPlantDetail(),
              isFeedBackRequired: FeedBackObject.fromJson({}),
            ),
          ),
        );
      } else {
        _showPlantNotFoundDialog(context);
      }
    }
  }

  void _showPlantNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Plant Not Found',
            style: TextStyle(color: Constants.primaryColor),
          ),
          content: Text('Sorry! The plant does not exist.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: TextButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Logout', style: TextStyle(color: Constants.primaryColor)),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action here
                _performLogout(context);
              },
              style: TextButton.styleFrom(
                primary: Constants.primaryColor,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    // Perform your logout logic here
    logindata?.setBool('login', true);
    logindata?.remove("userObj");
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _goToMyPlants() async {
    List<UserPlant> userPlants = [];
    Response? response;
    try {
      LoadingDialog.showLoadingDialog(context);
      response = await userPlantService.fetchUserPlants(username!);
    } catch (e) {
      print("Error: $e");
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
    if (response != null && response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['User Plants'];
      try {
        userPlants = data
            .map((item) => UserPlant.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
        print(e);
      }

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyPlantsScreen(
                username: username!,
                userplants: userPlants,
              )));
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
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    TextEditingController searchController = TextEditingController();

    List<Plant> _plantList = Plant.plantList;

    void searchForPlant(String searchTerm) {
      // Filter the plant list based on the search term
      List<Plant> filteredPlants = Plant.plantList
          .where((plant) =>
              plant.plantName.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      if (filteredPlants.isNotEmpty) {
        // If the filtered list is not empty, navigate to the detail page of the first plant
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailPage(plantId: filteredPlants.first.plantId),
          ),
        );
      } else {
        // If no plant matches the search term, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Plant Not Found',
                style: TextStyle(color: Constants.primaryColor),
              ),
              content: Text('The plant you are searching for does not exist.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    primary: Constants.primaryColor,
                  ),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

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
        toolbarHeight: size.width < 600 ? 56 : 65,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Constants.primaryColor,
            size: size.width < 600 ? 30 : 35,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Plant Shield',
          style: TextStyle(
            color: Color(0xFF236419),
            fontSize: size.width < 600 ? 18 : 22,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 2),
                blurRadius: 3,
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/logo3.png',
              width: size.width < 600 ? 40 : 50,
              height: size.width < 600 ? 40 : 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: Infocard(
                      user: currentUser,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(
                Icons.group_outlined,
                color: Constants.primaryColor,
                size: size.width < 600 ? 24 : 30,
              ),
              title: Text(
                'Community',
                style: TextStyle(fontSize: size.width < 600 ? 16 : 18),
              ),
              onTap: () {},
            ),
            Divider(
              color: Constants.primaryColor,
              thickness: 0.6,
            ),
            ListTile(
              leading: Image.asset(
                'assets/plant.png',
                color: Constants.primaryColor,
                width: size.width < 600 ? 24 : 30,
                height: size.width < 600 ? 24 : 30,
              ),
              title: Text(
                'My Plants',
                style: TextStyle(fontSize: size.width < 600 ? 16 : 18),
              ),
              onTap: () {
                _goToMyPlants();
              },
            ),
            Divider(
              color: Constants.primaryColor,
              thickness: 0.6,
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_border_outlined,
                color: Constants.primaryColor,
                size: size.width < 600 ? 24 : 30,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(fontSize: size.width < 600 ? 16 : 18),
              ),
              onTap: () {
                List<Plant> favoritedPlants =
                    _plantList.where((plant) => plant.isFavorated).toList();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => favScreen(
                          favoritedPlants: favoritedPlants,
                          removeFromFavorites: (int) {},
                        )));
              },
            ),
            Divider(
              color: Constants.primaryColor,
              thickness: 0.6,
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Constants.primaryColor,
                size: size.width < 600 ? 24 : 30,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: size.width < 600 ? 16 : 18),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsScreen(user: currentUser)));
              },
            ),
            Divider(
              color: Constants.primaryColor,
              thickness: 0.6,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Constants.primaryColor,
                size: size.width < 600 ? 24 : 30,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: size.width < 600 ? 16 : 18),
              ),
              onTap: () {
                _showLogoutDialog(context); // Show the logout dialog
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
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
                        Expanded(
                          child: TextField(
                            showCursor: true,
                            decoration: InputDecoration(
                              hintText: 'Search Plant',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              searchForPlant(value);
                            },
                          ),
                        ),
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
            SizedBox(
              height: 10,
            ),
            // Category bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: size.width < 550 ? 55.0 : 100.0,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _plantTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Text(
                        _plantTypes[index],
                        style: TextStyle(
                          fontSize: size.width < 600 ? 16.0 : 16.0,
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
                },
              ),
            ),
            // Right scroll plant view according to category
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
                      width: size.width * 0.5,
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
                                    _plantList[index].isFavorated = isFavorited;
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
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            // New Plant Text
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
            // All Plants
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: size.height * .41,
              child: Stack(
                children: [
                  ListView.builder(
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
                                plantId: _plantList[index].plantId,
                              ),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                        child: HomePlantWidget(
                          index: index,
                          plantList: _plantList,
                          onRemove: (removedIndex) {
                            setState(() {
                              _plantList.removeAt(removedIndex);
                            });
                          },
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: size.width * 0.04,
                    bottom: size.height * 0.08,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: _isExpanded,
                          child: FloatingActionButton(
                            onPressed: () {
                              _getImageToIdentifyPlantAndPredictPlantDisease(
                                  true);
                            },
                            backgroundColor: Constants.primaryColor,
                            tooltip: 'Button 1',
                            heroTag: null,
                            child: Icon(
                              Icons.camera_alt,
                              color: Color.fromARGB(255, 209, 230, 195),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Visibility(
                          visible: _isExpanded,
                          child: FloatingActionButton(
                            onPressed: () {
                              _getImageToIdentifyPlantAndPredictPlantDisease(
                                  false);
                            },
                            backgroundColor: Constants.primaryColor,
                            tooltip: 'Button 2',
                            heroTag: null,
                            child: Icon(
                              Icons.photo_library,
                              color: Color.fromARGB(255, 209, 230, 195),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          backgroundColor: Constants.primaryColor,
                          tooltip: 'Expand',
                          heroTag: null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30.0), // Adjust the radius as needed
                          ),
                          child: _isExpanded
                              ? Icon(
                                  Icons.close,
                                  color: Color.fromARGB(255, 209, 230, 195),
                                )
                              : Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('assets/plant.png'),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
