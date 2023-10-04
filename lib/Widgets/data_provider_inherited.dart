import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music_app/utilities/audio_linked_list.dart';
import 'package:music_app/utilities/music_file_processing.dart';
import 'package:audioplayers/audioplayers.dart';

class DataProviderInherited extends InheritedWidget {
  final DataProviderInheritedModel model;
  const DataProviderInherited(
      {super.key, required super.child, required this.model});

  static DataProviderInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return model != oldWidget.model;
  }
}

class DataProviderInheritedModel extends ChangeNotifier {
  Node<Song>? current;
  int? currentIndex;
  final player = AudioPlayer();
  final List<bool> listOfPlaying;
  final MyLinkedList<Song> songs;
  DataProviderInheritedModel(this.listOfPlaying, this.songs);

  void tapOnList(int index, File file) {
    if (!listOfPlaying[index]) {
      if (current == null) {
        player.play(DeviceFileSource(file.path));
        current = songs.nodeAt(index);
        currentIndex = index;
        listOfPlaying[index] = true;
      } else {
        if (listOfPlaying[currentIndex!]) {
          player.play(DeviceFileSource(file.path));
          current = songs.nodeAt(index);
          listOfPlaying[currentIndex!] = false;
          currentIndex = index;
          listOfPlaying[index] = true;
        } else {
          if (currentIndex == index) {
            player.resume();
            listOfPlaying[index] = true;
          } else {
            player.play(DeviceFileSource(file.path));
            current = songs.nodeAt(index);
            listOfPlaying[currentIndex!] = false;
            currentIndex = index;
            listOfPlaying[index] = true;
          }
        }
      }
    } else {
      player.pause();
      listOfPlaying[index] = false;
    }
    notifyListeners();
  }

  void tapOnNext() {
    if (current == null) {
      current = songs.nodeAt(0);
      currentIndex = 0;
      tapOnList(currentIndex!, current!.data.songFile!);
    } else {
      current = current!.nextNode;
      currentIndex = currentIndex! + 1;
      tapOnList(currentIndex!, current!.data.songFile!);
    }
  }
}
