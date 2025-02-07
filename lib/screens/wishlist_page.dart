import 'package:flutter/material.dart';
import 'package:flutterexam/widgets/product_card.dart';  
import 'package:provider/provider.dart';   
import '../product_provider.dart';  


class WishlistPage extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    // Access the ProductProvider to get the wishlist products  
    final productProvider = Provider.of<ProductProvider>(context);  
    final wishlistProducts = productProvider.wishlist;  

    return Scaffold(  
      appBar: AppBar(  
        title: Text('Wishlist'),  
      ),  
      body: wishlistProducts.isEmpty  
          ? Center(child: Text('Your wishlist is empty.'))  
          : ListView.builder(  
              itemCount: wishlistProducts.length,  
              itemBuilder: (context, index) {  
                return ProductCard(product: wishlistProducts[index]);  
              },  
            ),  
    );  
  }  
}