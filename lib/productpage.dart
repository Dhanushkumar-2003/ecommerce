import 'dart:convert';
import 'dart:math';
import 'dart:math';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intern/ProductBlock.dart';
import 'package:intern/cart.dart';
import 'package:intern/product_model.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  // Future<Cartproduct> fetchproduct() async {
  //   final uri = Uri.parse('https://dummyjson.com/products');
  //   final response = await http.get(uri);

  //   if (response.statusCode == 200) {
  //     var productsvalue = jsonDecode(response.body);
  //     print("PRODUCT>>>>${productsvalue}");

  //     var productdetail = Cartproduct.fromJson(productsvalue);
  //     ;
  //     print("PRODUCTDEATIL>>>>${productdetail.products[2].availabilityStatus}");
  //     var ak = productdetail;
  //     print("AKKKKKKKK>>>${ak}");
  //     return ak;
  //     // return productdetail;
  //     // return product;
  //   } else {
  //     throw Exception('Failed to update album.');
  //   }
  //   print("object");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 246, 188, 207),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(Icons.shopping_cart),
            )
          ],
          title: Text('catalogue'),
        ),
        body: Container(
          color: Color.fromARGB(255, 246, 188, 207),
          child:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            if (state is ProductInitial) {
              context.read<ProductBloc>().add(FetchProducts());
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return Container(
                child: GridView.builder(
                  itemCount: state.products.products.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 1,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    final random = Random();
                    int randomNumber = random.nextInt(100);
                    var productdata = state.products.products[index];
                    return Container(
                      margin: EdgeInsets.only(right: 0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, bottom: 10, right: 0),
                                width: double.infinity,
                                color: Colors.black,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        Container(
                                          // height: 300,
                                          // color: Colors.white,
                                          child: Image(
                                            width: 200,
                                            height: 150,
                                            image: NetworkImage(productdata
                                                .images![0]
                                                .toString()),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Positioned(
                                            top: 110,
                                            right: 20,
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<ProductBloc>().add(
                                                    AddToCart(productdata));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                width: 66,
                                                height: 35,
                                                child: Center(
                                                    child: Text(
                                                  'Add',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Color(0xFFD85880)),
                                                )),
                                              ),
                                            ))
                                      ]),
                                      Container(
                                        width: double.infinity,
                                        height: 97,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                productdata.title.toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              productdata.brand.toString(),
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "₹${(productdata.price! + randomNumber).toString()}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "₹${(productdata.price!).toString()}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "₹${(productdata.discountPercentage!).toString()}% OFF",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      )
                                    ])),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return CircularProgressIndicator();
          }),
        ));
  }
}
