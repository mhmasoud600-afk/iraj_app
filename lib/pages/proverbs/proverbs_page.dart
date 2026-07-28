// lib/pages/proverbs/proverbs_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'proverbs_list_page.dart';
import 'animal_curses_page.dart';

class ProverbsPage extends StatefulWidget {
  const ProverbsPage({Key? key}) : super(key: key);

  @override
  State<ProverbsPage> createState() => _ProverbsPageState();
}

class _ProverbsPageState extends State<ProverbsPage> with SearchableMixin {
  
  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'ضرب‌المثل‌ها و کنایه‌ها';
  
  @override
  String get pageSubtitle => 'ضرب‌المثل‌ها و کنایه‌های محلی';
  
  @override
  String get pageCategory => 'فرهنگی';
  
  @override
  IconData get pageIcon => Icons.format_quote;
  
  @override
  Widget get pageWidget => const ProverbsPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('ضرب‌المثل‌ها و کنایه‌های روستای ایراج:');
    fullText.writeln();
    
    final items = _getItems();
    for (var item in items) {
      fullText.writeln('--- ${item['title']} ---');
      fullText.writeln('توضیحات: ${item['description']}');
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

  List<Map<String, dynamic>> _getItems() {
    return [
      {
        "title": "ضرب‌المثل‌ها و کنایه‌ها",
        "icon": Icons.format_quote,
        "color": Colors.teal,
        "page": const ProverbsListPage(),
        "description": "مجموعه ضرب‌المثل‌ها و کنایه‌های محلی روستای ایراج",
        "keywords": "ضرب‌المثل کنایه محلی ضرب المثل حکمت پند",
      },
      {
        "title": "نفرین به حیوانات",
        "icon": Icons.pets,
        "color": Colors.teal,
        "page": const AnimalCursesPage(),
        "description": "نفرین‌های محلی به حیوانات در فرهنگ مردم روستا",
        "keywords": "نفرین حیوانات محلی دعا",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _getItems();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "ضرب‌المثل‌ها و کنایه ها",
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double cardHeight = constraints.maxHeight * 0.35;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, items[0], cardHeight)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCard(context, items[1], cardHeight)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // یک کارت خالی برای هماهنگی با صفحه محصولات
                    Row(
                      children: [
                        Expanded(child: _buildEmptyCard(cardHeight)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildEmptyCard(cardHeight)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> item, double cardHeight) {
    return SizedBox(
      height: cardHeight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item["page"]),
          );
        },
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (item["color"] as Color).withOpacity(0.15),
                  (item["color"] as Color).withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item["icon"],
                  size: cardHeight * 0.35,
                  color: Colors.teal,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    item["title"],
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Vazirmatn",
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.teal.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCard(double cardHeight) {
    return SizedBox(
      height: cardHeight,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.transparent,
        child: Container(),
      ),
    );
  }
}