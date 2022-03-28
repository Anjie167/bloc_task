import 'dart:convert';

LyricsModel lyricsModelFromMap(String str) => LyricsModel.fromMap(json.decode(str));

String lyricsModelToMap(LyricsModel data) => json.encode(data.toMap());

class LyricsModel{
  LyricsModel({
    required this.message,
  });

  Message message;

  factory LyricsModel.fromMap(Map<String, dynamic> json) => LyricsModel(
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
    required this.lyrics,
  });

  Lyrics lyrics;

  factory Body.fromMap(Map<String, dynamic> json) => Body(
    lyrics: Lyrics.fromMap(json["lyrics"]),
  );

  Map<String, dynamic> toMap() => {
    "lyrics": lyrics.toMap(),
  };
}

class Lyrics {
  Lyrics({
   required this.lyricsBody,
    required this.lyricsId
  });

  int lyricsId;
  String lyricsBody;


  factory Lyrics.fromMap(Map<String, dynamic> json) => Lyrics(
    lyricsId: json["lyrics_id"],
    lyricsBody: json["lyrics_body"],
  );

  Map<String, dynamic> toMap() => {
    "lyrics_id": lyricsId,
    "lyrics_body": lyricsBody,
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
