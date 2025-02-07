import 'package:flutter/material.dart';  
import 'package:flutterexam/screens/home_screen.dart';  
import 'package:http/http.dart' as http;  
import 'dart:convert';  

class OtpScreen extends StatefulWidget {  
  final String phoneNumber;  
  final String token;  

  OtpScreen({required this.phoneNumber, required this.token});  

  @override  
  _OtpScreenState createState() => _OtpScreenState();  
}  

class _OtpScreenState extends State<OtpScreen> {  
  final TextEditingController otpController = TextEditingController();  
  bool _isLoading = false;  

  Future<void> validateOtp() async {  
    setState(() {  
      _isLoading = true;  
    });  

    var response = await http.post(  
      Uri.parse('https://admin.kushinirestaurant.com/api/verify-otp/'),  
      headers: {'Content-Type': 'application/json'},  
      body: json.encode({"otp": otpController.text.trim(), "token": widget.token}),  
    );  

    setState(() {  
      _isLoading = false;  
    });  

    print('OTP Response body: ${response.body}');  

    if (response.statusCode == 200) {  
      var data = json.decode(response.body);  
      if (data['success'] == true) {  
        Navigator.pushReplacement(  
          context,  
          MaterialPageRoute(builder: (context) => HomePage()),  
        );  
      } else {  
        showErrorDialog('Invalid OTP. Please try again.');  
      }  
    } else {  
      showErrorDialog('Error verifying OTP: ${response.statusCode}');  
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
      appBar: AppBar(title: Text('Enter OTP')),  
      body: Padding(  
        padding: EdgeInsets.all(16.0),  
        child: Column(  
          children: [  
            TextFormField(  
              controller: otpController,  
              decoration: InputDecoration(labelText: 'OTP'),  
              keyboardType: TextInputType.number,  
              maxLength: 4,  
            ),  
            SizedBox(height: 20),  
            _isLoading  
                ? CircularProgressIndicator()  
                : ElevatedButton(  
                    onPressed: validateOtp,  
                    child: Text('Verify OTP'),  
                  ),  
          ],  
        ),  
      ),  
    );  
  }  
}