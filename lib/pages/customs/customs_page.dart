// lib/pages/customs/customs_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart';

// صفحات جداگانه
import 'weddings_page.dart';
import 'mourning/mourning_page.dart';
import 'traditional_page.dart';
import 'local_games_page.dart';
import 'beliefs_page.dart';
import 'superstitions_page.dart';
import 'entertainments_page.dart';
import 'kids_stories_page.dart';

class CustomsPage extends StatefulWidget {
  const CustomsPage({Key? key}) : super(key: key);

  @override
  State<CustomsPage> createState() => _CustomsPageState();
}

class _CustomsPageState extends State<CustomsPage> with SearchableMixin {
  
  final List<Map<String, dynamic>> items = const [
    {
      "title": "عروسی‌ها و جشن‌ها",
      "icon": Icons.celebration,
      "page": WeddingsPage(),
      "subtitle": "مراسم عروسی و جشن‌های سنتی روستا",
      "keywords": "عروسی جشن سنتی ازدواج خواستگاری حنابندان"
    },
    {
      "title": "عزاداری‌ها",
      "icon": Icons.sentiment_dissatisfied,
      "page": MourningPage(),
      "subtitle": "مراسم عزاداری و سوگواری",
      "keywords": "عزاداری سوگواری محرم صفر تعزیه سینه زنی"
    },
    {
      "title": "مراسمات سنتی",
      "icon": Icons.history_edu,
      "page": TraditionalPage(),
      "subtitle": "مراسم و آیین‌های سنتی روستا",
      "keywords": "مراسم سنتی آیین نوروز یلدا چهارشنبه سوری"
    },
    {
      "title": "اعتقادات و باورها",
      "icon": Icons.auto_awesome,
      "page": BeliefsPage(),
      "subtitle": "باورها و اعتقادات مردم روستا",
      "keywords": "اعتقاد باور دین مذهب سنت"
    },
    {
      "title": "خرافات",
      "icon": Icons.visibility_off,
      "page": SuperstitionsPage(),
      "subtitle": "خرافات و باورهای عامیانه",
      "keywords": "خرافات باور عامیانه فال بدشگون"
    },
    {
      "title": "بازی‌های محلی",
      "icon": Icons.sports_soccer,
      "page": LocalGamesPage(),
      "subtitle": "بازی‌ها و سرگرمی‌های محلی",
      "keywords": "بازی محلی سنتی کودکان جوانان"
    },
    {
      "title": "سرگرمی‌ها",
      "icon": Icons.camera_alt,
      "page": EntertainmentsPage(),
      "subtitle": "سرگرمی‌ها و تفریحات روستا",
      "keywords": "سرگرمی تفریح طبیعت گردش"
    },
    {
      "title": "شعر و قصه‌ها",
      "icon": Icons.auto_stories,
      "page": KidsStoriesPage(),
      "subtitle": "شعرها و قصه‌های کودکانه",
      "keywords": "شعر قصه کودکانه افسانه ترانه"
    },
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'آداب و رسوم';
  
  @override
  String get pageSubtitle => 'آداب سنتی، مراسم و آیین‌های روستا';
  
  @override
  String get pageCategory => 'فرهنگی';
  
  @override
  IconData get pageIcon => Icons.people;
  
  @override
  Widget get pageWidget => const CustomsPage();

  @override
  String getSearchText() {
    StringBuffer fullText = StringBuffer();
    fullText.writeln('آداب و رسوم روستای ایراج:');
    fullText.writeln();
    
    for (var item in items) {
      fullText.writeln('--- ${item['title']} ---');
      fullText.writeln('${item['subtitle']}');
      fullText.writeln('کلمات کلیدی: ${item['keywords']}');
      fullText.writeln();
    }
    
    return fullText.toString();
  }

  @override
  void initState() {
    super.initState();
    registerForSearch();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "آداب و رسوم روستا",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          
          // تعیین تعداد ستون‌ها بر اساس عرض صفحه
          int crossAxisCount;
          double iconSize;
          double fontSize;
          double spacing;
          double aspectRatio;
          
          if (screenWidth < 380) {
            crossAxisCount = 2;
            iconSize = 28;
            fontSize = 11;
            spacing = 6;
            aspectRatio = 1.0;
          } else if (screenWidth < 480) {
            crossAxisCount = 2;
            iconSize = 30;
            fontSize = 12;
            spacing = 8;
            aspectRatio = 1.1;
          } else if (screenWidth < 600) {
            crossAxisCount = 2;
            iconSize = 34;
            fontSize = 13;
            spacing = 10;
            aspectRatio = 1.2;
          } else if (screenWidth < 800) {
            crossAxisCount = 3;
            iconSize = 38;
            fontSize = 14;
            spacing = 12;
            aspectRatio = 1.2;
          } else {
            crossAxisCount = 4;
            iconSize = 42;
            fontSize = 15;
            spacing = 14;
            aspectRatio = 1.3;
          }

          // محاسبه ارتفاع مناسب
          final totalItems = items.length;
          final rowsNeeded = (totalItems / crossAxisCount).ceil();
          final availableHeight = screenHeight - kToolbarHeight - 50;
          final itemHeight = availableHeight / rowsNeeded;
          final itemWidth = (screenWidth - (spacing * (crossAxisCount - 1)) - 24) / crossAxisCount;
          
          if (itemWidth > 0 && itemHeight > 0) {
            aspectRatio = itemWidth / itemHeight;
            if (aspectRatio > 1.4) aspectRatio = 1.4;
            if (aspectRatio < 0.8) aspectRatio = 0.8;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: aspectRatio,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item["page"]),
                    );
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            item["icon"],
                            size: iconSize,
                            color: Colors.teal,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item["title"],
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}