// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/plantDetail/detail_page.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';

class HomePlantWidget extends StatefulWidget {
  final Function(int) onRemove;
  const HomePlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
    required this.onRemove,
  }) : super(key: key);

  final int index;
  final List<Plant> plantList;

  @override
  State<HomePlantWidget> createState() => _HomePlantWidgetState();
}

class _HomePlantWidgetState extends State<HomePlantWidget> {
  bool toggleIsFavorited(bool isFavorited) {
    return !isFavorited;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: DetailPage(
              plantId: widget.plantList[widget.index].plantId,
            ),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        // padding: EdgeInsets.only(
        //   left: size.width *0.0,
        //   top:size.height *0.0,
        // ),
        margin: EdgeInsets.only(
          top: size.height * 0.02,
        ),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 6, left: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey, // Color of the border
                        width: 1.0, // Width of the border
                      ),
                    ),
                    child: CircleAvatar(
                      radius: size.height * 0.04,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      backgroundImage: AssetImage(
                        widget.plantList[widget.index].imageURL,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plantList[widget.index].plantName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 600 ? 16.0 : 18.0,
                          color: Constants.blackColor,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.plantList[widget.index].species,
                        style: TextStyle(
                          fontSize: size.width < 600 ? 14.0 : 16.0,
                          color: Constants.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  bool isFavorited = toggleIsFavorited(
                      widget.plantList[widget.index].isFavorated);
                  widget.plantList[widget.index].isFavorated = isFavorited;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(right: 10, bottom: 10),
                child: Icon(
                  widget.plantList[widget.index].isFavorated
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Constants.primaryColor,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
