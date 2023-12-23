// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
            width: 306,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 102,
                    height: 102,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 102,
                    height: 102,
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/plant1.png',
                    width: 102,
                    height: 102,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          //2
          Container(
              width: 306,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant2.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          //3
          Container(
              width: 306,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant3.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          //4
          Container(
              width: 306,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          //5
          Container(
              width: 306,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          //6
          Container(
              width: 306,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              )),
          SizedBox(height: 5),
          //7
          Container(
              width: 306,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/plant4.png',
                      width: 102,
                      height: 102,
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
