import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musixly/constants/routes.dart';
import '../Bloc/music_track_event.dart';
import '../Bloc/music_track_state.dart';
import '../Bloc/track_bloc.dart';

class BookMarksPage extends StatefulWidget {
  const BookMarksPage({Key? key}) : super(key: key);

  @override
  State<BookMarksPage> createState() => _BookMarksPageState();
}

class _BookMarksPageState extends State<BookMarksPage> {
  @override
  Widget build(BuildContext context) {
    context.read<TrackBloc>().add(FetchBookmarksEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bookmarks",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.blueGrey,
        ),
      ),
      body: BlocBuilder<TrackBloc, MusicTrackState>(
        builder: (context, state) {
          if (state is FetchedBookmarks) {
            return ListView.builder(
                itemCount: state.tracks.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, trackDetailsPage,
                              arguments: state.tracks[index]['trackId'])
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 183,
                        left: MediaQuery.of(context).size.width / 83,
                        right: MediaQuery.of(context).size.width / 83,
                        bottom: MediaQuery.of(context).size.height / 183,
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 0.5,
                              color: Colors.grey,
                              offset: Offset(5.2, 5.2))
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 41,
                            right: MediaQuery.of(context).size.width / 41),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.music_note_outlined,
                                  color: Colors.black87,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 17,
                                ),
                                Text(
                                  state.tracks[index]['trackName'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              28),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
          } else {
            return Center(
              child: Text(
                "No Bookmarks yet",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: MediaQuery.of(context).size.width / 14),
              ),
            );
          }
        },
      ),
    );
  }
}
