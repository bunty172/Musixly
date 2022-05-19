import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:musixly/constants/routes.dart';
import 'package:musixly/screens/track_details_page.dart';
import 'package:musixly/backend/track_model.dart';
import 'package:musixly/reusable%20widgets/track_tile_widget.dart';
import 'Bloc/music_track_event.dart';
import 'Bloc/music_track_state.dart';
import 'Bloc/track_bloc.dart';
import 'screens/bookmarkspage.dart';

void main() {
  runApp(
    BlocProvider<TrackBloc>(
      create: (context) => TrackBloc(InitialState()),
      child: MaterialApp(
        title: "Musixly",
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          homePage: ((context) => const HomePage()),
          trackDetailsPage: (context) => const TrackDetailsPage(),
          bookmarksPage: (context) => const BookMarksPage(),
        },
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasInternet = true;
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
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<TrackBloc>().add(const FetchTracksEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trending",
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                bookmarksPage,
              ).then((value) {
                setState(() {});
              });
            },
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 27.4),
              child: const Icon(
                Icons.bookmarks_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey,
        ),
      ),
      body: BlocBuilder<TrackBloc, MusicTrackState>(builder: (context, state) {
        if (hasInternet == true) {
          if (state is TracksListLoaded) {
            List<TrackModel> tracksToBeDisplayed = state.tracks!;
            return ListView.builder(
              itemCount: tracksToBeDisplayed.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, trackDetailsPage,
                            arguments: tracksToBeDisplayed[index].trackId)
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: TrackTileWidget(
                      trackName: tracksToBeDisplayed[index].trackName!,
                      albumName: tracksToBeDisplayed[index].albumName!,
                      artistName: tracksToBeDisplayed[index].artistName!),
                );
              }),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.blueGrey,
            ));
          }
        } else {
          return Center(
            child: Text(
              "No Internet",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: MediaQuery.of(context).size.height / 30.46),
            ),
          );
        }
      }),
    );
  }
}
