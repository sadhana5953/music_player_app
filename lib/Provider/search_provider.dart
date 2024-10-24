import 'package:flutter/material.dart';
import 'package:music_player_app/Model/SearchModel.dart';
import 'package:music_player_app/Provider/search_api_service.dart';

import '../Model/SongModel.dart';

class SearchProvider extends ChangeNotifier
{
  String search='';
  String recentSearch='';
  List<Result> listOfSearch=[];
  List<Result> likedData=[];

  SongModel? searchModel;
  SongModel? searchSongModel;
  Future<void> getData()
  async {
    SearchApiService apiService=SearchApiService();
    Map<String,dynamic> json=await apiService.fetchData(search);
    searchModel=SongModel.fromJson(json);
    notifyListeners();
  }
  Future<void> fetchData()
  async {
    SearchApiService apiService=SearchApiService();
    Map<String,dynamic> json=await apiService.fetchData(recentSearch);
    searchSongModel=SongModel.fromJson(json);
    notifyListeners();
  }

  void removeData(int index)
  {
    listOfSearch.removeAt(index);
    notifyListeners();
  }
  void deleteData(int index)
  {
    likedData.removeAt(index);
    notifyListeners();
  }
  void searchSong(String songs)
  {
    search=songs;
    notifyListeners();
  }
  void playSong(String songs)
  {
    recentSearch=songs;
    notifyListeners();
  }
  SearchProvider()
  {
    getData();
  }
}