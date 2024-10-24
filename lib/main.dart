import 'package:flutter/material.dart';
import 'package:music_player_app/Provider/Music_provider.dart';
import 'package:music_player_app/Provider/search_provider.dart';
import 'package:music_player_app/View/Home_Screen.dart';
import 'package:music_player_app/View/Music_page.dart';
import 'package:music_player_app/View/Splash_Screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => MusicProvider(),),
        ChangeNotifierProvider(create: (context) => SearchProvider(),),
      ],
        builder: (context, child) =>  MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/':(context)=>SplashScreen(),
            '/home':(context)=>HomeScreen(),
            '/music':(context)=>MusicPage(),
          },
        ),
    );
  }
}


