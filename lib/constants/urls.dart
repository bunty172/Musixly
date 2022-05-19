class Urls {
  static String tracksUrl =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=a3d497205432812d5a3b0ceb1549fe47";

  static String getTrackUrl(int trackId) {
    return "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=a3d497205432812d5a3b0ceb1549fe47";
  }

  static String getTrackLyricsUrl(int trackId) {
    return "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=a3d497205432812d5a3b0ceb1549fe47";
  }
}
