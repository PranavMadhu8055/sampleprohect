import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _wishlist = [];
  bool _isLoading = false;
  String? _errorMessage; 

  List<Product> get products => _products;
   List<Product> get wishlist => _wishlist;  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; 

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null; 
    notifyListeners(); 

    try {
      final response = await http.get(
        Uri.parse('https://admin.kushinirestaurant.com/api/products/'),
        headers: {
          'Content-Type': 'application/json', 
         
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        _products = jsonData.map((product) => Product.fromJson(product)).toList();
      } else {
        _errorMessage = 'Failed to load products: ${response.statusCode}';
        notifyListeners(); 
        return; 
      }
    } catch (e) {
      _errorMessage = 'Error occurred: $e';
      notifyListeners(); 
    } finally {
      _isLoading = false;
      notifyListeners(); 
    }
  }
  void toggleWishlist(Product product) {  
    if (_wishlist.contains(product)) {  
      _wishlist.remove(product);  
    } else {  
      _wishlist.add(product);  
    }  
    notifyListeners();  
  } 
   bool isInWishlist(Product product) {  
    return _wishlist.contains(product);  
  } 
  Future<void> fetchWishlist() async {  
    final url = 'https://admin.kushinirestaurant.com/api/wishlist/';  
    final response = await http.get(  
      Uri.parse(url),  
    
    );  

    if (response.statusCode == 200) {   
      final List<dynamic> data = json.decode(response.body);  
      _wishlist = data.map((product) => Product.fromJson(product)).toList();  
      notifyListeners();  
    }  
  }  
}
