import 'dart:convert';

DetailsModel detailsModelFromMap(String str) => DetailsModel.fromMap(json.decode(str));

String detailsModelToMap(DetailsModel data) => json.encode(data.toMap());

class DetailsModel {
  DetailsModel({
    required this.message,
  });

  Message message;

  factory DetailsModel.fromMap(Map<String, dynamic> json) => DetailsModel(
    message: Message.fromMap(json["message"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message.toMap(),
  };
}

class Message {
  Message({
    required this.header,
    required this.body,
  });

  Header header;
  Body body;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    header: Header.fromMap(json["header"]),
    body: Body.fromMap(json["body"]),
  );

  Map<String, dynamic> toMap() => {
    "header": header.toMap(),
    "body": body.toMap(),
  };
}

class Body {
  Body({
    required this.track,
  });

  Track track;

  factory Body.fromMap(Map<String, dynamic> json) => Body(
    track: Track.fromMap(json["track"]),
  );

  Map<String, dynamic> toMap() => {
    "track": track.toMap(),
  };
}

class Track {
  Track({
    required this.artistName,
    required this.trackName,
    required this.albumName,
    required this.explicit,
    required this.trackId,
    required this.trackRating,
  });

  int trackId;
  String trackName;
  int trackRating;
  int explicit;
  String albumName;
  String artistName;



  factory Track.fromMap(Map<String, dynamic> json) => Track(
    trackId: json["track_id"],
    trackName: json["track_name"],
    trackRating: json["track_rating"],
    explicit: json["explicit"],
    albumName: json["album_name"],
    artistName: json["artist_name"],
  );

  Map<String, dynamic> toMap() => {
    "track_id": trackId,
    "track_name": trackName,
    "track_rating": trackRating,
    "explicit": explicit,
    "album_name": albumName,
    "artist_name": artistName,
  };
}

class Header {
  Header({
    required this.statusCode,
    required this.executeTime,
  });

  int statusCode;
  double executeTime;

  factory Header.fromMap(Map<String, dynamic> json) => Header(
    statusCode: json["status_code"],
    executeTime: json["execute_time"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "status_code": statusCode,
    "execute_time": executeTime,
  };
}
