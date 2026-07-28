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

class LetterHePage extends StatefulWidget {
  const LetterHePage({Key? key}) : super(key: key);

  @override
  State<LetterHePage> createState() => _LetterHePageState();
}

class _LetterHePageState extends State<LetterHePage> {
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
        title: const Text("واژه‌های حرف هـ"),
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
    {"fa": "هَووکَلی", "en": "havookalei", "desc": "گیج (... به یدفه از خواب پرید هووکلی شد)"},
    {"fa": "هُلُم هُلُم – هُلُمباش", "en": "holom", "desc": "پایین و بالا رفتن چیزی (آب در ظرف یا شاخه درخت)"},
    {"fa": "هم عروس", "en": "", "desc": "جاری"},
    {"fa": "هم دوماد", "en": "", "desc": "باجناق"},
    {"fa": "هُوّ", "en": "hov", "desc": "حرارت"},
    {"fa": "هوست کنه", "en": "", "desc": "دلت بخواد"},
    {"fa": "هُلُک هُلُک", "en": "holok", "desc": "تکان دادن پا"},
    {"fa": "هوچ", "en": "hooch", "desc": "تاب"},
    {"fa": "هُفُنه", "en": "hofona", "desc": "پف کرده"},
    {"fa": "هیمَه", "en": "heima", "desc": "هیزم"},
    {"fa": "هَوَک", "en": "havak", "desc": "نوعی گره که راحت باز شود"},
    {"fa": "هلاک", "en": "", "desc": "خسته"},
    {"fa": "هُرم", "en": "horm", "desc": "گرما"},
    {"fa": "همکشو", "en": "ham kaskoo", "desc": "جمع شدن قسمتی از پارچه بر اثر کشیده شدن نخ آن"},
    {"fa": "هُرموت", "en": "hormoot", "desc": "نوعی گلابی"},
    {"fa": "هوجِه کردن", "en": "hooja", "desc": "خود را به مریضی زدن"},
    {"fa": "هاشی", "en": "hashei", "desc": "بچه شتر"},
    {"fa": "هَچَّّه", "en": "hachche", "desc": "نهیب به الاغ برای تند رفتن (... ههههن هَچّه)"},
    {"fa": "هُسّا", "en": "hossa", "desc": "استاد (... هسّا میرزا و هسّا مشدیا آمرزشون میدن)"},
    {"fa": "هَنجین", "en": "hanjein", "desc": "وسیله‌ای با دسته بلند و چند شاخه برای جمع کردن کاه"},
    {"fa": "هَلندر", "en": "halandar", "desc": "گیاهی تلخ در بیابان شبیه علف انغوزه"},
    {"fa": "هَنگ", "en": "hang", "desc": "علف انغوزه بسیار تند و دارویی"},
    {"fa": "هندونه ابوجهل", "en": "", "desc": "حنظل – هندوانه کوچک خودرو و بسیار تلخ با خاصیت دارویی"},
    {"fa": "هَمگرد", "en": "ham gard", "desc": "توان حرکت سریع برای انجام کار (... همگرد نداره)"},
    {"fa": "هَمپا", "en": "", "desc": "همراه"},
    {"fa": "هوا را تو هم کشیده", "en": "", "desc": "ابرها سیاه و متراکم شده‌اند؛ خبر از بارش باران"},
    {"fa": "هَمبونه", "en": "", "desc": "توبره"},
    {"fa": "هَر", "en": "har", "desc": "تفاله خرما پس از تهیه شیره"},
    {"fa": "هَدَر", "en": "hadar", "desc": "جای مرتفع (... لب هدر وا نِسا)"},
    {"fa": "هُسّو", "en": "hossoo", "desc": "بختک (... دیشب هُسّو روم خوابید)"},
    {"fa": "هُو به دلم زد", "en": "hov", "desc": "وجودم داغ شد"},
    {"fa": "هُرِه", "en": "hore", "desc": "اصوات برای راندن گوسفند (... هره حیوون)"},
    {"fa": "هَنگو", "en": "hangoo", "desc": "حشرات ریز در پرهای مرغ که باعث بیماری می‌شوند"},
    {"fa": "هَناسَه – هناسه ریزون", "en": "hanasa", "desc": "هِن هِن کنان و با عجله (... هناسه ریزون اومد)"},
    {"fa": "هَشت", "en": "", "desc": "محاصره"},
    {"fa": "هَرَج", "en": "", "desc": "اعتبار (... هرجی بهش نیست)"},
    {"fa": "هوایی اش رسید", "en": "", "desc": "غش کرد"},
    {"fa": "هُری هُری", "en": "", "desc": "عبارت برای فراخواندن بز"},
    {"fa": "هُناخت", "en": "", "desc": "حدود و میزان"},
    {"fa": "هست و حروم کردن", "en": "", "desc": "اسراف کردن"},
    {"fa": "هَفنَه", "en": "", "desc": "لقمه بزرگ برداشتن میگن به دو هفنه خورد"},
  ];
}