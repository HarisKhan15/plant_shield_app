// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/profile/Editprofile_page.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => EditProfileScreen(),
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
