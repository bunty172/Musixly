import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:musixly/backend/musixmatch_api_client.dart';
import 'package:musixly/backend/track_model.dart';
import 'package:musixly/constants/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'music_track_event.dart';
import 'music_track_state.dart';

class TrackBloc extends Bloc<MusicTrackEvent, MusicTrackState> {
  late SharedPreferences sharedPreferences;
  initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  TrackBloc(MusicTrackState initialState) : super(initialState) {
    initializeSharedPreferences();
    on<FetchTracksEvent>((event, emit) async {
      var response = await MusixMatchApiClient.fetchTracksList();
      if (response.statusCode == 200) {
        Tracks tracks = Tracks.fromJson(jsonDecode(response.body));
        emit(TracksListLoaded(tracks: tracks.fetchedTracksList));
      } else {}
    });
    on<FetchTrackDetailsEvent>((event, emit) async {
      emit(Loading());
      var trackUrl = Urls.getTrackUrl(event.trackId);
      var response = await MusixMatchApiClient.fetchTrackDetails(trackUrl);
      if (response.statusCode == 200) {
        TrackDetails trackDetails =
            TrackDetails.fromJson(jsonDecode(response.body));
        emit(TracksDetailsLoaded(track: trackDetails.track));
      } else {}
    });
    on<FetchTrackLyricsEvent>((event, emit) async {
      emit(Loading());
      var trackUrl = Urls.getTrackLyricsUrl(event.trackId);
      var response = await MusixMatchApiClient.fetchTrackLyrics(trackUrl);
      if (response.statusCode == 200) {
        String lyric = LyricModel.fromJson(jsonDecode(response.body)).lyric!;
        emit(TracksLyricsLoaded(lyric: lyric));
      } else {}
    });

    on<SaveToDeviceEvent>((event, emit) {
      Map<String, dynamic> json = {
        'trackId': event.trackId,
        'trackName': event.trackName,
      };
      List<String> savedTracks = [];
      List<Map<String, dynamic>> savedTracksJson = [];
      if (sharedPreferences.containsKey("savedTracks")) {
        savedTracks = sharedPreferences.getStringList("savedTracks")!;
        for (var element in savedTracks) {
          var jsonobj = jsonDecode(element);
          savedTracksJson.add(jsonobj);
        }
        int flag = 0;
        for (var element in savedTracksJson) {
          if (element['trackId'] == event.trackId) {
            flag = 1;
          }
        }

        if (flag == 0) {
          savedTracks.add(jsonEncode(json));
          sharedPreferences.setStringList("savedTracks", savedTracks);
        }
      } else {
        List<String> savedTracks = [];
        savedTracks.add(jsonEncode(json));
        sharedPreferences.setStringList("savedTracks", savedTracks);
      }
    });
    on<FetchBookmarksEvent>((event, emit) {
      List<String>? tracksList = [];
      List<Map<String, dynamic>>? tracks = [];

      if (sharedPreferences.containsKey("savedTracks")) {
        tracksList = sharedPreferences.getStringList("savedTracks");
        tracksList!.forEach((element) {
          var json = jsonDecode(element);
          tracks.add(json);
        });
        emit(FetchedBookmarks(tracks));
      } else {

      }
    });
  }
}
