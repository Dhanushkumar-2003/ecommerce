import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/ProductBlock.dart';
import 'package:intern/product_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(CartProduct()); // Dispatch event only once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 246, 188, 207),
        title: Center(child: Text('Cart')),
      ),
      backgroundColor: Color.fromARGB(255, 246, 188, 207),
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        //
        // context.read<ProductBloc>().add(CartProduct());
        if (state is ProductInitial) {
          context.read<ProductBloc>().add(CartProduct());
        }
        Center(child: CircularProgressIndicator());
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          print("state>>${state.cartItems.length}");
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            color: Color.fromARGB(255, 246, 188, 207),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 246, 188, 207),
                    // width: 400,
                    // height: 600,
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        print("productdata>>");
                        final random = Random();
                        int randomNumber = random.nextInt(100);
                        var productdata = state.cartItems[index];
                        print("productdata>>$productdata");
                        return Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.black,
                                      child: Image(
                                        width: 150,
                                        height: 150,
                                        image: NetworkImage(
                                            productdata.images![0].toString()),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.amber,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              productdata.title.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            Text(
                                              productdata.brand.toString(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "₹${(productdata.price! + randomNumber).toString()}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  "₹${(productdata.price!).toString()}",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              "₹${(productdata.discountPercentage!).toString()}% OFF",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 212, 208, 208),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: EdgeInsets.only(
                                        top: 100,
                                        right: 10,
                                      ),
                                      // width: 100,
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 20,
                                              child: IconButton(
                                                  constraints: BoxConstraints(),
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {},
                                                  icon: Icon(Icons.remove))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFD85880)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(right: 9),
                                              width: 20,
                                              child: IconButton(
                                                  constraints: BoxConstraints(),
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {},
                                                  icon: Icon(Icons.add))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  //  width: double.infinity,
                  height: 100,
                  // margin: EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Amount price'),
                          Text(
                            '₹488',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE01858),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                          'Check Out 5',
                          style: TextStyle(color: Colors.white),
                        )),
                        width: 90,
                        height: 40,
                      ) // Fully opaque)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      }),
    );
    ;
  }
}


// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   _CartPageState createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductBloc>().add(CartProduct()); // Dispatch event only once
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CartLoaded) {
//             print("Cart Loaded: ${state.cartItems.length}");
//             return ListView.builder(
//               itemCount: state.cartItems.length,
//               itemBuilder: (context, index) {
//                 var productData = state.cartItems[index];
//                 print("PRODUCT>>$productData");
//                 return ListTile(
//                   leading: Image.network(productData.images![0]),
//                   title: Text(productData.brand ?? 'Unknown'),
//                   subtitle: Text("₹${productData.price}"),
//                 );
//               },
//             );
//           } else if (state is ProductError) {
//             return Center(child: Text("Error: ${state.message}"));
//           }

//           return Center(child: CircularProgressIndicator()); // Default case
//         },
//       ),
//     );
//   }
// }

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Cart")),
//       body: BlocBuilder<ProductBloc, ProductState>(

//         builder: (context, state) {
//           print("STATE>>$state ");

//             return ListView.builder(
//               itemCount: state.cartItems.length,
//               itemBuilder: (context, index) {
//                 final product = state.cartItems[index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text("\$${product.price}"),
//                 );
//               },
//             );

//           return Center(child: Text("Cart is Empty"));
//         },
//       ),
//     );
//   }
// }
