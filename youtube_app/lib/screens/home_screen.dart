import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_app/blocks/videos_bloc.dart';
import 'package:youtube_app/delegates/data_search.dart';
import 'package:youtube_app/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        centerTitle: false,
        title: Container(
          height: 100,
          width: 120,
          child: Image.asset('images/yt_logo_rgb_dark.png'),
        ),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(
            icon: Icon(Icons.star, color: Colors.white,),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white,),
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
              if (result != null) BlocProvider.of<VideosBloc>(context).inSearch.add(result);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                return VideoTile(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}