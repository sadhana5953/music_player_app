import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/Model/SongModel.dart';
import 'package:music_player_app/Provider/api_services.dart';

class MusicProvider extends ChangeNotifier
{
  SongModel? songModel;
  Result? result;
  AudioPlayer player=AudioPlayer();
  bool isSong=false;
  Duration? duration;
  int nextSong=0;
  ConcatenatingAudioSource? playlist;
  bool repeat=false;
  Future<void> getData()
  async {
    ApiServices apiServices=ApiServices();
    Map<String,dynamic> json=await apiServices.fetchData();
    songModel=SongModel.fromJson(json);
    notifyListeners();
  }

  void setSong(Result song)
  {
    result=song;
    notifyListeners();
  }

  Future<void> setMusic(String url)
  async {
    duration=await player.setUrl(url);
    notifyListeners();
  }
  void checkSong()
  {
    isSong=!isSong;
    (isSong==true)?player.play():player.pause();
    notifyListeners();
  }

  Stream<Duration> getCurrentPosition()
  {
    return player.positionStream;
  }
  Future<void> jumpSong(Duration position)
  async {
    await player.seek(position);
    notifyListeners();
  }

  void repeateSong()
  {
    repeat=!repeat;
    notifyListeners();
  }
  MusicProvider()
  {
    getData();
  }
}