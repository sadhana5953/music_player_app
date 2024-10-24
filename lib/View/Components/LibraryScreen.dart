import 'package:flutter/material.dart';
import 'package:music_player_app/Provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../../Provider/Music_provider.dart';
import '../Home_Screen.dart';

class Libraryscreen extends StatelessWidget {
  const Libraryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder:(context, provider, child) {
        final data=provider.likedData;
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
                Text('  Your Library',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),),
                Spacer(),
                Icon(Icons.add,color: Colors.white,)
              ],
            ),
            Divider(color: Colors.white,thickness: 0.5,),
            data.length==0?
            Column(
              children: [
                SizedBox(height: 350,),
                Text('Add music and prodcasts',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),
                Text('Collect your favourites so you can listen whenever\n you want',style: TextStyle(
                  color: Colors.white54,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),textAlign: TextAlign.center,),
              ],
            )
                :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Liked Songs',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                      ),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: List.generate(data.length, (index) =>  ListTile(
                      onTap: () async {
                        songProvider.setSong(data[index]);
                        await songProvider.setMusic(data[index].downloadUrl[1].url);
                        songProvider.player.play();
                        songProvider.isSong=true;
                        songProvider.nextSong=index;
                        tabController.animateTo(1);
                      },
                      leading: Image.network(data[index].image[2].url),
                      title: Text('${data[index].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
                      subtitle: Text('Singer - ${data[index].artists.primary[0].name}',style: TextStyle(color: Colors.white54,fontSize: 15,fontWeight: FontWeight.w500),),
                      trailing: IconButton(onPressed: () {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          backgroundColor: Color(0xff0a071e),
                          title: Text('${data[index].name}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          content: Text('Are you sure you want to remove this song!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                          actions: [
                            TextButton(onPressed: () {
                              Navigator.of(context).pop();
                            }, child: Text('Cancel')),
                            TextButton(onPressed: () {
                              provider.deleteData(index);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Removed from Liked Songs",
                                  style: TextStyle(color: Color(0xff6156e1),fontWeight: FontWeight.bold,fontSize: 16),
                                ),
                                backgroundColor: Colors.white,
                                action: SnackBarAction(
                                    label: 'Undo',
                                    textColor: Color(0xff6156e1),
                                    onPressed: () {}),
                              ));
                              Navigator.of(context).pop();
                            }, child: Text('Delete')),
                          ],
                        ),);
                      }, icon: Icon(Icons.delete_outline,color: Colors.white,)),
                    ),),
                  )

                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
