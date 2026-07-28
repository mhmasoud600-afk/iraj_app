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

class LetterPPage extends StatefulWidget {
  const LetterPPage({Key? key}) : super(key: key);

  @override
  State<LetterPPage> createState() => _LetterPPageState();
}

class _LetterPPageState extends State<LetterPPage> {
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
        title: const Text("واژه‌های حرف پ"),
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
    {"fa": "پت پتی", "en": "", "desc": "چراغ فانوس خراب که در حال خاموش شدن است"},
    {"fa": "پالیز", "en": "paliz", "desc": "گیاه خربزه و خیار"},
    {"fa": "پَیجوب", "en": "payjoob", "desc": "علف‌های هرز کنار جوی"},
    {"fa": "پول نوت", "en": "noot", "desc": "پول کاغذی"},
    {"fa": "پُرسه دادن", "en": "", "desc": "تسلیت گفتن"},
    {"fa": "پَرسه", "en": "", "desc": "دوره زدن"},
    {"fa": "پِس پَدونی", "en": "pes padooni", "desc": "چرت و پرت گفتن"},
    {"fa": "پوره چینی", "en": "poora", "desc": "خُرد و ریز خوردن (بیشتر برای گوسفند)"},
    {"fa": "پَخچ", "en": "pakhch", "desc": "میله یا میخی که سر آن پهن و له شده باشد"},
    {"fa": "پیج", "en": "pij", "desc": "الیاف درخت خرما"},
    {"fa": "پُشُرو", "en": "poshoroo", "desc": "ریز آشغال کوچک و سبک"},
    {"fa": "پُخال", "en": "pokhal", "desc": "پودر"},
    {"fa": "پُویدن", "en": "povidan", "desc": "له کردن و پودر کردن"},
    {"fa": "پَرخُو", "en": "parkhov", "desc": "سیلوی گندم و حبوبات"},
    {"fa": "پشت قلعه", "en": "", "desc": "ایراج به سه قسمت تقسیم می‌شود: تو ده، پشت قلعه، شهرک"},
    {"fa": "پشت بادگیر", "en": "", "desc": "سه راهی معروف در ایراج"},
    {"fa": "پینَکی", "en": "pinaki", "desc": "چرت زدن (چرت نسیه)"},
    {"fa": "پس غازیدن", "en": "", "desc": "پس زدن"},
    {"fa": "پاچین", "en": "pachin", "desc": "لباس بلند محلی زنان ایراج"},
    {"fa": "پِلتَه", "en": "pelta", "desc": "فتیله"},
    {"fa": "پازدن", "en": "", "desc": "کمی صبر کردن"},
    {"fa": "پیسک", "en": "pisk", "desc": "پوچ؛ تخمه بی‌مغز"},
    {"fa": "پشک", "en": "peshk", "desc": "هسته خرما"},
    {"fa": "پشکو", "en": "peshkoo", "desc": "هسته زردآلو"},
    {"fa": "پَخمَه", "en": "pakhma", "desc": "بی‌عرضه"},
    {"fa": "پَپو", "en": "papoo", "desc": "کاه ریز ذرت و ارزن و ..."},
    {"fa": "پیله", "en": "", "desc": "آبسه کردن دندان"},
    {"fa": "پَروا ندارم", "en": "parva", "desc": "حوصله ندارم"},
    {"fa": "پَرشَم", "en": "parsham", "desc": "نوعی درختچه در بیابان‌های ایراج"},
    {"fa": "پَرچ", "en": "parch", "desc": "حصار (مخفف پرچین)"},
    {"fa": "پِسکَرو", "en": "peskaroo", "desc": "کوچک و نحیف"},
    {"fa": "پُشته", "en": "", "desc": "مقداری از هیزم یا گیاهان ساقه‌دار"},
    {"fa": "پِخ", "en": "pekh", "desc": "کلمه‌ای که بچه‌ها هنگام شوخی و ترساندن ادا کنند"},
    {"fa": "پَسیم – پَسین", "en": "passim", "desc": "عصر"},
    {"fa": "پَخپوری", "en": "pakhpoori", "desc": "خوردنی خرده‌ریز (بیشتر برای حیوانات)"},
    {"fa": "پیوال", "en": "peyval", "desc": "محل تجمع حیوانات (پیوال شتر)"},
    {"fa": "پَرّا", "en": "parra", "desc": "جوجه گنجشکی که پر درآورد"},
    {"fa": "پیچو", "en": "pichoo", "desc": "گیاهی شبیه گل پیچک"},
    {"fa": "پیچو کردن", "en": "", "desc": "قنداق کردن بچه"},
    {"fa": "پیش زدن", "en": "", "desc": "تمیز کردن حبوبات با جلو و عقب ریختن در سینی"},
    {"fa": "پَز", "en": "paz", "desc": "ترشح مایعات؛ نم دادن زمین زراعی به زمین مجاور"},
    {"fa": "پوزه تاباندن", "en": "", "desc": "به نشانه کم‌محلی صورت را برگرداندن"},
    {"fa": "پَشُفته", "en": "pashofta", "desc": "پاشیدن مایعات از بالا و پخش شدن قطره‌های ریز"},
    {"fa": "پَت", "en": "pat", "desc": "حجیم شدن حبوبات خیس شده در طی مدتی"},
    {"fa": "پَفتَل", "en": "paftal", "desc": "به‌دردنخور و دورریختنی (چای پفتل)"},
    {"fa": "پَرتوندن", "en": "partondan", "desc": "سوزاندن موی کله‌پاچه"},
    {"fa": "پَک و پوز", "en": "pak o pooz", "desc": "سر و صورت"},
    {"fa": "پَندوس کرده", "en": "pandoos", "desc": "گربه مرده (اصطلاح زمانی که گربه اذیت می‌کند)"},
    {"fa": "پاکَشه", "en": "", "desc": "پایین چیزی"},
    {"fa": "پیرو", "en": "", "desc": "پژمرده"},
    {"fa": "پَچُل", "en": "pachol", "desc": "کثیف"},
    {"fa": "پِرمو", "en": "permoo", "desc": "مژه"},
    {"fa": "پریشش", "en": "", "desc": "زمانی که شخص بیش از اندازه برای آمدن معطل می‌کند"},
    {"fa": "پِیمو", "en": "paymoo", "desc": "مرز بین دو زمین زراعی"},
    {"fa": "پَنگول", "en": "pangool", "desc": "چنگال حیوانات وحشی"},
    {"fa": "پالوندن", "en": "palondan", "desc": "پاک کردن حبوبات با آب (سنگشور)"},
    {"fa": "پی پایی", "en": "pay paei", "desc": "بدرقه مسافر"},
    {"fa": "پسیمِ بلند", "en": "", "desc": "برای بیان زمان عصر؛ هنوز تا غروب مانده"},
    {"fa": "پَنوم", "en": "panoom", "desc": "پنهان"},
    {"fa": "پودینه", "en": "poodina", "desc": "پونه"},
    {"fa": "پَتاله", "en": "pattala", "desc": "نامرتب"},
    {"fa": "پیسار", "en": "", "desc": "رشته کوهی نزدیک ایراج"},
    {"fa": "پُت", "en": "pot", "desc": "پر مرغ، موی گربه و ..."},
    {"fa": "پِسّو", "en": "pessoo", "desc": "سست"},
    {"fa": "پُر باد شده", "en": "", "desc": "عبارتی برای پرخاش به گوسفند"},
    {"fa": "پُر باد شد", "en": "", "desc": "مُرد (برای گوسفند کاربرد دارد)"},
    {"fa": "پشت کلّه را دیدن", "en": "", "desc": "کنایه از کار نشدنی"},
    {"fa": "پایه", "en": "", "desc": "رعد و برق"},
    {"fa": "پاسبک کردن", "en": "", "desc": "وضع حمل کردن"},
    {"fa": "پنجه", "en": "penja", "desc": "انگشت؛ کرم سبز به اندازه انگشت"},
    {"fa": "پیر حاجاتو", "en": "", "desc": "میدانگاهی کوچک با درخت توتی بسیار قدیمی"},
    {"fa": "پوزه سَم", "en": "pooza sam", "desc": "نام قسمتی از کوهی در جنوب غربی ایراج"},
    {"fa": "پَشَنگ", "en": "", "desc": "قطره‌های ریز آب"},
    {"fa": "پَرّه زردآلو", "en": "", "desc": "برگه زردآلو"},
    {"fa": "پال پالو", "en": "", "desc": "غلت زدن پرندگان در خاک مرطوب برای خنک شدن"},
    {"fa": "پیناس", "en": "", "desc": "گدا"},
    {"fa": "پُشُو پُشُو", "en": "", "desc": "عبارتی برای فراخواندن میش و قوچ"},
    {"fa": "پُزُرمه", "en": "", "desc": "برف ریز"},
    {"fa": "پَشی", "en": "", "desc": "آب اول زمین زراعی"},
    {"fa": "پنجه کلاغی", "en": "", "desc": "دست‌خط بد"},
    {"fa": "پا داریم", "en": "", "desc": "اصطلاح بعد از بازگشت از مراسم عزا"},
    {"fa": "پُتکه", "en": "", "desc": "جوانه درخت"},
    {"fa": "پاتُوَ", "en": "", "desc": "بستن پارچه مخصوص از مچ پا تا زیر زانو"},
    {"fa": "پایه", "en": "paye", "desc": "رعد و برق؛ صدای مهیبی که از آسمان می‌آید (پایه صدا می‌دهد)"},
  ];
}