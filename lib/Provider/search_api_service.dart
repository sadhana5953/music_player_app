import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;

class SearchApiService
{
  Future<Map<String,dynamic>> fetchData(String song)
  async {
    String api="https://saavn.dev/api/search/songs?query=$song" ;
    Uri uri=Uri.parse(api);
    Response response = await http.get(uri);
    if(response.statusCode==200)
    {
      String json=response.body;
      Map<String,dynamic> data=jsonDecode(json);
      return data;
    }
    return {};
  }
}