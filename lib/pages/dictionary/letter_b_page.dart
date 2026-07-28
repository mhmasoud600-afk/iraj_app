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

class LetterBPage extends StatefulWidget {
  const LetterBPage({Key? key}) : super(key: key);

  @override
  State<LetterBPage> createState() => _LetterBPageState();
}

class _LetterBPageState extends State<LetterBPage> {
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
        title: const Text("واژه‌های حرف ب"),
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
    {"fa": "باجون", "en": "bajoon", "desc": "پدر بزرگ"},
    {"fa": "باوو", "en": "baoo", "desc": "بازو (...بیخ باووشا بگیر وَرش کن)"},
    {"fa": "بُن گوش", "en": "bongoosh", "desc": "ورم زیر گوش (اُریون)"},
    {"fa": "بَلبَلی", "en": "balbali", "desc": "وقتی آتش سبز و خوب بسوزد"},
    {"fa": "بُن داس", "en": "bondas", "desc": "رسمی در ایراج هنگام درو گندم"},
    {"fa": "بوکَن – بوکند", "en": "bookan", "desc": "اتاقک موقت در دامنه کوه"},
    {"fa": "بَنه", "en": "bana", "desc": "میوه کوهی چرب و مقوی"},
    {"fa": "بد جوش", "en": "", "desc": "عصبانی مزاج"},
    {"fa": "بوره ای", "en": "booraie", "desc": "غذای کم برای حیوانات"},
    {"fa": "بَندال", "en": "bandal", "desc": "آویزان کسی شدن"},
    {"fa": "بَنوش", "en": "banoosh", "desc": "گل درخت بنه"},
    {"fa": "بِری", "en": "beri", "desc": "زمین بایر"},
    {"fa": "بوق سماور", "en": "", "desc": "لوله حلبی روی سماور آتشی"},
    {"fa": "بَشَره", "en": "", "desc": "ظاهر فرد"},
    {"fa": "بُه بُه", "en": "boh boh", "desc": "واژه‌ای هنگام ناراحتی"},
    {"fa": "بِرین کردن", "en": "berin", "desc": "ماشین کردن موی سر"},
    {"fa": "بَکّو", "en": "bakkoo", "desc": "مارمولک"},
    {"fa": "بار آخ", "en": "bare akh", "desc": "شکستنی"},
    {"fa": "بال بالو", "en": "bal baloo", "desc": "بهم خوردن چشم"},
    {"fa": "بالَنگو", "en": "balangoo", "desc": "گیاه دارویی"},
    {"fa": "بیخ بُنجه", "en": "bonja", "desc": "مواد غذایی برای مهمان"},
    {"fa": "بُناب", "en": "bonab", "desc": "نوبت آبیاری آخر شب"},
    {"fa": "بِتیرون", "en": "betiroon", "desc": "بخور غیر مودبانه"},
    {"fa": "بِز کردن", "en": "bez", "desc": "زده شدن از چیزی"},
    {"fa": "بَلّو", "en": "balloo", "desc": "قسمت نرم گوش"},
    {"fa": "بَلّرو", "en": "balloroo", "desc": "نام کوهی در اطراف ایراج"},
    {"fa": "بَجِه", "en": "baje", "desc": "راستی (... بجه، چرا شما نرفتید؟)"},
    {"fa": "بیدار خوابی", "en": "", "desc": "از ناراحتی یا بیماری خواب نرفتن"},
    {"fa": "بالینو", "en": "balinoo", "desc": "بالشت نانوایی"},
    {"fa": "باد گرفتن", "en": "", "desc": "درد گرفتن ناگهانی در بدن"},
    {"fa": "بالشت مار", "en": "", "desc": "نوعی سوسک بزرگ پهن"},
    {"fa": "بالین", "en": "balin", "desc": "متکا"},
    {"fa": "بغل", "en": "", "desc": "واحد اندازه‌گیری طناب و لیف"},
    {"fa": "بُرّ", "en": "borr", "desc": "گروه گروه شدن"},
    {"fa": "بَیلَه", "en": "baila", "desc": "گروه، عده"},
    {"fa": "بون", "en": "boon", "desc": "بام"},
    {"fa": "بشور بپوش", "en": "", "desc": "نوعی پارچه"},
    {"fa": "بِنزیل", "en": "benzil", "desc": "نوعی ظرف فلزی بزرگ"},
    {"fa": "باک", "en": "", "desc": "کسالت"},
    {"fa": "بَشن", "en": "bashn", "desc": "قسمت خارجی ظرف"},
    {"fa": "بُته", "en": "botta", "desc": "درخت"},
    {"fa": "بَرو", "en": "baroo", "desc": "سرشیر"},
    {"fa": "بَز", "en": "baz", "desc": "زمین زراعی کم‌پشت"},
    {"fa": "باد برف", "en": "", "desc": "بوران"},
    {"fa": "بگی یا نگی", "en": "", "desc": "به احتمال زیاد، حتماً"},
    {"fa": "بهترم میشی", "en": "", "desc": "اصطلاح هنگام آشکار شدن خطا"},
    {"fa": "باد پناه", "en": "", "desc": "محلی امن از باد"},
    {"fa": "بُروش", "en": "boroosh", "desc": "روشنایی کم در تاریکی"},
    {"fa": "بیخ دَرگو", "en": "dargoo", "desc": "محلی در بافت قدیمی ایراج"},
    {"fa": "باغ نیزار", "en": "", "desc": "باغی با چشمه"},
    {"fa": "باغ سیّدا", "en": "", "desc": "اردوگاه تفریحی"},
    {"fa": "بن سفیلو", "en": "bonsafiloo", "desc": "نام باغ و سه‌راهی"},
    {"fa": "باغ قاسما", "en": "", "desc": "محلی در دشت ایراج"},
    {"fa": "بی در بلا کردن", "en": "", "desc": "آرامش کسی را به هم زدن"},
    {"fa": "برگ و باش", "en": "", "desc": "برگ درختان"},
    {"fa": "بسم الله بسم الله", "en": "", "desc": "یواش یواش و با احتیاط"},
    {"fa": "بو بَرَنگ", "en": "", "desc": "بو"},
    {"fa": "بارزنگو", "en": "", "desc": "گیاه دارویی"},
    {"fa": "بزمو", "en": "", "desc": "زیرانداز از موی بز"},
    {"fa": "باریک می‌ریسی", "en": "", "desc": "حال نداری، بیماری"},
    {"fa": "برو اورا", "en": "", "desc": "برو آن طرف"},
    {"fa": "بیا ایرا", "en": "", "desc": "بیا این طرف"},
    {"fa": "بزار رو هم", "en": "", "desc": "به کسی که می‌خواهند ساکت شود می‌گویند"},
    {"fa": "باکش نیست", "en": "", "desc": "مشکلی ندارد"},
    {"fa": "بیو تا بشیم", "en": "", "desc": "بیا بریم"},
    {"fa": "بیم", "en": "", "desc": "بودی"},
  ];
}