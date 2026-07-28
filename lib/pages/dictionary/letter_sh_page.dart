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

class LetterShPage extends StatefulWidget {
  const LetterShPage({Key? key}) : super(key: key);

  @override
  State<LetterShPage> createState() => _LetterShPageState();
}

class _LetterShPageState extends State<LetterShPage> {
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
        title: const Text("واژه‌های حرف ش"),
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
    {"fa": "شُوَنگَر", "en": "shovangar", "desc": "چوبی با دسته باریک و سر ضخیم برای خرد کردن ساقه لوبیا و باقالی"},
    {"fa": "شِکَمبه", "en": "", "desc": "سیرابی"},
    {"fa": "شیوَه", "en": "sheiva", "desc": "آویزان، مایل (... هر وقت سایه‌ها شیوه شد راه می‌افتیم)"},
    {"fa": "شاش بند", "en": "", "desc": "بیماری که فرد در ادرار کردن با مشکل روبه‌رو شود"},
    {"fa": "شب خونی", "en": "shab khoonei", "desc": "مناجات قبل از اذان صبح در رمضان از بلندگو"},
    {"fa": "شور خون", "en": "shoorkhoon", "desc": "غسالخانه"},
    {"fa": "شِرَق", "en": "sheragh", "desc": "صدای شکستن شاخه درخت"},
    {"fa": "شِرِند", "en": "sherend", "desc": "مغز گوسفند"},
    {"fa": "شُلار", "en": "sholar", "desc": "غیر متراکم، با فاصله (... علفا را شلار بریز تا خشک شود)"},
    {"fa": "شُمال", "en": "", "desc": "باد ملایم و فرحبخش (... هییی یه شمال اومد)"},
    {"fa": "شمال رو", "en": "", "desc": "هوای همراه با نسیم (... امروز هوا شمال روَه)"},
    {"fa": "شَنگ", "en": "shang", "desc": "هسته دانه انار"},
    {"fa": "شَخمو ن", "en": "shakhmoon", "desc": "فضولات پرندگان (... مرغا اینجا شخمون کردن)"},
    {"fa": "شُغوم", "en": "shoghoom", "desc": "نفوس بد زدن (... اینقدر شغوم بد نکن)"},
    {"fa": "شیوو", "en": "sheivoo", "desc": "محافظت از آتش در باد با جمع شدن دور اجاق"},
    {"fa": "شهید", "en": "", "desc": "تشنه"},
    {"fa": "شاشه", "en": "shasha", "desc": "حشرات ریز در برنج و حبوبات"},
    {"fa": "شاد", "en": "shad", "desc": "صاف، متضاد در هم و برهم (... این گندله نخا شاد کن)"},
    {"fa": "شَپَرو", "en": "shaparoo", "desc": "حشره و پروانه"},
    {"fa": "شُمُور کشیدن", "en": "shomoor", "desc": "تکان کوچک به خود دادن (... خوابیده بود، شمور نکشید)"},
    {"fa": "شاخ جنگی", "en": "", "desc": "درگیری دو گوسفند با زدن شاخ‌ها"},
    {"fa": "شیر خرگوش", "en": "", "desc": "از گیاهان صحرایی و خوردنی"},
    {"fa": "شیر دختر", "en": "", "desc": "از گیاهان صحرایی و خوردنی"},
    {"fa": "شُل شُلی", "en": "shol sholei", "desc": "نوعی نان با خمیر شل"},
    {"fa": "شیله", "en": "heila", "desc": "شیب‌های ملایم در کوه"},
    {"fa": "شغال مرگی", "en": "shoghal margei", "desc": "خود را به مریضی زدن (... خودشا به شغال مرگی زده)"},
    {"fa": "شغال برده", "en": "", "desc": "پرخاش به مرغ (... این شغال برده‌ها اینجا شخمون کردن)"},
    {"fa": "شُغله ذمه", "en": "", "desc": "مدیون"},
    {"fa": "شَپشَپه", "en": "", "desc": "آغشته (... پوزه‌اش شپشپه خون بود)"},
    {"fa": "شقز", "en": "", "desc": "پایین کمر"},
  ];
}