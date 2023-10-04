import 'package:flutter/material.dart';
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
    return Text('Text');
  }      
}
