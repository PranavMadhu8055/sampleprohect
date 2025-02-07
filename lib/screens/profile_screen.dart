import 'package:flutter/material.dart';  
import '../services/api_service.dart';  

class ProfileScreen extends StatelessWidget {  
  final ApiService apiService = ApiService();   
  final String token = 'your_jwt_token_here';  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text('Profile')),  
      body: FutureBuilder(  
        future: apiService.fetchUserProfile(token),  
        builder: (context, snapshot) {  
          if (snapshot.connectionState == ConnectionState.waiting) {  
            return Center(child: CircularProgressIndicator());  
          } else if (snapshot.hasError) {  
            return Center(child: Text('Error: ${snapshot.error}'));  
          } else {  
            final user = snapshot.data; // User object  
            return Padding(  
              padding: const EdgeInsets.all(16.0),  
              child: Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text('Name: ${user?.name}', style: TextStyle(fontSize: 20)),  
                  SizedBox(height: 8),  
                  Text('Phone: ${user?.phoneNumber}', style: TextStyle(fontSize: 20)),  
                ],  
              ),  
            );  
          }  
        },  
      ),  
    );  
  }  
}