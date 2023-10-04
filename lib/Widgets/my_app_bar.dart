import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 47, 47, 47),
      leading: Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(
            Icons.format_align_justify_rounded,
            color: Color.fromARGB(105, 255, 255, 255),
          ),
        ),
      ),
      title: Container(
        width: 247,
        height: 40,
        decoration: BoxDecoration(
          color: const Color.fromARGB(145, 23, 23, 23),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(child: Text('Главный')),
      ),
      actions: <Widget>[
        IconButton(
          splashRadius: 20,
          onPressed: () {},
          icon: const Icon(
            Icons.search_sharp,
            color: Color.fromARGB(105, 255, 255, 255),
          ),
        ),
      ],
    );
  }
}
