// lib/pages/old_poems_page.dart
import 'package:flutter/material.dart';
import '../mixins/searchable_mixin.dart'; // اضافه شد

class OldPoet {
  final String name;
  final List<String> poems;
  final String imageUrl;

  OldPoet({
    required this.name,
    required this.poems,
    required this.imageUrl,
  });
}

class OldPoemsPage extends StatefulWidget {
  const OldPoemsPage({super.key});

  @override
  State<OldPoemsPage> createState() => _OldPoemsPageState();
}

class _OldPoemsPageState extends State<OldPoemsPage> with SearchableMixin {
  final List<OldPoet> oldPoets = [
    // ==================== حاج فاطمه جان عشقی ====================
    OldPoet(
      name: 'حاج فاطمه جان عشقی',
      imageUrl: 'assets/images/poets/fatemeh_ashghi.jpg',
      poems: [
        '''اگه شونه شوی مویم نبینی
اگه آینه شوی رویم نبینی
شوی صیاد و آیی دامن کوه
که رد سم آهویم نبینی''',
        '''گر ماه شوی نگاه به رویت نکنم
گر قبله شوی نماز به سویت نکنم
گر دسته گلی شوی آیی به برم
بردارم و بگذارم و بویت نکنم''',
        '''یاران چه خوشه آلاله در فصل باهار
یاران چه خوشه قبیله با ایل و تبار
یاران چه خوشه به دور هم بنشینیم
شبهای زمستون و روزای باهار''',
        '''تو که بر دست داری جام شیره
به قربون سرت که بی نظیره
به قربون همون عقل و کمالت
که هر جا دشمنی داری بمیره''',
        '''سراگرمه بدیدم قد به قدی
بدیدم سرو ناز با شیرمردی
در خونه رضا وادار کردن
نشستن تا بنوشن آب سردی''',
        '''از این کوچه دراومد یک ندایی
سر و دستش بلور،کفشش طلایی
سلامش را به .....رسونید
که .....شده عقد ....''',
        '''به زیر آسمون پرواز پرواز
خودم ایراج دلم رفته به کهیاز
سر کوه بلند شش ماه نشینم
ببینم کی میاد اون دلبر ناز''',
        '''کجایش می برن درّ یگانه
به روی خونه فلفل دونه دونه
به هر جاش می برن زودی بیارن
که این شمع و چراغ خونه مونه''',
        '''درخت توت دم دالان فادمه
پلنگ و شیر در فرمان فادمه
تموم دختران این محله
همه باشن بلاگردان فادمه''',
        '''الا عمو ندادی دخترت را
تو گوش کردی سخنهای زنت را
سر پل صراط و روز محشر
بگیرد آه اصغر دامنت را''',
        '''سوار خر بود کُتشا پیش داشت
می رفت آخورک دلم ورشوریده بود
مث(مثل) آهک خدا همراهیش کردم
جوابم را نداد از پیشم
اورا رفت گفتم به درک!''',
        '''گلی دیدم به دنبالش دویدم
بدیدم خار داره وارمیدم
اگر از خاطر بلبل نمی بود
درخت گل ز ریشه می بریدم''',
        '''دو چشمانم به چشمان ول افتاد
چو مهتابی که بر شاخ گل افتاد
بیایید چاره سازون چاره سازید
که راهم دور، کارم مشکل افتاد''',
        '''کُلوت اشرفی پابندِ ریز اُو
به روی سینه دلبر کنم خُو
ز بس که خاطرش پیشم عزیزه
برایش می برم من آب سَنگُو''',
      ],
    ),
    // ==================== لیلی نجفی (صفر) ====================
    OldPoet(
      name: 'لیلی نجفی (صفر)',
      imageUrl: 'assets/images/poets/leili_najafi.jpg',
      poems: [
        '''ای ماه بلند بلند هوایی نکنی
ای خرمن گل ز من جدایی نکنی
ای خرمن گل با تو امیدا دارم
با کس دیگه تو آشنایی نکنی''',
        '''ما شش برادران کَشتی رونیم
کَشتی به هوای همدگر می رونیم
گَه می رونیم و گه فرو می مونیم
روشن شود اون خونه ای که ما مهمونیم''',
        '''ای ماه برو کنار دیوار امشب
تا من بروم به دیدن یار امشب
ای ستاره صبح تو روشنایی کم کن
تا دست برسه به دست حق دار امشب''',
        '''گلی سرخ سفیدم ارغوانی
منو با خود ببر تا می توانی
اگر مردم نمی دونِد بِدونِد
دیگه بی تو ندارم زندگانی''',
        '''گلی سرخ سفیدم باریکلا
بنفشه برگ بیدم باریکلا
دو صد فرسخ به دنبالت دویدم
نکردی ناامیدم باریکلا''',
        '''سر راهت نشینم فال گیرم
اگر قاصد بیاد احوال گیرم
اگر قاصد بیاد با حال خسته
به دستش می دهم گل دسته دسته''',
        '''از اینجا تا ز کرمون سه گُداره
گداری اولی نقش نگاره
گداری دومی ریگش بچینی
گداری سومی نزدیک یاره''',
        '''رفته بودیم ما سه روزه
یدالله قاصدی گیوه بدوزه
گرفتم رشته ای از بچه سالی
نترسیدم که از اعضایش بسوزه''',
        '''ستاره آسمون نقش زمینه
برادر غم نخور دنیا همینه
برادر غم نخور از مال دنیا
که ثروت سایه صبح پسینه''',
        '''سرا گَرمه بدیدم قد به قدی
بدیدم سر به ناز با شیر مردی
که در خونه رضا وادار کردم
خدایا تا بنوشم آب سردی''',
        '''به توی کوچ باغ دادی به من گل
گلی همرنگ، هم بوی خودت گل
گلا دادی و گفتی تو کلات کن
کلاه من نداره قابل گل''',
        '''عزیزم شاخه گل خم نمی شه
نصیب تو و اون پا هم نمی شه
نصیب تو به اون کار خداهه
چه سازم که خدا راضی نمی شه''',
        '''الا معصومه، عشق زارم تو کردی
درختی گل بودم خارم تو کردی
درختی گل بودم در باغ شاهون
به خاک کوچه پامالم تو کردی''',
        '''الف بودم به رنگ دار گشتم
شکر بودم به زهر مار گشتم
گلی بودم میون شاخه گل ها
به دست تو فتادم خوار گشتم''',
        '''ستاره آسمون مِشمارم امشب
به بالینم نیا تب دارم امشب
به بالینم نیا تو کشته می شی
تموم دشمنا بیدارن امشب''',
        '''بلند بالا به بالات اومدم من
برای خال لب هات اومدم من
شنیدم خال لب ها می فروشی
خریدارش منم چند می فروشی''',
        '''به تهران اومدم من در ماه قوس
مکانی منزلم بود باغ فردوس
به پای قلعه هم قصری خرابه
دلم از بخت دیدارم کبابه''',
        '''اگر مردم نمی دونه بدونی
اگر مثل منی حالت خرابه''',
        '''به تهران اومدم من بابت کار
که بس کُن داشتم قرض بسیار
خداوندا که قرضم را ادا کن
در خونه ما نیاید یک طلبکار''',
        '''قدی شه مال داره فاطمه گل
به سینه نار داره فاطمه گل
اگه مردم نمی دوند بدوند
منو بیمار داره فاطمه گل''',
        '''عزیز و شاخه گل خم نمی شه
نصیب تو و اون پا هم نمی شه
نصیب تو و اون کار خداهه
چه سازم که خدا راضی نمی شه''',
      ],
    ),
    // ==================== بتول نجفی (صفر) ====================
    OldPoet(
      name: 'بتول نجفی (صفر)',
      imageUrl: 'assets/images/poets/btoul_najafi.jpg',
      poems: [
        '''سَرِ دستت حنا کن اومدم من
برو رو بون نگا کن اومدم من
شنیدم که دلی تو غم گرفته
غمش از دل به درکن اومدم من''',
        '''گلی سرخ سفیدم دونه دونه
بیا عمرم بیا رودم به خونه
دو چشم دارم به دنبالت فرستم
نمی‌تونم بشینم توی خونه''',
        '''یارم نشسته توی خرمن
نمی دانم چه گیله داره از من
ببرد از کدخدای ده بپرسد
مگه یاری گرفته بهتر از من''',
        '''چشمم به سر گدار تا کی باشه
دو دیده به انتظار تا کی باشه
دو دیده به انتظار تا ماه ششم
این ماه ششم شماره تا کی باشه''',
        '''آنجا که تویی مگه قلم کاغذ نیست
سیرم شده ای یا به منت حاجات نیست
سیرم شده ای نامه سیری بفرست
ای عمر عزیز که بیش از این طاقت نیست''',
        '''آنجا که تویی مگر زمین یمن است
سر ریزه کاغذی به سیصد تومنه
کاغذ به عراق و مُرکّب به عراق
گویا که نویسنده به بین الحزنه''',
        '''پسیمی الودا گفتیم و رفتیم
دل از دلبر جدا گفتیم و رفتیم
ندارم توشه راه بیابون
توکل بر خدا گفتیم و رفتیم''',
        '''معصومه عشق زارم تو کردی
درخت گل بودم خوارم تو کردی
درخت گل بودم در باغ شاهان
به خاک کوچه پامالم تو کردی''',
        '''عاشقم کردی منا دیوانه رسوا مکن
یار نو برگرفته ای اما که ترک ما نکن
یار نو برگرفته ای اون هم چون گل ما هم چون خار
خواری ما را به گل‌های سحر سودا مکن''',
      ],
    ),
    // ==================== شهربانو دانا (روشنعلی) ====================
    OldPoet(
      name: 'حاج شهربانو دانا (روشنعلی)',
      imageUrl: 'assets/images/poets/shahrbano_dana.jpg',
      poems: [
        '''گل به گل گردم و تعریف کنم نازکی روی تورا
آنچه من غنچه بچینم ندهد بوی تورا
یا خدا مهر تورا از دل من دور کند
یا خدا تورا ماهی بسازه به سرمنزل ما''',
        '''قدت از دور میبینم بسم نیست
به جایی رفته ای که دسترسم نیست
به جایی رفته ای که گل بچینی
که هر چه گل بچینی من بسم نیست''',
        '''غریبی رفتم مثل وطن نیست
به غم‌ خوردن کسی مانند من نیست
اگر شط و شکر نوشتم ز غربت
به مانند گدایی در وطن نیست''',
        '''در اون روزی که اسم من دراومد
خیال کردی که آسمون بر سر اومد
نه یک ماه و نه دوماه و نه سه ماه
چطور من تاب بیارم ۲۴ ماه''',
        '''گَهی درخور و گهی در دادکینم
گهی در سرحد کوی بهینم
گهی جولان زنم در دشت ایراج
بِرَم در باغ اردیب گل بچینم''',
        '''عزیزم اشرفی نارو نمیشه
بزرگی از قبای نو نمیشه
اگر صد سال گندم خوار گردد
که گندم گندمه به جو نمیشه''',
        '''خودم اینجا دلم در پیش دلبر
خدایا این سفر کی میرسه سر
خدایا این سفر آسان بگردان
ببینم بار دیگر روی دلبر''',
        '''سحرگاهی رسیدم بر سر پل
قدمگاه علی با صمع و بلبل
عرق بر سینه صاف محمد
چکیده بر زمین و سر زده گل''',
        '''سر کوه بلند پر خلاشه
بگیرم دختری از هر که باشه
بگیرم دختری از میر و میرزا
کمر باریک و چهارده ساله باشه''',
        '''شب چهارشنبه بود و چهارده ماه
نیت کردم که بنشینم سر راه
نیت نکن و ننشین بر سر راه
که یارت میرسه امروز تا فردا''',
        '''زمین را زیر پا می بینم امشب
ستاره در هوا می بینم امشب
اگر مردم نمی دوند بدوند
که یار از خود جدا میبینم امشب''',
        '''ستاره در هوا نقش زمینه
خودم انگشتر یارم نگینه
خداوندا نگهدار نگین باش
که یار اول و آخر همینه''',
        '''از اینجا تا انارک سه گداره
گدار اولیش نقش و نگاره
گدار دومش مخمل بپوشد
گدار سومش نزدیک یاره''',
        '''از کوچه دراومدی و سیبم دادی
هم رنگ خودت سرخ و سفیدم دادی
آن سیب که داده ای هنوزش دارم
بر نقره فروختم و عزیزش دارم''',
        '''نه اینجایی نه آنجایی کجایی
یقینم شد که تو در بین راهی
خریدم چکمه زرد طلایی
که بر پایت زنی زودی بیایی''',
        '''اَلا دختر که شاه دخترانی
انار مِی خوش مازندرانی
هنوزم غنچه ایی پنج بوس به من ده
که فردا گل میشی از دیگرانی''',
        '''شب چهارشنبه از ایراج بار کردم
چه بد کردم که پشت بر یار کردم
نشستم بر سر آب صفاهان
نشستم گربه بسیار کردم''',
        '''برانید تا برانید گله ها را
که برف اومد گرفت سرکله ها را
برد محکم ببندد در دروازه ها را
که فرداست می برند نجمای ما را''',
        '''خداوندا دلم یاد وطن کرد
نمی‌دونم وطن کی یاد من کرد
نمی‌دونم پدر بود یا برادر
خوشش باشد که آنکس یاد من کرد''',
        '''خوشا روزی که با هم می نشستیم
قلم بر دست و کاغذ می نوشتیم
قلم بر دست کاغذ باد برداشت
مگر طرح جدایی می نوشتیم''',
        '''عزیزم شهربانو نام داره
بدستش ترکه بادام داره
بدستش ترکه بادام باغی
خودش عاشق مرا بدنام داره''',
        '''سیاه دومبی که گندم پاک میکرد
مرا میدید گریبان چاک میکرد
مرا می دید اشک از دیده می ریخت
که با دستمال کتانش پاک میکرد''',
        '''درخت آلبالو می شوم من
کنیز شهربانو میشوم من
درآن وقتی که از حموم در آیه
جلویش آب و جارو میشوم من''',
        '''الا ای معصومه عناب و رنگم
بده مویت ببندم بر تفنگم
بده مویت برای یادگاری
که هر جا می روی یاد من آیی''',
      ],
    ),
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'اشعار قدیم ایراج';
  
  @override
  String get pageSubtitle => 'اشعار و ترانه‌های محلی روستا';
  
  @override
  String get pageCategory => 'فرهنگی';
  
  @override
  IconData get pageIcon => Icons.music_note;
  
  @override
  Widget get pageWidget => const OldPoemsPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام اشعار و نام شاعران
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('اشعار قدیم روستای ایراج:');
    fullText.writeln();
    
    for (var poet in oldPoets) {
      fullText.writeln('--- ${poet.name} ---');
      for (var poem in poet.poems) {
        fullText.writeln(poem);
        fullText.writeln();
      }
      fullText.writeln();
    }
    
    return fullText.toString();
  }

  @override
  void initState() {
    super.initState();
    registerForSearch();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    super.dispose();
  }

  // ============================================================
  // بقیه کدهای UI (بدون تغییر)
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📜 اشعار قدیم ایراج',
          style: TextStyle(
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // ===== متن توضیحی =====
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber[50]!, Colors.amber[100]!],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber[300]!, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber[800],
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'درباره این اشعار',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[800],
                        fontFamily: 'Vazir',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'این اشعار سال‌های سال بین مردم نقل قول می‌شود، لیکن شاعر آن مشخص نمی‌باشد. در قدیم بسیاری از مردم طبع شعر داشته اند و این اشعار در مناسبت‌ها( عروسی ها و...) سراییده شده است که صرفاً نام نقل‌قول‌کنندگان آن در زیر آمده است.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.8,
                    color: Colors.brown[700],
                    fontFamily: 'Vazir',
                  ),
                ),
              ],
            ),
          ),

          // ===== لیست اشعار =====
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: oldPoets.length,
              itemBuilder: (context, index) {
                final poet = oldPoets[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OldPoemDetailPage(poet: poet),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? Colors.blue[50] : Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green[100],
                            border: Border.all(color: Colors.green[300]!, width: 1.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              poet.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.green[100],
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.green[700],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                poet.name,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF263238),
                                  fontFamily: 'Vazir',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${poet.poems.length} شعر',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                  fontFamily: 'Vazir',
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 14,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== صفحه جزئیات اشعار قدیم ====================
class OldPoemDetailPage extends StatefulWidget {
  final OldPoet poet;

  const OldPoemDetailPage({
    super.key,
    required this.poet,
  });

  @override
  State<OldPoemDetailPage> createState() => _OldPoemDetailPageState();
}

class _OldPoemDetailPageState extends State<OldPoemDetailPage> {
  Map<int, bool> poemExpandedState = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.poet.name,
          style: const TextStyle(
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== عکس شاعر =====
            Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green[300]!, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  widget.poet.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.green[100],
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.green[700],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ===== نام شاعر =====
            Text(
              widget.poet.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vazir',
                color: Color(0xFF263238),
              ),
            ),
            const SizedBox(height: 20),

            // ===== شمارش تعداد اشعار =====
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, color: Colors.green[700], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'مجموعه ${widget.poet.poems.length} شعر',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                      fontFamily: 'Vazir',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== نمایش هر شعر در یک کادر جداگانه =====
            ...widget.poet.poems.asMap().entries.map((entry) {
              final index = entry.key;
              final poem = entry.value;
              final isExpanded = poemExpandedState[index] ?? false;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPoemCard(
                  poem: poem,
                  title: 'شعر ${index + 1}',
                  isExpanded: isExpanded,
                  onToggle: () {
                    setState(() {
                      poemExpandedState[index] = !isExpanded;
                    });
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPoemCard({
    required String poem,
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    final lines = poem.split('\n').where((line) => line.trim().isNotEmpty).toList();
    final shouldShowExpandButton = lines.length > 8;
    final displayedLines = isExpanded ? lines : (shouldShowExpandButton ? lines.take(8).toList() : lines);

    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple[200]!, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ===== عنوان شعر =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontFamily: 'Vazir',
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Icon(
              Icons.format_quote,
              size: 24,
              color: Colors.purple,
            ),

            const SizedBox(height: 8),

            // ===== بیت‌های شعر =====
            ..._buildPoemLines(displayedLines, isExpanded && shouldShowExpandButton),

            const SizedBox(height: 8),

            const Icon(
              Icons.format_quote,
              size: 24,
              color: Colors.purple,
            ),

            // ===== دکمه نمایش بیشتر/کمتر =====
            if (shouldShowExpandButton)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton.icon(
                  onPressed: onToggle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[100],
                    foregroundColor: Colors.purple[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                  ),
                  label: Text(
                    isExpanded ? 'نمایش کمتر' : 'نمایش بیشتر',
                    style: const TextStyle(
                      fontFamily: 'Vazir',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPoemLines(List<String> lines, bool isExpanded) {
    List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final textAlign = i % 2 == 0 ? TextAlign.right : TextAlign.left;

      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            line,
            textAlign: textAlign,
            style: const TextStyle(
              fontSize: 15,
              height: 1.8,
              color: Color(0xFF4A148C),
              fontFamily: 'Vazir',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      if (!isExpanded && i == lines.length - 1 && lines.length > 8) {
        widgets.add(
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.purple,
                fontFamily: 'Vazir',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }
}