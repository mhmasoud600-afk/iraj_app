// lib/pages/customs/mourning/mourning_page.dart
import 'package:flutter/material.dart';
import '../../../mixins/searchable_mixin.dart'; // اضافه شد

import 'mourning_imam_hussain.dart';
import 'mourning_deceased.dart';
import 'mourning_fatimiyya.dart';
import 'mourning_other_imams.dart';
import 'mourning_ramadan_nights.dart';

class MourningPage extends StatefulWidget {
  const MourningPage({Key? key}) : super(key: key);

  @override
  State<MourningPage> createState() => _MourningPageState();
}

class _MourningPageState extends State<MourningPage> with SearchableMixin {
  
  final List<Map<String, dynamic>> mourningItems = const [
    {
      'title': 'عزاداری امام‌حسین (ع)',
      'icon': Icons.flag,
      'page': MourningImamHussainPage(),
      'subtitle': 'مراسم عزاداری سالار شهیدان امام حسین (ع)',
      'keywords': 'محرم صفر عاشورا تاسوعا سینه زنی زنجیرزنی تعزیه'
    },
    {
      'title': 'درگذشت اموات',
      'icon': Icons.people,
      'page': MourningDeceasedPage(),
      'subtitle': 'مراسم ختم و یادبود درگذشتگان',
      'keywords': 'ختم ترحیم یادبود فاتحه اموات'
    },
    {
      'title': 'دهه فاطمیه',
      'icon': Icons.woman,
      'page': MourningFatimiyyaPage(),
      'subtitle': 'مراسم عزاداری حضرت فاطمه زهرا (س)',
      'keywords': 'فاطمیه فاطمه زهرا ایام فاطمیه سوگواری'
    },
    {
      'title': 'ماه مبارک رمضان',
      'icon': Icons.nights_stay,
      'page': MourningRamadanNightsPage(),
      'subtitle': 'مراسم شب‌های احیای ماه رمضان',
      'keywords': 'رمضان احیا قدر شب قدر دعا مناجات روزه'
    },
    {
      'title': 'عزاداری سایر ائمه اطهار',
      'icon': Icons.history_edu,
      'page': MourningOtherImamsPage(),
      'subtitle': 'مراسم سوگواری سایر امامان معصوم (ع)',
      'keywords': 'ائمه امام رضا موسی کاظم جواد هادی عسگری'
    },
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'عزاداری‌ها';
  
  @override
  String get pageSubtitle => 'مراسم عزاداری و سوگواری روستا';
  
  @override
  String get pageCategory => 'مذهبی';
  
  @override
  IconData get pageIcon => Icons.sentiment_dissatisfied;
  
  @override
  Widget get pageWidget => const MourningPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('عزاداری‌های روستای ایراج:');
    fullText.writeln();
    
    for (var item in mourningItems) {
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
          "عزاداری‌ها",
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
        ),
        itemCount: mourningItems.length,
        itemBuilder: (context, index) {
          final item = mourningItems[index];
          
          final iconSize = screenHeight * 0.08;
          final titleFontSize = (screenHeight * 0.018).clamp(12.0, 14.0);
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['page']),
              );
            },
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'],
                    size: iconSize,
                    color: Colors.teal,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      item['title'],
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vazirmatn',
                      ),
                      textAlign: TextAlign.center,
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