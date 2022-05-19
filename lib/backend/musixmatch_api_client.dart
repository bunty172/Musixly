import 'package:http/http.dart' as http;
import 'package:musixly/constants/urls.dart';

class MusixMatchApiClient {
  static Future<http.Response> fetchTracksList() async {
    final responseFromServer = await http.get(Uri.parse(Urls.tracksUrl));
    if (responseFromServer.statusCode == 200) {
      return responseFromServer;
    } else {
      return http.Response("Sorry,Something went wrong", 1);
    }
  }

  static Future<http.Response> fetchTrackDetails(String trackUrl) async {
    final responseFromServer = await http.get(Uri.parse(trackUrl));
    if (responseFromServer.statusCode == 200) {
      return responseFromServer;
    } else {
      return http.Response("Sorry,Something went wrong", 1);
    }
  }

  static Future<http.Response> fetchTrackLyrics(String trackUrl) async {
    final responseFromServer = await http.get(Uri.parse(trackUrl));
    if (responseFromServer.statusCode == 200) {
      return responseFromServer;
    } else {
      return http.Response("Sorry,Something went wrong", 1);
    }
  }
}
