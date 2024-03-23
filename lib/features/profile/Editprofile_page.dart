// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _selectedCountry; // Set a default country
  String? _selectedGender; // Initially empty
  String? _selectedCity; // Initialize to null

  List<String> _genders = ['Male', 'Female', 'Other']; // List of genders
  List<String> _countries = [
    'USA',
    'Canada',
    'UK',
    'Australia',
    'Pakistan',
    'Saudi Arabia'
  ];
  Map<String, List<String>> _citiesByCountry = {
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal'],
    'UK': ['London', 'Manchester', 'Birmingham'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane'],
    'Pakistan': ['Karachi', 'Lahore', 'Islamabad'],
    'Saudi Arabia': ['Riyadh', 'Jeddah', 'Dammam'],
  };

  @override
  void initState() {
    super.initState();
    if (_selectedCountry != null) {
      _selectedCity = _citiesByCountry[_selectedCountry!]!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Constants.primaryColor,
            // expandedHeight: size.height * 0.07,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                CurvedContainer(),
                Positioned(
                  top: size.height * 0.1,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.27,
                      right: 10,
                      left: 10,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextField(
                              decoration: constantInputDecoration(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              decoration: constantInputDecoration(
                                hintText: 'UserName',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: TextFormField(
                              decoration: constantInputDecoration(
                                hintText: 'Bio',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownButtonFormField<String>(
                              value: _selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue!;
                                });
                              },
                              items: _genders.map((gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              decoration: constantInputDecoration(
                                hintText: 'Gender',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownButtonFormField<String>(
                              value: _selectedCountry,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCountry = newValue!;
                                  // Update selected city based on the selected country
                                  _selectedCity =
                                      _citiesByCountry[newValue]!.first;
                                });
                              },
                              items: _countries.map((country) {
                                return DropdownMenuItem<String>(
                                  value: country,
                                  child: Text(country),
                                );
                              }).toList(),
                              decoration: constantInputDecoration(
                                hintText: 'Country',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DropdownButtonFormField<String>(
                              value: _selectedCity,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedCity = newValue!;
                                });
                              },
                              items: _selectedCountry != null
                                  ? _citiesByCountry[_selectedCountry!]!
                                      .map((city) {
                                      return DropdownMenuItem<String>(
                                        value: city,
                                        child: Text(city),
                                      );
                                    }).toList()
                                  : [],
                              decoration: constantInputDecoration(
                                hintText: 'City',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 255,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Constants.primaryColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerWidth = size.width; 
    double containerHeight =
        size.height * 0.2; //  height as a percentage of screen height
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: ClipPath(
        clipper: CurvedClipper(),
        child: Container(
          color: Constants.primaryColor, 
        ),
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Start at the bottom-left corner
    path.quadraticBezierTo(size.width / 2, size.height + 20, size.width,
        size.height - 50); // Create a quadratic Bezier curve
    path.lineTo(size.width, 0); // Line to the bottom-right corner
    path.close(); // Close the path to form a closed shape
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
