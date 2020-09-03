import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_app/models/video.dart';

const API_KEY = 'AIzaSyBYQ3IKycBm-DE7Hls-0YY5DDycbeNo_EI';

class Api {

  search(String search) async{
    http.Response response = await http.get(
      "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"
    );
  }

  List<Video> decode(http.Response response){
    if(response.statusCode == 200){
      var decoded = json.decode(response.body);

      List<Video> videos = decoded['items'].map<Video>(
        (map){
          return Video.fromJson(map);
        }
      ).toList();
    } else {
      throw Exception('Failed to load data!');
      
    }
  }
}