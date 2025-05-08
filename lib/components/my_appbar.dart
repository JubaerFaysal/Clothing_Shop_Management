import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const MyAppbar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      backgroundColor: const Color.fromARGB(255, 25, 175, 255),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 1.2,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
