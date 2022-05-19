import 'package:flutter/material.dart';

class TrackTileWidget extends StatelessWidget {
  final String trackName;
  final String albumName;
  final String artistName;
  const TrackTileWidget(
      {Key? key,
      required this.trackName,
      required this.albumName,
      required this.artistName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 183,
          left: MediaQuery.of(context).size.width / 83,
          right: MediaQuery.of(context).size.width / 83,
          bottom: MediaQuery.of(context).size.height / 183),
      height: MediaQuery.of(context).size.height / 9.1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              blurRadius: 0.5, color: Colors.grey, offset: Offset(5.2, 5.2))
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 41,
            right: MediaQuery.of(context).size.width / 41),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.music_note_outlined,
                  color: Colors.black87,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 21,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        trackName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 21,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 91,
                    ),
                    Flexible(
                      child: Text(
                        albumName,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4.1,
                child: Text(
                  "By " + artistName,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: MediaQuery.of(context).size.width / 28,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
