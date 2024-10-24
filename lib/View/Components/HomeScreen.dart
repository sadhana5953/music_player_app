import 'dart:math';
import 'package:flutter/material.dart';
import 'package:music_player_app/Provider/Music_provider.dart';
import 'package:music_player_app/View/Home_Screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    int value=0;
    int songs(int length)
    {
      var random = Random();
      int randomNumber = random.nextInt(length);
      value=randomNumber;
      return randomNumber;
    }
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Consumer<MusicProvider>(
        builder: (context, provider, child) {
          final data=provider.songModel!.data.results;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage('https://play-lh.googleusercontent.com/LeX880ebGwSM8Ai_zukSE83vLsyUEUePcPVsMJr2p8H3TUYwNg-2J_dVMdaVhfv1cHg'),
                  ),
                  Text('  Chaudhary Sadhana',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                  Spacer(),
                  Icon(Icons.notifications_none,color: Colors.white,)
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  Text('Listen The\nLatest Musics',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27),),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      tabController.animateTo(2);
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff130f34),width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 15,),
                        Icon(Icons.search,color: Colors.white,),
                        Text('  Search Music',style: TextStyle(color: Colors.white),),
                      ],),
                    ),
                  )
                ],
              ),
              Text('\nNew Release',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(data.length, (index) =>  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () async {
                        provider.setSong(data[index]);
                        await provider.setMusic(data[index].downloadUrl[1].url);
                        provider.player.play();
                        provider.isSong=true;
                        provider.nextSong=index;
                        tabController.animateTo(1);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 120,
                            margin: EdgeInsets.only(top: 10,bottom: 10,right: 15),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              image: DecorationImage(image: NetworkImage('${data[index].image[2].url}'),fit: BoxFit.cover,opacity: 0.55),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Icon(Icons.play_arrow,color: Colors.white,),
                          ),
                          Text('${data[index].name}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                          Text('${data[index].artists.primary[0].name}',style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),),
                ),
              ),
              Text('\nRecommended Artist',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(data.length, (index) => Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 7),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black,width: 5),
                              image: DecorationImage(image: NetworkImage('${data[index].artists.primary[0].image[2].url}'),fit: BoxFit.cover),
                            ),
                          ),
                          Text('${data[index].artists.primary[0].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),),
                  ),
                ),
              ),
              Text('\nRecommended for you',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 22),),
              SingleChildScrollView(
                child: Column(
                  children: List.generate(data.length, (index) {
                    songs(data.length);
                    return GestureDetector(
                      onTap: () async {
                        provider.setSong(data[value]);
                        await provider.setMusic(data[value].downloadUrl[1].url);
                        provider.player.play();
                        provider.isSong=true;
                        Navigator.of(context).pushNamed('/music');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 10,bottom: 10,right: 15),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              image: DecorationImage(image: NetworkImage('${data[value].image[2].url}'),fit: BoxFit.cover,opacity: 0.95),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data[value].name}',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,),
                              Text('${data[value].artists.primary[0].name}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),),
                              SizedBox(height: 5,),
                              Text('${data[value].duration}k Stream',style: TextStyle(color: Colors.white,fontSize: 15),),
                            ],
                          ),
                        ],
                      ),
                    );
                  },),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

