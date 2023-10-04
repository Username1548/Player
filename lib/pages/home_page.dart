import 'package:flutter/material.dart';
import 'package:music_app/Widgets/my_scaffold.dart';
import 'package:music_app/utilities/audio_linked_list.dart';
import 'package:music_app/utilities/music_file_processing.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyLinkedList<Song>>(
      future: SongManager().songsList,
      builder: (context, snapshot) {
        final songs = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Text('Some error occured!');
            } else {
              return SafeArea(top: false, child: MyScaffold(songs!));
            }
        }
      },
    );
  }
}
