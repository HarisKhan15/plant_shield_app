// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 80,
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
                    width: 80,
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
                    width: 80,
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
                    width: 80,
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
                    width: 80,
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
                    width: 80,
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
