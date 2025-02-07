import 'package:flutter/material.dart';
import 'package:flutterexam/screens/login_screen.dart';
import 'package:provider/provider.dart';  
import 'product_provider.dart'; 

void main() {  
  runApp(  
    ChangeNotifierProvider(  
      create: (_) => ProductProvider(),  
      child: MyApp(),  
    ),  
  );  
}  

class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(
      home: LoginPage(),
    );  
  }  
}