import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/Provider/Music_provider.dart';
import 'package:music_player_app/Provider/search_provider.dart';
import 'package:music_player_app/View/Home_Screen.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    var musicProvide=Provider.of<MusicProvider>(context);

    void changeSong(double first,double second)
    async {
      if(musicProvide.repeat==true)
        {
          if(first==second)
          {
            final data=musicProvide.songModel!.data.results[musicProvide.nextSong];
            musicProvide.setSong(data);
            await musicProvide.setMusic(data.downloadUrl[1].url);
            musicProvide.player.play();
            musicProvide.isSong=true;
          }
        }
      else
        {
          if(first==second)
          {
            final data=musicProvide.songModel!.data.results[musicProvide.nextSong+1];
            musicProvide.setSong(data);
            await musicProvide.setMusic(data.downloadUrl[1].url);
            musicProvide.player.play();
            musicProvide.isSong=true;
            musicProvide.nextSong=musicProvide.nextSong+1;
          }
        }
    }

    num checkSong(double firstSong,double secondSong)
    {
      changeSong(firstSong, secondSong);
      return secondSong;
    }
    var songProvider=Provider.of<SearchProvider>(context);
    return Consumer<MusicProvider>(
      builder:(context, provider, child) =>  SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {
                  tabController.animateTo(0);
                }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
                Text('${provider.result!.album.name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                IconButton(onPressed: () {
                  songProvider.likedData.add(provider.result!);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(CupertinoIcons.headphones,color: Color(0xff6156e1),),
                        Text(
                          "  Added to Liked Songs",
                          style: TextStyle(color: Color(0xff6156e1),fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.white,
                    action: SnackBarAction(
                        label: 'Undo',
                        textColor: Color(0xff6156e1),
                        onPressed: () {}),
                  ));
                }, icon: Icon(Icons.favorite,color: Colors.white,size: 25,)),
              ],
            ),
            Container(
              height: 370,
              width: 350,
              margin: EdgeInsets.only(top: 35,bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(image: NetworkImage('${provider.result!.image[2].url}'),fit: BoxFit.cover)
              ),
            ),
            Text(provider.result!.name,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w500),),
            Text(provider.result!.artists.primary[0].name,style: TextStyle(color: Colors.white,fontSize: 20),),
            SizedBox(
              height: 40,
            ),
            StreamBuilder(stream: provider.getCurrentPosition(), builder: (context, snapshot) =>(snapshot.data==null)?Text('data'):
                Column(
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Slider(
                          max: provider.duration!.inSeconds.toDouble()??0,
                          value: snapshot.data!.inSeconds.toDouble()??1,
                          onChanged: (value) {
                        provider.jumpSong(Duration(seconds: value.toInt()));
                      },),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${provider.duration!.inMinutes.toDouble()}',style: TextStyle(color: Colors.white,fontSize: 15,),),
                          Text('${checkSong(provider.duration!.inSeconds.toDouble(), snapshot.data!.inSeconds.toDouble())}',style: TextStyle(color: Colors.white,fontSize: 15,),),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.shuffle,color: Colors.white,)),
                Spacer(),
                IconButton(onPressed: () async {
                  final data=provider.songModel!.data.results[provider.nextSong-1];
                  provider.setSong(data);
                  await provider.setMusic(data.downloadUrl[1].url);
                  provider.player.play();
                  provider.isSong=true;
                  provider.nextSong=provider.nextSong-1;
                }, icon: Icon(Icons.skip_previous_outlined,color: Colors.white,size: 38,)),
                Container(
                  height: 65,
                  width: 65,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff6156e1),
                    boxShadow: [
                      BoxShadow(color: Colors.white12,blurRadius: 7,spreadRadius: 3)
                    ]
                  ),
                  alignment: Alignment.center,
                  child:  IconButton(onPressed: () {
                    provider.checkSong();
                  }, icon: (provider.isSong==true)?Icon(Icons.pause_sharp,color: Colors.white,size: 40,):Icon(Icons.play_arrow,color: Colors.white,size: 35,)),
                ),
                IconButton(onPressed: () async {
                  // provider.songModel!.data.results[0]
                  final data=provider.songModel!.data.results[provider.nextSong+1];
                  provider.setSong(data);
                  await provider.setMusic(data.downloadUrl[1].url);
                  provider.player.play();
                  provider.isSong=true;
                  provider.nextSong=provider.nextSong+1;
                }, icon: Icon(Icons.skip_next_outlined,color: Colors.white,size: 38,)),
                Spacer(),
                IconButton(onPressed: () {
                  provider.repeateSong();
                }, icon: Icon(CupertinoIcons.repeat,color: (provider.repeat==true)?Color(0xff6156e1):Colors.white,)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
