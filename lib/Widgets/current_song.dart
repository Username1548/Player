import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Widgets/data_provider_inherited.dart';

class CurrentSong extends StatelessWidget {
  const CurrentSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 123123,
      color: const Color.fromARGB(255, 60, 58, 58),
      child: const SongElement(),
    );
  }
}

class SongElement extends StatefulWidget {
  const SongElement({super.key});

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
    if (model!.current == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const Text('Player'),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    model!.tapOnPrevious();
                  },
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                ((model!.currentIndex == null)
                        ? false
                        : model!.listOfPlaying[model!.currentIndex!])
                    ? IconButton(
                        onPressed: () {
                          model!.tapOnList(model!.currentIndex!,
                              model!.current!.data.songFile!);
                        },
                        icon: const Icon(Icons.pause_outlined))
                    : IconButton(
                        onPressed: () {
                          if (model!.current == null) {
                            model!.tapOnList(0, model!.songs.first.songFile!);
                          } else {
                            model!.tapOnList(model!.currentIndex!,
                                model!.current!.data.songFile!);
                          }
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                      ),
                IconButton(
                  onPressed: () {
                    model!.tapOnNext();
                  },
                  icon: const Icon(Icons.skip_next_rounded),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(
            width: 100,
            child: Marquee(
              text: '${model!.current!.data.trackName!} ',
              startAfter: const Duration(seconds: 5),
              pauseAfterRound: const Duration(seconds: 5),
              blankSpace: 40,
              velocity: 20,
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    model!.tapOnPrevious();
                  },
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                (model!.listOfPlaying[model!.currentIndex!])
                    ? IconButton(
                        onPressed: () {
                          model!.tapOnList(model!.currentIndex!,
                              model!.current!.data.songFile!);
                        },
                        icon: const Icon(Icons.pause_outlined))
                    : IconButton(
                        onPressed: () {
                          model!.tapOnList(model!.currentIndex!,
                              model!.current!.data.songFile!);
                        },
                        icon: const Icon(Icons.play_arrow_rounded),
                      ),
                IconButton(
                  onPressed: () {
                    model!.tapOnNext();
                  },
                  icon: const Icon(Icons.skip_next_rounded),
                )
              ],
            ),
          )
        ],
      );
    }
  }
}
