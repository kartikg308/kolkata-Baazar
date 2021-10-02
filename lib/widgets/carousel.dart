import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousels extends StatelessWidget {
  const Carousels({
    Key? key,
    required this.imageSliders,
  }) : super(key: key);

  final List<Widget> imageSliders;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        autoPlay: true,
      ),
      items: imageSliders,
    );
  }
}
