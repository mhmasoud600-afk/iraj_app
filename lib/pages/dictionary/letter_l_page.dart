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

class LetterLPage extends StatefulWidget {
  const LetterLPage({Key? key}) : super(key: key);

  @override
  State<LetterLPage> createState() => _LetterLPageState();
}

class _LetterLPageState extends State<LetterLPage> {
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
        title: const Text("واژه‌های حرف ل"),
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
    {"fa": "لیسک", "en": "leisk", "desc": "چوب صاف و بلند"},
    {"fa": "لُمبَر", "en": "lombar", "desc": "باسن"},
    {"fa": "لوش", "en": "loosh", "desc": "لجن"},
    {"fa": "لا ابر", "en": "la abr", "desc": "ابرهای نازک که بعضی قسمت‌های آسمان را پوشانده باشد"},
    {"fa": "لَخت", "en": "lakht", "desc": "سنگ پهن نازک"},
    {"fa": "لَخَر", "en": "", "desc": "زمینی که به صورت تخته سنگ پهن باشد"},
    {"fa": "لَلَه", "en": "lala", "desc": "پرستار بچه"},
    {"fa": "لَقّاطه", "en": "laghata", "desc": "قراضه، فرسوده"},
    {"fa": "لِشواره", "en": "leshvara", "desc": "پاره پاره"},
    {"fa": "لنگ به لنگ", "en": "", "desc": "تا به تا (کفش لنگ به لنگ)"},
    {"fa": "لَقلا", "en": "laghla", "desc": "یقلوی – ظرفی شبیه ماهی‌تابه"},
    {"fa": "لُغُنچه", "en": "loghoncha", "desc": "تکه‌ای از چیزی (... افتادم سر زانوَم لغنچه کن شد)"},
    {"fa": "لُغوم", "en": "loghoom", "desc": "سیم کوتاه با نخ برای جلوگیری از شیر خوردن بزغاله"},
    {"fa": "لیف", "en": "", "desc": "طناب"},
    {"fa": "لَمپا", "en": "", "desc": "نوعی چراغ روشنایی"},
    {"fa": "لیب", "en": "leib", "desc": "نوعی علف صحرایی"},
    {"fa": "لُغُز", "en": "loghoz", "desc": "حرف کنایه‌دار (... چار تا لُغُز بارش کن)"},
    {"fa": "لَمبُو", "en": "lambov", "desc": "ریختن آهسته آب از ظرف لبریز (... هی لمبو میخوره)"},
    {"fa": "لوک", "en": "look", "desc": "شتر نر"},
    {"fa": "لَکنه", "en": "", "desc": "لق‌لق (... نردبونا محکم بگیر لکنه نخوره)"},
    {"fa": "لَشت", "en": "lasht", "desc": "گودی‌های کوچک در سنگ کوه‌ها که آب باران در آن جمع می‌شود"},
    {"fa": "لَردَکی", "en": "lardakei", "desc": "جایی که زیاد باد بوزد و خنک باشد"},
    {"fa": "لُک", "en": "lok", "desc": "برآمدگی کوچک روی بدن بر اثر آسیب (... پام لُک شد)"},
    {"fa": "لَک", "en": "kak", "desc": "فک"},
    {"fa": "لَپَر", "en": "lapar", "desc": "لپه حبوبات (باقلا لپر)"},
    {"fa": "لَواسه", "en": "lavasa", "desc": "توده گل بزرگ همراه ریشه گیاهان هنگام شخم (... یه لواسه وردار بذار دم وار)"},
    {"fa": "لَس", "en": "las", "desc": "شل و وارفته"},
    {"fa": "لَپَتو", "en": "lapatoo", "desc": "نوعی پرنده کوچک"},
    {"fa": "لِچ", "en": "lech", "desc": "خیس خیس (... لِچ عرق شدم)"},
    {"fa": "لَت", "en": "lat", "desc": "نصفه حبوبات"},
    {"fa": "لُنج", "en": "lonj", "desc": "لب"},
    {"fa": "لُهُرد", "en": "lohord", "desc": "سنگ بزرگ"},
    {"fa": "لُنج تاباندن", "en": "lonj", "desc": "حرکت لب به نشانه کم‌محلی و تمسخر (... لُنج میتابونه)"},
    {"fa": "لب دُر", "en": "", "desc": "لب شتری"},
    {"fa": "لِم", "en": "", "desc": "قِلِق"},
    {"fa": "لُغُنچه", "en": "", "desc": "قسمتی از چیزی (... شلوارم لغنچه کن شد)"},
    {"fa": "له و لَوَرده", "en": "", "desc": "له"},
    {"fa": "لباستا برت کن", "en": "", "desc": "لباس پوشیدن"},
    {"fa": "لور کرده", "en": "", "desc": "لباسش را شل کرده"},
    {"fa": "لنجو کرده", "en": "", "desc": "دلش پر شده"},
  ];
}