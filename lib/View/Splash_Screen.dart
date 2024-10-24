import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xff0a071e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
                image: DecorationImage(image: NetworkImage('https://www.icegif.com/wp-content/uploads/2024/01/icegif-109.gif')),
              ),
            ),
            Text('\nGetting Started',style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            Text('Getting Started Getting',style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: Container(
                height: 45,
                width: 120,
                margin: EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Color(0xff6156e1),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("Let's go ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),
                    Icon(Icons.music_note,color: Colors.white,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
