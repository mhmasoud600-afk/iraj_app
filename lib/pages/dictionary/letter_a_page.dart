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

class LetterAPage extends StatefulWidget {
  const LetterAPage({Key? key}) : super(key: key);

  @override
  State<LetterAPage> createState() => _LetterAPageState();
}

class _LetterAPageState extends State<LetterAPage> {
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
        title: const Text("واژه‌های حرف ا"),
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
    {"fa": "اَکّو", "en": "akkoo", "desc": "همان دالی است."},
    {"fa": "اَرمُنده", "en": "armonda", "desc": "نان بیات شده"},
    {"fa": "اِیلون ویلون", "en": "eyloon veyloon", "desc": "سرگردان"},
    {"fa": "آش شولی", "en": "shooli", "desc": "نوعی آش همراه با سبزی و خمیر بریده و چغندر و ..."},
    {"fa": "آتش پاره", "en": "", "desc": "آدم شر و بد جنس"},
    {"fa": "آشار", "en": "ashar", "desc": "نوعی زنبیل که از برگ درخت خرما ساخته می شود."},
    {"fa": "آفتاب غروب", "en": "", "desc": "بیان زمان (عصر ، نزدیک غروب ) _ (...آفتاب غروب راه می افتیم )"},
    {"fa": "اِشم", "en": "eshm", "desc": "نوعی علف صحرایی"},
    {"fa": "اَگال", "en": "agal", "desc": "بستن پای حیوان با طناب"},
    {"fa": "اُزو", "en": "ozoo", "desc": "سوراخی در زمین زراعی که در هنگام آبیاری، آب از آن به زمین های پایین دست می رود."},
    {"fa": "اَسبُسو", "en": "asbosoo", "desc": "نوعی یونجه خودرو کنار جوی ها ( مادها در هنگام ورود به ایران نوعی یونجه به اسبان خود می دادند که \" اسب اس \" (asbas) نام داشت...)"},
    {"fa": "اِوار", "en": "evar", "desc": "آرواره"},
    {"fa": "آب دوغه", "en": "ab doogha", "desc": "آب لنبو ( ... انار را آب دوغه کن )"},
    {"fa": "اُرچونه", "en": "orchoona", "desc": "راه پله (راخچونه ، راهبون )"},
    {"fa": "آب گوزیدن", "en": "", "desc": "لو رفتن"},
    {"fa": "آفتاب زار", "en": "", "desc": "آفتاب مستقیم و سوزان"},
    {"fa": "اُرُزو تو پشتم رفت", "en": "orozoo", "desc": "لرزه بر اندامم افتاد"},
    {"fa": "آجِده کردن", "en": "ajeda", "desc": "کوک های بزرگ زدن به پارچه"},
    {"fa": "اَنگار کردن", "en": "angar", "desc": "تعطیل کردن کار (انگارم کرد : مرا جا گذاشت)"},
    {"fa": "اَسِرگ", "en": "aserg", "desc": "نوعی آرد جو که بسیار خوشمزه و مقوی است."},
    {"fa": "اُوشون", "en": "ovshoon", "desc": "آویشن ( گیاه دارویی خوشبو )"},
    {"fa": "اَخُوَ", "en": "akhova", "desc": "خمیازه ( دهن دَرَک )"},
    {"fa": "آسمون گُدار", "en": "asemoon godar", "desc": "سَرسَره کوه که آسمان مشخص است."},
    {"fa": "آکسون", "en": "aksoon", "desc": "زنبیلی که به قلاب و طناب آویزان باشد و سر دیگر طناب زیر سقف خانه وصل باشد و در آن خوردنی ها را می ریزند که دور از دسترس موش و حیوانات موذی باشد."},
    {"fa": "آلَه", "en": "", "desc": "نصفه ، دو نیم کردن ( آله هندونه)"},
    {"fa": "آگی", "en": "", "desc": "قطعه آهن کوچک که برای محکم کردن دسته کلنگ استفاده می شود. ( گاز )"},
    {"fa": "آب کشیدن", "en": "", "desc": "آبیاری کردن"},
    {"fa": "آبا ببند هی", "en": "", "desc": "جمله ای که روزانه در هنگام آبیاری کردن بارها تکرار می شود ( ... آبا ببند هُی )"},
    {"fa": "آتش گیرا", "en": "", "desc": "یک مشت هیزم نرم و خُرد که برای روشن شدن آتش از آن استفاده کنند."},
    {"fa": "آسونه", "en": "", "desc": "صخره ای مرتفع که در ابتدای مسیل آب در کوه قرار دارد و در هنگام بارش باران آبشار ایجاد می کند"},
    {"fa": "اُوسار", "en": "", "desc": "افسار"},
    {"fa": "اُق", "en": "ogh", "desc": "استفراغ"},
    {"fa": "انار سگی", "en": "", "desc": "انار خیلی ترش"},
    {"fa": "القاج", "en": "alghaj", "desc": "پود ضخیم فرش"},
    {"fa": "اتاق در بست", "en": "", "desc": "انباری"},
    {"fa": "ای", "en": "", "desc": "از اصوات برای ابراز تنفر از چیزی (اه )"},
    {"fa": "اذان گفتن گوش", "en": "", "desc": "وز وز کردن گوش ( ...گوشم داره اذون می گه )"},
    {"fa": "اِله شب", "en": "elah", "desc": "پاسی از شب ( ...تا اله شب بیدار بودم .)"},
    {"fa": "اَخیَه", "en": "akhiya", "desc": "قلابی که بر دیوار نصب می کنند و افسار الاغ را به آن می بندند"},
    {"fa": "از بین رفته", "en": "", "desc": "کنایه از اینکه لاغر و ضعیف شده"},
    {"fa": "از سر هم در رفتن", "en": "", "desc": "از هم جدا شدن ( طلاق گرفتن )"},
    {"fa": "ابله دوان", "en": "", "desc": "نوعی گنجشک که خیلی نترس است و تا شخص نزدیکش نشود پرواز نمی کند و به این وسیله شخص ابله را کیلومترها دنبال خود می دواند!"},
    {"fa": "آتش چشمو", "en": "", "desc": "افتادن نور از روبرو در چشم در شب"},
    {"fa": "این پا از من نیست!", "en": "", "desc": "کنایه از اینکه خیلی درد دارد و از شدت درد بی حس شده."},
    {"fa": "آب تُرّه", "en": "ab torra", "desc": "آبشار"},
    {"fa": "انگور شغال", "en": "", "desc": "درختچه ای خودرو که میوه های وحشی قرمز رنگ دارد و شبیه انگور خیلی ریز است."},
    {"fa": "اَخلاخ", "en": "akhlakh", "desc": "کُت"},
    {"fa": "اَنگِله", "en": "angela", "desc": "قسمتی از دست ، آرنج ( ...انگله شا بگیر بیارش ! )"},
    {"fa": "آتشونی", "en": "atshooni", "desc": "شب نشینی"},
    {"fa": "اغماض نکن", "en": "", "desc": "چشم پوشی نکن"},
    {"fa": "اَلُو", "en": "alov", "desc": "آتش"},
    {"fa": "آتش تو گوری", "en": "", "desc": "نوعی نفرین پشت سر مرده"},
    {"fa": "اَتمات شب", "en": "atamat", "desc": "نیمه های شب"},
    {"fa": "انار رشکو", "en": "", "desc": "انار نارس"},
    {"fa": "اِسپُجُرو", "en": "", "desc": "نوعی گیاه خاردار"},
    {"fa": "انار غوزو", "en": "", "desc": "انار کوچک و ترش و بی مصرف"},
    {"fa": "اُوِنزون", "en": "", "desc": "آویزان"},
    {"fa": "آب گردون", "en": "", "desc": "کفگیر"},
    {"fa": "اَفَندی", "en": "", "desc": "نوعی پارچه"},
    {"fa": "امه ", "en": "", "desc": "ما"},
  ];
}