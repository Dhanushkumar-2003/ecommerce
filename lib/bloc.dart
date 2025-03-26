import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/ProductBlock.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(FetchProducts());
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.products.length,
              itemBuilder: (context, index) {
                final product = state.products;
                return ListTile(
                  title: Text(
                      product.products[index].availabilityStatus.toString()),
                  //  subtitle: "),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
