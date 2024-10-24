import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/Model/SearchModel.dart';
import 'package:music_player_app/Provider/Music_provider.dart';
import 'package:music_player_app/Provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../Home_Screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<SearchProvider>(context);
    var songProvider=Provider.of<MusicProvider>(context);
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage('https://play-lh.googleusercontent.com/LeX880ebGwSM8Ai_zukSE83vLsyUEUePcPVsMJr2p8H3TUYwNg-2J_dVMdaVhfv1cHg'),
            ),
            Text('  Search',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
            Spacer(),
            Icon(Icons.camera_alt_outlined,color: Colors.white,)
          ],
        ),
        SizedBox(height: 15,),
        TextFormField(
          controller: txtSearch,
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            provider.searchSong(value);
            provider.getData();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(CupertinoIcons.search,color: Colors.white,),
            suffixIcon: IconButton(onPressed: () {
              provider.searchSong('');
              provider.getData();
              txtSearch.clear();
            }, icon: Icon(Icons.cancel_outlined,color: Colors.white,)),
            hintText: 'What do you want to listen to?',
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.white54,width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: Colors.white,width: 2),
            ),
          ),
        ),
        Consumer<SearchProvider>(builder: (context, provider, child) => (provider.searchModel==null||provider.search==''&&provider.listOfSearch.length==0)?
        Column(
          children: [
            SizedBox(height: 270,),
            Text('Play what you love',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),),
            Text('Search for artists, songs, prodcasts, and\nmore.',style: TextStyle(
              color: Colors.white54,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),textAlign: TextAlign.center,),
          ],
        )
            :(provider.search!='')?Expanded(child: ListView.builder(itemCount:provider.searchModel!.data.results.length,itemBuilder: (BuildContext context, int index) {
              final data=provider.searchModel!.data.results;
             return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  onTap: () async {
                   // SearchModel m1=SearchModel(img: data[index].image[2].url, name: data[index].name, singer: data[index].artists.primary[0].name,num: index);
                    provider.listOfSearch.add(data[index]);
                    songProvider.setSong(data[index]);
                    await songProvider.setMusic(data[index].downloadUrl[1].url);
                    songProvider.player.play();
                    songProvider.isSong=true;
                    songProvider.nextSong=index;
                    tabController.animateTo(1);
                    provider.searchSong('');
                    provider.getData();
                    txtSearch.clear();
                  },
                  leading: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(image: NetworkImage('${data[index].image[2].url}'),fit: BoxFit.cover,),
                    ),
                  ),
                  title: Text('${data[index].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                  subtitle: Text('Singer - ${data[index].artists.primary[0].name}',style: TextStyle(color: Colors.white54,fontSize: 15,fontWeight: FontWeight.w500),),
                ),
              );
        },))
            :Column(
          children: [
            SizedBox(height: 15,),
            Row(
              children: [
                Text('Recent Searches',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),
              ],
            ),
            Column(
              children: List.generate(provider.listOfSearch.length, (index) =>  Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  onTap: () async {
                    final data=provider.listOfSearch[index];
                    songProvider.setSong(data);
                    await songProvider.setMusic(data.downloadUrl[1].url);
                    songProvider.player.play();
                    songProvider.isSong=true;
                    songProvider.nextSong=index;
                    tabController.animateTo(1);
                  },
                  leading: Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(image: NetworkImage('${provider.listOfSearch[index].image[2].url}'),fit: BoxFit.cover,),
                    ),
                  ),
                  title: Text('${provider.listOfSearch[index].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                  subtitle: Text('Singer - ${provider.listOfSearch[index].artists.primary[0].name}',style: TextStyle(color: Colors.white54,fontSize: 15,fontWeight: FontWeight.w500),),
                  trailing: IconButton(onPressed: () {
                    provider.removeData(index);
                  }, icon: Icon(Icons.cancel,color: Colors.white,)),
                ),
              ),),
            )

          ],
        ),
        ),

      ],
    );
  }
}

var txtSearch=TextEditingController();