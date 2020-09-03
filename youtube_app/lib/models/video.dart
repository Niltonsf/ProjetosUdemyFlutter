class Video{
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({this.id, this.channel, this.thumb, this.title});

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumb: json['snippet']['thumbnails']['high']['url'],
      channel: json['snippet']['channelTitle']
    );
  }
}