import 'package:musixly/backend/track_model.dart';

abstract class MusicTrackState {
  MusicTrackState();
}

class InitialState extends MusicTrackState {
  InitialState();
}

class Loading extends MusicTrackState {
  Loading();
}

class TracksListLoaded extends MusicTrackState {
   List<TrackModel>? tracks = [];
  
  TracksListLoaded({
    this.tracks,
  });
}

class TracksDetailsLoaded extends MusicTrackState {
  TrackModel? track;

  TracksDetailsLoaded({
    this.track,
  });
}

class TracksLyricsLoaded extends MusicTrackState {
  String? lyric;
  TracksLyricsLoaded({this.lyric});
}

class FetchedBookmarks extends MusicTrackState {
  List<Map<String, dynamic>> tracks = [];
  FetchedBookmarks(this.tracks);
}
