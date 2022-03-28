import 'package:bloc_task/models/details_model.dart' as details;
import 'package:bloc_task/models/lyrics_model.dart';
import 'package:bloc_task/models/track_list_model.dart';
import 'package:http/http.dart' as http;
class ApiRepository {
  Future<List<TrackList>> fetchTrackList() async {
    String _url = 'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';
    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final parseData = trackModelFromJson(response.body);
      final tracks = parseData.message.body.trackList;
      return tracks;
    } else {
      throw Exception('Failed');
    }
  }

  Future<details.Track> getDetails(String trackID) async {
    String _url = 'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';
    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final parseData = details.detailsModelFromMap(response.body);
      final trackDetails = parseData.message.body.track;
      return trackDetails;
    } else {
      throw Exception('Failed');
    }
  }

  Future<Lyrics> getLyrics(String trackID) async {
    String _url = 'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7';
    var response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final parseData = lyricsModelFromMap(response.body);
      final lyrics = parseData.message.body.lyrics;
      return lyrics;
    } else {
      throw Exception('Failed');
    }
  }
}