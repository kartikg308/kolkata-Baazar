// ignore_for_file: prefer_typing_uninitialized_variables, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolkatabaazar2/screens/screens.dart';

class CircleAvatarCategory extends StatelessWidget {
  final String imageURL;
  final String title;
  final Widget widget;
  const CircleAvatarCategory({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => widget);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 35,
              backgroundImage: AssetImage(imageURL),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
