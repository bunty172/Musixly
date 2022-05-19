class Tracks {
  List<TrackModel> fetchedTracksList = [];
  Tracks.fromJson(Map<String, dynamic> tracksJsonData) {
    var tracksList = tracksJsonData['message']['body']['track_list'];
    if (tracksList != null) {
      fetchedTracksList = [];
      for (var aTrackJsonData in tracksList) {
        fetchedTracksList.add(TrackModel.fromJson(aTrackJsonData));
      }
    }
  }
}

class TrackDetails {
  TrackModel? track;
  TrackDetails.fromJson(Map<String, dynamic> trackJsonData) {
    track = TrackModel.fromJson(trackJsonData['message']['body']);
  }
}

class LyricModel {
  String? lyric;
  LyricModel.fromJson(Map<String, dynamic> trackLyricJsonData) {
    lyric = trackLyricJsonData['message']['body']['lyrics']['lyrics_body'];
  }
}


class TrackModel {
  int? trackId;
  String? trackName;
  String? albumName;
  String? artistName;
  int? explicit;
  int? rating;
  TrackModel({
    this.trackId,
    this.trackName,
    this.albumName,
    this.artistName,
    this.explicit,
    this.rating,
  });
  TrackModel.fromJson(Map<String, dynamic> aTrackjsonData) {
    trackId = aTrackjsonData['track']['track_id'];
    trackName = aTrackjsonData['track']['track_name'];
    albumName = aTrackjsonData['track']['album_name'];
    artistName = aTrackjsonData['track']['artist_name'];
    explicit = aTrackjsonData['track']['explicit'];
    rating = aTrackjsonData['track']['track_rating'];
  }
}
