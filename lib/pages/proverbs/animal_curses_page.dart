import 'package:flutter/material.dart';

// لیست نفرین ها به حیوانات
final List<Map<String, String>> animalCurses = const [
  {
    "title": "مرغ شغال برده",
    "desc": "آرزو می‌کنم شغال این مرغ را ببرد (نفرین به مرغ)"
  },
  {
    "title": "گوسفند پر باد شده",
    "desc": "گوسفندی که به دلایلی مثل گندم یا آرد خوردن، شکمش پر از باد می‌شود و از بین می‌رود"
  },
  {
    "title": "خر سقط شده",
    "desc": "خر یا الاغی که مرده است (نفرین به خر)"
  },
  {
    "title": "گربه پندوس کرده",
    "desc": "گربه‌ای که مرده است (نفرین به گربه)"
  },
{
    "title": "دم بریده",
    "desc": "نفرین به بز یا الاغ که دم‌شان کنده یا بریده شود (نشانه بی‌ارزشی و ناقصی)"
  },

];

class AnimalCursesPage extends StatelessWidget {
  const AnimalCursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("نفرین به حیوانات"),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: animalCurses.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final curse = animalCurses[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.red.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.pets,
                        color: Colors.red.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        curse["title"]!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                          fontFamily: "Vazirmatn",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    curse["desc"]!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade800,
                      fontFamily: "Vazirmatn",
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}