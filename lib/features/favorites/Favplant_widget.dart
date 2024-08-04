// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_shield_app/features/Components/constants.dart';
import 'package:plant_shield_app/features/plantDetail/detail_page.dart';
import 'package:plant_shield_app/features/home/plants_model.dart';

class FavPlantWidget extends StatefulWidget {
  final Function(int) onRemove;
  const FavPlantWidget({
    Key? key,
    required this.index,
    required this.plantList,
    required this.onRemove,
  }) : super(key: key);

  final int index;
  final List<Plant> plantList;

  @override
  State<FavPlantWidget> createState() => _FavPlantWidgetState();
}

class _FavPlantWidgetState extends State<FavPlantWidget> {
  void navigateToDetailPage() {
    Navigator.push(
      context,
      PageTransition(
        child: DetailPage(
          plantId: widget.plantList[widget.index].plantId,
        ),
        type: PageTransitionType.bottomToTop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        navigateToDetailPage();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.1,
        padding:
            EdgeInsets.only(left: size.width * 0.03, top: size.width * 0.03),
        margin: EdgeInsets.only(
            bottom: size.height * 0.01, top: size.height * 0.01),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: size.height * 0.058,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      backgroundImage: AssetImage(
                        widget.plantList[widget.index].imageURL,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.13,
                  // left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.plantList[widget.index].plantName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 600
                              ? size.height * 0.021
                              : size.height * 0.025,
                          color: Constants.blackColor,
                        ),
                      ),
                      Text(widget.plantList[widget.index].species),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  bool isFavorited =
                      !widget.plantList[widget.index].isFavorated;
                  widget.plantList[widget.index].isFavorated = isFavorited;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.only(right: 10, bottom: 115),
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
