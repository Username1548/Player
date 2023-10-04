import 'package:flutter/material.dart';
import 'package:music_app/Widgets/song_element.dart';
import 'package:music_app/utilities/music_file_processing.dart';

class ShowSongs extends StatelessWidget {
  final Iterator<Song> songs;
  final int length;
  const ShowSongs(this.songs, this.length, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.separated(
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          final Song song = songs.moveNext() ? songs.current : songs.current;
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: SongElement(song, index),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black,
        ),
      ),
    );
  }
}





