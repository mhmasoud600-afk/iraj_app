import 'package:flutter/material.dart';
import '../settings/app_settings.dart';

class SunPage extends StatefulWidget {
  const SunPage({Key? key}) : super(key: key);

  @override
  State<SunPage> createState() => _SunPageState();
}

class _SunPageState extends State<SunPage> with SettingsAwareWidget {
  bool isDarkMode = false; // حالت اولیه: روشن

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      // تغییر تنظیمات سراسری
      settings.isDarkMode = isDarkMode;
      if (isDarkMode) {
        settings.mainTextColor = Colors.white;
        settings.pageBackgroundColor = const Color(0xFF0A1A2F);
        settings.appBarColor = const Color(0xFF0A1A2F);
        settings.primaryColor = Colors.teal[300]!;
      } else {
        settings.mainTextColor = Colors.black;
        settings.pageBackgroundColor = Colors.white;
        settings.appBarColor = Colors.teal;
        settings.primaryColor = Colors.teal;
      }
      // ذخیره تنظیمات
      settings.saveSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "صفحه اصلی",
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              settings.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.white,
            ),
            onPressed: _toggleTheme,
            tooltip: settings.isDarkMode ? "حالت روز" : "حالت شب",
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              settings.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              size: 80,
              color: settings.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              settings.isDarkMode ? "حالت شب فعال است" : "حالت روز فعال است",
              style: TextStyle(
                fontSize: settings.mainFontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              settings.isDarkMode
                  ? "برای تغییر به حالت روز، روی آیکون بالا کلیک کنید"
                  : "برای تغییر به حالت شب، روی آیکون بالا کلیک کنید",
              style: TextStyle(
                fontSize: settings.mainFontSize - 2,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: settings.buttonFontSize,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SubPage()),
                );
              },
              child: const Text("رفتن به صفحه فرعی"),
            ),
          ],
        ),
      ),
    );
  }
}

class SubPage extends StatelessWidget with SettingsAwareWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "صفحه فرعی",
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 80,
              color: settings.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              "این یک صفحه فرعی است",
              style: TextStyle(
                fontSize: settings.mainFontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "رنگ‌های این صفحه با تنظیمات سراسری هماهنگ شده است",
              style: TextStyle(
                fontSize: settings.mainFontSize - 2,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: settings.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: settings.buttonFontSize,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("بازگشت"),
            ),
          ],
        ),
      ),
    );
  }
}