import 'package:flutter/material.dart';
import 'package:kolkatabaazar2/widgets/widgets.dart';

import 'screens.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.0),
        itemCount: data1.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            data: data[data1[index]], data1: data1[index],
          );
        },
      ),
    );
  }
}
