import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/product_model.dart';

import 'package:http/http.dart' as http;

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Cartproduct products;
  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  final List<Product> additem = [];
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<AddToCart>((AddToCart event, emit) {
      // final cartItems = List.from((state));
      additem.add(event.product);
      print("CARTITEM>>$additem");
      //  emit(CartLoaded(additem));
      // emit(CartLoaded([event.product]));
    });

    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        print("STEP1>>>>");
        var products = await repository.fetchproduct();
        print("STEP1>>>>$products");

        emit(ProductLoaded(products));
      } catch (e) {
        print("erroer>>$e");
        emit(ProductError("Failed to fetch products$e"));
      }
    });
    on<CartProduct>((event, emit) async {
      print("step11>>");
      emit(ProductLoading());

      try {
        print("ADDITEMM$additem");
        emit(CartLoaded(additem));
      } catch (e) {
        print("erroer>>$e");
        emit(ProductError("Failed to fetch products$e"));
      }
    });
  }
}

class AddToCart extends ProductEvent {
  final Product product;

  AddToCart(this.product);
}

class RemoveFromCart extends ProductEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class ClearCart extends ProductEvent {}

class CartInitial extends ProductState {}

class CartLoaded extends ProductState {
  final List<Product> cartItems;
  CartLoaded(this.cartItems);
}

class CartProduct extends ProductEvent {}

class ProductRepository {
  Future<Cartproduct> fetchproduct() async {
    print("object");
    try {
      final uri = Uri.parse('https://dummyjson.com/products');
      print("object>>>$uri");
      final response = await http.get(uri);
      print("object>>>$response");
      if (response.statusCode == 200) {
        var productsvalue = jsonDecode(response.body);
        print("PRODUCT>>>>${productsvalue}");

        var productdetail = Cartproduct.fromJson(productsvalue);
        ;
        print(
            "PRODUCTDEATIL>>>>${productdetail.products[2].availabilityStatus}");
        var ak = productdetail;
        print("AKKKKKKKK>>>${ak}");
        return ak;
        // return productdetail;
        // return product;
      } else {
        throw Exception('Failed to update album.');
      }
    } catch (e) {
      print("error>>>>$e");
      throw Exception("Network Error: ${e.toString()}");
    }
  }

  Future<List<Product>> fetchproducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
            "Failed to load products (Error ${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Network Error: ${e.toString()}");
    }
  }
}
