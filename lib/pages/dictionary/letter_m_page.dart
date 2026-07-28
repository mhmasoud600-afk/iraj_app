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

class LetterMPage extends StatefulWidget {
  const LetterMPage({Key? key}) : super(key: key);

  @override
  State<LetterMPage> createState() => _LetterMPageState();
}

class _LetterMPageState extends State<LetterMPage> {
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
        title: const Text("واژه‌های حرف م"),
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
    {"fa": "مادرت بچه کور میاره", "en": "", "desc": "وقتی کسی خوراکی که خودش تهیه کرده برای دیگران می‌آورد نباید خود از آن بخورد"},
    {"fa": "مافَنگی", "en": "mafangei", "desc": "خراب (... چراغمونم مافنگیه)"},
    {"fa": "مَندیل", "en": "mandeil", "desc": "دستار، عمامه"},
    {"fa": "مَغموم", "en": "", "desc": "بی‌بهره، متضرر"},
    {"fa": "مردخونه", "en": "mard khoona", "desc": "بوکنی کنار بوکن گوسفندان؛ محل خواب چوپان"},
    {"fa": "موجو", "en": "moojoo", "desc": "بادام کوهی"},
    {"fa": "مرغک", "en": "", "desc": "آخوندک؛ اگر مرغ این حشره را بخورد مسموم می‌شود"},
    {"fa": "مَمُو", "en": "mamov", "desc": "خطاب به مادر"},
    {"fa": "مَمَن", "en": "maman", "desc": "مادر"},
    {"fa": "مَنداب", "en": "", "desc": "گیاهی روغنی برای چراغ‌های قدیم"},
    {"fa": "مُلتفت", "en": "", "desc": "متوجه (... ملتفتی چی میگم؟)"},
    {"fa": "مُحیل باز", "en": "mohbaz", "desc": "حیله‌گر"},
    {"fa": "مُرافه", "en": "", "desc": "بگو مگو (مرافعه)"},
    {"fa": "مُدبَق", "en": "modbagh", "desc": "مطبخ"},
    {"fa": "مَناگی", "en": "managei", "desc": "به زبان آوردن مشکلات با حالت تمسخر (... بی مناگی!)"},
    {"fa": "موسه", "en": "moosa", "desc": "به رخ کشیدن داشته‌ها (... موسه اش بدیم)"},
    {"fa": "موندگی", "en": "mondagei", "desc": "خستگی (... بیا بشین موندگی بنداز)"},
    {"fa": "ماسوره شُش", "en": "masoora", "desc": "نای"},
    {"fa": "مُتَنگ", "en": "motang", "desc": "نوعی کلنگ"},
    {"fa": "موش عروسو", "en": "", "desc": "سنجاب"},
    {"fa": "مُلَنگ", "en": "molang", "desc": "ایستادن و بر و بر نگاه کردن (... مُلَنگ واساده)"},
    {"fa": "مزار گبرا", "en": "", "desc": "محل قدیمی قبرستان گبرها در ایراج"},
    {"fa": "مَسکه", "en": "maska", "desc": "کره حیوانی"},
    {"fa": "مرگی", "en": "", "desc": "وقتی چند نفر در مدت کمی بمیرند؛ می‌گویند مرگی افتاده"},
    {"fa": "مُگِشک", "en": "mogeshk", "desc": "سبزی دشتی خودرو برای آش"},
    {"fa": "مُرده بَنگ", "en": "morda bang", "desc": "رتیل، عنکبوت زهرآگین"},
    {"fa": "مَگین", "en": "magein", "desc": "محلی در دشت ایراج"},
    {"fa": "مَردُکو", "en": "mardokoo", "desc": "مَرده (... یه مردکو داره میاد)"},
    {"fa": "مَندَمول", "en": "mandamool", "desc": "ناخوش‌احوال (... این بچه امروز مندموله)"},
    {"fa": "میون خونه", "en": "meioon", "desc": "حیاط"},
    {"fa": "مَیدون", "en": "maeidoon", "desc": "حسینیه ایراج (... دو ماه محرم هر شب میریم مَیدون)"},
    {"fa": "مَلور", "en": "maloor", "desc": "ولرم (... آب ملور شد برو بشور)"},
    {"fa": "مَتکی", "en": "matkei", "desc": "شیرین‌بیان"},
    {"fa": "میون پی", "en": "meioon pay", "desc": "فضای گود میان دو طاق ضربی پشت‌بام"},
    {"fa": "مَلار", "en": "malar", "desc": "بافت اولیه طناب از الیاف خرما"},
    {"fa": "مَشام", "en": "masham", "desc": "حس بویایی"},
    {"fa": "مَنگال", "en": "mangal", "desc": "نوعی داس"},
    {"fa": "مُچّه", "en": "", "desc": "مزه (... مُچه شا بکش)"},
    {"fa": "مومنایی", "en": "moomenaei", "desc": "مومیایی؛ ماده چسبناک قهوه‌ای در سقف غارها برای درد استخوان"},
    {"fa": "مَشیم", "en": "masheim", "desc": "قسمتی از فتیله چراغ فانوس"},
    {"fa": "مُخُل", "en": "mokhol", "desc": "مُخِل، دردسرساز (... ای داد هی، مُخُله)"},
    {"fa": "مَجمَع", "en": "majmaa", "desc": "سینی مسی بزرگ"},
    {"fa": "ملّا شدن", "en": "molla", "desc": "با سواد شدن (... ملّا شدن چه آسون، آدم شدن چه مشکل)"},
    {"fa": "مُظَنَه", "en": "mozana", "desc": "به گمانم"},
    {"fa": "مُجُلو", "en": "", "desc": "غوزک پا، زنگوی پا"},
    {"fa": "مَستوره", "en": "", "desc": "نمونه جنس"},
    {"fa": "میوه مهار", "en": "", "desc": "میوه"},
    {"fa": "مُد فُری", "en": "", "desc": "منزجر و عاجز"},
    {"fa": "مِجری", "en": "", "desc": "صندوقچه اسناد و مدارک"},
    {"fa": "مازه کمر", "en": "", "desc": "راسته"},
    {"fa": "مَرو", "en": "", "desc": "مشکی که سوراخه با نخ سوراخش را بند میارن"},
    {"fa": "معوری", "en": "mavari", "desc": "کج و کوله، به پهلو و نامتعادل؛ شبیه حرکت موریانه. می‌گویند «کج و معوری راه می‌ره» یعنی کج و کوله و نامتعادل راه می‌رود"},
    {"fa": "متفری", "en": "motafari", "desc": "کلافه‌گی، بهم ریختگی اعصاب؛ حالت ناراحتی و بی‌قراری ناشی از فشار روحی یا عصبی"},
  ];
}