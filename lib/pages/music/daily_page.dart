import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final AudioPlayer player = AudioPlayer();
  final ScrollController scrollController = ScrollController();

  int page = 1;
  bool isLoading = false;
  bool isPlayingPage = false;
  bool loadedFromCache = false;

  String todayDate = '';
  int todayPage = 1;
  String? _startDateKey;

  List arabic = [];
  List persian = [];

  int? playingIndex;
  int? playingWordIndex;

  int _playToken = 0;

  List<GlobalKey> verseKeys = [];

  @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  void dispose() {
    _playToken++;
    player.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // محاسبه صفحه بر اساس تاریخ شروع هر کاربر
  // ============================================================
  Future<int> getPageForToday() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();

    final startDateKey = prefs.getString('quran_start_date');

    if (startDateKey == null) {
      final todayKey = "${now.year}-${now.month}-${now.day}";
      await prefs.setString('quran_start_date', todayKey);
      _startDateKey = todayKey;

      final startOfYear = DateTime(now.year, 1, 1);
      final dayOfYear = now.difference(startOfYear).inDays + 1;
      int calculatedPage = dayOfYear % 604;
      if (calculatedPage == 0) calculatedPage = 604;

      await prefs.setInt('quran_last_page', calculatedPage);
      return calculatedPage;
    } else {
      _startDateKey = startDateKey;
      final startParts = startDateKey.split('-');
      final startDate = DateTime(
        int.parse(startParts[0]),
        int.parse(startParts[1]),
        int.parse(startParts[2]),
      );

      final difference = now.difference(startDate).inDays;

      final firstPage = prefs.getInt('quran_first_page') ?? 1;

      int todayPage = firstPage + difference;

      while (todayPage > 604) {
        todayPage -= 604;
      }
      while (todayPage < 1) {
        todayPage += 604;
      }

      await prefs.setInt('quran_last_page', todayPage);
      return todayPage;
    }
  }

  Future<void> setFirstPage(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quran_first_page', pageNumber);
    await prefs.setInt('quran_last_page', pageNumber);
  }

  Future<void> initPage() async {
    final prefs = await SharedPreferences.getInstance();

    todayPage = await getPageForToday();

    final lastVisitedPage = prefs.getInt('quran_last_visited_page') ?? 0;

    if (lastVisitedPage == 0) {
      page = todayPage;
      await prefs.setInt('quran_last_visited_page', page);
    } else {
      page = lastVisitedPage;
    }

    final now = Jalali.now();
    todayDate = "${toFa(now.day)} ${now.formatter.mN} ${toFa(now.year)}";

    await loadPage();
  }

  String toFa(dynamic n) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

    String s = n.toString();

    for (int i = 0; i < 10; i++) {
      s = s.replaceAll(en[i], fa[i]);
    }

    return s;
  }

  Future<void> savePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quran_last_page', page);
    await prefs.setInt('quran_last_visited_page', page);
  }

  Future<void> loadPage() async {
    _playToken++;

    setState(() {
      isLoading = true;
      playingIndex = null;
      playingWordIndex = null;
      isPlayingPage = false;
      loadedFromCache = false;
    });

    await player.stop();

    final prefs = await SharedPreferences.getInstance();
    final cacheKey = "quran_page_cache_$page";

    bool hasCache = false;

    try {
      final cached = prefs.getString(cacheKey);

      if (cached != null) {
        final cachedData = jsonDecode(cached);

        arabic = cachedData["arabic"] ?? [];
        persian = cachedData["persian"] ?? [];

        verseKeys = List.generate(arabic.length, (_) => GlobalKey());

        hasCache = arabic.isNotEmpty;

        if (hasCache) {
          setState(() {
            isLoading = false;
            loadedFromCache = true;
          });
        }
      }
    } catch (_) {}

    try {
      final ar = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/page/$page/quran-uthmani"),
      );

      final fa = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/page/$page/fa.ansarian"),
      );

      if (ar.statusCode == 200 && fa.statusCode == 200) {
        final arData = jsonDecode(ar.body);
        final faData = jsonDecode(fa.body);

        final newArabic = arData["data"]["ayahs"] ?? [];
        final newPersian = faData["data"]["ayahs"] ?? [];

        arabic = newArabic;
        persian = newPersian;

        verseKeys = List.generate(arabic.length, (_) => GlobalKey());

        await prefs.setString(
          cacheKey,
          jsonEncode({
            "arabic": arabic,
            "persian": persian,
            "savedAt": DateTime.now().toIso8601String(),
          }),
        );

        setState(() {
          isLoading = false;
          loadedFromCache = false;
        });
      } else {
        if (!hasCache) {
          setState(() => isLoading = false);
          showMessage("خطا در دریافت اطلاعات صفحه");
        }
      }
    } catch (_) {
      if (!hasCache) {
        setState(() => isLoading = false);
        showMessage("اتصال اینترنت برقرار نیست و کشی برای این صفحه وجود ندارد");
      } else {
        showMessage("صفحه از حافظه آفلاین نمایش داده شد");
      }
    }
  }

  void showMessage(String text) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  String cleanArabicText(String text) {
    if (text.isEmpty) return text;

    final charsToRemove = [
      '۝',
      '\u200B', '\u200C', '\u200D', '\u200E', '\u200F', '\uFEFF', '\u00A0',
    ];

    String result = text;

    for (final char in charsToRemove) {
      result = result.replaceAll(char, '');
    }

    return result.trim();
  }

  // ============================================================
  // تشخیص علائم اعراب (دقیقاً از صفحه دعا کپی شده)
  // ============================================================
  bool _isArabicDiacritic(String ch) {
    if (ch.isEmpty) return false;
    final code = ch.codeUnitAt(0);

    if (code >= 0x064B && code <= 0x065F) return true;
    if (code == 0x0670) return true;
    if (code >= 0x06D6 && code <= 0x06ED) return true;

    return false;
  }

  // ============================================================
  // ساخت TextSpanهای عربی (دقیقاً از صفحه دعا کپی شده)
  // ============================================================
  List<TextSpan> _getArabicTextWithRedDiacritics(String text) {
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
              fontSize: 28,
              fontFamily: "NotoNaskhArabic",
              height: 1.8,
            ),
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(0),
          style: const TextStyle(
            color: Colors.red,
            fontSize: 28,
            fontFamily: "NotoNaskhArabic",
            height: 1.8,
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
            fontSize: 28,
            fontFamily: "NotoNaskhArabic",
            height: 1.8,
          ),
        ),
      );
    }

    return spans;
  }

  // ============================================================
  // نمایش متن عربی با فونت NotoNaskhArabic (دقیقاً از صفحه دعا)
  // ============================================================
  Widget _buildArabicText(String text, int ayah, bool isPlaying) {
    if (text.isEmpty) return const SizedBox();

    final cleaned = text
        .replaceAll('۝', '')
        .replaceAll(RegExp(r'[\u200B-\u200F\uFEFF]'), '');

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isPlaying ? const Color(0xfffff1b8) : null,
          borderRadius: BorderRadius.circular(14),
          border: isPlaying
              ? Border.all(color: const Color(0xffff9800), width: 1.5)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 28,
                  fontFamily: "NotoNaskhArabic",
                  height: 1.8,
                ),
                children: _getArabicTextWithRedDiacritics(cleaned),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xfff0c84c),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                "آیه ${toFa(ayah)}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'Vazirmatn',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // توابع کمکی
  // ============================================================
  Future<void> scrollToVerse(int index) async {
    await Future.delayed(const Duration(milliseconds: 120));

    if (!mounted) return;
    if (index < 0 || index >= verseKeys.length) return;

    final context = verseKeys[index].currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      alignment: 0.18,
    );
  }

  Future<void> followWordsApproximately({
    required int verseIndex,
    required Duration? duration,
    required int token,
  }) async {
    if (verseIndex < 0 || verseIndex >= arabic.length) return;

    final text = cleanArabicText(arabic[verseIndex]["text"] ?? "");
    final words = text.split(RegExp(r'\s+'));

    if (words.isEmpty) return;

    final totalMs = duration?.inMilliseconds ?? 0;

    if (totalMs <= 0) {
      return;
    }

    int interval = totalMs ~/ words.length;

    if (interval < 180) {
      interval = 180;
    }

    for (int i = 0; i < words.length; i++) {
      if (!mounted) return;
      if (_playToken != token) return;
      if (playingIndex != verseIndex) return;

      setState(() {
        playingWordIndex = i;
      });

      await Future.delayed(Duration(milliseconds: interval));
    }
  }

  Future<void> playSingleAyah(int index) async {
    if (index < 0 || index >= arabic.length) return;

    _playToken++;
    final token = _playToken;

    final ar = arabic[index];
    final int global = ar["number"];

    setState(() {
      playingIndex = index;
      playingWordIndex = null;
      isPlayingPage = false;
    });

    await scrollToVerse(index);

    final url =
        "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$global.mp3";

    try {
      await player.stop();

      final duration = await player.setUrl(url);

      if (!mounted || _playToken != token) return;

      await player.play();

      followWordsApproximately(
        verseIndex: index,
        duration: duration,
        token: token,
      );
    } catch (_) {
      showMessage("خطا در پخش صوت آیه");
    }
  }

  Future<void> playWholePage() async {
    if (arabic.isEmpty) return;

    _playToken++;
    final token = _playToken;

    setState(() {
      isPlayingPage = true;
      playingIndex = null;
      playingWordIndex = null;
    });

    for (int i = 0; i < arabic.length; i++) {
      if (!mounted) return;
      if (_playToken != token) return;
      if (!isPlayingPage) break;

      final ar = arabic[i];
      final int global = ar["number"];

      setState(() {
        playingIndex = i;
        playingWordIndex = null;
      });

      await scrollToVerse(i);

      final url =
          "https://cdn.islamic.network/quran/audio/128/ar.alafasy/$global.mp3";

      try {
        await player.stop();

        final duration = await player.setUrl(url);

        if (!mounted || _playToken != token || !isPlayingPage) return;

        await player.play();

        followWordsApproximately(
          verseIndex: i,
          duration: duration,
          token: token,
        );

        await player.processingStateStream.firstWhere(
          (state) => state == ProcessingState.completed,
        );
      } catch (_) {
        showMessage("خطا در پخش صوت صفحه");
        break;
      }
    }

    if (!mounted) return;
    if (_playToken != token) return;

    setState(() {
      playingIndex = null;
      playingWordIndex = null;
      isPlayingPage = false;
    });
  }

  Future<void> stopAudio() async {
    _playToken++;

    await player.stop();

    if (!mounted) return;

    setState(() {
      playingIndex = null;
      playingWordIndex = null;
      isPlayingPage = false;
    });
  }

  Future<void> copyPage() async {
    String text = "";

    for (int i = 0; i < arabic.length; i++) {
      text += cleanArabicText(arabic[i]["text"] ?? "");
      text += "\n";

      if (i < persian.length) {
        text += persian[i]["text"] ?? "";
        text += "\n\n";
      }
    }

    await Clipboard.setData(ClipboardData(text: text));

    showMessage("کل صفحه کپی شد");
  }

  String hizbQuarterTitle(int value) {
    final hizbNumber = ((value - 1) ~/ 4) + 1;
    final position = value % 4;

    if (position == 1) {
      return "شروع حزب ${toFa(hizbNumber)}";
    } else if (position == 2) {
      return "ربع حزب ${toFa(hizbNumber)}";
    } else if (position == 3) {
      return "نصف حزب ${toFa(hizbNumber)}";
    } else {
      return "سه‌ربع حزب ${toFa(hizbNumber)}";
    }
  }

  bool shouldShowHizbMarker(int index) {
    if (index < 0 || index >= arabic.length) return false;

    final current = arabic[index]["hizbQuarter"];

    if (current == null) return false;

    if (index == 0) return true;

    final previous = arabic[index - 1]["hizbQuarter"];

    return current != previous;
  }

  bool shouldShowSurahHeader(int index) {
    if (index < 0 || index >= arabic.length) return false;

    final currentSurah = arabic[index]["surah"]?["number"];

    if (currentSurah == null) return false;

    if (index == 0) return true;

    final previousSurah = arabic[index - 1]["surah"]?["number"];

    return currentSurah != previousSurah;
  }

  Widget hizbMarker(int index) {
    final value = arabic[index]["hizbQuarter"];

    if (value == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xffeef8ef),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xff2e7d32).withOpacity(0.35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "۞",
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff2e7d32),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              hizbQuarterTitle(value),
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xff2e7d32),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget surahHeader(int index) {
    final surah = arabic[index]["surah"];

    if (surah == null) return const SizedBox();

    final String name = cleanArabicText(surah["name"] ?? "");
    final int numberOfAyahs = surah["numberOfAyahs"] ?? 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff123c69),
              Color(0xff1f6f8b),
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 1.7,
                fontFamily: "NotoNaskhArabic",
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "تعداد آیات: ${toFa(numberOfAyahs)}",
              style: const TextStyle(
                color: Color(0xffffe9a8),
                fontSize: 12,
              ),
            ),
            if ((surah["number"] ?? 0) != 1 && (surah["number"] ?? 0) != 9)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  cleanArabicText("بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    height: 1.8,
                    fontFamily: "NotoNaskhArabic",
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget verseItem(int i) {
    final ar = arabic[i];
    final fa = i < persian.length ? persian[i] : null;

    final int ayah = ar["numberInSurah"] ?? 0;
    final bool playing = playingIndex == i;

    return Column(
      children: [
        if (shouldShowSurahHeader(i)) surahHeader(i),
        if (shouldShowHizbMarker(i)) hizbMarker(i),
        Container(
          key: verseKeys[i],
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      playing ? Icons.graphic_eq : Icons.volume_up,
                      size: 22,
                      color: playing ? Colors.orange : Colors.black87,
                    ),
                    onPressed: () {
                      playSingleAyah(i);
                    },
                  ),
                  if (playing)
                    const Text(
                      "در حال پخش",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const Spacer(),
                  Text(
                    "آیه ${toFa(ayah)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: playing ? Colors.orange : Colors.black87,
                      fontWeight: playing ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              _buildArabicText(
                ar["text"] ?? "",
                ayah,
                playing,
              ),
              if (fa != null) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xfffafafa),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    fa["text"] ?? "",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget meta() {
    if (arabic.isEmpty) return const SizedBox();

    final s = arabic.first["surah"];

    if (s == null) return const SizedBox();

    String name = s["name"] ?? "";
    name = name.replaceFirst("سوره ", "");

    final int ayahs = s["numberOfAyahs"] ?? 0;
    final int juz = arabic.first["juz"] ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xffdddddd),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "سوره $name",
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              "آیات ${toFa(ayahs)}",
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              "جزء ${toFa(juz)}",
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              "صفحه ${toFa(page)}",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget cacheStatus() {
    if (!loadedFromCache) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "نمایش از حافظه آفلاین",
        style: TextStyle(
          color: Colors.green.shade700,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget audioBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (isPlayingPage) {
                  stopAudio();
                } else {
                  playWholePage();
                }
              },
              icon: Icon(
                isPlayingPage ? Icons.stop : Icons.play_arrow,
                size: 19,
              ),
              label: Text(
                isPlayingPage ? "توقف پخش صفحه" : "پخش کل صفحه",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: copyPage,
                icon: const Icon(Icons.copy, size: 17),
                label: const Text(
                  "کپی",
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: page <= 1
                    ? null
                    : () async {
                        await stopAudio();
                        page--;
                        await savePage();
                        await loadPage();
                      },
                icon: const Icon(Icons.chevron_right, size: 18),
                label: const Text(
                  "قبل",
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: page >= 604
                    ? null
                    : () async {
                        await stopAudio();
                        page++;
                        await savePage();
                        await loadPage();
                      },
                icon: const Icon(Icons.chevron_left, size: 18),
                label: const Text(
                  "بعد",
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xfff6f8fb),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 6),
              Text(
                todayDate,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff555555),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              cacheStatus(),
              meta(),
              Expanded(
                child: isLoading && arabic.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: loadPage,
                        child: arabic.isEmpty
                            ? ListView(
                                children: const [
                                  SizedBox(height: 120),
                                  Center(
                                    child: Text("اطلاعاتی برای نمایش وجود ندارد"),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: arabic.length,
                                itemBuilder: (context, i) => verseItem(i),
                              ),
                      ),
              ),
              audioBar(),
              bottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}