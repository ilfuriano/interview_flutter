import 'package:flutter/material.dart';

import 'screens/bookshelf_screen.dart';

void main() => runApp(const BookshelfApp());

class BookshelfApp extends StatelessWidget {
  const BookshelfApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Bookshelf',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: const BookshelfScreen(),
  );
}
