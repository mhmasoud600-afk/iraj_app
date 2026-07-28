import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global_music_player.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  final GlobalMusicPlayer player = GlobalMusicPlayer();

  // لیست دعاها
  final List<Map<String, String>> prayers = [
{
      "title": "دعای چهاردهم صحیفه سجادیه",
      "file": "prayers/sahifeh_fourteen.ogg",
      "textFile": "assets/prayers/sahifeh_fourteen.txt"
    },
    {
      "title": "مناجات شعبانیه",
      "file": "prayers/monajat_shabaniye.ogg",
      "textFile": "assets/prayers/monajat_shabaniye.txt"
    },
    {
      "title": "زیارت عاشورا",
      "file": "prayers/ziarat_ashura.ogg",
      "textFile": "assets/prayers/ziarat_ashura.txt"
    },
    {
      "title": "دعای هفتم صحیفه سجادیه",
      "file": "prayers/sahifa_seven.ogg",
      "textFile": "assets/prayers/sahifa_seven.txt"
    },
    {
      "title": "دعای فرج",
      "file": "prayers/faraj.ogg",
      "textFile": "assets/prayers/faraj.txt"
    },
    {
      "title": "دعای عهد",
      "file": "prayers/ahd.ogg",
      "textFile": "assets/prayers/ahd.txt"
    },
    {
      "title": "زیارت آل یاسین",
      "file": "prayers/alyasin.ogg",
      "textFile": "assets/prayers/alyasin.txt"
    },
    {
      "title": "حدیث کساء",
      "file": "prayers/kasa.ogg",
      "textFile": "assets/prayers/kasa.txt"
    },
  ];

  /// تشخیص علائم/اعراب عربی و نشانه‌های قرآنی
  bool _isArabicDiacritic(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);

    // Basic harakat + tanween + shadda + sukun
    if (code >= 0x064B && code <= 0x065F) return true;

    // superscript alef
    if (code == 0x0670) return true;

    // other Quranic marks
    if (code >= 0x06D6 && code <= 0x06ED) return true;

    return false;
  }

  /// ساخت TextSpanهای عربی با:
  /// - حروف مشکی
  /// - اعراب آبی
  List<TextSpan> _getArabicTextWithBlueDiacritics(String text) {
  final spans = <TextSpan>[];

  final regex = RegExp(r'[\u064B-\u065F\u0670\u06D6-\u06ED]');
  int start = 0;

  for (final match in regex.allMatches(text)) {
    if (match.start > start) {
      spans.add(
        TextSpan(
          text: text.substring(start, match.start),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontFamily: "NotoNaskhArabic",
            height: 2,
          ),
        ),
      );
    }

    spans.add(
      TextSpan(
        text: match.group(0),
        style: const TextStyle(
          color: Colors.red,
          fontSize: 30,
          fontFamily: "NotoNaskhArabic",
          height: 2,
        ),
      ),
    );

    start = match.end;
  }

  if (start < text.length) {
    spans.add(
      TextSpan(
        text: text.substring(start),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontFamily: "NotoNaskhArabic",
          height: 2,
        ),
      ),
    );
  }

  return spans;
}

  Color _getPrayerColor(int index) {
    final colors = [
      Colors.teal,
      Colors.indigo,
      Colors.deepPurple,
      Colors.green,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }

  IconData _getPrayerIcon(int index) {
    final icons = [
      Icons.mosque,
      Icons.menu_book,
      Icons.auto_stories,
      Icons.favorite,
      Icons.star,
    ];
    return icons[index % icons.length];
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// متد جاافتاده‌ای که در خط 209 صدا زده شده بود
  Widget _buildPrayerTextWithFormat(String ar, String fa) {

return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (ar.trim().isNotEmpty)
            Directionality(
              textDirection: ui.TextDirection.rtl,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  children: _getArabicTextWithBlueDiacritics(ar),
                ),
              ),
            ),
          if (fa.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Text(
                fa,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontFamily: "Vazirmatn",
                  height: 1.9,
                ),
              ),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  /// نمایش متن دعا در دیالوگ با فرمت:
  /// هر زوج (عربی + فارسی) => Divider
  /// نکته: فایل‌های txt شما باید به صورت «خط عربی / خط فارسی / خط عربی / خط فارسی ...» باشند.
  void _showFormattedPrayerText(BuildContext context, String title, String text) {
    // تمیزکاری خطوط
    final rawLines = text
        .split(RegExp(r'\r?\n'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // زوج‌سازی عربی/فارسی
    final pairs = <Map<String, String>>[];
    for (int i = 0; i < rawLines.length; i += 2) {
      final arabic = rawLines[i];
      final persian = (i + 1 < rawLines.length) ? rawLines[i + 1] : "";
      pairs.add({"ar": arabic, "fa": persian});
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.menu_book, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Vazirmatn",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),


itemCount: pairs.length,
                    itemBuilder: (context, index) {
                      final ar = pairs[index]["ar"] ?? "";
                      final fa = pairs[index]["fa"] ?? "";
                      return _buildPrayerTextWithFormat(ar, fa);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrayersTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: prayers.length,
      itemBuilder: (context, index) {
        final prayer = prayers[index];
        final isPlaying = player.currentSong == prayer["file"];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                if (isPlaying) {
                  await player.stop();
                } else {
                  await player.play(prayer["file"]!);
                }
                setState(() {});
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: _getPrayerColor(index),
                child: Icon(
                  isPlaying ? Icons.pause : _getPrayerIcon(index),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () async {
                if (isPlaying) {
                  await player.stop();
                } else {
                  await player.play(prayer["file"]!);
                }
                setState(() {});
              },
              child: Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Text(
                  prayer["title"]!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Vazirmatn",
                  ),
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.stop : Icons.play_arrow,
                    color: isPlaying ? Colors.red : Colors.green,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await player.stop();
                    } else {
                      await player.play(prayer["file"]!);
                    }
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.menu_book,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    try {
                      final text = await rootBundle.loadString(prayer["textFile"]!);
                      _showFormattedPrayerText(context, prayer["title"]!, text);
                    } catch (e) {
                      _showErrorSnackbar(context, 'خطا در بارگیری متن');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("صفحه دعا و زیارت"),
      ),
      body: _buildPrayersTab(),
    );
  }
}