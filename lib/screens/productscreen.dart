// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolkatabaazar2/screens/screens.dart';

List cartItems = [];

class ProductScreen extends StatelessWidget {
  final data;
  final String data1;
  const ProductScreen({Key? key, this.data, required this.data1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: Image.network(
                "${data['imageURL']}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    data['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Rs. ${data['price']}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => CheckoutWindow());
                      },
                      child: const Text('Buy Now'),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    child: ElevatedButton(
                      onPressed: () {
                        print(data1);
                        cartItems.add(data1);
                        print(cartItems);
                      },
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product Description',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data['description'],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const TitleText(
              title: 'Similar Products',
            ),
            const ProductList(),
            const TitleText(
              title: 'You may want to buy',
            ),
            const ProductList(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Product Reviews',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('This is a great product must try it.'),
                  const Text('Amazing Experience'),
                  const Text('Very NiCE Products'),
                  const Text('Great!!!'),
                  const Text('Must Try it >>>>>>'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
