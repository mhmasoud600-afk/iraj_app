// lib/pages/eghamatgah/egamatgah_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'erabeh_page.dart';
import 'pako_page.dart';
import 'chelehkhone_page.dart';
import 'jeyran_page.dart';
import 'fahmideh_page.dart';

class EgamatgahPage extends StatefulWidget {
  const EgamatgahPage({Key? key}) : super(key: key);

  @override
  State<EgamatgahPage> createState() => _EgamatgahPageState();
}

class _EgamatgahPageState extends State<EgamatgahPage> with SearchableMixin {
  
  final List<Map<String, dynamic>> accommodations = const [
    {
      "title": "اقامتگاه ارابه",
      "icon": Icons.home,
      "page": ErabehPage(),
      "subtitle": "اقامتگاه بوم‌گردی ارابه با معماری سنتی",
      "keywords": "ارابه بوم‌گردی سنتی اقامت"
    },
    {
      "title": "اقامتگاه پاکو",
      "icon": Icons.home_work,
      "page": PakoPage(),
      "subtitle": "اقامتگاه بوم‌گردی پاکو در دل کویر",
      "keywords": "پاکو بوم‌گردی کویر اقامت"
    },
    {
      "title": "اقامتگاه چله خونه",
      "icon": Icons.house,
      "page": ChelehKhonePage(),
      "subtitle": "اقامتگاه سنتی چله خونه با معماری قدیمی",
      "keywords": "چله خونه سنتی قدیمی اقامت"
    },
    {
      "title": "سفرخانه جیران",
      "icon": Icons.apartment,
      "page": JeyranPage(),
      "subtitle": "سفرخانه جیران، اقامتگاه لوکس در طبیعت",
      "keywords": "جیران سفرخانه لوکس طبیعت"
    },
    {
      "title": "اردوگاه شهید حسین فهمیده",
      "icon": Icons.cabin,
      "page": FahmidehPage(),
      "subtitle": "اردوگاه تفریحی و فرهنگی شهید حسین فهمیده",
      "keywords": "اردوگاه حسین فهمیده تفریحی فرهنگی"
    },
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'اقامتگاه‌ها';
  
  @override
  String get pageSubtitle => 'محل‌های اقامت و مهمان‌پذیرهای روستا';
  
  @override
  String get pageCategory => 'خدمات';
  
  @override
  IconData get pageIcon => Icons.hotel;
  
  @override
  Widget get pageWidget => const EgamatgahPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('اقامتگاه‌های روستای ایراج:');
    fullText.writeln();
    
    for (var item in accommodations) {
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
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اقامتگاه‌ها",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: accommodations.length,
        itemBuilder: (context, index) {
          final item = accommodations[index];
          
          final iconSize = screenHeight * 0.07;
          final titleFontSize = (screenHeight * 0.018).clamp(12.0, 14.0);
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item["page"]),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item["icon"], size: iconSize, color: Colors.deepPurple),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Vazirmatn",
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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