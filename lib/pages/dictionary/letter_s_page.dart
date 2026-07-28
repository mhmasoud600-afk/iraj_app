import 'package:flutter/material.dart';

class Word {
  final String word;
  final String latin;
  final String desc;

  Word({required this.word, required this.latin, required this.desc});

  factory Word.fromMap(Map<String, String> map) {
    return Word(
      word: map["word"] ?? "",
      latin: map["latin"] ?? "",
      desc: map["desc"] ?? "",
    );
  }
}

class LetterSPage extends StatefulWidget {
  const LetterSPage({Key? key}) : super(key: key);

  @override
  State<LetterSPage> createState() => _LetterSPageState();
}

class _LetterSPageState extends State<LetterSPage> {
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
    allWords.sort((a, b) => _compareWithoutDiacritics(a.word, b.word));
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim();
      if (searchQuery.isEmpty) {
        filteredWords = List.from(allWords);
      } else {
        filteredWords = allWords.where((word) {
          return _containsWithoutDiacritics(word.word, searchQuery) ||
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
        title: const Text("واژه‌های حرف س"),
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
    if (searchQuery.isNotEmpty && _containsWithoutDiacritics(item.word, searchQuery)) {
      final query = searchQuery;
      final wordText = item.word;
      final wordWithoutDiacritics = _removeDiacritics(wordText);
      final queryWithoutDiacritics = _removeDiacritics(query);
      
      // پیدا کردن موقعیت‌های جستجو در متن بدون اعراب
      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < wordWithoutDiacritics.length) {
        int index = wordWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
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
              text: wordText.substring(lastIndex, idx),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        }
        children.add(
          TextSpan(
            text: wordText.substring(idx, idx + query.length),
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
      if (lastIndex < wordText.length) {
        children.add(
          TextSpan(
            text: wordText.substring(lastIndex),
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
          text: item.word,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }

    // ===== لاتین داخل پرانتز با رنگ آبی =====
    if (item.latin.isNotEmpty) {
      children.add(
        TextSpan(
          text: " (${item.latin})",
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
      
      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < descWithoutDiacritics.length) {
        int index = descWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
        if (index == -1) break;
        indices.add(index);
        startIndex = index + queryWithoutDiacritics.length;
      }

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

  // ==================== داده‌های حرف س ====================
  final List<Map<String, String>> rawData = const [
    {"word": "سردل", "latin": "sardal", "desc": "نوعی ظرف سفالی بزرگ برای نگهداری آب و مواد غذایی"},
    {"word": "سَرگ", "latin": "sarg", "desc": "نوعی نخ ضخیم و محکم"},
    {"word": "سَرسَر", "latin": "sarsar", "desc": "سراسر؛ تماماً"},
    {"word": "سُست", "latin": "sost", "desc": "سست و ضعیف، در هم و برهم"},
    {"word": "سوسن", "latin": "soosan", "desc": "گل سوسن؛ گیاهی با گل‌های زیبا و عطری خوش"},
    {"word": "سالیانه", "latin": "salianeh", "desc": "یک ساله، حیوانی که یک سال از عمرش گذشته باشد"},
    {"word": "سُنبله", "latin": "sonbola", "desc": "شاخه درخت خرما با خوشه‌هایی از میوه‌های سبز"},
    {"word": "سَرچون", "latin": "sarchoon", "desc": "خم شدن سر به جلو؛ وضعیتی که سر به سمت پایین و جلو باشد"},
    {"word": "سَهما", "latin": "sahma", "desc": "سهم، قسمت، نصیب"},
    {"word": "سِرادون", "latin": "seradoon", "desc": "سرداب؛ فضای زیرزمینی خنک برای نگهداری مواد غذایی"},
    {"word": "سَرده", "latin": "sarda", "desc": "نوعی ظرف سفالی برای آب یا شیر"},
    {"word": "سَنجو", "latin": "sanjoo", "desc": "وسیله‌ای چوبی برای پهن کردن گل روی دیوار در بنایی قدیم"},
    {"word": "سَف", "latin": "saf", "desc": "ردیف، صف؛ در موقع نشستن یا ایستادن کنار هم"},
    {"word": "سِفاب", "latin": "sefab", "desc": "نوعی پارچه‌ی نخی ضخیم برای چادر یا پوشاک"},
    {"word": "سَگس", "latin": "sagas", "desc": "نوعی گیاه خودرو در بیابان‌های اطراف ایراج"},
    {"word": "سِروین", "latin": "servin", "desc": "کفش چرمی سنتی که زنان ایراجی می‌دوزند"},
    {"word": "سَپی", "latin": "sapi", "desc": "نوعی پارچه‌ی نخی نازک"},
    {"word": "سُتار", "latin": "sotar", "desc": "نوعی پرده یا پوشش ضخیم که جلوی آفتاب می‌گیرد"},
    {"word": "سُودوز", "latin": "sodoz", "desc": "نوعی غذای محلی با برنج و سبزی‌های دشتی"},
    {"word": "سیرو", "latin": "siro", "desc": "نوعی گیاه خودرو با برگ‌های پهن و خواص دارویی"},
    {"word": "سِمر", "latin": "semar", "desc": "میوه نارس درختان؛ به خصوص میوه‌های کوهی که بموقع نچیده‌اند"},
  ];
}