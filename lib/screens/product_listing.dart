import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterexam/product_provider.dart'; // Import your ProductProvider
import 'package:flutterexam/widgets/product_card.dart';

class ProductListing extends StatefulWidget {
  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<ProductProvider>(context, listen: false).fetchProducts();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) => Container(
          color: Colors.white,
          width: size.width,
          height: size.height,
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: value.products[index]);
            },
          ),
        ),
      ),
    );
  }
}
