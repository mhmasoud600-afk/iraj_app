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

class LetterChPage extends StatefulWidget {
  const LetterChPage({Key? key}) : super(key: key);

  @override
  State<LetterChPage> createState() => _LetterChPageState();
}

class _LetterChPageState extends State<LetterChPage> {
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
        title: const Text("واژه‌های حرف چ"),
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
    {"fa": "چُروشک", "en": "chorooshk", "desc": "آتش بی‌فروغ (... یه چروشک آتش بیار)"},
    {"fa": "چار پاشنه", "en": "", "desc": "سریع آماده شدن (... تا بهش گفتم چارپاشنه کرد و رفت)"},
    {"fa": "چِکّو", "en": "chekkoo", "desc": "بادام کوهی که با پوسته باشد"},
    {"fa": "چُدار", "en": "chodar", "desc": "بستن دست و پای حیوان به صورت ضربدر برای جلوگیری از فرار"},
    {"fa": "چِشته", "en": "cheshta", "desc": "خوردن چیزی که تمایل افراطی ایجاد کند (چِشته خوردن)"},
    {"fa": "چُل", "en": "chol", "desc": "قسمت پایین چادر یا دامن"},
    {"fa": "چشم و دل گشنه", "en": "", "desc": "حریص، ندیدپدید"},
    {"fa": "چشم و چاره", "en": "", "desc": "چشم (... این چوبا بنداز اونجا میزنی تو چشم و چاره بچه‌ها)"},
    {"fa": "چُن", "en": "chon", "desc": "سوراخ کوه (چن مادو: سوراخی با دهانه کوچک و فضای داخلی وسیع)"},
    {"fa": "چَپُش", "en": "chaposh", "desc": "نوعی بز نر جوان"},
    {"fa": "چغندر دیوونه", "en": "", "desc": "نوعی گیاه خود رو شبیه چغندر با گل دارویی"},
    {"fa": "چلّه خونه", "en": "chella", "desc": "چشمه‌سار و محلی در ایراج"},
    {"fa": "چَری", "en": "chari", "desc": "ابزار نخ‌ریسی"},
    {"fa": "چوق", "en": "", "desc": "چوب"},
    {"fa": "چَنگمال", "en": "changmal", "desc": "خوردنی از نان سمنو، خرما، کنجد، سیاهدانه و..."},
    {"fa": "چرخ ریسو", "en": "charkh reisoo", "desc": "نوعی جیرجیرک"},
    {"fa": "چوری", "en": "choori", "desc": "جوجه (... ما امسال چوری نداریم باید مرغ بشونیم)"},
    {"fa": "چَپَلاق", "en": "chapalagh", "desc": "سیلی"},
    {"fa": "چَزّه", "en": "chazza", "desc": "درختچه‌ای خاردار در بیابان‌های ایراج"},
    {"fa": "چَش", "en": "chash", "desc": "اصوات برای از حرکت بازداشتن الاغ (... چَشششش)"},
    {"fa": "چِلَپ چِلَپ", "en": "chelap chelap", "desc": "صدای آب وقتی دست یا جسمی در آن زده شود"},
    {"fa": "چَنبَره", "en": "chanbara", "desc": "چهارچوب آویزان زیر سقف برای نگهداری خوردنی‌ها دور از دسترس حیوانات"},
    {"fa": "چُسو", "en": "chosoo", "desc": "سن"},
    {"fa": "چادر پی", "en": "chador pi", "desc": "چربی داخل شکم گوسفند اطراف روده‌ها"},
    {"fa": "چُرک", "en": "chork", "desc": "زایدهای کوچک بر روی چوب درختان"},
    {"fa": "چُفت", "en": "choft", "desc": "دگمه، قفل در؛ همچنین کیپ و گرفته (... چفت درا بنداز)"},
    {"fa": "چفت چریکو", "en": "choft cherikoo", "desc": "دگمه قابلمه‌ای"},
    {"fa": "چَکیده دادن", "en": "", "desc": "افتادن چیزی به زمین و دوباره بالا پریدن"},
    {"fa": "چراغ باد", "en": "", "desc": "فانوس (چراغ تور، چراغ گردسوز، چراغ لمپا)"},
    {"fa": "چَن چینو", "en": "chan chinoo", "desc": "آیین رفع چشم‌زخم با جمع‌آوری خوردنی‌ها برای کودک چشم‌خورده"},
    {"fa": "چُغو", "en": "choghoo", "desc": "گنجشک (چغو اُوِنجونو، چغو سیاوو، چغو کاکلو، چغو چرسکو ...)"},
    {"fa": "چِرِسک", "en": "cheresk", "desc": "کوچک و ضعیف (ریزه‌میزه)"},
    {"fa": "چوب سرتنور", "en": "", "desc": "چوبی بلند برای جابجا کردن آتش تنور که سیاه شده باشد"},
    {"fa": "چَکُل", "en": "chakol", "desc": "کثیف"},
    {"fa": "چَکوله", "en": "chakoola", "desc": "آدم بی‌دست‌وپا"},
    {"fa": "چِشگین نیستم", "en": "cheshgein", "desc": "تمایل ندارم، حسش نیست"},
    {"fa": "چَمگَرد", "en": "chamgard", "desc": "پیچ راه"},
    {"fa": "چِلیک", "en": "chelik", "desc": "ظرف نفتی"},
    {"fa": "چِلَنگ", "en": "chelang", "desc": "کارهای روزمره منزل"},
    {"fa": "چراغ را بُکُش", "en": "", "desc": "خاموش کن"},
    {"fa": "چرخک", "en": "charkhak", "desc": "قرقره"},
    {"fa": "چلاسیدن", "en": "cholasidan", "desc": "لیسیدن (چلاسو: آب‌نبات)"},
    {"fa": "چیل", "en": "chil", "desc": "سنگ‌چین کوچک برای مشخص کردن راه‌ها در بیابان"},
    {"fa": "چِندون", "en": "chendoon", "desc": "چینه‌دان مرغ"},
    {"fa": "چینه", "en": "cheina", "desc": "دان برای ماکیان"},
    {"fa": "چپکو", "en": "", "desc": "دمپایی"},
    {"fa": "چَپال", "en": "chapal", "desc": "مُشت (... یه چپال تخمه بیار)"},
    {"fa": "چَپُو", "en": "", "desc": "کشک"},
    {"fa": "چِش سفید", "en": "", "desc": "نوعی پرخاش به کسی"},
    {"fa": "چاچَپ", "en": "", "desc": "چادر شب"},
    {"fa": "چُکُرو پُکُرو", "en": "", "desc": "درگوشی صحبت کردن"},
    {"fa": "چرخو", "en": "", "desc": "دور خود گشتن (چرخو نکن)"},
  ];
}