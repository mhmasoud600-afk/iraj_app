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

class LetterYPage extends StatefulWidget {
  const LetterYPage({Key? key}) : super(key: key);

  @override
  State<LetterYPage> createState() => _LetterYPageState();
}

class _LetterYPageState extends State<LetterYPage> {
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
        title: const Text("واژه‌های حرف ی"),
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
    {"fa": "یَمان زده", "en": "yaman", "desc": "نوعی مریضی الاغ؛ پرخاش به الاغ (... یَمان زده باز بارشا انداخت، این کَرَت دوّمه)"},
    {"fa": "یه جیغ راه", "en": "", "desc": "واحد اندازه‌گیری مسافت؛ مسافتی که صدای بلند از آنجا شنیده شود (... یه جیغ راه مونده بود به ما برسه)"},
    {"fa": "یاغوندن", "en": "yaghondan", "desc": "آغشته کردن"},
    {"fa": "یه لنگه لیف", "en": "", "desc": "واحد اندازه‌گیری ارتفاع (... این چاه یه لنگه لیف ته داره)"},
    {"fa": "یه فنجون وقت", "en": "", "desc": "چند دقیقه؛ واحد اندازه‌گیری زمان (مراجعه شود به فنجون دوونو)"},
    {"fa": "یه احوالی ازت می‌گیرم", "en": "", "desc": "به حسابت می‌رسم (... اگر دستم بهت برسه یه احوالی ازت می‌گیرم)"},
    {"fa": "یه حول ولا", "en": "", "desc": "یکدفعه (... به یه حول و لا مریض شد)"},
    {"fa": "یه پاره ها", "en": "", "desc": "برخی افراد، عده‌ای از مردم (... یه پاره‌ها گفتن، یه پاره‌ها هم گفتن نه)"},
  ];
}