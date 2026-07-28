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

class LetterKhPage extends StatefulWidget {
  const LetterKhPage({Key? key}) : super(key: key);

  @override
  State<LetterKhPage> createState() => _LetterKhPageState();
}

class _LetterKhPageState extends State<LetterKhPage> {
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
        title: const Text("واژه‌های حرف خ"),
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
    {"fa": "خالو کُش", "en": "khaloo kosh", "desc": "طحال گوسفند (باور قدیمی: اگر کسی آن را بخورد دایی‌اش می‌میرد)"},
    {"fa": "خلا", "en": "khala", "desc": "دستشویی"},
    {"fa": "خِفَّت", "en": "kheffat", "desc": "خجالت (مایه خفّت)"},
    {"fa": "خَمخَمو", "en": "", "desc": "کمر خم راه رفتن"},
    {"fa": "خُلقم تنگ می‌شه", "en": "", "desc": "نفسم می‌گیره (... هر وقت جوراب پام می‌کنم خلقم تنگ میشه)"},
    {"fa": "خالو", "en": "khaloo", "desc": "دایی"},
    {"fa": "خَرَند", "en": "kharand", "desc": "فضای پای دیوار باغ که چوب‌های اضافه را آنجا می‌ریزند"},
    {"fa": "خِفت", "en": "kheft", "desc": "گره فرش"},
    {"fa": "خزان", "en": "", "desc": "برگ‌های خشک در پاییز که کف باغ را می‌پوشاند"},
    {"fa": "خُشکال", "en": "khoshkal", "desc": "علف‌های انبوه خشک‌شده در بیابان"},
    {"fa": "خر شَل معطل چَش", "en": "", "desc": "ضرب‌المثل برای بهانه‌جو بودن"},
    {"fa": "خَف", "en": "khaf", "desc": "پنهان (خَف نشستن = پنهان شدن)"},
    {"fa": "خُوف", "en": "khovf", "desc": "داربست"},
    {"fa": "خَرِف", "en": "", "desc": "خرفت"},
    {"fa": "خرفو", "en": "", "desc": "بخشی از مغز"},
    {"fa": "خاکالم", "en": "khakalam", "desc": "کوتاه‌شدهٔ «خاک عالم بر سرم» در مقام تأسف"},
    {"fa": "خَلاشه", "en": "khalasha", "desc": "ریزه آشغال (... خلاشه تو چشمم افتاده)"},
    {"fa": "خبر کَشو", "en": "khabar kashoo", "desc": "قاصدک"},
    {"fa": "خاک وَرز", "en": "", "desc": "گودال کوچک انتهای زمین زراعی برای انباشتن کود حیوانی"},
    {"fa": "خَلِشکَن", "en": "khaleshkan", "desc": "نوعی خرما"},
    {"fa": "خَرَک", "en": "kharak", "desc": "نوعی خرما (خارک)"},
    {"fa": "خون طَما", "en": "khoontama", "desc": "حریص"},
    {"fa": "خَسیل جو", "en": "khasil jov", "desc": "جو خوشه کرده"},
    {"fa": "خَچ", "en": "khach", "desc": "گوسفندی که صورتش دارای خطوط باشد"},
    {"fa": "خُل", "en": "khol", "desc": "خاکستر"},
    {"fa": "خود نماگر", "en": "", "desc": "تظاهرکننده؛ کسی که برای خودنمایی کاری انجام دهد"},
    {"fa": "خرتا خیلی دراز بستی", "en": "", "desc": "پایت را از گلیمت درازتر کردی"},
    {"fa": "خُرنَس", "en": "", "desc": "خُرخُر بلند و ناگهانی در خواب"},
    {"fa": "خر تب می‌کند", "en": "", "desc": "کنایه از گرمای زیاد هوا"},
    {"fa": "خر یه جله", "en": "", "desc": "به شخصی می‌گویند که فقط یک لباس دارد و همیشه آن را می‌پوشد"},
  ];
}