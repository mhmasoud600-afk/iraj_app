import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("یادداشت‌ها")),
      body: const Center(
        child: Text(
          "صفحه یادداشت‌ها",
          style: TextStyle(fontSize: 20, fontFamily: "Vazir"),
        ),
      ),
    );
  }
}