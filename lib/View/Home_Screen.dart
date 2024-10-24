import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/View/Components/HomeScreen.dart';
import 'package:music_player_app/View/Components/LibraryScreen.dart';
import 'package:music_player_app/View/Components/SearchScreen.dart';
import 'package:music_player_app/View/Music_page.dart';
import 'package:provider/provider.dart';

import '../Provider/Music_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 55,right: 17,left: 17),
        decoration: BoxDecoration(
          color: Color(0xff0a071e),
        ),
        alignment: Alignment.centerLeft,
        child: Provider.of<MusicProvider>(context).songModel==null?Center(child: CircularProgressIndicator(),):Stack(
          children: [
            TabBarView(
              controller: tabController,
              children: [
                HomePage(),
                MusicPage(),
                SearchScreen(),
                Libraryscreen(),
              ],
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff0a071e),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35),),
                    boxShadow: [
                      BoxShadow(color: Colors.white12,spreadRadius: 2.5,blurRadius: 5)
                    ]
                  ),
                  child: TabBar(tabs: [
                    Tab(icon: Icon(Icons.home_outlined,size: 33,),),
                    Tab(icon: Icon(CupertinoIcons.music_note_2,size: 30,),),
                    Tab(icon: Icon(Icons.search,size: 33,),),
                    Tab(icon: Icon(Icons.library_music_outlined,size: 33,),),
                  ],
                    dividerColor: Color(0xff0a071e),
                    indicatorColor:Color(0xff0a071e),
                    unselectedLabelColor: Colors.white38,
                    controller: tabController,),
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}

late TabController tabController;
