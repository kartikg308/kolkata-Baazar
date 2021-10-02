// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kolkatabaazar2/screens/screens.dart';
import 'package:kolkatabaazar2/widgets/widgets.dart';

Map<dynamic, dynamic> data = {}.obs;
var data1 = [].obs;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> getData() async {
    try {
      var url =
          'https://kolkata-baazar-2db9b-default-rtdb.asia-southeast1.firebasedatabase.app/products.json';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body);
          for (var i in data.keys) {
            data1.add(i);
          }
        });
        // ignore: avoid_print
        print(data1);
        // ignore: avoid_print
        print(response.body);
      } else {
        // ignore: avoid_print
        print(response.body);
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/small/pexels-shazaf-zafar-9064117.jpg',
      'assets/small/pexels-andrea-piacquadio-840916.jpg',
      'assets/small/pexels-caique-silva-806261.jpg',
      'assets/small/pexels-eren-li-7169614.jpg',
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          // child: Text(
                          //   'No. ${imgList.indexOf(item)} image',
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kolkata Baazar'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text('My Orders'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.favorite_outline),
                title: Text('My Wishlist'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.delivery_dining),
                title: Text('Delivery'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('My Profile'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatarCategory(
                      imageURL: 'assets/small/pexels-shazaf-zafar-9064117.jpg',
                      title: 'All Categories',
                      widget: AllCategories(),
                    ),
                    CircleAvatarCategory(
                      imageURL:
                          'assets/small/pexels-andrea-piacquadio-840916.jpg',
                      title: 'Mens Fashion',
                      widget: MensFashion(),
                    ),
                    CircleAvatarCategory(
                      imageURL: 'assets/small/pexels-caique-silva-806261.jpg',
                      title: 'Womens Fashion',
                      widget: WomensFashion(),
                    ),
                    CircleAvatarCategory(
                      imageURL: 'assets/small/pexels-eren-li-7169614.jpg',
                      title: 'Kids Fashion',
                      widget: KidsFashion(),
                    ),
                  ],
                ),
              ),
            ),
            Carousels(imageSliders: imageSliders),
            TitleText(
              title: 'Mens Fashion',
            ),
            ProductList(),
            TitleText(
              title: 'Womens Fashion',
            ),
            ProductList(),
            TitleText(
              title: 'Kids Fashion',
            ),
            ProductList(),
            TitleText(
              title: 'Hot Deals',
            ),
            ProductList(),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data1.length,
        itemBuilder: (context, index) {
          return ProductCard(
            data: data[data1[index]],
            data1: data1[index].toString(),
          );
        },
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
