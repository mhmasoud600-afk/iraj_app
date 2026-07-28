// lib/plain_page.dart
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../services/search_service.dart'; // اضافه شد

class PlainPage extends StatelessWidget {
  const PlainPage({Key? key}) : super(key: key);

  Text _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFFB00020),
      ),
    );
  }

  void _registerForSearch() {
    final service = SearchService();
    
    StringBuffer fullText = StringBuffer();
    fullText.writeln('نقشه دشت و محله‌های روستای ایراج:');
    fullText.writeln();
    
    fullText.writeln('گورگاه‌های اصلی دشت:');
    fullText.writeln('''
۱. گورگاه زیر باغ مد آقا
۲. گورگاه کلنکی
۳. گورگاه قاسمی
۴. گورگاه اشرف
۵. گورگاه پادوله
۶. گورگاه میون دشت
۷. گورگاه یشت باغ عبدالله
۸. گورگاه زیر باغ حاج رضاعلی زیور
۹. گورگاه میراثی
*: محل تقسیم آب کشاورزی به چند شعبه، گورگاه نام دارد
''');
    fullText.writeln();
    
    fullText.writeln('جوی‌های اصلی دشت:');
    fullText.writeln('''
۱. جوی دشت بالا
۲. جوی کلنکی
۳. جوی زیر باغ مدآقا به طرف گودال
۴. جوی قاسمی
۵. جوی زمین اشرف
۶. جوی پا دووله
۷. جوی باغ دراز
۸. جوی اسبسو
۹. جوی غلومو
۱۰. جوی سرکو
۱۱. جوی نوچنگ بلند
۱۲. جوی در خونه رضا
۱۳. جوی در باغ قاضی
''');
    
    fullText.writeln();
    fullText.writeln('نقشه‌های PDF موجود:');
    fullText.writeln('- نقشه محله‌های مسکونی');
    fullText.writeln('- نقشه مناطق مختلف دشت');
    
    service.registerItem(
      SearchItem(
        title: 'نقشه دشت و محله‌ها',
        subtitle: 'نقشه و تقسیمات دشت و محله‌های روستا',
        searchText: fullText.toString(),
        page: const PlainPage(),
        icon: Icons.landscape,
        category: 'طبیعت',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerForSearch();
    });

    return Scaffold(
      appBar: AppBar(title: const Text("نقشه دشت و محله‌ها")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _title("نقشه محله‌های مسکونی"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => const PdfViewerPage(
                  title: "نقشه محله‌های مسکونی",
                  assetPath: "assets/pdf/asli_manataqe_maskooni.pdf",
                ),
              ));
            },
            child: const Text("مشاهده PDF"),
          ),

          const SizedBox(height: 20),
          _title("نقشه مناطق مختلف دشت"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => const PdfViewerPage(
                  title: "نقشه مناطق مختلف دشت",
                  assetPath: "assets/pdf/naghshe_manategh_dasht.pdf",
                ),
              ));
            },
            child: const Text("مشاهده PDF"),
          ),

          const SizedBox(height: 20),
          _title("گورگاه‌های اصلی دشت"),
          const SizedBox(height: 8),
          const Text(
            '''١. گورگاه زير باغ مد آقا
٢. گورگاه كلنكى
٣. گورگاه قاسمى
٤. گورگاه اشرف
٥. گورگاه پادوله
٦. گورگاه ميون دشت
٧. گورگاه يشت باغ عبدالله
٨. گورگاه زير باغ حاج رضاعلى زيور
٩. گورگاه ميراثى

*: محل تقسیم آب کشاورزی به چند شعبه، گورگاه نام دارد''',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 20),
          _title("جوی‌های اصلی دشت"),
          const SizedBox(height: 8),
          const Text(
            '''١. جوی دشت بالا
٢. جوی کلنکی
٣. جوی زیر باغ مدآقا به طرف گودال
٤. جوی قاسمی
٥. جوی زمین اشرف
٦. جوی پا دووله
٧. جوی باغ دراز
٨. جوی اسبسو
٩. جوی غلومو
١٠. جوی سرکو
١١. جوی نوچنگ بلند
١٢. جوی در خونه رضا
١٣.جوی در باغ قاضی''',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String title;
  final String assetPath;

  const PdfViewerPage({Key? key, required this.title, required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SfPdfViewer.asset(assetPath),
    );
  }
}