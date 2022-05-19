import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Bloc/music_track_event.dart';
import '../Bloc/music_track_state.dart';
import '../Bloc/track_bloc.dart';

class TrackDetailsPage extends StatefulWidget {
  const TrackDetailsPage({Key? key}) : super(key: key);

  @override
  State<TrackDetailsPage> createState() => _TrackDetailsPageState();
}

class _TrackDetailsPageState extends State<TrackDetailsPage> {
  bool hasInternet = true;
  late SharedPreferences sharedPreferences;
  late final StreamSubscription<InternetConnectionStatus> listener;
  @override
  void initState() {
    listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus internetConnectionStatus) {
        hasInternet =
            internetConnectionStatus == InternetConnectionStatus.connected;
        setState(() {});
      },
    );
    initializeSharedPreferences();
    super.initState();
  }

  initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackId = ModalRoute.of(context)!.settings.arguments as int;
    context.read<TrackBloc>().add(FetchTrackDetailsEvent(trackId));
    context.read<TrackBloc>().add(FetchTrackLyricsEvent(trackId));
    String? trackName;
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          context.read<TrackBloc>().add(SaveToDeviceEvent(trackId, trackName!));
        },
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 36.56,
              right: MediaQuery.of(context).size.width / 4.8,
              left: MediaQuery.of(context).size.width / 4.8),
          child: Container(
            height: MediaQuery.of(context).size.height / 15.23,
            width: MediaQuery.of(context).size.width / 41.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 13.7),
                color: Colors.blueGrey),
            child: const Center(
              child: Text(
                "Add to Bookmarks",
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Track Details"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey,
        ),
      ),
      body: hasInternet
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<TrackBloc, MusicTrackState>(
                  buildWhen: (previous, current) {
                    if (current is TracksDetailsLoaded || current is Loading) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is TracksDetailsLoaded) {
                      trackName = state.track!.trackName;
                      return Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height / 41,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TrackName:",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: MediaQuery.of(context).size.height /
                                      40.57,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Text(
                              state.track!.trackName!,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 61,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 91,
                            ),
                            Text(
                              "AlbumName:",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: MediaQuery.of(context).size.height /
                                      40.57,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Text(
                              state.track!.albumName!,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 61,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 91,
                            ),
                            Text(
                              "ArtistName:",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: MediaQuery.of(context).size.height /
                                      40.57,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Text(
                              state.track!.artistName!,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 61,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 91,
                            ),
                            Text(
                              "Explicit:",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: MediaQuery.of(context).size.height /
                                      40.57,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Text(
                              state.track!.explicit == 1 ? "True" : "False",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 61,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 91,
                            ),
                            Text(
                              "Rating:",
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: MediaQuery.of(context).size.height /
                                      40.57,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Text(
                              "${state.track!.rating!}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize:
                                    MediaQuery.of(context).size.height / 61,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 61,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.blueGrey,
                        )),
                      );
                    }
                  },
                ),
                BlocBuilder<TrackBloc, MusicTrackState>(
                  buildWhen: (previous, current) {
                    if (current is TracksLyricsLoaded || current is Loading) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is TracksLyricsLoaded) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.height / 41),
                              child: Text(
                                "Lyrics:",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            40.57,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 183,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height /
                                                41),
                                    child: Column(
                                      children: [
                                        Text(
                                          state.lyric!,
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                40.57,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.blueGrey,
                      ));
                    }
                  },
                )
              ],
            )
          : Center(
              child: Text(
                "No Internet",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: MediaQuery.of(context).size.height / 30.5),
              ),
            ),
    );
  }
}
