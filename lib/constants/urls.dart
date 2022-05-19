class Urls {
  static String tracksUrl =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";

  static String getTrackUrl(int trackId) {
    return "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  }

  static String getTrackLyricsUrl(int trackId) {
    return "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7";
  }
}
