// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/home/infocard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//APPBAR
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
                    child: infocard(Username: 'wania', FullName: 'wania jamal'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //1
            ListTile(
              leading:
                  Icon(Icons.home_outlined, color: Color(0xFF449636), size: 30),
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
                onTap: () {}),
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

//BODY
      body: Stack(children: [
        SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: 10,
                    left: 10),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
//search bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              // contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: Offset(2, 4),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 12),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Search here',
                                hintStyle: TextStyle(fontSize: 12),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Icon(Icons.search),
                                ),
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
//recently viewed
                      RecentlyViewedPlants(),
//popular plants
                      SizedBox(height: 5),
                      PopularPlants(),
                    ]))))
      ]),
    );
  }
}

//popular
class RecentlyViewedPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Viewed',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/plant1.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                //2
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/plant2.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )),
                //3
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/plant3.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )),
                //4
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/plant4.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )),
                //5
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/plant1.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )),
                //6
                Container(
                    width: 100,
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/plant2.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//popular

class PopularPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Popular Plants',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
//1
          SizedBox(height: 15),

          Container(
            width: 380,
            margin: EdgeInsets.only(right: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 110,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          //2
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          //3
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          //4
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          //5
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          //6
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          //7
          Container(
              width: 380,
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 110,
                      height: 110,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
