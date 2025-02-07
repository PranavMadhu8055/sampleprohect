import 'package:flutter/material.dart';  

class BannerSlider extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    // Mock banners for illustration  
    List<String> bannerImages = [  
      'https://example.com/banner1.jpg',  
      'https://example.com/banner2.jpg',  
      'https://example.com/banner3.jpg',  
    ];  

    return Container(  
      height: 200,  
      child: PageView.builder(  
        itemCount: bannerImages.length,  
        itemBuilder: (context, index) {  
          return Image.network(  
            bannerImages[index],  
            fit: BoxFit.cover,  
          );  
        },  
      ),  
    );  
  }  
}