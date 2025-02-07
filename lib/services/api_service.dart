import 'dart:convert';  
import 'package:http/http.dart' as http;  
import '../models/product.dart';  
import '../models/user.dart';  

class ApiService {  
  Future<String> verifyUser(String phoneNumber) async {  
    final response = await http.post(  
      Uri.parse('https://admin.kushinirestaurant.com/api/verify/'),  
      headers: {'Content-Type': 'application/json'},  
      body: jsonEncode({'phone_number': phoneNumber}),  
    );  

    if (response.statusCode == 200) {  
      final data = jsonDecode(response.body);  
      return data['otp']; 
    } else {  
      throw Exception('Failed to verify user');  
    }  
  }  

  Future<List<Product>> fetchProducts() async {  
    final response = await http.get(  
      Uri.parse('https://admin.kushinirestaurant.com/api/products/')  
    );  

    if (response.statusCode == 200) {  
      final List jsonResponse = jsonDecode(response.body);  
      return jsonResponse.map((product) => Product.fromJson(product)).toList();  
    } else {  
      throw Exception('Failed to load products');  
    }  
  }  
 
  Future<User> fetchUserProfile(String token) async {  
    final response = await http.get(  
      Uri.parse('user-data/'),  
      headers: {'Authorization': 'Bearer $token'},  
    );  

    if (response.statusCode == 200) {  
      final data = jsonDecode(response.body);  
      return User(name: data['name'], phoneNumber: data['phone_number']);  
    } else {  
      throw Exception('Failed to load user profile');  
    }  
  }  
}