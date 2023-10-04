import 'package:flutter/material.dart';
import 'package:music_app/Widgets/data_provider_inherited.dart';
import 'package:music_app/utilities/music_file_processing.dart';

class SongElement extends StatefulWidget {
  final Song song;
  final int index;
  const SongElement(this.song, this.index, {super.key});

  @override
  State<SongElement> createState() => _SongElementState();
}

class _SongElementState extends State<SongElement> {
  late final DataProviderInheritedModel? model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = DataProviderInherited.of(context)?.model;
    model!.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (model!.current != null) {
      if (model!.currentIndex == widget.index) {
        if (model!.listOfPlaying[widget.index]) {
          return TextButton(
            onPressed: () {
              model!.tapOnList(widget.index, widget.song.songFile!);
            },
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(145, 0, 0, 0),
                  ),
                  child: const Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.pause_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Color.fromARGB(255, 224, 217, 195),
                          size: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Text(widget.song.trackName!)
              ],
            ),
          );
        } else {
          return TextButton(
            onPressed: () {
              model!.tapOnList(widget.index, widget.song.songFile!);
            },
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(145, 0, 0, 0),
                  ),
                  child: const Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Center(
                        child: Icon(
                          Icons.music_note_rounded,
                          color: Color.fromARGB(255, 224, 217, 195),
                          size: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Text(widget.song.trackName!)
              ],
            ),
          );
        }
      }
    }
    return TextButton(
      onPressed: () {
        model!.tapOnList(widget.index, widget.song.songFile!);
      },
      child: Row(
        children: [
          Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(145, 0, 0, 0),
              ),
              child: const Icon(
                Icons.music_note_rounded,
                color: Color.fromARGB(255, 224, 217, 195),
                size: 10,
              )),
          Text(widget.song.trackName!)
        ],
      ),
    );
  }
}
