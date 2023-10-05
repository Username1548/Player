import 'package:flutter/material.dart';

class ShowPlayLists extends StatelessWidget {
  ShowPlayLists({super.key});
  final List<String> entries = <String>['A', 'B', 'C', 'c', 'asd', 'a'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: SizedBox(
              width: 110,
              child: Column(children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(145, 0, 0, 0),
                  ),
                  child: const Icon(
                    Icons.music_note_rounded,
                    color: Color.fromARGB(255, 224, 217, 195),
                    size: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    'Playlist ${entries[index]}',
                    style: const TextStyle(
                        color: Color.fromARGB(201, 22, 143, 255)),
                  ),
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
