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
                        left: 20.0, top: 15.0, right: 20.0, bottom: 35),
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
                              Text(
                                'Outdoor',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Mulish-VariableFont_wght',
                                  fontWeight: FontWeight.w900,
                                  color: Constants.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.1, bottom: 10),
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
                    padding: const EdgeInsets.only(top: 25),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.3),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildExpandableSection(
                          iconAssetPath: 'assets/lab.png',
                          imageSize: 35,
                          header: 'Scientific Name',
                          content:
                              'Night-blooming jasmine, also known as Cestrum nocturnum, is a fragrant flowering plant native to the West Indies. It belongs to the Solanaceae family and is known for its small, white, tubular flowers that bloom at night, releasing a strong, sweet fragrance. This plant is often cultivated for its ornamental value and is popular in gardens and landscapes.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/edit-info.png',
                          imageSize: 35,
                          header: 'Description',
                          content:
                              'Night-blooming jasmine is a woody shrub or small tree that can grow up to 15 feet tall. It has dark green, lance-shaped leaves arranged alternately along the stems. The flowers are small, white, and tubular, with five petals fused into a narrow tube. They bloom at night and release a sweet, intoxicating fragrance that attracts nocturnal pollinators such as moths and bats.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/humidity.png',
                          imageSize: 40,
                          header: 'Humidity',
                          content:
                              'Night-blooming jasmine thrives in moderate to high humidity levels. It prefers humidity levels between 60% and 80%. To maintain optimal humidity, you can mist the plant regularly or place a humidifier nearby.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/temp.png',
                          imageSize: 40,
                          header: 'Temperature',
                          content:
                              'Night-blooming jasmine prefers warm temperatures between 20°C and 25°C. It is sensitive to cold temperatures and should be protected from frost. If grown outdoors, it should be planted in a sheltered location.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/sun.png',
                          imageSize: 40,
                          header: 'Sunlight Requirement',
                          content:
                              'Night-blooming jasmine requires full sunlight to thrive. It should be planted in a location where it receives at least 6 to 8 hours of direct sunlight per day. Insufficient sunlight can result in poor growth and fewer blooms.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/water.png',
                          imageSize: 40,
                          header: 'Watering Schedule',
                          content:
                              'Night-blooming jasmine prefers evenly moist soil. Water deeply once a week, allowing the soil to dry slightly between waterings. Avoid overwatering, as it can lead to root rot.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/care.png',
                          imageSize: 40,
                          header: 'Care Instructions',
                          content:
                              'Night-blooming jasmine requires minimal care once established. Prune regularly to maintain its shape and remove dead or damaged branches. Fertilize lightly in spring to promote healthy growth. Monitor for pests and diseases and treat promptly if detected.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/virus.png',
                          imageSize: 40,
                          header: 'Diseases',
                          content:
                              'Night-blooming jasmine is relatively resistant to pests and diseases but may occasionally encounter issues such as powdery mildew and root rot. Powdery mildew can be prevented by ensuring good air circulation and avoiding overhead watering. Root rot can be prevented by avoiding overwatering and ensuring well-draining soil.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/preven.png',
                          imageSize: 40,
                          header: 'Prevention',
                          content:
                              'To prevent powdery mildew, ensure good air circulation around the plant by spacing them adequately. Water at the base to prevent moisture accumulation on the leaves, especially in the evening. Apply fungicidal sprays as a preventive measure during periods of high humidity. To prevent root rot, water plants only when necessary and ensure proper drainage in the soil.',
                        ),
                        _buildExpandableSection(
                          iconAssetPath: 'assets/life.png',
                          imageSize: 40,
                          header: 'Max Life',
                          content:
                              'Night-blooming jasmine has a lifespan of approximately 36 months under ideal growing conditions. With proper care and maintenance, it can live longer and continue to provide beauty and fragrance to your garden.',
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
  }) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              content,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Mulish-VariableFont_wght',
                fontWeight: FontWeight.w600,
                height: 1.4,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
