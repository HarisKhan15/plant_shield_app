// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_shield_app/features/Components/constants.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height + 20, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SelectedImageScreen extends StatefulWidget {
  final File imageFile;

  const SelectedImageScreen({Key? key, required this.imageFile})
      : super(key: key);

  @override
  _SelectedImageScreenState createState() => _SelectedImageScreenState();
}

class _SelectedImageScreenState extends State<SelectedImageScreen> {
  bool isButtonClicked = false;
  String? selectedButton;
 @override
  void initState() {
    super.initState();
    selectedButton = 'Details'; 
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    width: size.width,
                    child: ClipPath(
                      clipper: CurvedClipper(),
                      child: Container(
                        color: Constants.primaryColor,
                        height: size.height * 0.34,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              widget.imageFile,
                              fit: BoxFit.cover,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6, top: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                    size: size.width < 600 ? 24 : 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 15.0, right: 10, bottom: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 7),
                              Text(
                                'Night Blooming Jasmine',
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(1, 2),
                                      blurRadius: 3,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 9),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text(
                                  'Outdoor',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Mulish-VariableFont_wght',
                                    fontWeight: FontWeight.w900,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0.1,
                            bottom: 10,
                          ),
                          child: ElevatedButton(
                            onPressed: isButtonClicked
                                ? null
                                : () {
                                    setState(() {
                                      isButtonClicked = true;
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              primary: Colors.white,
                              onPrimary: Colors.green,
                              padding: EdgeInsets.all(8),
                              elevation: 7,
                              shadowColor: Colors.grey,
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/plant.png',
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 45,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 15),
                        _buildHorizontalButton(
                          text: 'Details',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Details';
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        _buildHorizontalButton(
                          text: 'Disease',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Disease';
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        _buildHorizontalButton(
                          text: 'Care',
                          onPressed: () {
                            setState(() {
                              selectedButton = 'Care Instructions';
                            });
                          },
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildExpandableSection(
                          iconAssetPath: 'assets/edit-info.png',
                          imageSize: 35,
                          header: 'Description',
                          content:
                              'Night-blooming jasmine is a woody shrub or small tree that can grow up to 15 feet tall. It has dark green, lance-shaped leaves arranged alternately along the stems. The flowers are small, white, and tubular, with five petals fused into a narrow tube. They bloom at night and release a sweet, intoxicating fragrance that attracts nocturnal pollinators such as moths and bats.',
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/lab.png',
                          imageSize: 40,
                          header: 'Species',
                          content:
                              'Night-blooming jasmine has a lifespan of approximately 36 months under ideal growing conditions. With proper care and maintenance, it can live longer and continue to provide beauty and fragrance to your garden.',
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/life.png',
                          imageSize: 40,
                          header: 'Max Life',
                          content:
                              'Night-blooming jasmine has a lifespan of approximately 36 months under ideal growing conditions. With proper care and maintenance, it can live longer and continue to provide beauty and fragrance to your garden.',
                          expanded: selectedButton == 'Details',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/virus.png',
                          imageSize: 40,
                          header: 'Diseases',
                          content:
                              'Night-blooming jasmine is relatively resistant to pests and diseases but may occasionally encounter issues such as powdery mildew and root rot. Powdery mildew can be prevented by ensuring good air circulation and avoiding overhead watering. Root rot can be prevented by avoiding overwatering and ensuring well-draining soil.',
                          expanded: selectedButton == 'Disease',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/preven.png',
                          imageSize: 40,
                          header: 'Prevention',
                          content:
                              'To prevent powdery mildew, ensure good air circulation around the plant by spacing them adequately. Water at the base to prevent moisture accumulation on the leaves, especially in the evening. Apply fungicidal sprays as a preventive measure during periods of high humidity. To prevent root rot, water plants only when necessary and ensure proper drainage in the soil.',
                          expanded: selectedButton == 'Disease',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/humidity.png',
                          imageSize: 40,
                          header: 'Humidity',
                          content:
                              'Night-blooming jasmine thrives in moderate to high humidity levels. It prefers humidity levels between 60% and 80%. To maintain optimal humidity, you can mist the plant regularly or place a humidifier nearby.',
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/temp.png',
                          imageSize: 40,
                          header: 'Temperature',
                          content:
                              'Night-blooming jasmine prefers warm temperatures between 20°C and 25°C. It is sensitive to cold temperatures and should be protected from frost. If grown outdoors, it should be planted in a sheltered location.',
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/sun.png',
                          imageSize: 40,
                          header: 'Sunlight Requirement',
                          content:
                              'Night-blooming jasmine requires full sunlight to thrive. It should be planted in a location where it receives at least 6 to 8 hours of direct sunlight per day. Insufficient sunlight can result in poor growth and fewer blooms.',
                          expanded: selectedButton == 'Care Instructions',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/water.png',
                          imageSize: 40,
                          header: 'Watering Schedule',
                          content:
                              'Night-blooming jasmine prefers evenly moist soil. Water deeply once a week, allowing the soil to dry slightly between waterings. Avoid overwatering, as it can lead to root rot.',
                          expanded: selectedButton == 'Care Instructions',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String iconAssetPath,
    required double imageSize,
    required String header,
    required String content,
    required bool expanded,
  }) {
    if (!expanded) {
      return SizedBox.shrink();
    }
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: expanded,
        title: Text(
          header,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(1, 0.5),
                blurRadius: 2,
              )
            ],
          ),
        ),
        leading: SizedBox(
          width: imageSize,
          height: imageSize,
          child: Image(
            image: AssetImage(iconAssetPath),
            fit: BoxFit.contain,
          ),
        ),
        iconColor: Constants.primaryColor,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Mulish-VariableFont_wght',
                fontWeight: FontWeight.w600,
                height: 1.4,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHorizontalButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
