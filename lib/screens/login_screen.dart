import 'package:flutter/material.dart';  
import 'package:flutterexam/screens/otpscreen.dart';  
import 'package:http/http.dart' as http;  
import 'dart:convert';  

class LoginPage extends StatefulWidget {  
  @override  
  _LoginPageState createState() => _LoginPageState();  
}  

class _LoginPageState extends State<LoginPage> {  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();  
  final TextEditingController phoneController = TextEditingController();  
  bool _isLoading = false;  

  Future<void> submitPhoneNumber() async {  
    if (formKey.currentState!.validate()) {  
      setState(() {  
        _isLoading = true;  
      });  

      String phoneNumber = phoneController.text.trim();  

      var response = await http.post(  
        Uri.parse('https://admin.kushinirestaurant.com/api/login-register/'),  
        headers: {'Content-Type': 'application/json'},  
        body: json.encode({"phone_number": phoneNumber}),  
      );  

      setState(() {  
        _isLoading = false;  
      });  
  
      print('Response body: ${response.body}');  

      if (response.statusCode == 200) {  
        var data = json.decode(response.body);  

        if (data['user_id'] != null) {  
          String accessToken = data['token']['access'];

          Navigator.push(  
            context,  
            MaterialPageRoute(  
              builder: (context) => OtpScreen(phoneNumber: phoneNumber, token: accessToken),  
            ),  
          );  
        } else {  
          showErrorDialog('User does not exist. Please register.');  
        }  
      } else {  
        showErrorDialog('Error verifying user: ${response.statusCode}');  
      }  
    }  
  }  

  void showErrorDialog(String message) {  
    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          content: Text(message),  
          actions: [  
            TextButton(  
              onPressed: () => Navigator.of(context).pop(),  
              child: Text('OK'),  
            ),  
          ],  
        );  
      },  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: Text('Login')),  
      body: Padding(  
        padding: EdgeInsets.all(16.0),  
        child: Form(  
          key: formKey,  
          child: Column(  
            children: [  
              TextFormField(  
                controller: phoneController,  
                decoration: InputDecoration(labelText: 'Phone Number'),  
                keyboardType: TextInputType.phone,  
                validator: (value) {  
                  return value!.isEmpty ? 'Please enter a phone number' : null;  
                },  
              ),  
              SizedBox(height: 20),  
              _isLoading  
                  ? CircularProgressIndicator()  
                  : ElevatedButton(  
                      onPressed: submitPhoneNumber,  
                      child: Text('Submit'),  
                    ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}