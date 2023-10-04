import 'package:flutter/material.dart';
import 'package:music_app/Widgets/current_song.dart';
import 'package:music_app/Widgets/data_provider_inherited.dart';
import 'package:music_app/Widgets/my_app_bar.dart';
import 'package:music_app/Widgets/show_play_lists.dart';
import 'package:music_app/Widgets/show_songs.dart';
import 'package:music_app/utilities/audio_linked_list.dart';
import 'package:music_app/utilities/music_file_processing.dart';

class MyScaffold extends StatefulWidget {
  final MyLinkedList<Song> songs;
  const MyScaffold(this.songs, {super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    final songs = widget.songs;
    final model =
        DataProviderInheritedModel(List.filled(songs.length, false), songs);
    return DataProviderInherited(
      model: model,
      child: Scaffold(
        appBar: const MyAppBar(
          height: 50,
        ),
        body: Container(
          color: const Color.fromARGB(255, 47, 47, 47),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'PlayLists',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Show All',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ShowPlayLists(),
                  ],
                ),
              ),
              ShowSongs(songs.iterator, songs.length),
            ],
          ),
        ),
        bottomSheet: CurrentSong(),
      ),
    );
  }
}
