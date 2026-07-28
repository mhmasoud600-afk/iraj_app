// lib/main.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

// صفحات اصلی
import 'settings_page.dart';
import 'services/search_service.dart';

import 'village_intro_page.dart';
import 'pages/zakerin/zakerin_page.dart';
import 'pages/dictionary/dictionary_page.dart';

import 'pages/products/products_page.dart';
import 'pages/mosque/mosque_page.dart';
import 'water_calendar_page.dart';

// صفحات محتوایی جدا
import 'gallery_page.dart';
import 'pages/historical/historical_page.dart';
import 'pages/customs/customs_page.dart';
import 'memorial_page.dart';
import 'development_page.dart';
import 'plain_page.dart';
import 'mountains_page.dart';
import 'pages/farms/farms_page.dart';
import 'poets_page.dart';
// صفحات جدید
import 'cheshmeha_page.dart';
import 'pages/proverbs/proverbs_page.dart';
import 'pages/eghamatgah/egamatgah_page.dart';

// صفحات جایگزین جدید
import 'martyrs_page.dart';
import 'pages/teachers/teachers_page.dart';
import 'about_app_page.dart';
import 'splash_screen.dart';

// صفحات دکمه‌های بالا
import 'search_page.dart';
import 'pages/music/music_tabs_page.dart';
import 'share_page.dart';
import 'routing_page.dart';

// تنظیمات سراسری
import 'settings/app_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fa', null);
  await initializeDateFormatting('en', null);
  
  await AppSettings.instance.loadSettings();
  
  await _registerAllPages();
  
  runApp(const IrajApp());
}

Future<void> _registerAllPages() async {
  final service = SearchService();
  service.clear();

  service.registerItem(
    SearchItem(
      title: 'معرفی روستا',
      subtitle: 'تاریخ و فرهنگ روستای ایراج',
      searchText: 'معرفی روستا تاریخ فرهنگ ایراج روستای ایراج',
      page: const VillageIntroPage(),
      icon: Icons.home,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'شاعران',
      subtitle: 'شاعران و ادیبان روستای ایراج',
      searchText: 'شاعران ادیبان شعر ادبیات ایراج',
      page: const PoetsPage(),
      icon: Icons.edit,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'اساتید قرآنی و ذاکرین',
      subtitle: 'اساتید قرآنی، مداحان و ذاکرین اهل بیت',
      searchText: 'اساتید قرآنی مداحان ذاکرین اهل بیت قرآن',
      page: ZakerinPage(
        fontSize: 16,
        fontFamily: 'Vazir',
        textColor: Colors.black,
        backgroundColor: Colors.white,
        buttonFontSize: 14,
        buttonFontFamily: 'Vazir',
        buttonTextColor: Colors.white,
        buttonBackgroundColor: Colors.teal,
      ),
      icon: Icons.mic,
      category: 'مذهبی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'فرهنگ لغت روستا',
      subtitle: 'واژه‌ها و اصطلاحات بومی و محلی',
      searchText: 'فرهنگ لغت واژه‌ها اصطلاحات بومی محلی لغت واژه',
      page: VillageDictionaryPage(
        fontSize: 16,
        fontFamily: 'Vazir',
        textColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      icon: Icons.book,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'محصولات روستا',
      subtitle: 'محصولات کشاورزی و صنایع دستی',
      searchText: 'محصولات کشاورزی صنایع دستی تولیدات کشاورزی',
      page: ProductsPage(
        fontSize: 16,
        fontFamily: 'Vazir',
        textColor: Colors.black,
        backgroundColor: Colors.white,
        buttonFontSize: 14,
        buttonFontFamily: 'Vazir',
        buttonTextColor: Colors.white,
        buttonBackgroundColor: Colors.teal,
      ),
      icon: Icons.shopping_basket,
      category: 'محصولات',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'مساجد روستا',
      subtitle: 'مساجد قدیمی و جدید روستا',
      searchText: 'مساجد مسجد قدیمی جدید ایراج',
      page: MosquePage(
        fontSize: 16,
        fontFamily: 'Vazir',
        textColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      icon: Icons.mosque,
      category: 'مذهبی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'تقویم گردش آب',
      subtitle: 'تقویم و زمان‌بندی گردش آب در قنات‌ها',
      searchText: 'تقویم گردش آب قنات زمان‌بندی آب',
      page: const WaterCalendarPage(),
      icon: Icons.calendar_today,
      category: 'طبیعت',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'گالری تصاویر',
      subtitle: 'تصاویر قدیمی و جدید از روستا',
      searchText: 'گالری تصاویر عکس قدیمی جدید',
      page: const GalleryPage(),
      icon: Icons.photo,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'آثار باستانی و دیدنی',
      subtitle: 'آثار تاریخی، بناهای قدیمی و جاهای دیدنی',
      searchText: 'آثار باستانی دیدنی تاریخی بنا قدیمی قلعه حمام',
      page: const HistoricalPage(),
      icon: Icons.account_balance,
      category: 'تاریخی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'آداب و رسوم',
      subtitle: 'آداب سنتی، مراسم و آیین‌های روستا',
      searchText: 'آداب رسوم سنتی مراسم عروسی عزاداری محرم نوروز یلدا چهارشنبه سوری',
      page: const CustomsPage(),
      icon: Icons.people,
      category: 'فرهنگی',
    ),
  );

  try {
    final jsonStr = await rootBundle.loadString('assets/data/martyrs.json');
    final List<dynamic> martyrs = json.decode(jsonStr);
    
    StringBuffer martyrsText = StringBuffer();
    martyrsText.writeln('شهدای روستای ایراج:');
    
    for (var m in martyrs) {
      martyrsText.writeln('--- ${m['name']} ---');
      martyrsText.writeln('نام: ${m['name']}');
      martyrsText.writeln('تاریخ تولد: ${m['birthDate']}');
      martyrsText.writeln('محل تولد: ${m['birthPlace']}');
      martyrsText.writeln('تاریخ شهادت: ${m['deathDate']}');
      martyrsText.writeln('محل شهادت: ${m['deathPlace']}');
      martyrsText.writeln('نام عملیات: ${m['operation']}');
      
      if (m['bio'] != null && m['bio'].toString().isNotEmpty) {
        martyrsText.writeln('زندگینامه: ${m['bio']}');
      }
      if (m['will'] != null && m['will'].toString().isNotEmpty) {
        martyrsText.writeln('وصیت‌نامه: ${m['will']}');
      }
      if (m['quote'] != null && m['quote'].toString().isNotEmpty) {
        martyrsText.writeln('گفتار: ${m['quote']}');
      }
      if (m['poem'] != null && m['poem'].toString().isNotEmpty) {
        martyrsText.writeln('شعر: ${m['poem']}');
      }
      martyrsText.writeln();
    }
    
    service.registerItem(
      SearchItem(
        title: 'شهدای روستا',
        subtitle: 'یادبود و زندگینامه شهدای روستا',
        searchText: martyrsText.toString(),
        page: const MartyrsPage(),
        icon: Icons.military_tech,
        category: 'مذهبی',
      ),
    );
    print('✅ شهدا از JSON بارگذاری شد (${martyrs.length} شهید)');
  } catch (e) {
    print('❌ خطا در بارگذاری شهدا: $e');
    service.registerItem(
      SearchItem(
        title: 'شهدای روستا',
        subtitle: 'یادبود و زندگینامه شهدای روستا',
        searchText: 'شهدا شهید یادبود زندگینامه جانباز',
        page: const MartyrsPage(),
        icon: Icons.military_tech,
        category: 'مذهبی',
      ),
    );
  }

  service.registerItem(
    SearchItem(
      title: 'عکس درگذشتگان',
      subtitle: 'گالری تصاویر درگذشتگان روستا',
      searchText: 'درگذشتگان عکس یادبود متوفی',
      page: const MemorialPage(),
      icon: Icons.image,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'چشم‌انداز توسعه روستا',
      subtitle: 'طرح‌ها و برنامه‌های توسعه روستا',
      searchText: 'توسعه چشم‌انداز طرح برنامه آینده',
      page: const DevelopmentPage(),
      icon: Icons.bar_chart,
      category: 'توسعه',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'نقشه دشت و محله‌ها',
      subtitle: 'نقشه و تقسیمات دشت و محله‌های روستا',
      searchText: 'نقشه دشت محله تقسیمات مسیر',
      page: const PlainPage(),
      icon: Icons.landscape,
      category: 'طبیعت',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'مناطق اطراف',
      subtitle: 'کوه‌ها، دشت‌ها و مناطق اطراف روستا',
      searchText: 'مناطق اطراف کوه دشت طبیعت',
      page: const MountainsPage(),
      icon: Icons.terrain,
      category: 'طبیعت',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'فرهیختگان و خادمین',
      subtitle: 'فرهیختگان، معلمان و خادمین روستا',
      searchText: 'فرهیختگان خادمین معلمان فرهنگ معلم',
      page: const TeachersPage(),
      icon: Icons.school,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'قنات و چشمه‌ها',
      subtitle: 'چشمه‌های طبیعی و قنات‌های روستا',
      searchText: '''
قنات و چشمه‌های روستای ایراج:
ایراج روستایی از توابع شهرستان خور و بیابانک در استان اصفهان است.
چشمه‌ها: قنات و چشمه کهریز، چاله حوضو، چشمه قلعه، چشمه کتل ته جوی، چشمه کتل آسیو، چشمه بیخ درگو، چشمه خواجه خضر، چشمه صحابه، چشمه علی اکبر، چشمه آبگادو، چشمه انجیر کوهی، چشمه پی زر، چشمه چله خونه، چشمه سیما، چشمه باغ نیزار، چشمه کوچه خرمنا، چشمه کلاته پایین، چشمه کلاته بالا، چشمه کهینو، چشمه اوشکو، چشمه آفرین، چشمه بیخ چاه، چشمه دومو، چشمه آخرک، چشمه آبگیشه، چشمه منک، چشمه اسلام دشت، چشمه گولار، قنات خرم آباد، چشمه آب یوزگون، چشمه بندر، چشمه بهین، چشمه پاپرده، چشمه زایین، چشمه چاه شور، چشمه گدار نتک، چشمه آب تلخون، چشمه حاجی آبادی، چشمه گودال خجه، چشمه زردو، چشمه جمون، چشمه کتل مرغزار، چشمه شوراب منک، چشمه صنم، چشمه کلاته شرف، چشمه سنجد
''',
      page: const CheshmehaPage(),
      icon: Icons.water,
      category: 'طبیعت',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'ضرب‌المثل‌ها و کنایه‌ها',
      subtitle: 'ضرب‌المثل‌ها و کنایه‌های محلی',
      searchText: 'ضرب‌المثل کنایه محلی ضرب المثل حکمت پند',
      page: const ProverbsPage(),
      icon: Icons.format_quote,
      category: 'فرهنگی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'اقامتگاه‌ها',
      subtitle: 'محل‌های اقامت و مهمان‌پذیرهای روستا',
      searchText: 'اقامتگاه مهمان‌پذیر محل اقامت هتل',
      page: const EgamatgahPage(),
      icon: Icons.hotel,
      category: 'خدمات',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'مزارع اطراف',
      subtitle: 'مزارع و زمین‌های کشاورزی اطراف روستا',
      searchText: 'مزارع کشاورزی زمین محصول مزرعه',
      page: const FarmsPage(),
      icon: Icons.agriculture,
      category: 'محصولات',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'درباره نرم‌افزار',
      subtitle: 'معرفی و اطلاعات نرم‌افزار روستای ایراج',
      searchText: '''
درباره نرم‌افزار روستای ایراج:
این نرم‌افزار برای معرفی روستای ایراج طراحی شده است.
هدف آن حفظ فرهنگ، تاریخ و سنت‌های روستا و ارائه اطلاعات مفید به علاقه‌مندان است.

توسعه‌دهندگان:
مسعود خدایی، مهرنوش جمشیدی، دکتر مهدی مسعود، دکتر مهدی نجفی،
اباذر نجفی، شهره اکبر، حاج رسول دانا، حاج صادق موبد،
جواد نجفی، حاج نبی اله موبد، حامد اکبر، حمید اکبر،
حمیدرضا زاهد، محمدحسن یزدانی، فاطمه اکبر، الهه اکبر،
شهربانو دانا، طیبه نجفی، محمدحسین اشرف، مهندس احمد عشقی،
هما یگانه، فرید اکبر، محمدرضا نجفی، محمد یازان،
محمد زاهد، دکتر فرج اله زاهد
''',
      page: const AboutAppPage(),
      icon: Icons.info,
      category: 'درباره',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'ترانه‌ها',
      subtitle: 'ترانه‌ها و آهنگ‌های محلی',
      searchText: 'ترانه آهنگ موسیقی محلی آواز',
      page: const MusicTabsPage(),
      icon: Icons.music_note,
      category: 'موسیقی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'دعا و زیارات',
      subtitle: 'دعاها و زیارات مذهبی',
      searchText: 'دعا زیارت مذهبی نماز',
      page: const MusicTabsPage(),
      icon: Icons.mosque,
      category: 'مذهبی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'اوقات شرعی',
      subtitle: 'اوقات شرعی و زمان‌های نماز',
      searchText: 'اوقات شرعی نماز زمان اذان',
      page: const MusicTabsPage(),
      icon: Icons.access_time,
      category: 'مذهبی',
    ),
  );

  service.registerItem(
    SearchItem(
      title: 'هواشناسی',
      subtitle: 'وضعیت آب و هوای روستا',
      searchText: 'هواشناسی آب و هوا آبوهوا',
      page: const MusicTabsPage(),
      icon: Icons.wb_sunny,
      category: 'طبیعت',
    ),
  );

  print('✅ ${service.count} صفحه برای جستجو ثبت شد');
}

class IrajApp extends StatefulWidget {
  const IrajApp({Key? key}) : super(key: key);

  @override
  _IrajAppState createState() => _IrajAppState();
}

class _IrajAppState extends State<IrajApp> {
  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    
    return MaterialApp(
      title: 'Erabeh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: settings.primaryColor,
        scaffoldBackgroundColor: settings.pageBackgroundColor,
        colorScheme: ColorScheme(
          primary: settings.primaryColor,
          secondary: settings.secondaryColor,
          surface: settings.pageBackgroundColor,
          background: settings.pageBackgroundColor,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: settings.mainTextColor,
          onBackground: settings.mainTextColor,
          onError: Colors.white,
          brightness: settings.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: settings.appBarColor,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: settings.mainFontSize + 4,
            fontFamily: settings.mainFontFamily,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 8,
            color: settings.mainTextColor,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 4,
            color: settings.mainTextColor,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize,
            color: settings.mainTextColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize * 0.9,
            color: settings.mainTextColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: settings.primaryColor,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontFamily: settings.buttonFontFamily,
              fontSize: settings.buttonFontSize,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
        ),
        cardColor: settings.isDarkMode ? Colors.grey[850] : Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: settings.appBarColor,
          selectedItemColor: settings.accentColor,
          unselectedItemColor: Colors.white70,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A1A2F),
        primaryColor: const Color(0xFF0A1A2F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A1A2F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0A1A2F),
          secondary: Color(0xFF1A2A3F),
          surface: Color(0xFF0A1A2F),
        ),
      ),
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/poets': (context) => const PoetsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppSettings _settings = AppSettings.instance;
  
  bool _isDarkMode = false;
  int _bottomIndex = 0;
  int _topPage = 0;
  final List<_NavCode> _stack = [];
  Widget? _currentContent;

  String _getCurrentPageTitle() {
    if (_currentContent != null) {
      if (_currentContent is VillageIntroPage) return 'معرفی روستای ایراج';
      if (_currentContent is PoetsPage) return 'شاعران روستا';
      if (_currentContent is ProductsPage) return 'محصولات روستا';
      if (_currentContent is HistoricalPage) return 'آثار باستانی ایراج';
      if (_currentContent is CustomsPage) return 'آداب و رسوم روستا';
      if (_currentContent is FarmsPage) return 'مزارع اطراف روستا';
      if (_currentContent is CheshmehaPage) return 'قنات و چشمه‌های ایراج';
      if (_currentContent is MountainsPage) return 'مناطق اطراف روستا';
      if (_currentContent is MartyrsPage) return 'شهدای روستا';
      if (_currentContent is TeachersPage) return 'فرهیختگان و خادمین';
      if (_currentContent is ProverbsPage) return 'ضرب‌المثل‌ها و کنایه‌ها';
      if (_currentContent is EgamatgahPage) return 'اقامتگاه‌ها';
      if (_currentContent is MemorialPage) return 'عکس درگذشتگان';
      if (_currentContent is DevelopmentPage) return 'چشم‌انداز توسعه روستا';
      if (_currentContent is PlainPage) return 'نقشه دشت و محله‌ها';
      if (_currentContent is GalleryPage) return 'گالری تصاویر';
      if (_currentContent is WaterCalendarPage) return 'تقویم گردش آب';
      if (_currentContent is MosquePage) return 'مساجد و زیارتگاه‌ها';
      if (_currentContent is ZakerinPage) return 'اساتید قرآنی و ذاکرین';
      if (_currentContent is VillageDictionaryPage) return 'فرهنگ لغت روستا';
      if (_currentContent is AboutAppPage) return 'درباره نرم‌افزار';
      if (_currentContent is MusicTabsPage) return 'بخش‌های مذهبی و موسیقی';
    }
    
    switch (_bottomIndex) {
      case 0: return 'معرفی روستای ایراج';
      case 1: return 'مزارع اطراف روستا';
      case 2: return 'شاعران روستا';
      case 3: return 'مسیریابی';
      case 4: return 'درباره نرم‌افزار';
      default: return 'روستای ایراج';
    }
  }

  String _getCurrentPageContent() {
    if (_currentContent != null) {
      if (_currentContent is VillageIntroPage) {
        return 'روستای ایراج با قدمتی بیش از 4000 سال در حاشیه کویر مرکزی ایران واقع شده است. این روستا دارای تاریخچه غنی، فرهنگ اصیل و مردمی مهمان‌نواز است.';
      }
      if (_currentContent is PoetsPage) {
        return 'شاعران و ادیبان روستای ایراج با اشعار زیبا و دلنشین خود، فرهنگ و تاریخ این روستا را زنده نگه داشته‌اند.';
      }
      if (_currentContent is HistoricalPage) {
        return 'آثار باستانی ایراج شامل قلعه تاریخی، تپه‌های باستانی، مزار گبرا، درخت سرو کهن و بافت قدیمی روستا می‌باشد.';
      }
      if (_currentContent is CustomsPage) {
        return 'آداب و رسوم روستای ایراج شامل عروسی‌ها و جشن‌ها، عزاداری‌ها، مراسمات سنتی، اعتقادات و باورها، خرافات، بازی‌های محلی و سرگرمی‌ها می‌شود.';
      }
      if (_currentContent is FarmsPage) {
        return 'مزارع اطراف روستای ایراج شامل منک، اسلام دشت، آخرک، بهین، چشمه سنجد، کاشفیه، کلاته بالا، کلاته پایین، کهینو، آبگادو، افرنگ، گولار، خرم آباد، دومو و بندر می‌باشد.';
      }
      if (_currentContent is CheshmehaPage) {
        return 'چشمه‌های طبیعی و قنات‌های روستای ایراج که حیات و کشاورزی را در این منطقه کویری امکان‌پذیر کرده است.';
      }
      if (_currentContent is MountainsPage) {
        return 'کوه‌ها، دشت‌ها و مناطق اطراف روستای ایراج شامل مناطق مختلف و دیدنی‌های طبیعی می‌باشد.';
      }
      if (_currentContent is MartyrsPage) {
        return 'یادبود و زندگینامه شهدای گرانقدر روستای ایراج که در راه دفاع از اسلام و ایران به شهادت رسیدند.';
      }
      if (_currentContent is TeachersPage) {
        return 'فرهیختگان، معلمان و خادمین روستای ایراج که در عرصه‌های مختلف فرهنگی، علمی و خدماتی فعالیت داشته‌اند.';
      }
      if (_currentContent is ProverbsPage) {
        return 'ضرب‌المثل‌ها و کنایه‌های محلی روستای ایراج که نشان‌دهنده فرهنگ و حکمت مردمان این دیار است.';
      }
      if (_currentContent is EgamatgahPage) {
        return 'اقامتگاه‌های بوم‌گردی و محل‌های اقامت در روستای ایراج برای گردشگران و مسافران.';
      }
      if (_currentContent is AboutAppPage) {
        return 'نرم‌افزار روستای ایراج برای معرفی تاریخ، فرهنگ و جاذبه‌های این روستای کهن طراحی شده است.';
      }
      if (_currentContent is MemorialPage) {
        return 'گالری تصاویر درگذشتگان روستای ایراج که یادگاران این دیار را گرامی می‌دارد.';
      }
      if (_currentContent is DevelopmentPage) {
        return 'طرح‌ها و برنامه‌های توسعه روستای ایراج در زمینه کشاورزی، گیاهان دارویی و گردشگری.';
      }
      if (_currentContent is GalleryPage) {
        return 'گالری تصاویر قدیمی و جدید از روستای ایراج.';
      }
      if (_currentContent is WaterCalendarPage) {
        return 'تقویم و زمان‌بندی گردش آب در قنات‌های روستای ایراج.';
      }
      if (_currentContent is MosquePage) {
        return 'مساجد قدیمی و جدید و زیارتگاه‌های روستای ایراج.';
      }
      if (_currentContent is ZakerinPage) {
        return 'اساتید قرآنی، مداحان و ذاکرین اهل بیت در روستای ایراج.';
      }
      if (_currentContent is VillageDictionaryPage) {
        return 'واژه‌ها و اصطلاحات بومی و محلی روستای ایراج.';
      }
      if (_currentContent is MusicTabsPage) {
        return 'بخش‌های مختلف شامل ترانه‌ها، دعا و زیارات، روزانه، اوقات شرعی، هواشناسی و بهشت گمشده.';
      }
    }
    
    switch (_bottomIndex) {
      case 0: return 'روستای ایراج با قدمتی بیش از 4000 سال در حاشیه کویر مرکزی ایران واقع شده است.';
      case 1: return 'مزارع اطراف روستا شامل منک، اسلام دشت، آخرک و...';
      case 2: return 'شاعران و ادیبان روستای ایراج.';
      case 3: return 'مسیریابی به روستای ایراج.';
      case 4: return 'درباره نرم‌افزار روستای ایراج.';
      default: return 'برنامه معرفی روستای ایراج';
    }
  }

  void _openSharePage() {
    _pushState();
    setState(() {
      _topPage = 3;
      _currentContent = SharePage(
        pageTitle: _getCurrentPageTitle(),
        pageContent: _getCurrentPageContent(),
      );
    });
  }

  void _pushState() {
    _stack.add(_NavCode(
      bottomIndex: _bottomIndex,
      topPage: _topPage,
      content: _currentContent,
    ));
  }

  void _reloadSettings() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color night = const Color(0xFF0A1A2F);
    final Color bg = _isDarkMode ? night : _settings.pageBackgroundColor;

    return WillPopScope(
        onWillPop: () async {
          if (_stack.isNotEmpty) {
            setState(() {
              final popped = _stack.removeLast();
              _bottomIndex = popped.bottomIndex;
              _topPage = popped.topPage;
              _currentContent = popped.content;
            });
            return false;
          }
          return true;
        },
        child: Scaffold(
            backgroundColor: bg,
            appBar: AppBar(
              title: Text(
                "روستای ایراج",
                style: TextStyle(
                  fontSize: _settings.mainFontSize,
                  fontFamily: _settings.mainFontFamily,
                  color: _settings.mainTextColor,
                ),
              ),
              backgroundColor: _isDarkMode ? night : _settings.appBarColor,
              leading: IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  _pushState();
                  setState(() => _topPage = 4);
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _pushState();
                    setState(() => _topPage = 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.music_note),
                  onPressed: () {
                    _pushState();
                    setState(() => _topPage = 2);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: _openSharePage,
                  tooltip: 'اشتراک‌گذاری محتوای صفحه',
                ),
                IconButton(
                  icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                  onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
                ),
              ],
            ),
            body: _currentContent ?? _buildBody(),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _bottomIndex,
                onTap: (index) {
                  _pushState();
                  setState(() {
                    _bottomIndex = index;
                    _topPage = 0;
                    _currentContent = null;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "خانه"),
                  BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: "مزارع اطراف"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "شاعران"),
                  BottomNavigationBarItem(icon: Icon(Icons.map), label: "مسیریابی"),
                  BottomNavigationBarItem(icon: Icon(Icons.info), label: "درباره نرم‌افزار"),
                ],
                selectedItemColor: _settings.accentColor,
                unselectedItemColor: Colors.white,
                backgroundColor: _isDarkMode ? night : _settings.appBarColor,
                type: BottomNavigationBarType.fixed,
                elevation: 8,
            ),
        ),
    );
  }

  Widget _buildBody() {
    switch (_topPage) {
      case 1:
        return SearchPage(
          fontSize: _settings.mainFontSize,
          fontFamily: _settings.mainFontFamily,
          textColor: _settings.mainTextColor,
          backgroundColor: _settings.pageBackgroundColor,
        );
      case 2:
        return MusicTabsPage();
      case 3:
        return SharePage(
          pageTitle: _getCurrentPageTitle(),
          pageContent: _getCurrentPageContent(),
        );
      case 4:
        return SettingsPage(onSettingsChanged: () {
          _reloadSettings();
        });
      default:
        break;
    }

    switch (_bottomIndex) {
      case 1:
        return FarmsPage();
      case 2:
        return const PoetsPage();
      case 3:
        return RoutingPage();
      case 4:
        return AboutAppPage();
      default:
        // ============================================
        // صفحه اصلی با ۳ ستون و ۶ سطر بدون اسکرول (با اسکرول اضطراری)
        // ============================================
        return Container(
          color: _settings.pageBackgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 4),
              Expanded(
                child: _buildHomeGrid(),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildHomeGrid() {
  final List<Map<String, dynamic>> menuItems = [
    {"title": "معرفی روستا", "icon": Icons.home},
    {"title": "آثار باستانی و دیدنی", "icon": Icons.account_balance},
    {"title": "آداب و رسوم", "icon": Icons.people},
    {"title": "گالری تصاویر", "icon": Icons.photo},
    {"title": "قنات و چشمه‌ها", "icon": Icons.water},
    {"title": "شهدای روستا", "icon": Icons.military_tech},
    {"title": "تقویم گردش آب", "icon": Icons.calendar_today},
    {"title": "عکس درگذشتگان", "icon": Icons.image},
    {"title": "چشم‌انداز توسعه روستا", "icon": Icons.bar_chart},
    {"title": "فرهیختگان وخادمین", "icon": Icons.school},
    {"title": "اساتید قرآنی و ذاکرین", "icon": Icons.mic},
    {"title": "فرهنگ لغت روستا", "icon": Icons.book},
    {"title": "ضرب‌المثل‌ها و کنایه‌ها", "icon": Icons.format_quote},
    {"title": "اقامتگاه‌ها", "icon": Icons.hotel},
    {"title": "محصولات روستا", "icon": Icons.shopping_basket},
    {"title": "مساجد روستا", "icon": Icons.account_balance_outlined},
    {"title": "نقشه دشت و محله ها", "icon": Icons.landscape},
    {"title": "مناطق اطراف", "icon": Icons.terrain},
  ];

  return LayoutBuilder(
    builder: (context, constraints) {
      final double availableWidth = constraints.maxWidth;
      final double availableHeight = constraints.maxHeight;

      const int crossAxisCount = 3;
      const int rowCount = 6;
      const double spacing = 10;
      const double padding = 12;

      double itemHeight = (availableHeight - padding * 2 - spacing * (rowCount - 1)) / rowCount;
      double itemWidth = (availableWidth - padding * 2 - spacing * (crossAxisCount - 1)) / crossAxisCount;
      double aspectRatio = itemWidth / itemHeight;

      bool shouldScroll = aspectRatio < 0.7 || itemHeight < 50;
      double finalAspectRatio = aspectRatio.clamp(0.7, 1.5);

      return GridView.builder(
        shrinkWrap: true,
        physics: shouldScroll ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: finalAspectRatio,
        ),
        padding: EdgeInsets.all(padding),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () => _openMenu(item["title"] as String),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: _isDarkMode ? Colors.grey[850] : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item["icon"] as IconData,
                    size: (finalAspectRatio * 28).clamp(20.0, 40.0),
                    color: _settings.primaryColor,
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: Text(
                      item["title"] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // ============================================================
                        // استفاده از تنظیمات برای اندازه فونت
                        // ============================================================
                        fontSize: _settings.menuFontSize,
                        fontFamily: _settings.buttonFontFamily,
                        color: _settings.mainTextColor,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

  void _openMenu(String title) {
    _pushState();
    switch (title) {
      case "معرفی روستا":
        _pushContent(const VillageIntroPage());
        break;
      case "شاعران":
        _pushContent(const PoetsPage());
        break;
      case "اساتید قرآنی و ذاکرین":
        _pushContent(ZakerinPage(
          fontSize: _settings.mainFontSize,
          fontFamily: _settings.mainFontFamily,
          textColor: _settings.mainTextColor,
          backgroundColor: _settings.pageBackgroundColor,
          buttonFontSize: _settings.buttonFontSize,
          buttonFontFamily: _settings.buttonFontFamily,
          buttonTextColor: _settings.buttonTextColor,
          buttonBackgroundColor: _settings.buttonBackgroundColor,
        ));
        break;
      case "فرهنگ لغت روستا":
        _pushContent(VillageDictionaryPage(
          fontSize: _settings.mainFontSize,
          fontFamily: _settings.mainFontFamily,
          textColor: _settings.mainTextColor,
          backgroundColor: _settings.pageBackgroundColor,
        ));
        break;
      case "محصولات روستا":
        _pushContent(ProductsPage(
          fontSize: _settings.mainFontSize,
          fontFamily: _settings.mainFontFamily,
          textColor: _settings.mainTextColor,
          backgroundColor: _settings.pageBackgroundColor,
          buttonFontSize: _settings.buttonFontSize,
          buttonFontFamily: _settings.buttonFontFamily,
          buttonTextColor: _settings.buttonTextColor,
          buttonBackgroundColor: _settings.buttonBackgroundColor,
        ));
        break;
      case "مساجد روستا":
        _pushContent(MosquePage(
          fontSize: _settings.mainFontSize,
          fontFamily: _settings.mainFontFamily,
          textColor: _settings.mainTextColor,
          backgroundColor: _settings.pageBackgroundColor,
        ));
        break;
      case "تقویم گردش آب":
        _pushContent(const WaterCalendarPage());
        break;
      case "گالری تصاویر":
        _pushContent(const GalleryPage());
        break;
      case "آثار باستانی و دیدنی":
        _pushContent(const HistoricalPage());
        break;
      case "آداب و رسوم":
        _pushContent(const CustomsPage());
        break;
      case "شهدای روستا":
        _pushContent(const MartyrsPage());
        break;
      case "عکس درگذشتگان":
        _pushContent(const MemorialPage());
        break;
      case "چشم‌انداز توسعه روستا":
        _pushContent(const DevelopmentPage());
        break;
      case "نقشه دشت و محله ها":
        _pushContent(const PlainPage());
        break;
      case "مناطق اطراف":
        _pushContent(const MountainsPage());
        break;
      case "فرهیختگان وخادمین":
        _pushContent(const TeachersPage());
        break;
      case "قنات و چشمه‌ها":
        _pushContent(const CheshmehaPage());
        break;
      case "ضرب‌المثل‌ها و کنایه‌ها":
        _pushContent(const ProverbsPage());
        break;
      case "اقامتگاه‌ها":
        _pushContent(const EgamatgahPage());
        break;
    }
  }

  void _pushContent(Widget page) {
    setState(() {
      _currentContent = page;
    });
  }
}

class _NavCode {
  final int bottomIndex;
  final int topPage;
  final Widget? content;

  _NavCode({
    required this.bottomIndex,
    required this.topPage,
    required this.content,
  });
}