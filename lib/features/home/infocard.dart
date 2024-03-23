import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/profile/Editprofile_page.dart';
import 'package:plant_shield_app/features/splash/myProfile/MyProfile_page.dart';
import 'package:plant_shield_app/models/user.dart';

class Infocard extends StatelessWidget {
  const Infocard({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    Uint8List bytes =
        Uint8List.fromList(base64.decode(user?.profilePicture ?? ''));

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
            backgroundImage: bytes.isNotEmpty
                ? Image.memory(
                    bytes,
                    width: 500,
                    fit: BoxFit.cover,
                  ).image
                : AssetImage('assets/profile.png'),
          ),
          title: Text(
            "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            "@${user?.username ?? ''}",
            style: TextStyle(fontSize: 15),
          ),
        ));
  }
}
