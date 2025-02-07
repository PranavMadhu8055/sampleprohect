import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../product_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with error handling
          Image.network(
            product.featuredImage,
            height: 100, // Adjust the height according to your needs
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Icon(Icons.error); // Display an error icon if the image fails to load
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  '\$${product.salePrice.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.green),
                ),
                if (product.mrp > product.salePrice) // Show MRP if applicable
                  Text(
                    '\$${product.mrp.toStringAsFixed(2)}',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        product.inWishlist ? Icons.favorite : Icons.favorite_border,
                        color: product.inWishlist ? Colors.red : null,
                      ),
                      onPressed: () {
                                      Provider.of<ProductProvider>(context, listen: false)  
                  .toggleWishlist(product);  
                                },
                    ),
                    Text(
                      '${product.avgRating} ★', // Show average rating
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}