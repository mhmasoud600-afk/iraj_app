// lib/pages/farms/farms_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart';

// صفحات جداگانه
import 'menk_page.dart';
import 'eslamdasht_page.dart';
import 'akharak_page.dart';
import 'behin_page.dart';
import 'cheshmeh_senjed_page.dart';
import 'kashfieh_page.dart';
import 'kalateh_bala_page.dart';
import 'kalateh_paeein_page.dart';
import 'kahinu_page.dart';
import 'abgadu_page.dart';
import 'ofrang_page.dart';
import 'goolar_page.dart';
// صفحات جدید
import 'khorramabad_page.dart';
import 'domo_page.dart';
import 'bondar_page.dart';

class FarmsPage extends StatefulWidget {
  const FarmsPage({Key? key}) : super(key: key);

  @override
  State<FarmsPage> createState() => _FarmsPageState();
}

class _FarmsPageState extends State<FarmsPage> with SearchableMixin {
  
  final List<Map<String, dynamic>> items = const [
    {"title": "مزرعه مِنک", "icon": Icons.grass, "page": MenkPage()},
    {"title": "مزرعه اسلام دشت", "icon": Icons.handshake, "page": EslamDashtPage()},
    {"title": "مزرعه آخُرَک", "icon": Icons.landscape, "page": AkharakPage()},
    {"title": "مزرعه بَهین", "icon": Icons.eco, "page": BehinPage()},
    {"title": "مزرعه چشمه سنجد", "icon": Icons.local_florist, "page": CheshmehSenjedPage()},
    {"title": "مزرعه کاشفیه", "icon": Icons.search, "page": KashfiehPage()},
    {"title": "مزرعه کلاته بالا", "icon": Icons.terrain, "page": KalatehBalaPage()},
    {"title": "مزرعه کلاته پایین", "icon": Icons.park, "page": KalatehPaeeinPage()},
    {"title": "مزرعه کُهینو", "icon": Icons.forest, "page": KahinuPage()},
    {"title": "مزرعه آبگادو", "icon": Icons.water, "page": AbgaduPage()},
    {"title": "مزرعه اُفرنگ", "icon": Icons.sunny, "page": OfrangPage()},
    {"title": "مزرعه گولار", "icon": Icons.agriculture, "page": GoolarPage()},
    {"title": "مزرعه خرم آباد", "icon": Icons.nature, "page": KhorramabadPage()},
    {"title": "مزرعه دومو", "icon": Icons.terrain, "page": DomoPage()},
    {"title": "مزرعه بُندَر", "icon": Icons.beach_access, "page": BondarPage()},
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'مزارع اطراف';
  
  @override
  String get pageSubtitle => 'مزارع و زمین‌های کشاورزی اطراف روستا';
  
  @override
  String get pageCategory => 'محصولات';
  
  @override
  IconData get pageIcon => Icons.agriculture;
  
  @override
  Widget get pageWidget => const FarmsPage();

  @override
  String getSearchText() {
    StringBuffer fullText = StringBuffer();
    fullText.writeln('مزارع اطراف روستای ایراج:');
    fullText.writeln();
    
    for (var item in items) {
      fullText.writeln('--- ${item['title']} ---');
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "مزارع اطراف روستا",
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.2,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => item["page"]),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal.withOpacity(0.1),
                        ),
                        child: Icon(
                          item["icon"],
                          size: 36,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          item["title"],
                          style: const TextStyle(
                            fontSize: 12,
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
        ),
      ),
    );
  }
}