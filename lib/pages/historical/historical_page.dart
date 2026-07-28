// lib/pages/historical/historical_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart';

// صفحات جداگانه
import 'castle_page.dart';
import 'ancient_hills_page.dart';
import 'gabra_tomb_page.dart';
import 'cypress_tree_page.dart';
import 'sabat_page.dart';
import 'hosseinieh_page.dart';
import 'castle_square_page.dart';
import 'tower_page.dart';
import 'garden_alleys_page.dart';
import 'chale_hozo_page.dart';
import 'chenmado_cave_page.dart';
import 'old_texture_page.dart';

class HistoricalPage extends StatefulWidget {
  const HistoricalPage({Key? key}) : super(key: key);

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> with SearchableMixin {
  
  final List<Map<String, dynamic>> items = const [
    {
      "title": "قلعه",
      "icon": Icons.fort,
      "page": CastlePage(),
      "subtitle": "قلعه تاریخی ایراج با قدمت هزار ساله",
      "keywords": "قلعه تاریخی دژ نظامی برج"
    },
    {
      "title": "تپه‌های باستانی",
      "icon": Icons.landscape,
      "page": AncientHillsPage(),
      "subtitle": "تپه‌های باستانی و محوطه‌های تاریخی",
      "keywords": "تپه باستانی محوطه تاریخی"
    },
    {
      "title": "مزار گبرا",
      "icon": Icons.account_balance,
      "page": GabraTombPage(),
      "subtitle": "قبرستان زرتشتیان و گبرها",
      "keywords": "گبر زرتشتی قبرستان دخمه"
    },
    {
      "title": "درخت سرو",
      "icon": Icons.nature,
      "page": CypressTreePage(),
      "subtitle": "سرو کهن هزار ساله ایراج",
      "keywords": "سرو کهن درخت هزار ساله"
    },
    {
      "title": "ساباط",
      "icon": Icons.house,
      "page": SabatPage(),
      "subtitle": "ساباط‌های قدیمی و معماری سنتی",
      "keywords": "ساباط معماری سنتی قدیمی"
    },
    {
      "title": "حسینیه",
      "icon": Icons.mosque,
      "page": HosseiniehPage(),
      "subtitle": "حسینیه تاریخی و مذهبی روستا",
      "keywords": "حسینیه مذهبی تاریخی"
    },
    {
      "title": "میدان پشت قلعه",
      "icon": Icons.location_city,
      "page": CastleSquarePage(),
      "subtitle": "میدان تاریخی پشت قلعه ایراج",
      "keywords": "میدان قلعه تاریخی"
    },
    {
      "title": "برج",
      "icon": Icons.apartment,
      "page": TowerPage(),
      "subtitle": "برج‌های دیده‌بانی و نگهبانی",
      "keywords": "برج دیده‌بانی نگهبانی تاریخی"
    },
    {
      "title": "کوچه باغ‌ها",
      "icon": Icons.park,
      "page": GardenAlleysPage(),
      "subtitle": "کوچه باغ‌های قدیمی و سرسبز",
      "keywords": "کوچه باغ قدیمی سرسبز"
    },
    {
      "title": "چاله حوضو",
      "icon": Icons.water,
      "page": ChaleHozoPage(),
      "subtitle": "چاله حوض و آب‌انبارهای قدیمی",
      "keywords": "چاله حوض آب‌انبار قدیمی"
    },
    {
      "title": "غار چن مادو",
      "icon": Icons.hiking,
      "page": ChenMadoCavePage(),
      "subtitle": "غار چن مادو و اسرار تاریخی",
      "keywords": "غار چن مادو تاریخی اسرار"
    },
    {
      "title": "بافت قدیمی",
      "icon": Icons.account_balance_wallet,
      "page": OldTexturePage(),
      "subtitle": "بافت تاریخی و معماری قدیمی روستا",
      "keywords": "بافت تاریخی معماری قدیمی"
    },
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'آثار باستانی و دیدنی';
  
  @override
  String get pageSubtitle => 'آثار تاریخی، بناهای قدیمی و جاهای دیدنی';
  
  @override
  String get pageCategory => 'تاریخی';
  
  @override
  IconData get pageIcon => Icons.account_balance;
  
  @override
  Widget get pageWidget => const HistoricalPage();

  @override
  String getSearchText() {
    StringBuffer fullText = StringBuffer();
    fullText.writeln('آثار باستانی و دیدنی روستای ایراج:');
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
          "آثار باستانی ایراج",
          style: TextStyle(fontFamily: 'Vazirmatn'),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          
          // تعیین تعداد ستون‌ها بر اساس عرض صفحه
          int crossAxisCount;
          double crossAxisSpacing;
          double mainAxisSpacing;
          double iconSize;
          double fontSize;
          double aspectRatio;
          
          if (screenWidth < 380) {
            crossAxisCount = 2;
            crossAxisSpacing = 8;
            mainAxisSpacing = 8;
            iconSize = 32;
            fontSize = 11;
            aspectRatio = 1.0;
          } else if (screenWidth < 480) {
            crossAxisCount = 3;
            crossAxisSpacing = 10;
            mainAxisSpacing = 10;
            iconSize = 36;
            fontSize = 12;
            aspectRatio = 1.0;
          } else if (screenWidth < 600) {
            crossAxisCount = 3;
            crossAxisSpacing = 12;
            mainAxisSpacing = 12;
            iconSize = 40;
            fontSize = 13;
            aspectRatio = 1.1;
          } else if (screenWidth < 800) {
            crossAxisCount = 4;
            crossAxisSpacing = 14;
            mainAxisSpacing = 14;
            iconSize = 44;
            fontSize = 14;
            aspectRatio = 1.1;
          } else {
            crossAxisCount = 5;
            crossAxisSpacing = 16;
            mainAxisSpacing = 16;
            iconSize = 48;
            fontSize = 15;
            aspectRatio = 1.2;
          }

          // محاسبه ارتفاع مناسب برای نمایش تمام آیتم‌ها بدون اسکرول
          final totalItems = items.length;
          final rowsNeeded = (totalItems / crossAxisCount).ceil();
          final availableHeight = constraints.maxHeight - kToolbarHeight - 24;
          final itemHeight = availableHeight / rowsNeeded;
          final itemWidth = (screenWidth - (crossAxisSpacing * (crossAxisCount - 1)) - 24) / crossAxisCount;
          
          // تنظیم aspectRatio بر اساس ابعاد واقعی
          if (itemWidth > 0 && itemHeight > 0) {
            aspectRatio = itemWidth / itemHeight;
            // محدود کردن aspectRatio برای جلوگیری از تغییرات شدید
            if (aspectRatio > 1.4) aspectRatio = 1.4;
            if (aspectRatio < 0.7) aspectRatio = 0.7;
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // جلوگیری از اسکرول
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item["icon"],
                          size: iconSize,
                          color: Colors.teal,
                        ),
                        SizedBox(height: screenWidth < 400 ? 4 : 8),
                        Flexible(
                          child: Text(
                            item["title"],
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Vazirmatn',
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
        },
      ),
    );
  }
}