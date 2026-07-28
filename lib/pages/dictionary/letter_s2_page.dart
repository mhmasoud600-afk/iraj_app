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

class LetterS2Page extends StatefulWidget {
  const LetterS2Page({Key? key}) : super(key: key);

  @override
  State<LetterS2Page> createState() => _LetterS2PageState();
}

class _LetterS2PageState extends State<LetterS2Page> {
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
    {"fa": "سولاخ", "en": "", "desc": "سوراخ"},
    {"fa": "سِریت", "en": "serit", "desc": "چوب‌های باریک درخت بادام کوهی"},
    {"fa": "سارگ", "en": "sarg", "desc": "سار"},
    {"fa": "سُسِّه", "en": "sossa", "desc": "جگر سفید"},
    {"fa": "سینه بوکندا", "en": "bookanda", "desc": "بیابان جنوب ایراج"},
    {"fa": "سیب دو آله کرده", "en": "", "desc": "کنایه از دو چیز مثل هم (...این دو تا برادر عین همن، مث سیب دو آله کرده)"},
    {"fa": "سنگ چینو", "en": "sangh cheinoo", "desc": "بازی یک قل دو قل"},
    {"fa": "سَق", "en": "sagh", "desc": "کام"},
    {"fa": "سَرَشیوه", "en": "", "desc": "سراشیبی"},
    {"fa": "سَرَبالا", "en": "", "desc": "سربالایی"},
    {"fa": "سیا چوله", "en": "sia choola", "desc": "سیاه سوخته"},
    {"fa": "سَلخ", "en": "salkh", "desc": "استخر (... برو سلخا سر بده)"},
    {"fa": "سنجد شیرینو", "en": "", "desc": "جایی در دشت ایراج"},
    {"fa": "سونَند", "en": "soonand", "desc": "سرعت (... این موتوریا به یه سونندی رد می‌شن)"},
    {"fa": "سَر پُلّو", "en": "sare polloo", "desc": "محلی در ایراج"},
    {"fa": "ساهار", "en": "sahar", "desc": "بوی زُخم (... ساهار ماهی)"},
    {"fa": "سو", "en": "soo", "desc": "قنات"},
    {"fa": "سینقُر", "en": "seinghor", "desc": "نوعی جوجه تیغی"},
    {"fa": "سنده", "en": "sonda", "desc": "مدفوع"},
    {"fa": "سیم کردن", "en": "seim", "desc": "چرکی شدن زخم بر اثر عدم مراقبت"},
    {"fa": "سگ مار", "en": "", "desc": "سوسمار بزرگ خطرناک"},
    {"fa": "سُفال", "en": "sofal", "desc": "ساقه گندم"},
    {"fa": "سیله", "en": "seila", "desc": "لوبیا و باقالی نارس"},
    {"fa": "سِندون", "en": "sendoon", "desc": "سندان – کنایه از چیز سنگین"},
    {"fa": "سُندُلی", "en": "sondolei", "desc": "نوع نشستن گربه و سگ (... گربه رو دیوار سندلی کرده)"},
    {"fa": "سیره", "en": "seira", "desc": "حالتی بین خشک و تر، نمدار"},
    {"fa": "سَختون", "en": "sakhtoon", "desc": "صخره"},
    {"fa": "سیا دمب", "en": "seia domb", "desc": "حیوانی از تیره سوسمارها با دم سیاه"},
    {"fa": "سَبَد", "en": "sabad", "desc": "نوعی علف در صحرا"},
    {"fa": "ساباط", "en": "sabat", "desc": "قسمتی از کوچه سرپوشیده با هوای خنک، محل تجمع همسایگان"},
    {"fa": "سر راهی", "en": "", "desc": "پولی که در بدرقه مسافران برای خرید سوغات می‌دادند"},
    {"fa": "سر خاراندن", "en": "", "desc": "در کاری درنگ کردن (... سر نخارون بیا)"},
    {"fa": "سَنگاب", "en": "sangab", "desc": "چاله‌های سنگی در کوه که آب باران جمع می‌شود"},
    {"fa": "سردرگاه", "en": "sardargah", "desc": "قسمت بالای ورودی در"},
    {"fa": "سَقَط شده", "en": "saghat", "desc": "عبارت پرخاش به الاغ (... سقط شده همه سردرختیا را خورده)"},
    {"fa": "سَرجُل", "en": "sarjol", "desc": "پوششی بر روی پالان الاغ"},
    {"fa": "سر بیل", "en": "", "desc": "کندن زمین سطحی با سر بیل"},
    {"fa": "سکَندَری", "en": "sekandarei", "desc": "تنه زدن، تنه خوردن"},
    {"fa": "سنگ و سُقاط", "en": "soghat", "desc": "سنگ و ناهمواری"},
    {"fa": "سُلّیدن", "en": "sollidan", "desc": "از هم پاشیدن و پخش شدن (... بار هیمه سُلّید)"},
    {"fa": "سر دست", "en": "sar dast", "desc": "راه رفتن الاغ در حال افتادن (... خرمون امروز هی سردست میره)"},
    {"fa": "سُک", "en": "sok", "desc": "سقلمه"},
    {"fa": "سر دَنگ / سر کَیف", "en": "sar e dang", "desc": "سر حال، هنگام احوالپرسی"},
    {"fa": "سیل کردن", "en": "", "desc": "تماشا کردن"},
    {"fa": "سُکال", "en": "sokal", "desc": "زخمی که روی آن خشک شده باشد"},
    {"fa": "سِفنه", "en": "", "desc": "توده چرک و کثیفی روی بدن (... پاهاش سفنه بسته)"},
    {"fa": "سَمسُرت", "en": "", "desc": "شاخه درخت بین خشک و تر"},
    {"fa": "سَنیفه", "en": "", "desc": "نوعی کرباس راه‌راه برای عبا"},
    {"fa": "سَخلُوی", "en": "", "desc": "سختی"},
    {"fa": "سرگاش", "en": "", "desc": "کود اولیه زمین زراعی"},
    {"fa": "سر سیخ کردن", "en": "", "desc": "به هوس انداختن (... بچه را سر سیخش کردی)"},
    {"fa": " سرا", "en": "", "desc": "خونه"},
    {"fa": "سرمشک", "en": "", "desc": "مشک کوچه"},
  ];
}