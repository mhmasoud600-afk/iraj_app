import 'package:flutter/material.dart';

// 🔵 همه صفحات حروف را ایمپورت کن
import 'letter_a_page.dart';
import 'letter_b_page.dart';
import 'letter_p_page.dart';
import 'letter_t_page.dart';
import 'letter_s_page.dart';
import 'letter_j_page.dart';
import 'letter_ch_page.dart';
import 'letter_h_page.dart';
import 'letter_kh_page.dart';
import 'letter_d_page.dart';
import 'letter_z_page.dart';
import 'letter_r_page.dart';
import 'letter_z2_page.dart';
import 'letter_zh_page.dart';
import 'letter_s2_page.dart';
import 'letter_sh_page.dart';
import 'letter_sad_page.dart';
import 'letter_zad_page.dart';
import 'letter_ta_page.dart';
import 'letter_za_page.dart';
import 'letter_ain_page.dart';
import 'letter_ghain_page.dart';
import 'letter_f_page.dart';
import 'letter_gh_page.dart';
import 'letter_k_page.dart';
import 'letter_g_page.dart';
import 'letter_l_page.dart';
import 'letter_m_page.dart';
import 'letter_n_page.dart';
import 'letter_v_page.dart';
import 'letter_he_page.dart';
import 'letter_y_page.dart';

class VillageDictionaryPage extends StatelessWidget {
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;

  const VillageDictionaryPage({
    Key? key,
    required this.fontSize,
    required this.fontFamily,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  static const List<String> persianLetters = [
    "ا","ب","پ","ت","ث","ج","چ","ح","خ",
    "د","ذ","ر","ز","ژ","س","ش","ص","ض",
    "ط","ظ","ع","غ","ف","ق","ک","گ","ل",
    "م","ن","و","ه","ی"
  ];

  // 🔵 این تابع صفحهٔ مربوط به هر حرف را برمی‌گرداند
  Widget? _getLetterPage(String letter) {
    switch (letter) {
      case "ا": return LetterAPage();
      case "ب": return LetterBPage();
      case "پ": return LetterPPage();
      case "ت": return LetterTPage();
      case "ث": return LetterSPage();
      case "ج": return LetterJPage();
      case "چ": return LetterChPage();
      case "ح": return LetterHPage();
      case "خ": return LetterKhPage();
      case "د": return LetterDPage();
      case "ذ": return LetterZPage();
      case "ر": return LetterRPage();
      case "ز": return LetterZ2Page();
      case "ژ": return LetterZhPage();
      case "س": return LetterS2Page();
      case "ش": return LetterShPage();
      case "ص": return LetterSadPage();
      case "ض": return LetterZadPage();
      case "ط": return LetterTaPage();
      case "ظ": return LetterZaPage();
      case "ع": return LetterAinPage();
      case "غ": return LetterGhainPage();
      case "ف": return LetterFPage();
      case "ق": return LetterGhPage();
      case "ک": return LetterKPage();
      case "گ": return LetterGPage();
      case "ل": return LetterLPage();
      case "م": return LetterMPage();
      case "ن": return LetterNPage();
      case "و": return LetterVPage();
      case "ه": return LetterHePage();
      case "ی": return LetterYPage();
      default: return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "فرهنگ لغت روستا",
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
          double fontSizeValue;
          double aspectRatio;
          
          if (screenWidth < 380) {
            // گوشی‌های بسیار کوچک
            crossAxisCount = 3;
            crossAxisSpacing = 6;
            mainAxisSpacing = 6;
            fontSizeValue = 20;
            aspectRatio = 1.0;
          } else if (screenWidth < 480) {
            // گوشی‌های کوچک
            crossAxisCount = 4;
            crossAxisSpacing = 8;
            mainAxisSpacing = 8;
            fontSizeValue = 22;
            aspectRatio = 1.1;
          } else if (screenWidth < 600) {
            // گوشی‌های معمولی
            crossAxisCount = 5;
            crossAxisSpacing = 10;
            mainAxisSpacing = 10;
            fontSizeValue = 24;
            aspectRatio = 1.2;
          } else if (screenWidth < 800) {
            // تبلت‌های کوچک
            crossAxisCount = 6;
            crossAxisSpacing = 12;
            mainAxisSpacing = 12;
            fontSizeValue = 28;
            aspectRatio = 1.3;
          } else {
            // تبلت‌های بزرگ
            crossAxisCount = 7;
            crossAxisSpacing = 14;
            mainAxisSpacing = 14;
            fontSizeValue = 32;
            aspectRatio = 1.4;
          }

          // محاسبه ارتفاع مناسب برای نمایش تمام آیتم‌ها
          final totalItems = persianLetters.length;
          final rowsNeeded = (totalItems / crossAxisCount).ceil();
          final availableHeight = constraints.maxHeight - kToolbarHeight - 24; // کم کردن ارتفاع AppBar
          final itemHeight = availableHeight / rowsNeeded;
          final itemWidth = (screenWidth - (crossAxisSpacing * (crossAxisCount - 1)) - 24) / crossAxisCount;
          
          // تنظیم aspectRatio بر اساس ابعاد واقعی
          if (itemWidth > 0 && itemHeight > 0) {
            aspectRatio = itemWidth / itemHeight;
            // محدود کردن aspectRatio برای جلوگیری از تغییرات شدید
            if (aspectRatio > 1.6) aspectRatio = 1.6;
            if (aspectRatio < 0.7) aspectRatio = 0.7;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: aspectRatio,
            ),
            itemCount: persianLetters.length,
            itemBuilder: (context, index) {
              final letter = persianLetters[index];
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[100],
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  final page = _getLetterPage(letter);
                  if (page != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => page),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "صفحهٔ مربوط به $letter هنوز ساخته نشده",
                          style: const TextStyle(fontFamily: 'Vazirmatn'),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  letter,
                  style: TextStyle(
                    fontSize: fontSizeValue,
                    fontFamily: fontFamily,
                    color: Colors.teal[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}