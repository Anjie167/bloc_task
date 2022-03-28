// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TrackModel trackModelFromJson(String str) => TrackModel.fromJson(json.decode(str));

String trackModelToJson(TrackModel data) => json.encode(data.toJson());

class TrackModel{
  TrackModel({
    required this.message,
  });

  Message message;

  factory TrackModel.fromJson(Map<String, dynamic> json) => TrackModel(
    message: Message.fromJson(json["message"]),
  );


  Map<String, dynamic> toJson() => {
    "message": message.toJson(),
  };
}
class Header {
  Header({
    required this.statusCode,
    required this.executeTime,
  });

  int statusCode;
  double executeTime;

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    statusCode: json["status_code"],
    executeTime: json["execute_time"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "execute_time": executeTime,
  };
}

class Message {
  Message({
    required this.header,
    required this.body,
  });

  Header header;
  Body body;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    header: Header.fromJson(json["header"]),
    body: Body.fromJson(json["body"]),
  );

  Map<String, dynamic> toJson() => {
    "header": header.toJson(),
    "body": body.toJson(),
  };
}

class Body {
  Body({
    required this.trackList,
  });

  List<TrackList> trackList;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    trackList: List<TrackList>.from(json["track_list"].map((x) => TrackList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "track_list": List<dynamic>.from(trackList.map((x) => x.toJson())),
  };
}

class TrackList {
  TrackList({
    required this.track,
  });

  Track track;

  factory TrackList.fromJson(Map<String, dynamic> json) => TrackList(
    track: Track.fromJson(json["track"]),
  );

  Map<String, dynamic> toJson() => {
    "track": track.toJson(),
  };
}

class Track {
  Track({
    required this.trackId,
    required this.trackName,
    required this.artistName,
    required this.albumName,


  });

  int trackId;
  String trackName;
  String artistName;
  String albumName;



  factory Track.fromJson(Map<String, dynamic> json) => Track(
    trackId: json["track_id"],
    trackName: json["track_name"],
    artistName: json["artist_name"],
    albumName: json["album_name"],

  );

  Map<String, dynamic> toJson() => {
    "track_id": trackId,
    "track_name": trackName,
    "artist_name": artistName,
    "album_name": albumName,
  };
}


