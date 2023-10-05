import 'dart:async';
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
  StreamSubscription subscription = const Stream.empty().listen((event) {});
  DataProviderInheritedModel(this.listOfPlaying, this.songs);

  void tapOnList(int index, File file) {
    if (!listOfPlaying[index]) {
      if (current == null) {
        player.play(DeviceFileSource(file.path));
        current = songs.nodeAt(index);
        currentIndex = index;
        listOfPlaying[index] = true;
        _createSongSteam();
      } else {
        if (listOfPlaying[currentIndex!]) {
          player.play(DeviceFileSource(file.path));
          current = songs.nodeAt(index);
          listOfPlaying[currentIndex!] = false;
          currentIndex = index;
          listOfPlaying[index] = true;
          _createSongSteam();
        } else {
          if (currentIndex == index) {
            player.resume();
            subscription.resume();
            listOfPlaying[index] = true;
          } else {
            player.play(DeviceFileSource(file.path));
            current = songs.nodeAt(index);
            listOfPlaying[currentIndex!] = false;
            currentIndex = index;
            listOfPlaying[index] = true;
            _createSongSteam();
          }
        }
      }
    } else {
      player.pause();
      subscription.pause();
      listOfPlaying[index] = false;
    }
    notifyListeners();
  }

  void tapOnNext({int? userIndex}) {
    if (current == null) {
      currentIndex = 1;
      current = songs.nodeAt(currentIndex);
      listOfPlaying[currentIndex!] = true;
      player.play(DeviceFileSource(current!.data.songFile!.path));
    } else {
      if (userIndex == null) {
        current = current!.nextNode;
        listOfPlaying[currentIndex!] = false;
        currentIndex =
            (currentIndex! == songs.length - 1) ? 0 : currentIndex! + 1;
        listOfPlaying[currentIndex!] = true;
        player.play(DeviceFileSource(current!.data.songFile!.path));
      } else {
        listOfPlaying[currentIndex!] = false;
        currentIndex = (userIndex == songs.length - 1) ? 0 : userIndex + 1;
        listOfPlaying[currentIndex!] = true;
        current = songs.nodeAt(currentIndex);
        player.play(DeviceFileSource(current!.data.songFile!.path));
      }
    }
    _createSongSteam();
    notifyListeners();
  }

  void tapOnPrevious() {
    if (current == null) {
      currentIndex = songs.length - 1;
      current = songs.nodeAt(currentIndex);
      listOfPlaying[currentIndex!] = true;
      player.play(DeviceFileSource(current!.data.songFile!.path));
    } else {
      current = current!.previousNode;
      listOfPlaying[currentIndex!] = false;
      currentIndex =
          (currentIndex! == 0) ? songs.length - 1 : currentIndex! - 1;
      listOfPlaying[currentIndex!] = true;
      player.play(DeviceFileSource(current!.data.songFile!.path));
    }
    _createSongSteam();
    notifyListeners();
  }

  void _createSongSteam() {
    if (current != null) {
      subscription.cancel();
      Stream stream = Stream.periodic(
          Duration(seconds: current!.data.trackDuration! ~/ 1000 + 2),
          (next) => next);
      subscription = stream.listen((event) {
        tapOnNext();
      });
    }
  }
}
