// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolkatabaazar2/screens/productscreen.dart';

class ProductCard extends StatelessWidget {
  final data;
  final String data1;
  const ProductCard({
    Key? key,
    this.data,
    required this.data1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ProductScreen(
              data: data,
              data1: data1,
            ));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Container(
                  child: Image.network("${data['imageURL']}"),
                  width: 100,
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        data["name"].toString().toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "Rs.${data["price"]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Buy Now"),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
