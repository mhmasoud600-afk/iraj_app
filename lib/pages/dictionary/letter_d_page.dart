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

class LetterDPage extends StatefulWidget {
  const LetterDPage({Key? key}) : super(key: key);

  @override
  State<LetterDPage> createState() => _LetterDPageState();
}

class _LetterDPageState extends State<LetterDPage> {
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
        title: const Text("واژه‌های حرف د"),
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
    {"fa": "دو دُمبو", "en": "dodomboo", "desc": "نوعی از بند پایان کوچکتر از عقرب"},
    {"fa": "دِرّو", "en": "derroo", "desc": "نوعی درختچه در بیابان‌های ایراج"},
    {"fa": "دُلمُلی", "en": "dolmoli", "desc": "ماست بریده بریده"},
    {"fa": "دَخلِ دو مُشتک", "en": "dakhle do moshtak", "desc": "بازی بچه‌ها با پنهان کردن سنگ در دامن یکی و حدس دیگران"},
    {"fa": "دم الّا بلّا بود", "en": "dame ella bella", "desc": "نزدیک بود (... دم الا بلا بود بیفتم تو جوب)"},
    {"fa": "دَدَه", "en": "dada", "desc": "خواهر"},
    {"fa": "دادو", "en": "dadoo", "desc": "برادر"},
    {"fa": "دالون", "en": "daloon", "desc": "دالان، راهرو"},
    {"fa": "درجَن", "en": "darjan", "desc": "بسته محتوی چند جعبه کبریت"},
    {"fa": "دُکارت", "en": "dokart", "desc": "قیچی برای چیدن پشم گوسفند"},
    {"fa": "دوکونه پراندن", "en": "", "desc": "نوعی راه رفتن الاغ که عقب بدن را ناگهان بالا می‌اندازد"},
    {"fa": "دُنگُرو", "en": "dongoroo", "desc": "قسمت کوچک آویزان به شیء بزرگ‌تر"},
    {"fa": "درنگ", "en": "derang", "desc": "لحظه (... یه درنگ صبر کن)"},
    {"fa": "درنگ بـرنگ", "en": "derang berang", "desc": "سر و صدای فلزات"},
    {"fa": "دار", "en": "dar", "desc": "چوب بلند، بیشتر به عنوان ستون"},
    {"fa": "دوغی", "en": "dooghei", "desc": "خوراک بسیار لذیذ از کره حیوانی و آرد پخته"},
    {"fa": "دَبیل", "en": "dabil", "desc": "تنه درخت خرما"},
    {"fa": "دو گرفتن", "en": "dov", "desc": "کسی را جزو گروه خود گرفتن"},
    {"fa": "...دست و پا به هم مالیدن", "en": "", "desc": "معطل کردن"},
    {"fa": "...دست پشت سر نداری؟", "en": "", "desc": "وقتی کسی در را نمی‌بندد (در را چارتا وا انداختی؟)"},
    {"fa": "... دِلَم کَنده شد", "en": "", "desc": "کنایه از اینکه ترسیدم"},
    {"fa": "دلجوشی", "en": "deljooshi", "desc": "خشم و عصبانیت"},
    {"fa": "دونو", "en": "doonoo", "desc": "گندم بوداده با دانه‌ها؛ خوراک شادی هنگام تولد"},
    {"fa": "دست به آب", "en": "", "desc": "دستشویی"},
    {"fa": "دشته بون", "en": "", "desc": "دشتبان؛ نگهبان دشت"},
    {"fa": "دُمبا", "en": "domba", "desc": "گندم نارس همراه خوشه که پخته یا بوداده شود"},
    {"fa": "دندونو", "en": "dandoonoo", "desc": "آش هنگام دندان درآوردن بچه (آش دندانی)"},
    {"fa": "دربچه", "en": "darbacha", "desc": "پنجره"},
    {"fa": "دست مَرزا", "en": "dast marza", "desc": "خدا قوت"},
    {"fa": "دَم بریدن", "en": "dam", "desc": "نشخوار کردن"},
    {"fa": "دُراق", "en": "doragh", "desc": "زنگوله بزرگ"},
    {"fa": "دستپاچه", "en": "", "desc": "عجول"},
    {"fa": "دست پا گنجشکو", "en": "", "desc": "نوعی علف ریز"},
    {"fa": "دُشکی", "en": "doshkei", "desc": "وسیله کوچک نخ‌ریسی قدیم؛ خربزه کوچک نارس به آن تشبیه می‌شود"},
    {"fa": "دَلِّه", "en": "dalla", "desc": "ظرف بزرگ فلزی، عموماً برای نفت"},
    {"fa": "دَلِه", "en": "dala", "desc": "شکم‌چران"},
    {"fa": "دُوری", "en": "dovri", "desc": "پیشدستی"},
    {"fa": "دسته بیل", "en": "", "desc": "واحد مسافت کوتاه (... یه دسته بیل مونده آب برسه سر زمین)"},
    {"fa": "دُرُوش", "en": "dorovsh", "desc": "درفش"},
    {"fa": "دَفتون", "en": "daftoon", "desc": "شانه قالیبافی"},
    {"fa": "دُروش", "en": "doroosh", "desc": "علامت‌گذاری گوش گوسفند با بریدن برای تمایز گله"},
    {"fa": "دِس", "en": "dess", "desc": "اصوات خطاب به الاغ برای برداشتن پا (... دسسسسس)"},
    {"fa": "دوره – دوره زن", "en": "dovra", "desc": "آیین دعوت عروسی توسط دو مرد و دو زن از دو خانواده"},
    {"fa": "دوماد شیطون", "en": "", "desc": "نوعی پروانه سیاه که شب‌ها کنار چراغ‌ها جمع می‌شود"},
    {"fa": "داغی", "en": "daghei", "desc": "گیاه زیبا در دشت ایراج؛ دست را تاول می‌زند"},
    {"fa": "دولِنده", "en": "doolenda", "desc": "ظرف کوچک حصیریِ در دار برای مواد خوراکی"},
    {"fa": "داسَه", "en": "dasa", "desc": "نوعی علف مزاحم در گندمزار"},
    {"fa": "دَمبُلاب", "en": "dambolab", "desc": "پر از آب"},
    {"fa": "دیس", "en": "deis", "desc": "کاه‌ریز چسبیده به دانه گندم؛ خطرناک برای گلوی بچه"},
    {"fa": "دیفال", "en": "", "desc": "دیوار"},
    {"fa": "دوبُر", "en": "do bor", "desc": "تکه دوساله"},
    {"fa": "دولَق", "en": "doolagh", "desc": "گرد و غبار"},
    {"fa": "دونه", "en": "doona", "desc": "زخم چرکی"},
    {"fa": "دَووله", "en": "davoola", "desc": "مترسک"},
    {"fa": "دَگمَسه", "en": "dagmasa", "desc": "سختی کشیدن در کار"},
    {"fa": "دَم پَسّا", "en": "dampassa", "desc": "پشت سر هم، یکنواخت"},
    {"fa": "دم تو کوه رفته", "en": "", "desc": "نهیب به باد وقتی نخواهد بوزد"},
    {"fa": "دیدَنا", "en": "deidana", "desc": "دید و بازدید"},
    {"fa": "در بند چیزی بودن", "en": "", "desc": "تمایل داشتن به چیزی"},
    {"fa": "دوقلو", "en": "", "desc": "قلقلک"},
    {"fa": "دَبوک", "en": "", "desc": "تله آهنی با حلب روغن برای شکار کبک/تیهو"},
    {"fa": "دُهُل شده", "en": "", "desc": "کلمه پرخاش به حیوانات اهلی"},
    {"fa": "دَق", "en": "", "desc": "خاک رس"},
    {"fa": "دلیل کردن", "en": "", "desc": "پیوند زدن دو نخ بدون گره"},
    {"fa": "دست مشک", "en": "", "desc": "کنایه از کسی که کاری بلد نیست"},
    {"fa": "دَوید", "en": "", "desc": "نوعی پارچه برای شلوار"},
    {"fa": "درا کوفتن", "en": "", "desc": "در را کوبیدن"},
    {"fa": "دَردَرو", "en": "", "desc": "خونه خونه"},
    {"fa": "دو گوتن بشن", "en": "", "desc": "می‌خوام برم"},
    {"fa": "دوشب", "en": "", "desc": "دیشب"},
    {"fa": "دوتورو", "en": "dotoro", "desc": "نوعی پرنده (همان یا کریم) که در خیابان‌ها و کوچه‌ها زیاد دیده می‌شود"},
  ];
}