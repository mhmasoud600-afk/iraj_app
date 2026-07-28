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

class LetterTPage extends StatefulWidget {
  const LetterTPage({Key? key}) : super(key: key);

  @override
  State<LetterTPage> createState() => _LetterTPageState();
}

class _LetterTPageState extends State<LetterTPage> {
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
        title: const Text("واژه‌های حرف ت"),
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
    {"fa": "تَنگَس", "en": "tangas", "desc": "نوعی درختچه خاردار با بادام‌های ریز تلخ"},
    {"fa": "تاسه", "en": "", "desc": "ویار"},
    {"fa": "تَبَرو", "en": "tabaroo", "desc": "بازی بچه‌ها در کنار آب؛ زدن سنگ‌های پهن روی آب"},
    {"fa": "تَفت باد", "en": "taft bad", "desc": "باد گرم و سوزان که گاه نفس کشیدن را مشکل می‌کند"},
    {"fa": "ته افتادن", "en": "tah", "desc": "پایین افتادن"},
    {"fa": "ته دادن", "en": "", "desc": "قورت دادن"},
    {"fa": "تیرقَس", "en": "", "desc": "حالت جهیدن"},
    {"fa": "تیغ بُرّا؟", "en": "tigh borra", "desc": "اصطلاحِ شکار: تیغت بریده یا نه"},
    {"fa": "تَنگ", "en": "tang", "desc": "طنابی برای محکم کردن پالان خر"},
    {"fa": "تَمَرّه", "en": "tamarra", "desc": "طعنه و کنایه"},
    {"fa": "تحلیر", "en": "tahlir", "desc": "تحلیل؛ هضم شدن غذا"},
    {"fa": "تُتُرّو", "en": "totorroo", "desc": "یا کریم"},
    {"fa": "تِلَنگ", "en": "telang", "desc": "بشکن زدن؛ یا بخشی از خوشه انگور"},
    {"fa": "تَنُک", "en": "tanok", "desc": "کم‌پشت"},
    {"fa": "تنگ و تُرُش", "en": "tang o torosh", "desc": "فضای کوچک؛ تنگنا"},
    {"fa": "تُلُمب", "en": "tolomb", "desc": "کیسه بزرگ پوستی برای زدن کره از ماست"},
    {"fa": "تَقَرس", "en": "taghars", "desc": "تگرگ"},
    {"fa": "تیره رفتن", "en": "tira", "desc": "سفت و چغر شدن و بذر دادن سبزیجات"},
    {"fa": "تُف تُف", "en": "tof tof", "desc": "کم‌کم، از روی بی‌میلی خوردن"},
    {"fa": "تِج", "en": "tej", "desc": "لعاب"},
    {"fa": "تَرزا", "en": "tarza", "desc": "زن تازه زایمان‌کرده"},
    {"fa": "تو تو تو تو ...", "en": "too too", "desc": "اصوات برای فراخواندن مرغ و ماکیان"},
    {"fa": "تَلّار", "en": "tallar", "desc": "آلاچیق"},
    {"fa": "تختِ گل", "en": "takhte gol", "desc": "پر از گل"},
    {"fa": "تال خوردن", "en": "tal", "desc": "غِل خوردن"},
    {"fa": "تَرف", "en": "tarf", "desc": "قره‌قروت"},
    {"fa": "تَکه", "en": "taka", "desc": "بز نر"},
    {"fa": "تُرک – تُرکو", "en": "tork", "desc": "غنچه گل"},
    {"fa": "تسمه شدن", "en": "tasma", "desc": "سفت و چغر شدن"},
    {"fa": "تیماج", "en": "timaj", "desc": "چرم"},
    {"fa": "تُوَه", "en": "tova", "desc": "ظرف فلزی پهن بزرگ برای پخت نان نازک"},
    {"fa": "تِریش", "en": "terish", "desc": "چوب ریش‌ریش شده"},
    {"fa": "تُرشو", "en": "torshoo", "desc": "نوعی سبزی صحرایی ترش‌مزه که از آن آش می‌پزند"},
    {"fa": "تُوبره", "en": "tobra", "desc": "کوله‌پشتی"},
    {"fa": "تونه", "en": "toona", "desc": "تارهای فرش"},
    {"fa": "تِکّه", "en": "tekke", "desc": "خوردنی که در کوچه تعارف کنند"},
    {"fa": "تِرخ", "en": "terkh", "desc": "درختچه خوشبو در بیابان‌های ایراج"},
    {"fa": "تارگ", "en": "targ", "desc": "موریانه"},
    {"fa": "تِلّه", "en": "tella", "desc": "تنه زدن؛ «دو تله»"},
    {"fa": "تاس", "en": "tas", "desc": "کاسه"},
    {"fa": "تِریق", "en": "terigh", "desc": "سفت؛ «تریق بگیر»"},
    {"fa": "تَپاله", "en": "tapala", "desc": "فضولات روی هم انباشته شده"},
    {"fa": "ته لَنگی", "en": "tah langi", "desc": "بار الاغ که یک طرف آن سنگین‌تر باشد"},
    {"fa": "تویی", "en": "tooei", "desc": "تیهو"},
    {"fa": "تَوَقّا", "en": "tavagha", "desc": "توقع"},
    {"fa": "تنوره", "en": "tanoora", "desc": "بنای استوانه‌ای برای ورود آب و چرخاندن آسیاب"},
    {"fa": "تیر مار", "en": "tir mar", "desc": "نوعی مار بلند و فرّار"},
    {"fa": "تَلَنبار", "en": "talanbar", "desc": "انباشته"},
    {"fa": "تَختَه گو", "en": "takhtagoo", "desc": "صنایع دستی آویزی از دانه‌های اسفند برای رفع چشم‌زخم"},
    {"fa": "تَمس زدن", "en": "tams", "desc": "ضربان زدن در قسمتی از بدن"},
    {"fa": "تو خندق", "en": "", "desc": "محلی در ایراج با چاهی معروف و پرآب"},
    {"fa": "تُرُسید", "en": "", "desc": "ترکید؛ پاره شد"},
    {"fa": "تُغوم", "en": "", "desc": "یک دسته گیاه یا مقداری میوه متراکم"},
    {"fa": "ترتر", "en": "", "desc": "ریختن آب از بلندی"},
    {"fa": "تِرِند", "en": "", "desc": "شاخه کوچک پُرمیو‌ه"},
    {"fa": "تاب در کن", "en": "", "desc": "نوعی پابند برای گوسفندان که به پا پیچیده نمی‌شود"},
    {"fa": "تودو", "en": "", "desc": "توت نارس"},
    {"fa": "تُوگا", "en": "tovga", "desc": "مدت و زمان مشخص"},
    {"fa": "تُغُلی", "en": "", "desc": "بره یک‌ساله"},
    {"fa": "توف و نوف", "en": "", "desc": "از هم پاشیدن و از بین رفتن"},
    {"fa": "تِلواش", "en": "", "desc": "پاره‌پاره شده؛ چوب تِریش‌تِریش شده"},
    {"fa": "تُرک تو چشمم افتاده", "en": "", "desc": "نوعی بیماری چشم"},
    {"fa": "تَک و تُل", "en": "", "desc": "وسایل خرده‌ریز"},
    {"fa": "تخته سینَک", "en": "", "desc": "بی‌تابی کردن همراه با بر سر و سینه زدن"},
    {"fa": "تُلمَه", "en": "", "desc": "مقداری مو"},
    {"fa": "تَلَپَس", "en": "", "desc": "یک هو زمین خوردن"},
    {"fa": "ته نیاوی", "en": "", "desc": "تو نمی آیی"},
    {"fa": "تو گوتن بهسیم", "en": "", "desc": "تو میخواهی بخوابی"},
    {"fa": "تمبوره", "en": "", "desc": "چاق؛ کسی که زیادی غذا می‌خورد و شکم بزرگ دارد"},
  ];
}