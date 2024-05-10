// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/models/edit-profile.dart';
import 'package:plant_shield_app/services/profile-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final EditProfile profile;
  const EditProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? _selectedCountry; // Set a default country
  String? _selectedGender; // Initially empty
  String? _selectedCity; // Initialize to null
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //late ScrollController _scrollController;
  final ProfileService _profileService = ProfileService();
  File? imageFile;

  List<String> _genders = ['Male', 'Female'];
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

  SharedPreferences? logindata;

  EditProfile? currentProfile;
  ProfileService profileService = ProfileService();

  void initializeVariables() async {
    setState(() {
      currentProfile = widget.profile;
      _lastNameController.text = currentProfile?.lastName ?? '';
      _firstNameController.text = currentProfile?.firstName ?? '';
      _bioController.text = currentProfile?.bio ?? '';
      _phoneController.text = currentProfile?.phoneNumber ?? '';
      if (currentProfile?.gender != null && currentProfile?.gender != "") {
        _selectedGender = currentProfile?.gender ?? '';
      }
      if (currentProfile?.location != null && currentProfile?.location != "") {
        final locationParts = currentProfile?.location.split(',');
        if (locationParts != null && locationParts.length == 2) {
          _selectedCountry = locationParts[1].trim();
          _selectedCity = locationParts[0].trim();
        }
      }
      imageFile = currentProfile?.profilePicture != null
          ? File.fromRawPath(
              Uint8List.fromList(base64.decode(currentProfile!.profilePicture)))
          : null;
    });
  }

  EditProfile _constructUpdatedProfileObject() {
    return EditProfile(
        id: currentProfile!.id,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        bio: _bioController.text,
        gender: _selectedGender ?? '',
        phoneNumber: _phoneController.text,
        location: (_selectedCity != null && _selectedCountry != null)
            ? '$_selectedCity, $_selectedCountry'
            : '',
        profilePicture: '');
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (_selectedCountry != null) {
      _selectedCity = _citiesByCountry[_selectedCountry!]!.first;
    }
    initializeVariables();
    // _scrollController = ScrollController();
    // _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  // void _scrollListener() {
  //   setState(() {
  //     _isTitleRightAligned = min(_scrollController.offset, 40) > 20;
  //   });
  // }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      Response? response;
      try {
        LoadingDialog.showLoadingDialog(context);
        EditProfile updatedProfile = _constructUpdatedProfileObject();

        response = await _profileService.saveProfileData(null, updatedProfile);

        if (response != null && response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully.'),
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
        print('Error updating profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error. Please try again.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes =
        Uint8List.fromList(base64.decode(currentProfile?.profilePicture ?? ''));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Constants.primaryColor,
                expandedHeight: MediaQuery.of(context).size.height * 0.05,
                pinned: false,
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      size: size.width < 600 ? 24 : 30,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    CurvedContainer(),
                    Positioned(
                      top: size.height * 0.06,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: GestureDetector(
                          onTap: _getImageFromGallery,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundImage: bytes.isNotEmpty
                                  ? Image.memory(
                                      bytes,
                                      width: 600,
                                      fit: BoxFit.cover,
                                    ).image
                                  : AssetImage('assets/profile.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.29,
                          right: 10,
                          left: 10,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: constantInputDecoration(
                                    hintText: 'First Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration: constantInputDecoration(
                                    hintText: 'Last Name',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                  controller: _bioController,
                                  decoration: constantInputDecoration(
                                    hintText: 'Bio',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: TextFormField(
                                  controller: _phoneController,
                                  decoration: constantInputDecoration(
                                    hintText: 'Phone Number',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return validatePhoneNumber(value);
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedCountry,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedCountry = newValue!;
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
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
                                      onPressed: _updateProfile,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
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
        ));
  }
}

class CurvedContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double containerWidth = size.width;
    double containerHeight = size.height * 0.2;
    return Container(
      width: containerWidth,
      height: containerHeight,
      child: Stack(
        children: [
          ClipPath(
            clipper: CurvedClipper(),
            child: Container(
              color: Constants.primaryColor,
            ),
          ),
        ],
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

String? validatePhoneNumber(String value) {
  // Remove any non-digit characters from the input
  String cleanedValue = value.replaceAll(RegExp(r'\D'), '');

  // Regular expression to match common phone number formats
  RegExp regExp = RegExp(
    r'^(?:\+?)(?:[0-9]){6,14}[0-9]$',
  );

  if (!regExp.hasMatch(cleanedValue)) {
    return 'Please enter a valid phone number';
  }

  return null;
}
