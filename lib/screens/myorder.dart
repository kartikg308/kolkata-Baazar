// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolkatabaazar2/screens/payment.dart';

import 'home.dart';
import 'productscreen.dart';

var amount = 0.0;

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (_, index) {
          data[cartItems[index]]['count'] = 6.obs;
          var price = double.parse(data[cartItems[index]]['price']);
          amount = amount + price * 6;
          print(amount);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Image.network("${data[cartItems[index]]['imageURL']}"),
                ),
                Text(
                  "${data[cartItems[index]]['name']} \nRs. ${data[cartItems[index]]['price']}",
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    IconButton(
                      onPressed: () {
                        print(data[cartItems[index]]['count']);
                        setState(() {
                          data[cartItems[index]]['count']--;
                        });
                      },
                      icon: const Icon(Icons.remove_circle),
                    ),
                    Obx(() => Text('${data[cartItems[index]]['count']}')),
                    IconButton(
                      onPressed: () {
                        print(data[cartItems[index]]['count']);
                        setState(() {
                          data[cartItems[index]]['count']++;
                        });
                      },
                      icon: const Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => CheckoutWindow());
          },
          child: Text('Amount: Rs. $amount    Next'),
        ),
      ),
    );
  }
}
