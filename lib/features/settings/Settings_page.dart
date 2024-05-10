// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/Components/loader.dart';
import 'package:plant_shield_app/features/profile/Editprofile_page.dart';
import 'package:plant_shield_app/models/edit-profile.dart';
import 'package:plant_shield_app/models/user.dart';
import 'package:plant_shield_app/services/profile-service.dart';

class SettingsScreen extends StatefulWidget {
  final User? user;
  const SettingsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? currentUser;
  ProfileService profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    setState(() {
      currentUser = widget.user?.username;
    });
  }

  void callEditProfile() async {
    EditProfile? profile;
    try {
      LoadingDialog.showLoadingDialog(context);
      final EditProfile? response =
          await profileService.getProfileByUserName(currentUser!);
      if (response != null) {
        profile = response;
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
    if (profile != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => EditProfileScreen(
            profile: profile!,
          ),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
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
        backgroundColor: Constants.primaryColor,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            
          ),
        ),
        centerTitle: true,
        elevation: 0,
         automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          _buildSettingsHeading('Account'),
          _buildSettingsItem(
            context,
            'Edit Profile',
            'assets/user.png',
            () {
              callEditProfile();
            },
          ),
          Divider(),
          _buildSettingsItem(
            context,
            'Change Password',
            'assets/lock.png',
            () {},
          ),
          Divider(),
          _buildSettingsItem(
            context,
            'Change Email',
            'assets/mail.png',
            () {},
          ),
          Divider(),
          _buildSettingsHeading('Notification'),
        ],
      ),
    );
  }

  Widget _buildSettingsHeading(String heading) {
    return ListTile(
      title: Text(
        heading,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Constants.primaryColor),
      ),
      dense: true,
    );
  }

  Widget _buildSettingsItem(BuildContext context, String title,
      String imagePath, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      leading: Image.asset(
        imagePath,
        width: 24,
        height: 24,
      ),
      trailing: Icon(
        Icons.arrow_forward,
        color: Constants.primaryColor,
      ),
      onTap: onTap,
    );
  }
}
