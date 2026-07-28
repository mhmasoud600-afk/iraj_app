import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PublicServantsPage extends StatefulWidget {
  const PublicServantsPage({Key? key}) : super(key: key);

  @override
  State<PublicServantsPage> createState() => _PublicServantsPageState();
}

class _PublicServantsPageState extends State<PublicServantsPage> {
  // کنترل‌کننده‌های باز و بسته شدن بخش‌های اصلی
  final Map<String, bool> _expandedSections = {
    'shora': true,
    'dehyar': false,
    'behvarz': false,
    'naft': false,
    'ab': false,
    'masjed': false,
    'hoseinieh': false,
    'heyat_masjed': false,
    'heyat_hoseinieh': false,
    'ostadkar': false,
    'maghaze': false,
    'ranande': false,
    'nanva': false,
    'mama': false,
    'ghasal': false,
  };

  // کنترل‌کننده‌های باز و بسته شدن لیست اسامی (برای هر بخش)
  final Map<String, bool> _expandedLists = {
    'shora_list': false,
    'dehyar_list': false,
    'behvarz_list': false,
    'naft_list': false,
    'ab_list': false,
    'masjed_list': false,
    'hoseinieh_list': false,
    'heyat_masjed_list': false,
    'heyat_hoseinieh_list': false,
    'ostadkar_list': false,
    'maghaze_list': false,
    'ranande_list': false,
    'nanva_list': false,
    'mama': false,
    'ghasal': false,
  };

  // لیست رنگ‌های آبی برای سربرگ‌ها (یک‌درمیان)
  final List<Color> headerColors = [
    Colors.blue[300]!.withOpacity(0.9), // آبی کم‌رنگ‌تر
    Colors.blue[700]!.withOpacity(0.9), // آبی پررنگ‌تر
  ];

  // لیست اعضای شورا
  final List<String> shoraMembers = [
    "حاج جعفر اکبر",
    "حاج علی اکبر",
    "رضا اکبر (خیاط)",
    "حاج امیر حسین عشقی",
    "حاج محمدرضا نجفی",
    "رمضان یگانه",
    "مرحوم حاج عبداله یگانه",
    "حاج حجت اله زاهد",
    "مرحوم حاج مهدی نجفی",
    "حسین اکبر (میرزا)",
    "مرحوم نورمحمد یزدانی",
    "حسین اقبال",
    "غلام رضا نجفی",
    "رضا آذر",
    "مهدی یزدانی (کوچک علی)",
    "محمدحسین اشرف",
    "فاطمه کاشف",
    "محمدحسن مسعود",
    "مرحوم فضل اله اکبر",
    "محمد معتمدی (حاج رضا علی)",
    "عبدالناصر عشقی",
    "حاج امیرقلی عشقی",
    "سمیه عشقی",
    "فرهاد نجفی",
    "امیر حسین اشرف",
    "ولی اله یگانه",
  ];

  // لیست دهیاران
  final List<String> dehyarMembers = [
    "حاج حمیدرضا زاهد",
    "محمدحسن مسعود",
    "علی عشقی",
    "مصطفی ایزدی",
    "امید شجاعی",
    "فرید اکبر",
  ];

  // لیست بهورزان
  final List<String> behvarzMembers = [
    "حسن عشقی",
    "بتول مسعود",
    "فاطمه ایزدی",
  ];

  // لیست اسامی مسئولان نفت
  final List<String> naftMembers = [
    "حاج محمد حسین نجفی",
    "حاج محمدرضا نجفی",
    "امیر مختار مسعود",
    "غلام کافی",
  ];

  // لیست مسئولان آب
  final List<String> abMembers = [
    "حاج حبیب اله نجفی",
    "سیدرضا موسوی",
  ];

  // لیست خادمین مسجد
  final List<String> masjedKhademin = [
    "مرحوم رمضان اکبری",
    "حاج حبیب اله نجفی",
    "حاج رضا عشقی",
  ];

  // لیست خادمین حسینیه
  final List<String> hoseiniehKhademin = [
    "مرحوم حاج فتح اله نجفی",
    "مرحوم سید کاظم موسوی",
    "مرحوم حسین بهمن",
    "کربلایی حورا معتمدی",
    "حاج غضنفر اشرف",
    "عبدالحسین اکبر",
  ];

  // لیست هیات امنای مسجد
  final List<String> heyatMasjed = [
    "مرحوم حاج امیر حسین عشقی",
    "مرحوم حاج مهدی نجفی",
    "حاج جعفر اکبر",
    "حمیدرضا زاهد",
    "فرهاد نجفی",
    "حاج رضا عشقی",
    "حاج امیر قلی عشقی",
    "مصطفی ایزدی",
    "محمد معتمدی",
    "احمد نجفی",
    "عزیزنجفی",
  ];

  // لیست هیات امنای حسینیه
  final List<String> heyatHoseinieh = [
    "مرحوم سیدکاظم موسوی",
    "مصطفی ایزدی",
    "عبدالحسین اکبر",
  ];

  // لیست استادکاران
  final List<String> ostadkarMembers = [
    "استاد میرزا",
    "استاد مشهدی",
    "مرحوم حاج محمد عشقی",
    "مرحوم رجبعلی عشقی",
    "مرحوم حسین ثابتی",
    "مرحوم حاج اسماعیل کاشف",
    "حاج حسین اکبر (میرزا)",
    "مهدی یزدانی (جلیل)",
    "مهدی اقبال",
    "هادی اقبال",
    "جابر عشقی",
  ];

  // لیست مغازه‌داران
  final List<String> maghazeMembers = [
    "حاج جعفر اکبر",
    "مرحوم حاج علی اکبر اکبر",
    "مرحوم حاج مهدی نجفی",
    "مرحوم حاج عبداله یگانه",
    "مرحوم حاج محمد عشقی",
    "مرحوم حاج حبیب اله ثابتی",
    "مرحوم شکر اله رفیع",
    "مرحوم حاج اسماعیل ازاد",
    "مرحوم قربانعلی مسعود",
    "احمد عشقی",
    "عباس عرب",
    "حاج علی اصغر زاهد",
    "زهره نجفی",
  ];

  // لیست رانندگان
  final List<String> ranandeMembers = [
    "مرحوم عباس اشرف (مینی‌بوس)",
    "حاج محمدرضا نجفی (خور و نخلک)",
    "مرحوم جمشید نجفی (سنگین)",
    "مرحوم نورمحمد یزدانی (سنگین)",
    "کمال اشرف (سنگین)",
    "حاج علی ثابتی (سنگین)",
    "مرحوم حاج حبیب ثابتی (وانت)",
    "مرحوم قربانعلی اشرف (وانت)",
    "کربلایی حسن عشقی (نیسان)",
     " اصغرعشقی (نیسان)",
    "کربلایی علی حسین اشرف (نیسان)",
    "مرحوم حسن اشرف (نیسان)",
    "حاج علی اصغر زاهد (وانت)",
    "حاج حبیب اله نجفی (وانت)",
    "مصطفی ایزدی (وانت)",

  ];

  // لیست نانوایان
  final List<String> nanvaMembers = [
    "حسین اقبال",
    "مرحوم جلیل یزدانی",
    "مهدی یزدانی (جلیل)",
    "محمدحسن مسعود",
    "حسین یگانه (حسن)",
    "حامد مرادی",
    "علی یگانه (حسین عبدل)",
    "مختار مسعود و همسر",
    "ام‌البنین عشقی",
  ];



final List<String> mamaMembers = [
    ' مرحومه فاطمه سلطان عشقی',
    'مرحومه بی بی محتشم',
    'مرحومه جانی عشقی( کریم)',
    'مرحومه فاطمه صغری اکبر',
    'مرحومه بی بی محتشم ',
    'مرحومه بمونه محتشم',
  ];

  final List<String> ghasalMembers = [
    'مرحومه فاطمه سلطان عشقی',
    'مرحومه بی بی محتشم ',
    'مرحومه بمونه محتشم',
    'مرحومه جانی عشقی(کریم)',
    'مرحومه فاطمه صغری اکبر',
    'حاج معصومه نجفی',
    'حاج فاطمه صغری مسعود',
    'مرحوم حاج عبداله یگانه',
    'مرحوم شاه رضا ایزدی',
    'مرحوم سید هاشم موسوی',
    'مصطفی ایزدی',
  ];

  // تابع ساخت آیتم لیست با شماره در سمت راست و اسم در سمت چپ (با رنگ‌های سبز یک‌درمیان)
  Widget _buildListItem(String text, int index) {
    // تعیین رنگ بر اساس ایندکس (یک‌درمیان) - سبز کمرنگ و سبز کمی پررنگ‌تر
    Color bgColor;
    if (index % 2 == 0) {
      bgColor = Colors.green[50]!; // سبز بسیار کمرنگ
    } else {
      bgColor = Colors.green[100]!; // سبز کمی پررنگ‌تر
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index % 2 == 0 ? Colors.green[300] : Colors.green[600],
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تابع ساخت لیست اسامی با قابلیت نمایش ۳ آیتم و بقیه جمع‌شونده
  Widget _buildExpandableNameList({
    required String listKey,
    required List<String> items,
  }) {
    int displayCount = _expandedLists[listKey] ?? false ? items.length : 3;
    List<String> displayItems = items.take(displayCount).toList();

    return Column(
      children: [
        ...displayItems.asMap().entries.map((entry) {
          int idx = entry.key;
          String item = entry.value;
          return _buildListItem(item, idx);
        }).toList(),
        
        if (items.length > 3)
          InkWell(
            onTap: () {
              setState(() {
                _expandedLists[listKey] = !(_expandedLists[listKey] ?? false);
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expandedLists[listKey] ?? false ? "نمایش کمتر" : "نمایش همه (${items.length} نفر)",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _expandedLists[listKey] ?? false ? Icons.expand_less : Icons.expand_more,
                    color: Colors.green[700],
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // تابع ساخت کادر حدیث با عکس
  Widget _buildHadithCard(String hadithText, String translation, {String? imageAsset}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.green.shade200, width: 1.5),
      ),
      child: Column(
        children: [
          if (imageAsset != null) ...[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[50],
                border: Border.all(color: Colors.green.shade300, width: 2),
              ),
              child: ClipOval(
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.green[300],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text(
            hadithText,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.green.shade200,
          ),
          const SizedBox(height: 8),
          Text(
            translation,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // تابع ساخت کادر معرفی
  Widget _buildInfoCard(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[50]!, Colors.green[100]!],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.5,
        ),
      ),
    );
  }
// تابع ساخت عکس دایره‌ای برای بخش‌ها با قابلیت کلیک و بزرگ‌نمایی
Widget _buildSectionImage(String? imageAsset, BuildContext context, {double size = 100}) {
  if (imageAsset == null) return const SizedBox.shrink();
  
  return GestureDetector(
    onTap: () {
      _showFullScreenImage(context, imageAsset);
    },
    child: Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green[50],
        border: Border.all(color: Colors.green.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imageAsset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.image_not_supported,
                size: size * 0.5,
                color: Colors.green[300],
              ),
            );
          },
        ),
      ),
    ),
  );
}

// تابع نمایش عکس در اندازه بزرگ با قابلیت زوم
void _showFullScreenImage(BuildContext context, String imageAsset) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'نمایش تصویر',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
          child: PhotoView(
            imageProvider: AssetImage(imageAsset),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    ),
  );
}

  // تابع ساخت بخش با قابلیت جمع‌شدن (با رنگ‌های آبی یک‌درمیان برای سربرگ‌ها)
  Widget _buildExpandableSection({
    required String title,
    required String sectionKey,
    required String listKey,
    required List<String> items,
    required int sectionIndex, // ایندکس بخش برای رنگ‌بندی یک‌درمیان
    String? imageAsset,
    String? hadithText,
    String? hadithTranslation,
    String? infoText,
  }) {
    // انتخاب رنگ سربرگ بر اساس ایندکس بخش (یک‌درمیان)
    Color headerColor = headerColors[sectionIndex % 2];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[sectionKey] = !(_expandedSections[sectionKey] ?? false);
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    _expandedSections[sectionKey] ?? false ? Icons.expand_less : Icons.expand_more,
                    color: Colors.white,
                    size: 22,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),
          ),
          if (_expandedSections[sectionKey] ?? false)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  if (imageAsset != null) _buildSectionImage(imageAsset, context),
                  if (hadithText != null && hadithTranslation != null)
                    _buildHadithCard(hadithText, hadithTranslation),
                  if (infoText != null) _buildInfoCard(infoText),
                  const SizedBox(height: 8),
                  _buildExpandableNameList(
                    listKey: listKey,
                    items: items,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "خادمین مردم",
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[800], // رنگ ثابت برای AppBar
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            
            // عکس اصلی صفحه
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[100],
                border: Border.all(color: Colors.blue[800]!, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/public_servants/main.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.people_alt,
                        size: 60,
                        color: Colors.blue[800],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // متن بالای صفحه
            const Text(
              'خادمین مردم روستای ایراج',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: const Text(
                '«خَيْرُ النّاسِ اَنْفَعُهُمْ لِلنّاسِ»',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // بخش شورا (ایندکس 0)
            _buildExpandableSection(
              title: 'اعضای شورای اسلامی روستا',
              sectionKey: 'shora',
              listKey: 'shora_list',
              items: shoraMembers,
              sectionIndex: 0,
              imageAsset: 'assets/images/public_servants/shora.jpg',
              hadithText: 'قالَ رَسُولُ اللّهِ صلي الله عليه و آله: مَنْ سَعى فِى حاجَةِ اَخيهِ الْمُؤْمِنِ فَكَاَنَّما عَبَدَاللّهَ تِسْعَةَ الافِ سَنَةٍ صآئِما نَهارَهُ، قَائِما لَيْلَهُ.',
              hadithTranslation: 'پیامبر گرامى اسلام صلى الله عليه و آله فرمود: كسى كه براى رفع نياز برادر مؤمن خود كوشش كند مثل اين است كه نه هزار سال خداوند متعال را عبادت كرده در حاليكه روزها روزه بوده و شبها را هم شب زنده‌دارى مى‌كرده است.',
              infoText: 'این عزیزان  در سال‌های قبل عضو شورای اسلامی روستا بودند و زحمت مدیریت کارهای آبادی را بعهده داشتند که از زحمات ایشان کمال تشکر و قدردانی را داریم.',
            ),

            // بخش دهیاران (ایندکس 1)
            _buildExpandableSection(
              title: 'دهیاران ایراج از ابتدا تا کنون',
              sectionKey: 'dehyar',
              listKey: 'dehyar_list',
              items: dehyarMembers,
              sectionIndex: 1,
              imageAsset: 'assets/images/public_servants/dehyar.jpg',
            ),

            // بخش بهورزان (ایندکس 2)
            _buildExpandableSection(
              title: 'بهورزان خانه بهداشت ایراج',
              sectionKey: 'behvarz',
              listKey: 'behvarz_list',
              items: behvarzMembers,
              sectionIndex: 2,
              imageAsset: 'assets/images/public_servants/behvarz.jpg',
              hadithText: 'عَنِ الصّادِقِ عليه السلام قالَ: ما قَضى مُسْلِمٌ لِمُسْلِمٍ حاجَةً اِلاّناداهُ اللّهُ تَبارَكَ وَتَعالى عَلَىَّ ثَوابُكَ وَلا اَرْضى لَكَ بِدُونِ الْجَنَّةِ.',
              hadithTranslation: 'امام صادق عليه السلام فرمود: هر مسلمانى كه نياز و حاجت مسلمانى را برطرف نمايد خداى متعال به او مى‌فرمايد: اجر و ثواب تو بعهده منست و به كمتر از بهشت براى تو راضى نخواهم شد.',
              infoText: 'بهورزان عزیز که سال‌ها در خانه بهداشت ایراج مشغول خدمت بودند',
            ),

            // بخش شعبه نفت (ایندکس 3)
            _buildExpandableSection(
              title: 'شعبه نفت ایراج',
              sectionKey: 'naft',
              listKey: 'naft_list',
              items: naftMembers,
              sectionIndex: 3,
              imageAsset: 'assets/images/public_servants/naft.jpg',
              infoText: 'ضمن تشکر و قدردانی از جناب حاج محمد حسین نجفی و حاج محمدرضا نجفی که سالهای سال مدیریت پخش شعبه نفت ایراج را برعهده داشتند و همچنین تشکر از آقای امیر مختار مسعود و آقای غلام کافی که در سال‌های اخیر به آقای حاج محمدرضا نجفی در پخش نفت در روستا کمک نموده‌اند',
            ),

            // بخش مسئول آب (ایندکس 4)
            _buildExpandableSection(
              title: 'مسئولان آب آشامیدنی',
              sectionKey: 'ab',
              listKey: 'ab_list',
              items: abMembers,
              sectionIndex: 4,
              imageAsset: 'assets/images/public_servants/water.jpg',
              hadithText: 'عَنِ النَّبِىِّ صلي الله عليه و آله: اِنَّ اللّهَ فِى عَوْنِ الْمُؤمِنِ مادامَ الْمُؤْمِنُ فِى عَوْنِ اَخِيهِ الْمُؤْمِنِ.',
              hadithTranslation: 'پيامبر اكرم صلى الله عليه و آله فرمود: تا زمانى كه مؤمن در كمك به برادر مؤمن خود كوشا باشد، خدا هم او را كمك و يارى خواهد كرد.',
              infoText: 'با تشکر از عزیزانی که سالهای سال مدیریت آب آشامیدنی روستا را برعهده داشتند و هیچ کسی متوجه زحمت‌های ایشان نمی‌شد مگر زمانی که آب آشامیدنی روستا قطع می‌شد',
            ),

            // بخش خادمین مسجد (ایندکس 5)
            _buildExpandableSection(
              title: 'خادمین مسجد امام حسین (ع)',
              sectionKey: 'masjed',
              listKey: 'masjed_list',
              items: masjedKhademin,
              sectionIndex: 5,
              imageAsset: 'assets/images/public_servants/masjed.jpg',
              infoText: 'خدمت بی‌منت شما، چراغ راه ما در مسیر عشق به اهل بیت است، از صمیم قلب تشکر می‌کنیم.',
            ),

            // بخش خادمین حسینیه (ایندکس 6)
            _buildExpandableSection(
              title: 'خادمین حسینیه',
              sectionKey: 'hoseinieh',
              listKey: 'hoseinieh_list',
              items: hoseiniehKhademin,
              sectionIndex: 6,
              imageAsset: 'assets/images/public_servants/hoseinieh.jpg',
            ),

            // بخش هیات امنای مسجد (ایندکس 7)
            _buildExpandableSection(
              title: 'هیات امنای مسجد امام حسین (ع)',
              sectionKey: 'heyat_masjed',
              listKey: 'heyat_masjed_list',
              items: heyatMasjed,
              sectionIndex: 7,
              imageAsset: 'assets/images/public_servants/heyat_masjed.jpg',
              infoText: 'خادمین عزیز هیئت، خدمت شما بهترین جلوه‌ی عشق به اهل بیت (ع) است، از شما صمیمانه سپاسگزاریم',
            ),

            // بخش هیات امنای حسینیه (ایندکس 8)
            _buildExpandableSection(
              title: 'هیات امنای حسینیه',
              sectionKey: 'heyat_hoseinieh',
              listKey: 'heyat_hoseinieh_list',
              items: heyatHoseinieh,
              sectionIndex: 8,
              imageAsset: 'assets/images/public_servants/heyat_hoseinieh.jpg',
            ),

            // بخش استادکاران (ایندکس 9)
            _buildExpandableSection(
              title: 'استادکاران',
              sectionKey: 'ostadkar',
              listKey: 'ostadkar_list',
              items: ostadkarMembers,
              sectionIndex: 9,
              imageAsset: 'assets/images/public_servants/ostadkar.jpg',
              hadithText: 'قالَ الصّادِقُ عليه السلام: مَنْ عَرِقَتْ جَبْهَتُهُ فِى حاجَةِ اَخِيهِ فِى اللّهِ عَزَّوَجَلَّ لَمْ يُعَذِّبْهُ بَعْدَ ذلِكَ.',
              hadithTranslation: 'امام صادق عليه السلام فرمود: كسى كه پيشانيش در مسير برآوردن نياز برادر دينى خود عرق بريزد، خداوند عزوجل او را بعد از آن عذاب نخواهد كرد.',
            ),

            // بخش مغازه‌داران (ایندکس 10)
            _buildExpandableSection(
              title: 'مغازه‌داران',
              sectionKey: 'maghaze',
              listKey: 'maghaze_list',
              items: maghazeMembers,
              sectionIndex: 10,
              imageAsset: 'assets/images/public_servants/maghaze.jpg',
              hadithText: 'قالَ الْحُسَيْنُ بْنُ عَلىٍّ عليه السلام: اِنَّ حَوائجَ النّاسِ اِلَيْكُمْ مِنْ نِعَمِ اللّهِ عَلَيْكُمْ، فَلاتَمِلُّوا النِّعَمَ.',
              hadithTranslation: 'امام حسين عليه السلام فرمود: نيازهاى مردم به شما از نعمتهاى الهى است براى شما، بنابراين از اين نعمتها خسته نشويد.',
            ),

            // بخش رانندگان (ایندکس 11)
            _buildExpandableSection(
              title: 'رانندگان',
              sectionKey: 'ranande',
              listKey: 'ranande_list',
              items: ranandeMembers,
              sectionIndex: 11,
              imageAsset: 'assets/images/public_servants/ranande.jpg',
              hadithText: 'عَنِ النَّبِىِّ صلي الله عليه و آله، قالَ: مَنْ قَضى حاجَةً لاَِخيهِ كُنْتُ واقِفا عِنْدَ مِيزانِهِ فَاِنْ رَجَحَ وَاِلاّ شَفَّعْتُ لَهُ.',
              hadithTranslation: 'پيامبر گرامى اسلام صلى الله عليه و آله فرمود: كسى كه نياز برادر دينى خود را بر طرف نمايد من در موقع سنجش اعمال او حاضر خواهم شد، اگر موفق بود كه هيچ، والا او را شفاعت مى‌كنم.',
              infoText: 'در قدیم تعداد وسایل نقلیه در روستا بسیار کم بود و مردم برای رفت و آمد به خور و جاهای دیگر و حمل بار با مشکلاتی روبرو بودند. چندین سال قبل، ایراج دارای دو مینی‌بوس و یک اتوبوس بود و تعدادی راننده ماشین سنگین و ماشین وانت و نیسان که به مردم کمک می‌کردند.',
            ),

            // بخش نانوایان (ایندکس 12)
            _buildExpandableSection(
              title: 'نانوایان',
              sectionKey: 'nanva',
              listKey: 'nanva_list',
              items: nanvaMembers,
              sectionIndex: 12,
              imageAsset: 'assets/images/public_servants/nanva.jpg',
              infoText: 'نانوای زحمتکش، عرق جبین شما آبروی سفره‌های ایرانی است',
            ),

// بخش ماماها
            _buildExpandableSection(
             title:  'ماماها',
             sectionKey: 'mama',
             listKey:'mama_list',
             items: mamaMembers,
             sectionIndex: 13,
             hadithText: '«إِنَّ الْوَلَدَ الصَّالِحَ رَیْحَانَهٌ مِنْ رَیَاحِینِ الْجَنَّه.»\n\n(الکافی، ج۶، ص۳)',
             hadithTranslation: '«فرزند شایسته و خوب، گلی از گل های بهشت است.»',
            
            ),
           

            // بخش غسال‌ها
            _buildExpandableSection(
            title:'غسال‌ها',
            sectionKey: 'ghasal',
            listKey:'ghasal_list',
            items: ghasalMembers,
            sectionIndex: 14,
            
              hadithText: '«مَن تَرقَّبَ المَوتَ تَرَكَ اللّذّات.»\n\n(شهاب‌الاخبار، ص ۱۴۶)',
             hadithTranslation: '«کسی که همواره به یاد مرگ باشد از هوی و هوس‌ها چشم‌پوشی می‌کند.»',
            ),
           


            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}