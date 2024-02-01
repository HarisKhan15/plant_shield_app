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
          color: Constants.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 75.0,
                  height: 75.0,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor.withOpacity(.8),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 100.0,
                    child: Image.asset(widget.plantList[widget.index].imageURL),
                  ),
                ),
                Positioned(
                  top: 83,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.plantList[widget.index].category),
                      Text(
                        widget.plantList[widget.index].plantName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                  bool isFavorited =
                      !widget.plantList[widget.index].isFavorated;
                  widget.plantList[widget.index].isFavorated = isFavorited;
                });
                widget.onRemove(widget.index);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(right: 19, bottom: 75),
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
