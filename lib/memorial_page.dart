// lib/memorial_page.dart
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../mixins/searchable_mixin.dart'; // اضافه شد

class MemorialPage extends StatefulWidget {
  const MemorialPage({Key? key}) : super(key: key);

  @override
  State<MemorialPage> createState() => _MemorialPageState();
}

class _MemorialPageState extends State<MemorialPage> with SearchableMixin {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool autoPlay = true;

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'عکس درگذشتگان';
  
  @override
  String get pageSubtitle => 'گالری تصاویر درگذشتگان روستا';
  
  @override
  String get pageCategory => 'فرهنگی';
  
  @override
  IconData get pageIcon => Icons.image;
  
  @override
  Widget get pageWidget => const MemorialPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام اسامی درگذشتگان
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('درگذشتگان روستای ایراج:');
    
    for (var photo in photos) {
      if (photo['desc'] != null && photo['desc']!.isNotEmpty) {
        fullText.writeln(photo['desc']);
      }
    }
    
    return fullText.toString();
  }

  @override
  void initState() {
    super.initState();
    registerForSearch();
    _startSlideshow();
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    _pageController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  // ==================== لیست عکس‌ها و توضیحات ====================
  final List<Map<String, String>> photos = [
    {"path": "assets/images/memorial/0.jpg", "desc": "."},
    {"path": "assets/images/memorial/1.jpg", "desc": "."},
    {"path": "assets/images/memorial/2.jpg", "desc": "مرحوم حاج سید مرتضی موسوی"},
    {"path": "assets/images/memorial/3.jpg", "desc": "مرحوم صفر نجفی (صفر اگبر)"},
    {"path": "assets/images/memorial/4.jpg", "desc": "مرحوم علیرضا مسعود (زین العابدین)"},
    {"path": "assets/images/memorial/5.jpg", "desc": "مرحوم حسن اکبر (عباسعلی)"},
    {"path": "assets/images/memorial/6.jpg", "desc": "مرحوم خداداد نجفی"},
    {"path": "assets/images/memorial/7.jpg", "desc": "مرحومه صفورا موبد (محمد حسن)"},
    {"path": "assets/images/memorial/8.jpg", "desc": "مرحوم علی اکبر نجفی (حاج محمد)"},
    {"path": "assets/images/memorial/9.jpg", "desc": "مرحوم حاج عباسعلی اقبال"},
    {"path": "assets/images/memorial/10.jpg", "desc": "مرحومه نوشابه موسوی (نوشی)"},
    {"path": "assets/images/memorial/11.jpg", "desc": "مرحومه ذلیخا اکبر"},
    {"path": "assets/images/memorial/12.jpg", "desc": "مرحوم حسین یگانه (حسین عبدل)"},
    {"path": "assets/images/memorial/13.jpg", "desc": "مرحوم حاج اسماعیل آزاد (حاج اسمال)"},
    {"path": "assets/images/memorial/14.jpg", "desc": "مرحوم حسین ثابتی (ذلیخا)"},
    {"path": "assets/images/memorial/15.jpg", "desc": "مرحومان حسین بهمن و حاج صغری"},
    {"path": "assets/images/memorial/16.jpg", "desc": "مرحومان رمضان اکبری و حاجی مشهدی"},
    {"path": "assets/images/memorial/17.jpg", "desc": "مرحومان زهرا محتشم و فاطمه رحمانی"},
    {"path": "assets/images/memorial/18.jpg", "desc": "مرحوم ابوالحسن اکبر (قاضی)"},
    {"path": "assets/images/memorial/19.jpg", "desc": "مرحومان علی اکبر نجفی و حاج نرگس"},
    {"path": "assets/images/memorial/20.jpg", "desc": "مرحوم یوسف اکبر (سیما)"},
    {"path": "assets/images/memorial/21.jpg", "desc": "مرحومان حاج سید هاشم موسوی و حسین بهمن"},
    {"path": "assets/images/memorial/22.jpg", "desc": "مرحومان یداله اکبر (موسی علی و همسرش)"},
    {"path": "assets/images/memorial/23.jpg", "desc": "مرحوم حاج سید کاظم موسوی"},
    {"path": "assets/images/memorial/24.jpg", "desc": "مرحوم نظر علی یگانه"},
    {"path": "assets/images/memorial/25.jpg", "desc": "مرحومه خدیجه یگانه"},
    {"path": "assets/images/memorial/26.jpg", "desc": "مرحوم عباس یازان (رباطی)"},
    {"path": "assets/images/memorial/27.jpg", "desc": "مرحومه مروارید یزدانی"},
    {"path": "assets/images/memorial/28.jpg", "desc": "مرحوم علی آقا کاشف"},
    {"path": "assets/images/memorial/29.jpg", "desc": "مرحوم حسین اشرف (فتح اله)"},
    {"path": "assets/images/memorial/30.jpg", "desc": "مرحومه عذرا عشقی"},
    {"path": "assets/images/memorial/31.jpg", "desc": "مرحومه سکینه عمو"},
    {"path": "assets/images/memorial/32.jpg", "desc": "مرحومه فاطمه صغری یگانه (کوکب)"},
    {"path": "assets/images/memorial/33.jpg", "desc": "مرحوم جعفر اکبر (چوپان)"},
    {"path": "assets/images/memorial/34.jpg", "desc": "مرحومه زهرا محتشم"},
    {"path": "assets/images/memorial/35.jpg", "desc": "مرحوم میرزا محمد مسعود"},
    {"path": "assets/images/memorial/36.jpg", "desc": ""},
    {"path": "assets/images/memorial/37.jpg", "desc": "مرحومان سید هاشم موسوی و حاج عبداله مسعود"},
    {"path": "assets/images/memorial/38.jpg", "desc": "مرحومه حاج سروی"},
    {"path": "assets/images/memorial/39.jpg", "desc": "مرحوم عباسعلی اکبر"},
    {"path": "assets/images/memorial/40.jpg", "desc": "مرحوم حسین نجفی (صفر)"},
    {"path": "assets/images/memorial/41.jpg", "desc": "مرحوم حاج علی اکبر اکبر"},
    {"path": "assets/images/memorial/42.jpg", "desc": "مرحوم حاج رضا یزدانی (حسین شریف)"},
    {"path": "assets/images/memorial/43.jpg", "desc": "مرحوم رجبعلی عشقی"},
    {"path": "assets/images/memorial/44.jpg", "desc": "مرحوم یعقوب ابوالحسنی"},
    {"path": "assets/images/memorial/45.jpg", "desc": "مرحوم حسن رفیع (رضا رقلی)"},
    {"path": "assets/images/memorial/46.jpg", "desc": "مرحوم حسین دانا (مراد)"},
    {"path": "assets/images/memorial/47.jpg", "desc": "مرحوم ذبیح اله اکبر"},
    {"path": "assets/images/memorial/48.jpg", "desc": "مرحوم حاج حسین کاشف"},
    {"path": "assets/images/memorial/49.jpg", "desc": "مرحوم حاجی عشقی"},
    {"path": "assets/images/memorial/50.jpg", "desc": "مرحوم جمشید نجفی"},
    {"path": "assets/images/memorial/51.jpg", "desc": "مرحوم اسداله یزدانی"},
    {"path": "assets/images/memorial/52.jpg", "desc": "مرحوم کربلایی محمد نجفی"},
    {"path": "assets/images/memorial/53.jpg", "desc": "مرحوم یداله اکبر (موسی علی)"},
    {"path": "assets/images/memorial/54.jpg", "desc": "مرحوم علی آقا عشقی"},
    {"path": "assets/images/memorial/55.jpg", "desc": "مرحوم یداله نجفی (حسین)"},
    {"path": "assets/images/memorial/56.jpg", "desc": "مرحوم امامقلی نجفی"},
    {"path": "assets/images/memorial/57.jpg", "desc": "مرحوم محمدبرومند عامری"},
    {"path": "assets/images/memorial/58.jpg", "desc": "مرحومان ابوالحسن اکبر و مرحومه نوشی"},
    {"path": "assets/images/memorial/59.jpg", "desc": "مرحوم منوچهر نجفی"},
    {"path": "assets/images/memorial/60.jpg", "desc": "مرحوم سعید اقبال"},
    {"path": "assets/images/memorial/61.jpg", "desc": "مرحومه فاطمه صغری اکبر"},
    {"path": "assets/images/memorial/62.jpg", "desc": "مرحوم حبیب مرادی"},
    {"path": "assets/images/memorial/63.jpg", "desc": "مرحوم روشنعلی دانا"},
    {"path": "assets/images/memorial/64.jpg", "desc": "مرحومه محترم نجفی"},
    {"path": "assets/images/memorial/65.jpg", "desc": "مرحوم غلام رضا دانا"},
    {"path": "assets/images/memorial/66.jpg", "desc": "مرحومه فاطمه سلطان نجفی"},
    {"path": "assets/images/memorial/67.jpg", "desc": "مرحوم محمدحسین نجفی"},
    {"path": "assets/images/memorial/68.jpg", "desc": "مرحوم اصغر یزدانی (غلامعلی)"},
    {"path": "assets/images/memorial/69.jpg", "desc": "مرحوم عباس اکبر"},
    {"path": "assets/images/memorial/70.jpg", "desc": "مرحوم محمدحسین یگانه"},
    {"path": "assets/images/memorial/71.jpg", "desc": "مرحوم نورمحمد یزدانی"},
    {"path": "assets/images/memorial/72.jpg", "desc": "مرحوم غلامرضا زاهد"},
    {"path": "assets/images/memorial/73.jpg", "desc": "مرحومان نوراله یزدانی و علی اکبر نجفی (اگبر حسین)"},
    {"path": "assets/images/memorial/74.jpg", "desc": "مرحوم کوچعلی یزدانی"},
    {"path": "assets/images/memorial/75.jpg", "desc": "مرحوم اسفندیار معتمدی"},
    {"path": "assets/images/memorial/76.jpg", "desc": "مرحوم غلامرضا مسعود"},
    {"path": "assets/images/memorial/77.jpg", "desc": "مرحوم حاج رضا علی معتمدی"},
    {"path": "assets/images/memorial/78.jpg", "desc": "مرحومان علی اصغر مسعود و قربانعلی اشرف"},
    {"path": "assets/images/memorial/79.jpg", "desc": "مرحومان حاج محمدحسن موبد و همسرشان"},
    {"path": "assets/images/memorial/80.jpg", "desc": "مرحوم بخشعلی عشقی (ملا بخشعلی)"},
    {"path": "assets/images/memorial/81.jpg", "desc": "مرحوم حاج رضا علی عشقی"},
    {"path": "assets/images/memorial/82.jpg", "desc": "مرحوم حاج احمد پاریاب"},
    {"path": "assets/images/memorial/83.jpg", "desc": "مرحوم حاج فیض اله دانا"},
    {"path": "assets/images/memorial/84.jpg", "desc": "مرحومان روشنعلی دانا و فاطمه سلطان اکبر"},
    {"path": "assets/images/memorial/85.jpg", "desc": "مرحوم حسن اشرف (ماه بانو)"},
    {"path": "assets/images/memorial/86.jpg", "desc": "مرحومه حاج صدیقه عشقی"},
    {"path": "assets/images/memorial/87.jpg", "desc": "مرحومه سیکنه اکبر و مرحومه کلثوم عشقی"},
    {"path": "assets/images/memorial/88.jpg", "desc": "مرحومه مریم نجفی"},
    {"path": "assets/images/memorial/89.jpg", "desc": "مرحوم حاج حسین اکبر (عباسعلی)"},
    {"path": "assets/images/memorial/90.jpg", "desc": "مرحومه ارشد نسا عامری"},
    {"path": "assets/images/memorial/91.jpg", "desc": "مرحومه گلستان شفایی"},
    {"path": "assets/images/memorial/92.jpg", "desc": ""},
    {"path": "assets/images/memorial/93.jpg", "desc": "مرحومه صفیه محسنی"},
    {"path": "assets/images/memorial/94.jpg", "desc": ""},
    {"path": "assets/images/memorial/95.jpg", "desc": "مرحوم ابراهیم کاشف"},
    {"path": "assets/images/memorial/96.jpg", "desc": ""},
    {"path": "assets/images/memorial/97.jpg", "desc": ""},
    {"path": "assets/images/memorial/98.jpg", "desc": ""},
    {"path": "assets/images/memorial/99.jpg", "desc": "مرحوم حسن یگانه"},
    {"path": "assets/images/memorial/100.jpg", "desc": "مرحومان حسین اشرف و منوچهر نجفی"},
    {"path": "assets/images/memorial/101.jpg", "desc": "مرحومه زهرا نجفی (یعقوب)"},
    {"path": "assets/images/memorial/102.jpg", "desc": "مرحومان عباس سیما و فاطمه عرب"},
    {"path": "assets/images/memorial/103.jpg", "desc": "مرحومان حاج عباسعلی دانا و حاجیه کوکب موبد"},
    {"path": "assets/images/memorial/104.jpg", "desc": "مرحومه عزت اکبر"},
    {"path": "assets/images/memorial/105.jpg", "desc": "مرحوم خسرو مسعود (مینا)"},
    {"path": "assets/images/memorial/106.jpg", "desc": "مرحوم جلیل یزدانی"},
    {"path": "assets/images/memorial/107.jpg", "desc": "مرحوم عباس اکبری (حسن)"},
    {"path": "assets/images/memorial/108.jpg", "desc": ""},
    {"path": "assets/images/memorial/109.jpg", "desc": ""},
    {"path": "assets/images/memorial/110.jpg", "desc": "مرحوم حکمت مرتضوی"},
    {"path": "assets/images/memorial/111.jpg", "desc": "مرحوم محمد حسین نجفی"},
    {"path": "assets/images/memorial/112.jpg", "desc": ""},
    {"path": "assets/images/memorial/113.jpg", "desc": "مرحوم عبداله یگانه"},
    {"path": "assets/images/memorial/114.jpg", "desc": "مرحوم امراله یزدانی"},
    {"path": "assets/images/memorial/115.jpg", "desc": "مرحوم داداله یزدانی"},
    {"path": "assets/images/memorial/116.jpg", "desc": "مرحومه کوکب"},
    {"path": "assets/images/memorial/117.jpg", "desc": "مرحومه کوکب کاشف"},
    {"path": "assets/images/memorial/118.jpg", "desc": "مرحومان حسین دانا (مراد) و حاج صدیقه"},
    {"path": "assets/images/memorial/119.jpg", "desc": "مرحوم کربلایی محمد نجفی"},
    {"path": "assets/images/memorial/120.jpg", "desc": "مرحومه محترم نجفی"},
    {"path": "assets/images/memorial/121.jpg", "desc": "مرحومه پری"},
    {"path": "assets/images/memorial/122.jpg", "desc": "مرحومه جمیله عشقی"},
    {"path": "assets/images/memorial/123.jpg", "desc": "مرحومه فاطمه نسا"},
    {"path": "assets/images/memorial/124.jpg", "desc": "مرحومه"},
    {"path": "assets/images/memorial/125.jpg", "desc": "مرحومه"},
    {"path": "assets/images/memorial/126.jpg", "desc": ""},
    {"path": "assets/images/memorial/127.jpg", "desc": "مرحومان حسین کاشف و فاطمه صغری آذر"},
    {"path": "assets/images/memorial/128.jpg", "desc": "مرحومه ماهرخ (همسر مرحوم حاج رضا یزدانی)"},
    {"path": "assets/images/memorial/129.jpg", "desc": "مرحومه حاجیه منور عشقی"},
    {"path": "assets/images/memorial/130.jpg", "desc": "مرحومه سلطان یگانه"},
    {"path": "assets/images/memorial/131.jpg", "desc": "مرحوم ابراهیم ثابتی"},
    {"path": "assets/images/memorial/132.jpg", "desc": "مرحومه حاج زینب"},
    {"path": "assets/images/memorial/133.jpg", "desc": "مرحومه"},
    {"path": "assets/images/memorial/134.jpg", "desc": "مرحومه حاج خانم شفایی (میرزا ملا)"},
    {"path": "assets/images/memorial/135.jpg", "desc": "مرحوم حاج مهدی نجفی"},
    {"path": "assets/images/memorial/136.jpg", "desc": "مرحومان حاج عباس اشرف و خانم رحمانی"},
    {"path": "assets/images/memorial/137.jpg", "desc": "مرحومه کربلایی فاطمه نجفی (علی اکبر)"},
    {"path": "assets/images/memorial/138.jpg", "desc": "مرحوم حاج رضا علی شفایی"},
    {"path": "assets/images/memorial/139.jpg", "desc": "مرحومه آمنه"},
    {"path": "assets/images/memorial/140.jpg", "desc": "مرحومه حاج صغری عیدانه"},
    {"path": "assets/images/memorial/141.jpg", "desc": "مرحوم حاج فتح اله نجفی"},
    {"path": "assets/images/memorial/142.jpg", "desc": "مرحومه حاج سکینه اکبر"},
    {"path": "assets/images/memorial/143.jpg", "desc": "مرحومه صنمبر و بی بی"},
    {"path": "assets/images/memorial/144.jpg", "desc": "مرحومه صنمبر نجفی"},
    {"path": "assets/images/memorial/145.jpg", "desc": "مرحوم فضل اله اکبر"},
    {"path": "assets/images/memorial/146.jpg", "desc": "مرحوم حاج اکبر یزدانی"},
    {"path": "assets/images/memorial/147.jpg", "desc": "مرحوم مصطفی بهمن"},
    {"path": "assets/images/memorial/148.jpg", "desc": "مرحوم محمدباقر شفایی"},
    {"path": "assets/images/memorial/149.jpg", "desc": "مرحوم صدیف اشرف"},
    {"path": "assets/images/memorial/150.jpg", "desc": "مرحوم حسن عشقی (سیما)"},
    {"path": "assets/images/memorial/151.jpg", "desc": "مرحوم عباس یزدانی (لیلا)"},
    {"path": "assets/images/memorial/152.jpg", "desc": "مرحوم علی یگانه (محمدحسین)"},
    {"path": "assets/images/memorial/153.jpg", "desc": "مرحوم عباس رفیع"},
    {"path": "assets/images/memorial/154.jpg", "desc": "مرحوم محمدرضا مسعود (قربانعلی)"},
    {"path": "assets/images/memorial/155.jpg", "desc": "مرحوم محمدحسن مسعود (قربانعلی)"},
    {"path": "assets/images/memorial/156.jpg", "desc": "مرحومه منور عشقی"},
    {"path": "assets/images/memorial/157.jpg", "desc": "مرحوم حاج امیر حسین عشقی"},
    {"path": "assets/images/memorial/158.jpg", "desc": "مرحوم حاج اسماعیل کاشف"},
    {"path": "assets/images/memorial/159.jpg", "desc": "مرحوم اسد اله هدایت"},
    {"path": "assets/images/memorial/160.jpg", "desc": "مرحومه معصومه عامری (رمضان)"},
    {"path": "assets/images/memorial/161.jpg", "desc": "مرحوم حسین جمشیدی"},
    {"path": "assets/images/memorial/162.jpg", "desc": "مرحومه حاجیه فاطمه نساء نجفی"},
    {"path": "assets/images/memorial/163.jpg", "desc": "مرحوم سعید یگانه (حسن)"},
    {"path": "assets/images/memorial/164.jpg", "desc": "مرحوم سید محمود محسنی"},
    {"path": "assets/images/memorial/165.jpg", "desc": "مرحومان عزیز اله یگانه و محمد رضا یزدانی"},
    {"path": "assets/images/memorial/166.jpg", "desc": "مرحومه ماهرخ رفیع "},
    {"path": "assets/images/memorial/167.jpg", "desc": "مرحوم حسنعلی آذر"},
    {"path": "assets/images/memorial/168.jpg", "desc": "مرحومه ندا خدایی"},
    {"path": "assets/images/memorial/169.jpg", "desc": "مرحوم محمدرضا اکبر (یوسف)"},
    {"path": "assets/images/memorial/170.jpg", "desc": "مرحوم سیدحسین موسوی"},
    {"path": "assets/images/memorial/171.jpg", "desc": "مرحومه حاج قمر یزدانی"},
    {"path": "assets/images/memorial/172.jpg", "desc": "مرحومه فاطمه نجفی"},
    {"path": "assets/images/memorial/173.jpg", "desc": "مرحومه خدیجه بیگم موسوی"},
    {"path": "assets/images/memorial/174.jpg", "desc": "مرحومه شهناز آذر"},
  ];

  void _startSlideshow() {
    Future.delayed(const Duration(seconds: 8), () {
      if (_pageController.hasClients && autoPlay) {
        currentIndex = (currentIndex + 1) % photos.length;
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _startSlideshow();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "یادبود درگذشتگان",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // ==================== صفحه‌گردان عکس‌ها ====================
          PageView.builder(
            controller: _pageController,
            itemCount: photos.length,
            onPageChanged: (index) {
              currentIndex = index;
            },
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ===== تصویر =====
                    Expanded(
                      flex: 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          photos[index]["path"]!,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[800],
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'بارگذاری تصویر ناموفق',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ===== متن توضیحات =====
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Text(
                          photos[index]["desc"]?.isNotEmpty == true
                              ? photos[index]["desc"]!
                              : 'فردی از یادگاران ایراج',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth > 600 ? 18 : 15,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    // ===== شماره عکس =====
                    Flexible(
                      flex: 0,
                      child: Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${index + 1} / ${photos.length}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),
                  ],
                ),
              );
            },
          ),

          // ==================== دکمه شناور ====================
          Positioned(
            top: 12,
            left: 12,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              icon: Icon(autoPlay ? Icons.pause : Icons.play_arrow),
              label: Text(autoPlay ? "توقف خودکار" : "شروع خودکار"),
              onPressed: () {
                setState(() {
                  autoPlay = !autoPlay;
                  if (autoPlay) {
                    _startSlideshow();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}