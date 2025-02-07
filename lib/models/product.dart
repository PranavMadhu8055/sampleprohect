class Product {  
  final int id;  
  final String name;  
  final String description;  
  final String featuredImage;  
  final double salePrice;  
  final double mrp;  
  bool inWishlist;  

  final double avgRating;  

  Product({  
    required this.id,  
    required this.name,  
    required this.description,  
    required this.featuredImage,  
    required this.salePrice,  
    required this.mrp,  
    this.inWishlist = false,  
    required this.avgRating,  
  });  

  factory Product.fromJson(Map<String, dynamic> json) {  
    return Product(  
      id: json['id'],  
      name: json['name'],  
      description: json['description'],  
      featuredImage: json['featured_image'],  
      salePrice: json['sale_price'].toDouble(),  
      mrp: json['mrp'].toDouble(),  
      inWishlist: json['in_wishlist'] ?? false,   
      avgRating: json['avg_rating'].toDouble(),  
    );  
  }  
}