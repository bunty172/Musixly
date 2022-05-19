abstract class MusicTrackEvent {
  const MusicTrackEvent();
}

class FetchTracksEvent extends MusicTrackEvent {
  const FetchTracksEvent();
}

class FetchTrackDetailsEvent extends MusicTrackEvent {
  int trackId;
  FetchTrackDetailsEvent(this.trackId);
}

class FetchTrackLyricsEvent extends MusicTrackEvent {
  int trackId;
  FetchTrackLyricsEvent(this.trackId);
}

class ClickedOnATrackEvent extends MusicTrackEvent {
  final int trackId;
  const ClickedOnATrackEvent(this.trackId);
}

class SaveToDeviceEvent extends MusicTrackEvent {
  final int trackId;
  final String trackName;
  SaveToDeviceEvent(this.trackId, this.trackName);
}
class FetchBookmarksEvent extends MusicTrackEvent {
  FetchBookmarksEvent();
}
