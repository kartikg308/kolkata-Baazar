// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'dart:convert';
import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:kolkatabaazar/models/cart_model.dart';

// ignore: must_be_immutable
class CheckoutWindow extends StatelessWidget {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String zipcode = '';
  String city = '';

  CheckoutWindow({Key? key}) : super(key: key);

  Future<void> sendData(name, email, phone, address, zipcode, city) async {
    try {
      var url =
          'https://kolkata-baazar-2db9b-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
      var response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'email': email,
          'phone': phone,
          "address": address,
          "zipcode": zipcode,
          "city": city
        }),
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> data = {};

  Map<dynamic, dynamic> res = {};

  Future<void> requestToken(amount, name, phone, email, orderid) async {
    var url = 'https://test.cashfree.com/api/v2/cftoken/order';
    var response = await http.post(Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json",
          "x-client-id": "949807cdea5151adb072fae9a08949",
          "x-client-secret": "7ffceefa813434df9a4f2bb9538e496017888812",
        },
        body: jsonEncode(<String, String>{
          "orderId": "$orderid",
          "orderAmount": "$amount",
          "orderCurrency": "INR",
        }));
    if (response.statusCode == 200) {
      print(response.body);
      data = jsonDecode(response.body);
      Map<String, dynamic> params = {
        "orderId": "$orderid",
        "orderAmount": "$amount",
        "appId": "949807cdea5151adb072fae9a08949",
        "orderCurrency": "INR",
        "customerName": "$name",
        "customerPhone": "$phone",
        "customerEmail": "$email",
        "stage": "TEST",
        "tokenData": "${data["cftoken"]}",
      };
      print(data["cftoken"]);
      CashfreePGSDK.doPayment(params)
          .then((value) => value?.forEach((key, value) {
                res["$key"] = "$value";
                print(res["$key"]);
                //Do something with the result
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.streetAddress,
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          city = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Zip Code',
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 6,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          zipcode = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Phone No',
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          phone = value;
                        },
                      ),
                    ),
                    // OrderSummary(),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print(
                              "$name  $email  $address  $phone  $zipcode  $city");
                          if (name.length > 2 &&
                              email.length > 10 &&
                              address.length > 10 &&
                              zipcode.length == 6 &&
                              phone.length == 10 &&
                              city.length > 4) {
                            print('true');
                            const chars =
                                'AaBbCcdDEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                            var random = Random.secure();
                            var value = List<int>.generate(
                                15, (index) => random.nextInt(255));
                            print(base64UrlEncode(value));
                            // print(amount);
                            sendData(
                                name, email, phone, address, zipcode, city);

                            // requestToken(amount, name, phone, email,
                            //     base64UrlEncode(value));
                          } else {
                            print('please supply valid data');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please fill all the reuired fields'),
                              ),
                            );
                          }
                          // requestToken();
                        },
                        child: const Text('Proceed to Pay'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
