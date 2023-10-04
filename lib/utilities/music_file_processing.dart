import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'dart:io';
import 'package:music_app/utilities/audio_linked_list.dart';

class SongManager {
  static const String _directoryPath = '/storage/emulated/0/Download/';
  final Directory _downloadDirectory = Directory(_directoryPath);

  Future<MyLinkedList<Song>> get songsList async {
    var fileList = _downloadDirectory.listSync();
    if (fileList.isNotEmpty) {
      MyLinkedList<Song> result = MyLinkedList();
      for (var file in fileList) {
        if (file is File && file.path.endsWith('.mp3')) {
          final metadata = await MetadataRetriever.fromFile(file);
          result.addLast(Song(
            songFile: file,
            trackName: metadata.trackName,
            trackArtistNames: metadata.trackArtistNames,
            authorName: metadata.authorName,
            trackDuration: metadata.trackDuration,
          ));
        }
      }
      return result;
    }
    return MyLinkedList();
  }
}

class Song {
  File? songFile;
  String? trackName;
  List<String>? trackArtistNames;
  String? authorName;
  int? trackDuration;

  Song({
    this.songFile,
    this.trackName,
    this.trackArtistNames,
    this.authorName,
    this.trackDuration,
  });

  get nextNode => null;
}
