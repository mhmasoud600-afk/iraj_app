// lib/development_page.dart
import 'package:flutter/material.dart';
import '../settings/app_settings.dart';
import '../mixins/searchable_mixin.dart'; // اضافه شد

class DevelopmentPage extends StatefulWidget {
  const DevelopmentPage({Key? key}) : super(key: key);

  @override
  State<DevelopmentPage> createState() => _DevelopmentPageState();
}

class _DevelopmentPageState extends State<DevelopmentPage> with SettingsAwareWidget, SearchableMixin {
  
  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'چشم‌انداز توسعه روستا';
  
  @override
  String get pageSubtitle => 'طرح‌ها و برنامه‌های توسعه روستا';
  
  @override
  String get pageCategory => 'توسعه';
  
  @override
  IconData get pageIcon => Icons.bar_chart;
  
  @override
  Widget get pageWidget => const DevelopmentPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو از همه بخش‌ها
    // ============================================================
    StringBuffer fullText = StringBuffer();
    
    // اضافه کردن متن‌های کشاورزی
    fullText.writeln('کشاورزی و باغداری:');
    for (var section in agricultureSections.keys) {
      fullText.writeln('--- $section ---');
      for (var detail in agricultureSections[section]!['details'] as List<String>) {
        fullText.writeln(detail);
      }
      fullText.writeln();
    }
    
    // اضافه کردن متن‌های گیاهان دارویی
    fullText.writeln('گیاهان دارویی:');
    for (var section in herbalSections.keys) {
      fullText.writeln('--- $section ---');
      for (var detail in herbalSections[section]!['details'] as List<String>) {
        fullText.writeln(detail);
      }
      fullText.writeln();
    }
    
    // اضافه کردن متن‌های گردشگری
    fullText.writeln('بوم‌گردی و گردشگری:');
    for (var section in tourismSections.keys) {
      fullText.writeln('--- $section ---');
      for (var detail in tourismSections[section]!['details'] as List<String>) {
        fullText.writeln(detail);
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
  // ========== سربرگ اول: کشاورزی و باغداری ==========
  // ============================================================
  final Map<String, Map<String, dynamic>> agricultureSections = {
    "محصولات باغی اصلی (زردآلو، سیب، آلو و...)": {
      "icon": Icons.apple,
      "color": Colors.green.shade700,
      "details": [
        "• زردآلو: یکی از محصولات اصلی باغات ایراج. ارقام شامل: زردآلوی انبه‌ای (اواسط تیر)، نوری (پایان اردیبهشت)، شاهرودی (خرداد تا تیر)، قیسی (مرداد) و جهانگیری (اواخر خرداد). برداشت از نیمه دوم اردیبهشت تا تیرماه ادامه دارد.",
        "• سیب: محصول سردسیری با قابلیت فرآوری به برگه سیب، چیپس سیب، سرکه سیب و آبمیوه طبیعی.",
        "• آلو و آلو زرد: مناسب برای تازه‌خوری و فرآوری به آلو بخارا، برگه آلو، لواشک و آلوی ترشیده.",
        "• هلو و شلیل: از محصولات هسته‌دار باغات منطقه، مناسب برای تازه‌خوری، خشک‌کردن و تهیه کمپوت.",
        "• گوجه سبز: محصول نوبرانه بهاری با بازارپسندی بالا در فصل برداشت."
      ],
    },
    "وضعیت باغات و پراکندگی جغرافیایی": {
      "icon": Icons.terrain,
      "color": Colors.green.shade700,
      "details": [
        "• باغات درجه یک: باغات واقع در حاشیه قنات‌ها و مسیل‌های فصلی که از آب شیرین بهره‌مندند.",
        "• باغات دیم: باغات کم بازده که نیاز به اصلاح و تبدیل به کشت‌های کم‌آب‌بر دارند.",
        "• پراکندگی سنتی: باغات به صورت پلکانی در دامنه کوه‌ها و اطراف قنات‌ها قرار گرفته‌اند."
      ],
    },
    "فرآوری، خشک‌کردن و بسته‌بندی": {
      "icon": Icons.factory,
      "color": Colors.green.shade700,
      "details": [
        "• خشک‌کن خورشیدی: احداث سوله‌های خشک‌کن با انرژی خورشیدی برای تولید برگه زردآلو، برگه سیب و آلو خشک با کیفیت صادراتی.",
        "• خط بسته‌بندی مدرن: ایجاد کارگاه بسته‌بندی میوه خشک با رعایت استانداردهای بهداشتی و استفاده از بسته‌بندی‌های وکیوم.",
        "• فرآوری سنتی: احیای روش‌های سنتی تولید لواشک، رب آلو، ترشک و سرکه میوه با برند محلی.",
        "• کمپوت و کنسانتره: راه‌اندازی خط تولید کمپوت میوه و کنسانتره زردآلو و سیب برای صنایع غذایی."
      ],
    },
    "برندسازی، بازاریابی و فروش": {
      "icon": Icons.shopping_cart,
      "color": Colors.green.shade700,
      "details": [
        "• برند محلی: ثبت برند 'ایراج' برای محصولات باغی با طراحی لوگو و هویت بصری منحصربه‌فرد.",
        "• فروشگاه اینترنتی: ایجاد فروشگاه در پلتفرم‌های دیجی‌کالا، باسلام و اینستاگرام برای فروش مستقیم به مصرف‌کننده.",
        "• صادرات منطقه‌ای: صادرات برگه زردآلو و آلو خشک به کشورهای حاشیه خلیج فارس و عراق.",
        "• بازارچه محلی: ایجاد بازارچه دائمی فروش محصولات باغی در مسیر گردشگری روستا.",
        "• گواهی استاندارد: اخذ سیب سلامت و نشان استاندارد برای محصولات فرآوری‌شده."
      ],
    },
    "چشم‌انداز ۵ ساله کشاورزی": {
      "icon": Icons.show_chart,
      "color": Colors.green.shade700,
      "details": [
        "• هدف ۱۴۱۰: افزایش ۵۰ درصدی درآمد باغداران از طریق فرآوری و بسته‌بندی.",
        "• ایجاد تعاونی باغداران: با عضویت ۵۰ باغدار و راه‌اندازی صندوق خرد محلی.",
        "• سردخانه: احداث سردخانه ۵۰۰ تنی برای نگهداری محصولات در خارج از فصل.",
        "• برند صادراتی: ثبت برند 'میوه‌های کویر ایراج' در بازارهای هدف."
      ],
    },
  };

  // ============================================================
  // ========== سربرگ دوم: گیاهان دارویی ==========
  // ============================================================
  final Map<String, Map<String, dynamic>> herbalSections = {
    "گونه‌های بومی قابل کشت (جدول مشخصات)": {
      "icon": Icons.local_florist,
      "color": Colors.green.shade700,
      "details": [
        "• آویشن کویری:",
        "  - خواص: ضدعفونی‌کننده قوی، خلط‌آور، ضد نفخ",
        "  - مقاومت به شوری: بالا",
        "  - نیاز آبی: کم (کاملاً سازگار با شرایط کویری)",
        "  - زمان برداشت: اواخر بهار تا اواسط تابستان",
        "• آنغوزه (هنگ):",
        "  - خواص: ضدنفخ، ضداسپاسم، قاعده‌آور",
        "  - مقاومت به شوری: بسیار بالا",
        "  - نیاز آبی: بسیار کم (کشت دیم)",
        "  - عمر مفید: تا ۲۰ سال، برداشت از سال سوم یا چهارم",
        "  - صادرات: به کشورهای عربی حاشیه خلیج فارس",
        "• باریجه:",
        "  - خواص: ضدالتهاب، مسکن، ضد تشنج",
        "  - مقاومت به شوری: بالا",
        "  - نیاز آبی: کم",
        "• خارشتر:",
        "  - خواص: مدر، ضدسنگ کلیه، ضد ویروس",
        "  - مقاومت به شوری: بسیار بالا",
        "  - نیاز آبی: بسیار کم",
        "• گل گاوزبان ایرانی:",
        "  - خواص: آرام‌بخش، ضداضطراب، تصفیه خون",
        "  - مقاومت به شوری: متوسط",
        "  - نیاز آبی: متوسط",
        "• سیاه‌دانه:",
        "  - خواص: تقویت سیستم ایمنی، ضدآلرژی",
        "  - مقاومت به شوری: متوسط",
        "  - نیاز آبی: کم",
        "• رازیانه:",
        "  - خواص: هورمونی، شیرافزا، ضد نفخ",
        "  - مقاومت به شوری: متوسط",
        "  - نیاز آبی: کم"
      ],
    },
    "کشت‌های جدید و اقتصادی (زعفران، قدومه، زیره)": {
      "icon": Icons.agriculture,
      "color": Colors.green.shade700,
      "details": [
        "• زعفران:",
        "  - محصول کم‌آب‌بر با ارزش افزوده بالا (هر کیلو تا ۸۰ میلیون تومان)",
        "  - مناسب برای مزارع کوچک با مساحت ۵۰۰ تا ۱۰۰۰ متر",
        "  - کشت در ماه‌های شهریور و مهر، برداشت در آبان",
        "  - نیاز آبی بسیار کم (فقط ۳ نوبت آبیاری در سال)",
        "• قدومه شیرازی (تخمه سرخو):",
        "  - خواص درمانی: ضدسرماخوردگی، ضد سرفه، ضد التهاب گلو",
        "  - کشت دیم در زمین‌های کم‌بازده",
        "  - زمان کاشت: پاییز، برداشت: اواخر بهار",
        "  - بازارپسندی بالا در طب سنتی",
        "• زیره سیاه:",
        "  - گیاهی کم‌توقع با سوددهی بالا (حدود ۱۵۰ میلیون تومان در هکتار)",
        "  - کشت دیم یا آبیاری محدود",
        "  - زمان کاشت: پاییز، برداشت: اواخر بهار",
        "  - کاربرد: صنایع دارویی، غذایی و ادویه‌جات",
        "• افزایش برداشت آویشن:",
        "  - توسعه کشت آویشن کویری در ۱۰ هکتار از اراضی شیبدار",
        "  - برداشت انبوه برای فرآوری و صادرات"
      ],
    },
    "فرآوری گیاهان دارویی (عرق‌گیری، خشک‌کنی)": {
      "icon": Icons.opacity,
      "color": Colors.green.shade700,
      "details": [
        "• عرق‌گیری سنتی و صنعتی:",
        "  - ایجاد کارگاه عرق‌گیری برای تولید عرق باریجه، عرق آنغوزه، عرق آویشن",
        "  - استفاده از دیگ‌های سنتی برای حفظ کیفیت و خواص درمانی",
        "  - بسته‌بندی در بطری‌های شیشه‌ای با برچسب برند محلی",
        "• خشک‌کنی گیاهان:",
        "  - احداث خشک‌کن خورشیدی با ظرفیت ۵ تن در سال",
        "  - خشک‌کردن آویشن، زیره، گل گاوزبان در دمای کنترل‌شده",
        "  - بسته‌بندی در پاکت‌های وکیوم و جعبه‌های شکیل",
        "• پودر و عصاره:",
        "  - تولید پودر آویشن و پودر آنغوزه برای صنایع غذایی",
        "  - استخراج عصاره به روش سنتی (جوشاندن و تغلیظ)",
        "  - بسته‌بندی در شیشه‌های قطره‌ای برای مصارف درمانی"
      ],
    },
    "برندسازی، بسته‌بندی و فروش اینترنتی": {
      "icon": Icons.shopping_bag,
      "color": Colors.green.shade700,
      "details": [
        "• برند محلی: ثبت برند 'گیاهان کویر ایراج' با طراحی لوگو و هویت بصری منحصربه‌فرد.",
        "• بسته‌بندی استاندارد:",
        "  - طراحی پاکت‌های کاغذی کرافت با طرح‌های سنتی",
        "  - درج اطلاعات تغذیه‌ای، خواص درمانی و تاریخ تولید و انقضا",
        "  - استفاده از بسته‌بندی‌های شفاف برای نمایش کیفیت محصول",
        "• فروش در دیجی‌کالا:",
        "  - ثبت فروشگاه رسمی در پلتفرم دیجی‌کالا برای فروش گیاهان دارویی",
        "  - ارسال به سراسر کشور با بسته‌بندی استاندارد",
        "  - دریافت نظرات و امتیازات مثبت از مشتریان",
        "• فروش در اینستاگرام و باسلام:",
        "  - ایجاد صفحه اینستاگرامی با محتوای آموزشی و تبلیغاتی",
        "  - فروش در پلتفرم باسلام به دلیل مخاطبان هدفمند محصولات طبیعی",
        "  - همکاری با اینفلوئنسرهای حوزه طب سنتی و سلامت",
        "• صادرات آنغوزه:",
        "  - صادرات شیره آنغوزه به کشورهای عربی حاشیه خلیج فارس",
        "  - بسته‌بندی ویژه صادراتی با برند بین‌المللی"
      ],
    },
    "چشم‌انداز ۵ ساله گیاهان دارویی": {
      "icon": Icons.auto_awesome,
      "color": Colors.green.shade700,
      "details": [
        "• هدف ۱۴۱۰: تبدیل ایراج به قطب گیاهان دارویی شرق اصفهان",
        "• سطح زیر کشت: ۲۰ هکتار گیاهان دارویی (آویشن، آنغوزه، زیره، زعفران)",
        "• اشتغال‌زایی: ایجاد ۱۵ شغل پایدار برای زنان و جوانان روستا",
        "• کارگاه فرآوری: احداث کارگاه نیمه‌صنعتی خشک‌کنی و عرق‌گیری",
        "• برند صادراتی: ثبت برند 'Herbs of Iraj' برای صادرات به کشورهای حوزه خلیج فارس",
        "• فروش آنلاین: کسب رتبه برتر فروش گیاهان دارویی در دیجی‌کالا"
      ],
    },
  };

  // ============================================================
  // ========== سربرگ سوم: بوم‌گردی و گردشگری ==========
  // ============================================================
  final Map<String, Map<String, dynamic>> tourismSections = {
    "جاذبه‌های طبیعی": {
      "icon": Icons.nature,
      "color": Colors.green.shade700,
      "details": [
        "• نخلستان‌های کویری: قدیمی‌ترین نخل‌های ایراج با قدمت بیش از ۲۰۰ سال، چشم‌انداز منحصربه‌فرد کویری.",
        "• تپه‌های ماسه‌ای و کویر بکر: ظرفیت برگزاری تورهای کویرنوردی، شترسواری، آفرود و شب‌مانی در کویر.",
        "• قنات تاریخی ایراج: با بیش از ۵ رشته میله‌چاه فعال، جاذبه‌ای برای گردشگران علاقه‌مند به معماری سنتی آبی.",
        "• آسمان شب کویر: پتانسیل برگزاری تورهای نجومی و رصد ستارگان با کمترین آلودگی نوری.",
        "• باغات و مزارع: چشم‌انداز باغات زردآلو و سیب در فصل بهار و تابستان."
      ],
    },
    "جاذبه‌های تاریخی و معماری": {
      "icon": Icons.account_balance,
      "color": Colors.green.shade700,
      "details": [
        "• قلعه ایراج (ثبت ملی): مرمت و احیای قلعه تاریخی ایراج با مشارکت میراث فرهنگی و استفاده از مصالح سنتی (خشت و گل) به عنوان یک قطب جذب گردشگر.",
        "• مسجد کهنه ایراج: با معماری خشتی و گلی، متعلق به دوره قاجار. دارای شبستان ستون‌دار و نورگیرهای سنتی.",
        "• خانه‌های تاریخی: نمونه‌هایی از خانه‌های کویری با بادگیر، ایوان و درهای چوبی منبت‌کاری‌شده.",
        "• آسیاب قدیمی: بقایای یک آسیاب آبی در حاشیه قنات که قابلیت مرمت و احیا دارد.",
        "• بافت تاریخی: کوچه‌های تنگ و باریک با معماری سنتی کویری، نیازمند مرمت و سنگ‌فرش."
      ],
    },
    "توسعه بوم‌گردی و اقامتگاه‌ها": {
      "icon": Icons.house,
      "color": Colors.green.shade700,
      "details": [
        "• ایجاد اقامتگاه‌های بوم‌گردی:",
        "  - راه‌اندازی حداقل ۲ اقامتگاه بوم‌گردی جدید در بافت تاریخی روستا",
        "  - مرمت خانه‌های قدیمی با حفظ معماری سنتی و امکانات مدرن",
        "  - هر اقامتگاه با ظرفیت ۵ تا ۱۰ گردشگر",
        "• آموزش جامعه محلی:",
        "  - دوره‌های آموزشی مهمان‌داری و پذیرایی برای زنان روستا",
        "  - آموزش راهنمایان محلی گردشگری (تور کویر، تور نجوم، تور کشاورزی)",
        "  - آموزش بهداشت گردشگری و طبخ غذاهای محلی",
        "• تجربه‌های بوم‌گردی:",
        "  - برگزاری تورهای کویرگردی با راهنمای محلی",
        "  - برگزاری کارگاه‌های حصیربافی برای گردشگران",
        "  - پخت نان محلی و غذاهای سنتی در حضور گردشگران",
        "  - شب‌نشینی در کویر و رصد ستارگان"
      ],
    },
    "توسعه زیرساخت‌های گردشگری": {
      "icon": Icons.construction,
      "color": Colors.green.shade700,
      "details": [
        "• بازسازی بافت قدیم:",
        "  - سنگ‌فرش کوچه‌های بافت تاریخی با مصالح همگن",
        "  - بهسازی معابر و ایجاد مسیر گردشگری پیاده",
        "  - نصب تابلوهای راهنما و معرفی اماکن تاریخی",
        "• ایجاد بازارچه محلی صنایع دستی:",
        "  - احداث غرفه‌های فروش محصولات حصیربافی، گیاهان دارویی و محصولات باغی",
        "  - فروش سوغات و صنایع دستی در مسیر گردشگری",
        "• راه‌اندازی اینترنت پرسرعت:",
        "  - ایجاد زیرساخت فیبر نوری برای رفاه گردشگران",
        "  - امکان رزرواسیون آنلاین اقامتگاه‌ها",
        "• بهسازی جاده دسترسی:",
        "  - آسفالت و تعریض جاده روستا",
        "  - نصب تابلوهای راهنما در مسیرهای منتهی به روستا"
      ],
    },
    "مسیرهای گردشگری پیشنهادی": {
      "icon": Icons.route,
      "color": Colors.green.shade700,
      "details": [
        "• مسیر 'از نخل تا حصیر':",
        "  - بازدید از نخلستان‌های قدیمی",
        "  - مشاهده برداشت برگ خرما",
        "  - شرکت در کارگاه حصیربافی و خرید مستقیم صنایع دستی",
        "• مسیر 'قلعه و کوچه‌های تاریخی':",
        "  - بازدید از قلعه ثبت ملی ایراج",
        "  - گردش در بافت تاریخی و خانه‌های بادگیر",
        "  - بازدید از مسجد کهنه و آسیاب آبی",
        "• مسیر 'کویر و آسمان':",
        "  - تور غروب‌گردی در تپه‌های ماسه‌ای",
        "  - شام در اقامتگاه بوم‌گردی",
        "  - رصد ستارگان با تلسکوپ و آموزش نجوم"
      ],
    },
    "بازاریابی دیجیتال و برندسازی گردشگری": {
      "icon": Icons.laptop,
      "color": Colors.green.shade700,
      "details": [
        "• برند مقصد گردشگری: ثبت برند 'ایراج؛ نگین کویر مرکزی'",
        "• فعالیت در شبکه‌های اجتماعی:",
        "  - ایجاد صفحه اینستاگرام برای معرفی جاذبه‌ها",
        "  - انتشار محتوای تصویری و ویدیویی با کیفیت",
        "  - همکاری با بلاگرهای سفر و طبیعت‌گردی",
        "• سایت رسمی گردشگری ایراج:",
        "  - طراحی وب‌سایت چندزبانه با قابلیت رزرو آنلاین",
        "  - معرفی اقامتگاه‌ها، جاذبه‌ها و برنامه‌های گردشگری",
        "  - فروش اینترنتی صنایع دستی و محصولات محلی",
        "• تور مجازی کویر: استفاده از پهپاد برای ساخت فیلم‌های ۳۶۰ درجه از جاذبه‌های ایراج",
        "• همکاری با آژانس‌های مسافرتی: طراحی تورهای یک روزه و دو روزه به مقصد ایراج"
      ],
    },
    "چشم‌انداز ۵ ساله گردشگری": {
      "icon": Icons.flag,
      "color": Colors.green.shade700,
      "details": [
        "• هدف ۱۴۱۰: تبدیل ایراج به مقصد شاخص گردشگری کویری و تاریخی در شرق استان اصفهان",
        "• افزایش گردشگر: جذب ۵۰۰۰ گردشگر در سال (از ۵۰۰ نفر فعلی)",
        "• اشتغال‌زایی: ایجاد ۳۰ شغل مستقیم در حوزه گردشگری و بوم‌گردی",
        "• اقامتگاه‌ها: راه‌اندازی ۳ اقامتگاه بوم‌گردی فعال",
        "• رویدادها: برگزاری سالانه جشنواره خرما و صنایع دستی در مرداد و شهریور",
        "• بازسازی: مرمت کامل قلعه ایراج و سنگ‌فرش ۵۰٪ از بافت تاریخی"
      ],
    },
  };

  // ============================================================
  // بقیه کدهای UI (بدون تغییر)
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: settings.pageBackgroundColor,
          appBar: AppBar(
            title: Text(
              "چشم‌انداز توسعه روستای ایراج",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: settings.isDarkMode ? Colors.white : Colors.black87,
                fontFamily: settings.mainFontFamily,
                fontSize: settings.mainFontSize + 2,
              ),
            ),
            backgroundColor: settings.appBarColor,
            elevation: 1,
            bottom: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.black87,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(
                fontFamily: settings.mainFontFamily,
                fontSize: settings.buttonFontSize,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: settings.mainFontFamily,
                fontSize: settings.buttonFontSize - 2,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: "🌾 کشاورزی و باغداری"),
                Tab(text: "🌿 گیاهان دارویی"),
                Tab(text: "🏕️ بوم‌گردی و گردشگری"),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabContent(
                      imagePath: "assets/images/agriculture.jpg",
                      title: "کشاورزی و باغداری",
                      subtitle: "زردآلو، سیب، آلو | فرآوری، بسته‌بندی، برندسازی و فروش",
                      sections: agricultureSections,
                    ),
                    _buildTabContent(
                      imagePath: "assets/images/herbal.jpg",
                      title: "گیاهان دارویی",
                      subtitle: "آویشن، آنغوزه، زعفران | فرآوری، برندسازی، فروش در دیجی‌کالا",
                      sections: herbalSections,
                    ),
                    _buildTabContent(
                      imagePath: "assets/images/tourism.jpg",
                      title: "بوم‌گردی و گردشگری",
                      subtitle: "قلعه ثبت ملی، اقامتگاه‌ها، تورهای کویر، توسعه زیرساخت‌ها",
                      sections: tourismSections,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent({
    required String imagePath,
    required String title,
    required String subtitle,
    required Map<String, Map<String, dynamic>> sections,
  }) {
    final Color textColor = settings.mainTextColor;
    final Color secondaryColor = settings.isDarkMode ? Colors.white70 : Colors.grey.shade700;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                height: 200,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: settings.isDarkMode ? Colors.grey[800] : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: secondaryColor,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "تصویر $title",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: settings.mainFontSize,
                            fontFamily: settings.mainFontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: settings.mainFontSize + 6,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: settings.mainFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: settings.mainFontSize - 2,
                    color: secondaryColor,
                    fontStyle: FontStyle.italic,
                    fontFamily: settings.mainFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Divider(
              thickness: 2,
              color: settings.primaryColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: sections.length,
            itemBuilder: (context, index) {
              String sectionTitle = sections.keys.elementAt(index);
              var sectionData = sections[sectionTitle]!;
              return _buildSectionCard(sectionTitle, sectionData);
            },
          ),
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: settings.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: settings.primaryColor.withOpacity(0.3)),
            ),
            child: Text(
              "افق ۱۴۰۵ تا ۱۴۱۰: $title با مشارکت دهیاری، شورا و سرمایه‌گذاران محلی.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: settings.mainFontSize - 2,
                color: textColor,
                fontWeight: FontWeight.w500,
                fontFamily: settings.mainFontFamily,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, Map<String, dynamic> data) {
    final Color textColor = settings.mainTextColor;
    final Color cardColor = settings.isDarkMode ? Colors.grey[850]! : Colors.white;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: (data['color'] as Color).withOpacity(0.2),
          child: Icon(
            data['icon'] as IconData,
            color: settings.primaryColor,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: settings.mainFontSize,
            color: textColor,
            fontFamily: settings.mainFontFamily,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: settings.primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (data['details'] as List<String>).map((detail) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    detail,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.6,
                      fontSize: settings.mainFontSize - 2,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: settings.mainFontFamily,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}