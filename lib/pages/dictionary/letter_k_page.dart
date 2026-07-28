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

class LetterKPage extends StatefulWidget {
  const LetterKPage({Key? key}) : super(key: key);

  @override
  State<LetterKPage> createState() => _LetterKPageState();
}

class _LetterKPageState extends State<LetterKPage> {
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
        title: const Text("واژه‌های حرف ک"),
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
    {"fa": "کَمبُلو", "en": "kamboloo", "desc": "نوعی سبزی صحرایی که از برگ، ساقه و ریشه آن استفاده می‌شود؛ بر دو نوع است: گردو - درازو"},
    {"fa": "کالَک", "en": "kalak", "desc": "خربزه نارس"},
    {"fa": "کَف بیل", "en": "kaf beil", "desc": "بیل پهن"},
    {"fa": "کاشوندن", "en": "", "desc": "خراشیدن"},
    {"fa": "کَنگ", "en": "kang", "desc": "کپک"},
    {"fa": "کِنِس", "en": "", "desc": "خسیس"},
    {"fa": "کمر مویی را دو تا نمیکنه", "en": "", "desc": "هیچ کاری نمی‌کنه"},
    {"fa": "کُندُله", "en": "kondola", "desc": "فردی که در راه رفتن کند باشد"},
    {"fa": "کَلَرّه", "en": "kalarra", "desc": "شاخه درخت تقریباً خشک و کم‌برگ (... این بُتّه خیلی کَلَرّه شده)"},
    {"fa": "کِلِک", "en": "kelek", "desc": "ترشحات چشم که در گوشه آن به صورت خشک‌شده جمع شود"},
    {"fa": "کُتَل", "en": "kotal", "desc": "سرازیری (کتل آسیو، کتل مَیسینو، کتل گله، گتل تهجوب، کتل دروازه، کتل مزار، کتل خر کُشون و...)"},
    {"fa": "کارت اومده", "en": "", "desc": "گوسفندی که در حال مردن باشد – همچنین عبارت پرخاش به گوسفند"},
    {"fa": "کُرُچیدن", "en": "korocheidan", "desc": "جویدن خوردنی جامد که همراه با صدا باشد"},
    {"fa": "کُروک", "en": "korook", "desc": "تو کروک بودن: تو فکر بودن (تو کروکه = تو خودشه)"},
    {"fa": "کیسه پیله", "en": "", "desc": "کیسه"},
    {"fa": "کِرگاس", "en": "kergas", "desc": "کرم‌هایی در زیر پوست گوسفند"},
    {"fa": "کُپ", "en": "kop", "desc": "واژگون"},
    {"fa": "کَله مال", "en": "kalla mal", "desc": "لبریز"},
    {"fa": "کره مون رد شده", "en": "", "desc": "کره مون از گله به خونه نیومده (... بچه‌ها تو گله ور دویدن کره‌مون رد شد!)"},
    {"fa": "کار بافو – کاردُوونو", "en": "", "desc": "عنکبوت"},
    {"fa": "کوزَه او انداختن", "en": "", "desc": "بادکش کردن موضع درد"},
    {"fa": "کُله کُوی", "en": "kola kovei", "desc": "جستجو در وسایل"},
    {"fa": "کوکو مریمو", "en": "kookoo maryamoo", "desc": "نوعی حشره خاکی با تله قیفی در خاک برای شکار"},
    {"fa": "کُلوت", "en": "koloot", "desc": "تل و پشته"},
    {"fa": "کَمکال", "en": "kamkal", "desc": "فضای زیر کوه یا دامنه یا کنار مسیل‌ها با حالت غار و دهانه گشاد و ایوان مانند"},
    {"fa": "کمون رستم", "en": "", "desc": "رنگین‌کمان"},
    {"fa": "کَوِرچَه", "en": "kavercha", "desc": "سفیدی روی لباس ناشی از عرق"},
    {"fa": "کُوُو", "en": "kovoo", "desc": "انجیر نارس"},
    {"fa": "کُلوخو", "en": "kolookhoo", "desc": "زردآلو نارس"},
    {"fa": "کاج", "en": "kaj", "desc": "اطاقکی نزدیک خانه یا دشت برای ذخیره کاه"},
    {"fa": "کُوَه", "en": "kova", "desc": "کندو زنبور"},
    {"fa": "کَرّه", "en": "karra", "desc": "بزغاله"},
    {"fa": "کَفت", "en": "kaft", "desc": "کتف"},
    {"fa": "کِلِچ", "en": "kelech", "desc": "انگشت کوچک"},
    {"fa": "کیش _ کِت", "en": "ket", "desc": "کلمه نهیب به مرغ برای فراری دادن آن"},
    {"fa": "کُت", "en": "kot", "desc": "نوعی بز با گوش‌های کوچک و کشیده"},
    {"fa": "کُت کُتو کردن", "en": "", "desc": "در گوشی صحبت کردن"},
    {"fa": "کلّه بذار", "en": "", "desc": "بخواب (... برو کله بذار)"},
    {"fa": "کَوِشک", "en": "kaveshk", "desc": "بخشی از درخت خرما در انتهای برگه که ضخیم و پهن است"},
    {"fa": "کِرمُکو", "en": "kermokoo", "desc": "کوهی در غرب ایراج"},
    {"fa": "کج مار", "en": "", "desc": "نوعی مار"},
    {"fa": "کور مار", "en": "koor", "desc": "نوعی مار"},
    {"fa": "کُلوزه", "en": "kolooza", "desc": "غوزه پنبه (سیبی)"},
    {"fa": "کَل", "en": "kal", "desc": "گوسفند بدون شاخ"},
    {"fa": "کودری", "en": "koodarei", "desc": "نوعی پارچه"},
    {"fa": "کَل", "en": "kal", "desc": "چوب ذرت و آفتابگردان (کَل ذرت)"},
    {"fa": "کُماچ", "en": "komach", "desc": "نوعی نان محلی ضخیم که با روغن داخل قابلمه (قلیف) بپزند"},
    {"fa": "کُنده", "en": "konda", "desc": "تنه درخت"},
    {"fa": "کَل کَلی", "en": "kal kalei", "desc": "نامنظم؛ سری که درست اصلاح نشده باشد"},
    {"fa": "کُدُمبه", "en": "kodomba", "desc": "کلّه (کدو کلّه)"},
    {"fa": "کال", "en": "kal", "desc": "سوراخ کوه"},
    {"fa": "کَج", "en": "kaj", "desc": "آشیانه پرنده"},
    {"fa": "کَلاج", "en": "kalaj", "desc": "لوچ"},
    {"fa": "کَندال", "en": "kandal", "desc": "حیوان از شدت خستگی ناتوان از حرکت (... بزمون کندال شده)"},
    {"fa": "کَلَک", "en": "kalak", "desc": "چوب قلابی؛ یک سر با طناب به سقف وصل و سر قلاب برای آویزان کردن وسایل"},
    {"fa": "کاشو", "en": "kashoo", "desc": "ته دیگ"},
    {"fa": "کُو شورو", "en": "kovshooroo", "desc": "گودال کوچکی در کنار جوی آب برای شستن کاه و علف"},
    {"fa": "کاشو", "en": "kashoo", "desc": "قلقلک کف پا (... خودشا به خواب زده؛ کاشوش کن تا وخیزه)"},
    {"fa": "کمونه کش", "en": "kamoona kash", "desc": "چیزی که با شدت به جایی برخورد کند و به سمت کسی پرتاب شود"},
    {"fa": "کوز", "en": "kooz", "desc": "محل نگهداری مرغ"},
    {"fa": "کلیدون", "en": "keleidoon", "desc": "وسیله چوبی قدیمی قفل درب‌های چوبی؛ در محفظه کنار درب قرار می‌گرفت"},
    {"fa": "کوله", "en": "koola", "desc": "مخفیگاهی برای شکار حیوانات و پرندگان نزدیک آبگاه‌ها از سنگ و چوب"},
    {"fa": "کَسارگ", "en": "kasarg", "desc": "نوعی مرغ"},
    {"fa": "کَرَت", "en": "karat", "desc": "دفعه"},
    {"fa": "کُول", "en": "kovl", "desc": "یاد (از کُولم در رفت = از یادم رفت)"},
    {"fa": "کُندِله", "en": "kondela", "desc": "شخصی که در راه رفتن کند باشد"},
    {"fa": "کو کو", "en": "koo koo", "desc": "جغد، فاخته"},
    {"fa": "کُنده زانو", "en": "", "desc": "زانو"},
    {"fa": "کازه", "en": "kaza", "desc": "تل و پشته"},
    {"fa": "کِریُو", "en": "keryov", "desc": "خیلی شور"},
    {"fa": "کاله", "en": "kala", "desc": "پوششی برای بعضی چیزها؛ کاله گردو، کاله تخم‌مرغ (کاله زلو)"},
    {"fa": "کَجَنگ", "en": "kajang", "desc": "خوشه خرما که خرمای آن را چیده باشند"},
    {"fa": "کَمچَلیز", "en": "kamchaleiz", "desc": "ملاقه"},
    {"fa": "کُلوچ", "en": "kolooch", "desc": "قراضه"},
    {"fa": "کَلَفت", "en": "kalaft", "desc": "گاز زدن بزرگ به چیزی (... بیا کلفتش بزن بخور)"},
    {"fa": "کُتره", "en": "kotra", "desc": "توله (کُتره سگ)"},
    {"fa": "کَنَفو", "en": "kanafoo", "desc": "شاهدانه"},
    {"fa": "کولار", "en": "koolar", "desc": "بز جوان"},
    {"fa": "کَلّه", "en": "kalla", "desc": "سر افکنده (... فکر کرد من نمی‌دونم؛ وقتی فهمید، کلّه شد رفت)"},
    {"fa": "کَلّه کشو", "en": "kalla kashoo", "desc": "از پشت جایی یک لحظه نگاه کردن و دوباره پنهان شدن؛ سرک کشیدن"},
    {"fa": "کُلُمبزی", "en": "kolombozei", "desc": "برآمدگی"},
    {"fa": "کالیو", "en": "kaliyoo", "desc": "چاله کوچکی که بچه‌ها با سنگ بکنند"},
    {"fa": "کَمَری", "en": "kamarei", "desc": "نوعی گوسفند که روی کمر آن خط داشته باشد"},
    {"fa": "کاکُل دوشی", "en": "kakol", "desc": "سوار کردن بچه روی دوش خود"},
    {"fa": "کاسه مال", "en": "", "desc": "غذایی دارویی و مقوی برای بچه‌ها شامل هفت گل، بادام و ..."},
    {"fa": "کوزَل", "en": "koozal", "desc": "قسمتی از کاه گندم که هنگام خرمن کردن وارد گندم شود"},
    {"fa": "کوزل کوب", "en": "", "desc": "ابزاری چوبی با دسته باریک و بدنه ضخیم برای ضربه به خوشه‌های باقی‌گندم"},
    {"fa": "کورو", "en": "kooroo", "desc": "مه (... کورو همه جا را گرفته)"},
    {"fa": "کورو", "en": "kooroo", "desc": "فتیله چراغ که پایین باشد (... چراغا کورو کن)"},
    {"fa": "کُرپَه", "en": "korpa", "desc": "محصول یا چیزی که از نظر رشد عقب باشد (... گندممون کُرپه شده)"},
    {"fa": "کِلِش کِلِش", "en": "kelesh", "desc": "از اصوات؛ صدای کشیده شدن دو چیز مانند کاغذ"},
    {"fa": "کَیک", "en": "kaeik", "desc": "کَک"},
    {"fa": "کِشاله ریز", "en": "keshala", "desc": "قرار گرفتن پشت‌سرهم در یک مسیر (... بُزا کشاله ریز دارن میان)"},
    {"fa": "کفتر بچه", "en": "", "desc": "نوعی گلابی"},
    {"fa": "کَش", "en": "kash", "desc": "کنار (کَش راه = کنار راه)"},
    {"fa": "کیجو", "en": "keijoo", "desc": "توده چوب‌های باریک و کوچک انباشته (... برو کیجو جم کن الو کنیم)"},
    {"fa": "کنزآب", "en": "kanzab", "desc": "جلبک"},
    {"fa": "کفته", "en": "kafta", "desc": "خمیر نیم‌پخته که جمع شده و در کف تنور بیفتد"},
    {"fa": "کَشکِله", "en": "kashkela", "desc": "خرمای خراب"},
    {"fa": "کوم", "en": "koom", "desc": "کام؛ سقف دهان"},
    {"fa": "کَسرِش می‌کنه", "en": "", "desc": "براش کسر شأن است"},
    {"fa": "کُلوخ کوب", "en": "kolookh koob", "desc": "وسیله چوبی با دسته بلند و سر ضخیم برای نرم کردن کلوخ زمین زراعی"},
    {"fa": "کُول", "en": "kovl", "desc": "حلقه‌های سیمانی دور چاه یا قنات برای جلوگیری از ریزش"},
    {"fa": "کورا کورا", "en": "koora", "desc": "از اصوات؛ برای وقتی که می‌خواهند الاغ را آهسته بگیرند"},
    {"fa": "کلاه برگه‌ای", "en": "", "desc": "کلاه حصیری"},
    {"fa": "کارفرما", "en": "", "desc": "وسیله کار؛ ابزار"},
    {"fa": "کَوِر", "en": "", "desc": "خوشه درخت بنه که بنه آن را چیده باشند یا بنه نارس داشته باشد (کَوِر بنه)"},
    {"fa": "کُلُوشو", "en": "", "desc": "قسمتی از سم گوسفند"},
    {"fa": "کَپچ", "en": "", "desc": "قوس‌دار (... بیل کپچ – کپچه بیل)"},
    {"fa": "کُوشه", "en": "kovsha", "desc": "از دانه‌های روغنی"},
    {"fa": "کُلُوس", "en": "kolovs", "desc": "کرفس"},
    {"fa": "کاسه کُندِله", "en": "", "desc": "کاسه و کوزه گِلی شکسته"},
    {"fa": "کور گم", "en": "", "desc": "ناپدید"},
    {"fa": "کرم زردچوبه", "en": "", "desc": "تکه‌های زردچوبه ساییده‌نشده که به شکل کرم است"},
    {"fa": "کُجون", "en": "", "desc": "دشت"},
    {"fa": "کَنگو", "en": "", "desc": "کپک زده"},
    {"fa": "کرمُنه", "en": "", "desc": "نوعی توهین"},
    {"fa": "کَدراکه", "en": "", "desc": "نان خشک شده"},
    {"fa": "کیش", "en": "", "desc": "نوعی پارچه سنتی"},
    {"fa": "کِشته", "en": "", "desc": "برش اَنغوزه"},
    {"fa": "کول", "en": "", "desc": "دو قطعه سنگ نازک مثلثی روی گیاه انغوزه برای مشخص‌کردن محل و جلوگیری از آفتاب‌خوردن"},
    {"fa": "کُتول", "en": "", "desc": "ظرفی از پوست گوسفند که اَنغوزه در آن می‌ریزند"},
    {"fa": "کورو", "en": "kooroo", "desc": "مه – چراغی که فتیله (پِلته) آن پایین باشد (... چراغ بادا کورو کن)"},
    {"fa": "کِل و بِل", "en": "", "desc": "خرده کاری (... امروز از صبح تا حالا دارم کل و بل می‌کنم)"},
    {"fa": "کُوشورو", "en": "", "desc": "محل خیس کردن کاه"},
    {"fa": "کله اش آبووه", "en": "", "desc": "به بچه‌ای که استخوان سرش هنوز محکم نشده است"},
    {"fa": "کل آسین", "en": "", "desc": "لباس آستین کوتاه"},
    {"fa": "کولنگرو", "en": "", "desc": "قسمتی از پا"},
    {"fa": "کجون", "en": "", "desc": "باغ"},
  ];
}