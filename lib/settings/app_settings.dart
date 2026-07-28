import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static AppSettings? _instance;
  static AppSettings get instance => _instance ??= AppSettings._();

  AppSettings._();

  // تنظیمات پیش‌فرض
  double buttonFontSize = 14;
  String buttonFontFamily = 'Vazirmatn';
  Color buttonTextColor = Colors.black;
  Color buttonBackgroundColor = Colors.white;

  double mainFontSize = 16;
  String mainFontFamily = 'Vazirmatn';
  Color mainTextColor = Colors.black;
  Color mainBackgroundColor = Colors.white;

  Color pageBackgroundColor = Colors.white;
  Color appBarColor = Colors.teal;
  Color primaryColor = Colors.teal;
  Color secondaryColor = Colors.teal[700]!;
  Color accentColor = Colors.amber;

  bool isDarkMode = false;

  // ============================================================
  // جدید: اندازه فونت منوی اصلی
  // ============================================================
  double _menuFontSize = 13.0;

  double get menuFontSize => _menuFontSize;
  set menuFontSize(double value) {
    _menuFontSize = value;
  }

  final List<String> fontFamilies = [
    'Vazirmatn',
    'Roboto',
    'Vazir',
    'Shabnam',
    'Homa',
  ];

  final List<String> colorNames = [
    'سیاه', 'سفید', 'خاکستری', 'قرمز', 'آبی', 
    'سبز', 'نارنجی', 'بنفش', 'قهوه‌ای', 'صورتی',
    'زرد', 'فیروزه‌ای', 'سبزآبی', 'نیلی', 'لیمویی',
    'طوسی', 'مخملی', 'یاقوتی', 'زمردی', 'طلایی'
  ];

  final Map<String, Color> colorMap = {
    'سیاه': Colors.black,
    'سفید': Colors.white,
    'خاکستری': Colors.grey,
    'قرمز': Colors.red,
    'آبی': Colors.blue,
    'سبز': Colors.green,
    'نارنجی': Colors.orange,
    'بنفش': Colors.purple,
    'قهوه‌ای': Colors.brown,
    'صورتی': Colors.pink,
    'زرد': Colors.yellow,
    'فیروزه‌ای': Colors.cyan,
    'سبزآبی': Colors.teal,
    'نیلی': Colors.indigo,
    'لیمویی': Colors.lime,
    'طوسی': Colors.grey[700]!,
    'مخملی': Colors.deepPurple,
    'یاقوتی': Colors.deepOrange,
    'زمردی': Colors.green[800]!,
    'طلایی': Colors.amber,
  };

  String getColorName(Color color) {
    for (var entry in colorMap.entries) {
      if (entry.value == color) return entry.key;
    }
    return 'سفید';
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    buttonFontSize = prefs.getDouble('buttonFontSize') ?? 14;
    buttonFontFamily = prefs.getString('buttonFontFamily') ?? 'Vazirmatn';
    buttonTextColor = colorMap[prefs.getString('buttonTextColor') ?? 'سفید'] ?? Colors.black;
    buttonBackgroundColor = colorMap[prefs.getString('buttonBackgroundColor') ?? 'سفید'] ?? Colors.white;

    mainFontSize = prefs.getDouble('mainFontSize') ?? 16;
    mainFontFamily = prefs.getString('mainFontFamily') ?? 'Vazirmatn';
    mainTextColor = colorMap[prefs.getString('mainTextColor') ?? 'سیاه'] ?? Colors.black;
    mainBackgroundColor = colorMap[prefs.getString('mainBackgroundColor') ?? 'سفید'] ?? Colors.white;

    pageBackgroundColor = colorMap[prefs.getString('pageBackgroundColor') ?? 'سفید'] ?? Colors.white;
    appBarColor = colorMap[prefs.getString('appBarColor') ?? 'سبزآبی'] ?? Colors.teal;
    primaryColor = colorMap[prefs.getString('primaryColor') ?? 'سبزآبی'] ?? Colors.teal;
    secondaryColor = colorMap[prefs.getString('secondaryColor') ?? 'سبزآبی'] ?? Colors.teal[700]!;
    accentColor = colorMap[prefs.getString('accentColor') ?? 'طلایی'] ?? Colors.amber;
    isDarkMode = prefs.getBool('isDarkMode') ?? false;

    // ============================================================
    // جدید: بارگذاری اندازه فونت منوی اصلی
    // ============================================================
    _menuFontSize = prefs.getDouble('menuFontSize') ?? 13.0;
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('buttonFontSize', buttonFontSize);
    await prefs.setString('buttonFontFamily', buttonFontFamily);
    await prefs.setString('buttonTextColor', getColorName(buttonTextColor));
    await prefs.setString('buttonBackgroundColor', getColorName(buttonBackgroundColor));

    await prefs.setDouble('mainFontSize', mainFontSize);
    await prefs.setString('mainFontFamily', mainFontFamily);
    await prefs.setString('mainTextColor', getColorName(mainTextColor));
    await prefs.setString('mainBackgroundColor', getColorName(mainBackgroundColor));

    await prefs.setString('pageBackgroundColor', getColorName(pageBackgroundColor));
    await prefs.setString('appBarColor', getColorName(appBarColor));
    await prefs.setString('primaryColor', getColorName(primaryColor));
    await prefs.setString('secondaryColor', getColorName(secondaryColor));
    await prefs.setString('accentColor', getColorName(accentColor));
    await prefs.setBool('isDarkMode', isDarkMode);

    // ============================================================
    // جدید: ذخیره اندازه فونت منوی اصلی
    // ============================================================
    await prefs.setDouble('menuFontSize', _menuFontSize);
  }

  // ============================================================
  // جدید: متد بازنشانی به حالت پیش‌فرض (اختیاری)
  // ============================================================
  void resetToDefaults() {
    buttonFontSize = 14;
    buttonFontFamily = 'Vazirmatn';
    buttonTextColor = Colors.black;
    buttonBackgroundColor = Colors.white;

    mainFontSize = 16;
    mainFontFamily = 'Vazirmatn';
    mainTextColor = Colors.black;
    mainBackgroundColor = Colors.white;

    pageBackgroundColor = Colors.white;
    appBarColor = Colors.teal;
    primaryColor = Colors.teal;
    secondaryColor = Colors.teal[700]!;
    accentColor = Colors.amber;
    isDarkMode = false;

    _menuFontSize = 13.0;
  }
}

// Mixin برای استفاده آسان در صفحات
mixin SettingsAwareWidget {
  AppSettings get settings => AppSettings.instance;
}