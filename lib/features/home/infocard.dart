import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class infocard extends StatelessWidget {
  const infocard({
    super.key,
     required this.Username,
      required this.FullName,
  });

  final String Username, FullName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Color(0xFF449636),
          size: 40,
        ),
      ),
      title: Text(Username),
      subtitle: Text(FullName),
    );
  }
}