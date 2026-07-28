import 'package:flutter/material.dart';

class Word {
  final String fa;
  final String en;
  final String desc;

  Word({required this.fa, required this.en, required this.desc});

  factory Word.fromMap(Map<String, String> map) {
    return Word(
      fa: map["fa"] ?? "",
      en: map["en"] ?? "",
      desc: map["desc"] ?? "",
    );
  }
}

class LetterGPage extends StatefulWidget {
  const LetterGPage({Key? key}) : super(key: key);

  @override
  State<LetterGPage> createState() => _LetterGPageState();
}

class _LetterGPageState extends State<LetterGPage> {
  late List<Word> allWords;
  List<Word> filteredWords = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  // ==================== تابع حذف اعراب ====================
  String _removeDiacritics(String text) {
    // حروف عربی با اعراب را به حروف بدون اعراب تبدیل می‌کند
    const diacritics = {
      'َ': '', // فتحه
      'ِ': '', // کسره
      'ُ': '', // ضمه
      'ً': '', // تنوین نصب
      'ٍ': '', // تنوین جر
      'ٌ': '', // تنوین رفع
      'ّ': '', // تشدید
      'ْ': '', // سکون
      'ٓ': '', // مده
      'ٰ': '', // الف خنجری
      'ٔ': '', // همزه
      'ٕ': '', // همزه
    };
    
    String result = text;
    diacritics.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  // ==================== تابع مقایسه بدون اعراب ====================
  int _compareWithoutDiacritics(String a, String b) {
    return _removeDiacritics(a).compareTo(_removeDiacritics(b));
  }

  // ==================== تابع بررسی وجود زیررشته بدون اعراب ====================
  bool _containsWithoutDiacritics(String text, String query) {
    return _removeDiacritics(text).contains(_removeDiacritics(query));
  }

  @override
  void initState() {
    super.initState();
    allWords = rawData.map((map) => Word.fromMap(map)).toList();
    _sortWords();
    filteredWords = List.from(allWords);
    searchController.addListener(_onSearchChanged);
  }

  void _sortWords() {
    // مرتب‌سازی بر اساس حذف اعراب
    allWords.sort((a, b) => _compareWithoutDiacritics(a.fa, b.fa));
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim();
      if (searchQuery.isEmpty) {
        filteredWords = List.from(allWords);
      } else {
        filteredWords = allWords.where((word) {
          return _containsWithoutDiacritics(word.fa, searchQuery) ||
              _containsWithoutDiacritics(word.desc, searchQuery);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("واژه‌های حرف گ"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "جستجوی واژه یا توضیحات...",
                hintTextDirection: TextDirection.rtl,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: filteredWords.isEmpty
          ? const Center(child: Text("نتیجه‌ای یافت نشد"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredWords.length,
              itemBuilder: (context, index) {
                final item = filteredWords[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: RichText(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    text: _buildTextSpan(item),
                  ),
                );
              },
            ),
    );
  }

  TextSpan _buildTextSpan(Word item) {
    List<InlineSpan> children = [];

    // ===== کلمه اصلی با رنگ قرمز (با هایلایت زرد در صورت جستجو) =====
    if (searchQuery.isNotEmpty && _containsWithoutDiacritics(item.fa, searchQuery)) {
      // برای هایلایت، از کلمه اصلی با اعراب استفاده می‌کنیم ولی جستجو بدون اعراب انجام می‌شود
      final query = searchQuery;
      final faText = item.fa;
      final faWithoutDiacritics = _removeDiacritics(faText);
      final queryWithoutDiacritics = _removeDiacritics(query);
      
      // پیدا کردن موقعیت‌های جستجو در متن بدون اعراب
      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < faWithoutDiacritics.length) {
        int index = faWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
        if (index == -1) break;
        indices.add(index);
        startIndex = index + queryWithoutDiacritics.length;
      }

      // ساخت متن با هایلایت
      int lastIndex = 0;
      for (int idx in indices) {
        // بخش قبل از هایلایت
        if (idx > lastIndex) {
          children.add(
            TextSpan(
              text: faText.substring(lastIndex, idx),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        }
        // بخش هایلایت شده
        children.add(
          TextSpan(
            text: faText.substring(idx, idx + query.length),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
              backgroundColor: Colors.yellow,
            ),
          ),
        );
        lastIndex = idx + query.length;
      }
      // بخش باقی‌مانده
      if (lastIndex < faText.length) {
        children.add(
          TextSpan(
            text: faText.substring(lastIndex),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      children.add(
        TextSpan(
          text: item.fa,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }

    // ===== لاتین داخل پرانتز با رنگ آبی =====
    if (item.en.isNotEmpty) {
      children.add(
        TextSpan(
          text: " (${item.en})",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
      );
    }

    // ===== علامت : =====
    children.add(
      const TextSpan(
        text: " : ",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );

    // ===== توضیحات (با هایلایت زرد در صورت جستجو) =====
    if (searchQuery.isNotEmpty && _containsWithoutDiacritics(item.desc, searchQuery)) {
      final query = searchQuery;
      final descText = item.desc;
      final descWithoutDiacritics = _removeDiacritics(descText);
      final queryWithoutDiacritics = _removeDiacritics(query);
      
      // پیدا کردن موقعیت‌های جستجو در متن بدون اعراب
      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < descWithoutDiacritics.length) {
        int index = descWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
        if (index == -1) break;
        indices.add(index);
        startIndex = index + queryWithoutDiacritics.length;
      }

      // ساخت متن با هایلایت
      int lastIndex = 0;
      for (int idx in indices) {
        if (idx > lastIndex) {
          children.add(
            TextSpan(
              text: descText.substring(lastIndex, idx),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          );
        }
        children.add(
          TextSpan(
            text: descText.substring(idx, idx + query.length),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              backgroundColor: Colors.yellow,
            ),
          ),
        );
        lastIndex = idx + query.length;
      }
      if (lastIndex < descText.length) {
        children.add(
          TextSpan(
            text: descText.substring(lastIndex),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      children.add(
        TextSpan(
          text: item.desc,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    }

    return TextSpan(children: children);
  }

  final List<Map<String, String>> rawData = const [
    {"fa": "گُمب", "en": "gomb", "desc": "سوراخ استخر و محلی که آب وارد باغ می‌شود (گُمبه سلخ – گُمب باغ)"},
    {"fa": "گیرا", "en": "geira", "desc": "روشن شدن آتش (... آتشا گیرا کن)"},
    {"fa": "گَلَن", "en": "galan", "desc": "مخفف گالن، ظرف نفتی"},
    {"fa": "گیس بلندو", "en": "gis boland", "desc": "زردپی"},
    {"fa": "گَل گُلو هم", "en": "gal goloo ham", "desc": "در هم بر هم"},
    {"fa": "گَلوبنده", "en": "galoo banda", "desc": "گردن‌بند"},
    {"fa": "گلیز", "en": "geleiz", "desc": "آب دهان"},
    {"fa": "گندم گیاوو", "en": "", "desc": "نوعی علف"},
    {"fa": "گُراش", "en": "gorash", "desc": "دفعه، مرتبه"},
    {"fa": "گُله", "en": "gola", "desc": "تاج مرغ و خروس"},
    {"fa": "گورگا", "en": "goorga", "desc": "قسمتی از جوی که پهن می‌شود و آب به چند شعبه تقسیم می‌گردد (گورگا صدمنی)"},
    {"fa": "گاهَس", "en": "gahas", "desc": "احتمالاً (... گاهس نمیاد)"},
    {"fa": "گیدو", "en": "geidoo", "desc": "زائده‌ای در پلک چشم (... چشمم گیدو در آورده)"},
    {"fa": "گالو بته سرو", "en": "galoo", "desc": "میوه درخت سرو"},
    {"fa": "گودال خُجه", "en": "", "desc": "گودالی در محله دم دروازه ایراج که در قدیم آب داشته"},
    {"fa": "گاباشه", "en": "gabasha", "desc": "احتمالاً (... گاباشه رفته دشت)"},
    {"fa": "گیر از دست و پای کسی در رفتن", "en": "", "desc": "شوکه شدن بر اثر خبر بد؛ ناگهان سست شدن"},
    {"fa": "گَرتال", "en": "gartal", "desc": "گرد و غبار زیاد (... اینقد گرتال نکن)"},
    {"fa": "گَهگیر", "en": "gahgeir", "desc": "ناسازگار، نگرفته"},
    {"fa": "گیله", "en": "geila", "desc": "گِله"},
    {"fa": "گم و گُتار", "en": "gom o gotar", "desc": "گم"},
    {"fa": "گشنه مرده", "en": "goshna morda", "desc": "مفلس، نیازمند"},
    {"fa": "گرگین", "en": "gorgein", "desc": "دام سنگی تونلی برای گرگ؛ با نخ و سنگ پهن دهانه را می‌بستند"},
    {"fa": "گالو", "en": "galoo", "desc": "زگیل"},
    {"fa": "گَرتو", "en": "gartoo", "desc": "مه"},
    {"fa": "گُداخته", "en": "godakhta", "desc": "غذای مقوی از روغن حیوانی، تخم‌مرغ و شکر برای زن تازه‌زایمان کرده"},
    {"fa": "گوش کن!", "en": "", "desc": "عبارت تعجب هنگام صحبت یا خبر دادن"},
    {"fa": "گیوه", "en": "geiva", "desc": "نوعی کفش کار"},
    {"fa": "گالِش", "en": "galesh", "desc": "نوعی کفش راحتی"},
    {"fa": "گُس پا", "en": "gos pa", "desc": "از خانواده بندپایان (شبیه کنه)"},
    {"fa": "گُر کُشته", "en": "gor", "desc": "عبارت پرخاش به گوسفند (حروم شده)"},
    {"fa": "گَنکُتو", "en": "gankotoo", "desc": "بلبل کوهستان"},
    {"fa": "گُردو", "en": "ghordoo", "desc": "قلوه"},
    {"fa": "گُندِله", "en": "gondela", "desc": "توده نخ"},
    {"fa": "گوپ", "en": "goop", "desc": "توپ"},
    {"fa": "گوپونی", "en": "goopoonei", "desc": "توپ‌بازی"},
    {"fa": "گَردون", "en": "gardoon", "desc": "وسیله کوچکتر از گاری با چهار چرخ دندانه‌دار برای جدا کردن گندم از خوشه"},
    {"fa": "گوله", "en": "goola", "desc": "زمین زراعی کوچک"},
    {"fa": "گوش کوه", "en": "", "desc": "سوراخ‌های بسیار عمیق با دهانه تنگ در کوه؛ خروج بخارات (دم‌وبازدم کوه)"},
    {"fa": "گولیو", "en": "gooleioo", "desc": "خمیرهای گلوله‌ای در آتش؛ ترکیدن‌شان را نشانه ترکیدن چشم حسود می‌دانند"},
    {"fa": "گُلمه", "en": "golma", "desc": "قسمتی از جایی (گُلمه جا)"},
    {"fa": "گَلون", "en": "galoon", "desc": "گردن، گلو (... بگیر گلونشا بکن حروم شد = سر گوسفندا ببر)"},
    {"fa": "گَرت", "en": "gart", "desc": "نوبت آبیاری در ایراج (هر 16 روز یک‌بار)"},
    {"fa": "گُلّه", "en": "gholla", "desc": "گلوله"},
    {"fa": "گُلو", "en": "", "desc": "گل‌آلود"},
    {"fa": "گُل ماس", "en": "gol mas", "desc": "ماست و شیر آمیخته"},
    {"fa": "گرمایی", "en": "garmaei", "desc": "گرمازده"},
    {"fa": "گُل گُلی", "en": "golgolei", "desc": "رنگ‌وارنگ"},
    {"fa": "گوش بل", "en": "", "desc": "حیوانی که گوش‌های دراز دارد"},
    {"fa": "گله در رُو", "en": "", "desc": "صبح زود پیش از طلوع آفتاب (... گله در رو باید راه بیفتیم)"},
    {"fa": "گَرّو", "en": "garroo", "desc": "جایی در بیابان نزدیک کوهستان (نزدیک گولار ایراج – گرو گولار)"},
    {"fa": "گُه تالونو", "en": "goh taloonoo", "desc": "سرگین غلتان"},
    {"fa": "گایه", "en": "gaya", "desc": "اثر چیزی روی بدن (مثل اثر کش جوراب)"},
    {"fa": "گلِ بو", "en": "", "desc": "گل محمدی"},
    {"fa": "گُشک", "en": "goshk", "desc": "مرحله‌ای از بافت زنبیل حصیری با برگ خرما (... داره گشک می‌بافه)"},
    {"fa": "گُمپُله", "en": "gompola", "desc": "توده نخ"},
    {"fa": "گَل", "en": "gal", "desc": "دور چیزی (... گَل دستشا بگیر بیارش)"},
    {"fa": "گوُو", "en": "govoo", "desc": "چهار دست و پا راه رفتن"},
    {"fa": "گاب خدا", "en": "gab", "desc": "نوعی سوسک"},
    {"fa": "گیراگیر بود", "en": "", "desc": "نزدیک بود"},
    {"fa": "گُرپ", "en": "", "desc": "دنبال کسی دویدن (... گرپش کرد تا گرفتش)"},
    {"fa": "گَل گَل", "en": "gal gal", "desc": "سر و صدا"},
    {"fa": "گُجار", "en": "", "desc": "شکاف"},
    {"fa": "گُرُپ گُرُپ", "en": "", "desc": "صدای بمِ ضربه روی چیزی"},
    {"fa": "گرگ انداز", "en": "", "desc": "روده بزرگ گوسفند"},
    {"fa": "گِبر", "en": "", "desc": "پل شلوار"},
    {"fa": "گازورو", "en": "", "desc": "سنگ سوراخ‌سوراخ"},
    {"fa": "گیشه", "en": "", "desc": "بیشه"},
  ];
}