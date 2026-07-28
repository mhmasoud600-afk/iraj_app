
// medicinal_plants_page.dart
import 'package:flutter/material.dart';

class MedicinalPlantsPage extends StatefulWidget {
  const MedicinalPlantsPage({Key? key}) : super(key: key);

  @override
  State<MedicinalPlantsPage> createState() => _MedicinalPlantsPageState();
}

class _MedicinalPlantsPageState extends State<MedicinalPlantsPage> {
  String searchText = "";

  // لیست گیاهان دارویی با اطلاعات کامل
  final List<Map<String, dynamic>> plants = [
    {
      'title': 'زیره سیاه',
      'icon': Icons.grass,
      'imagePath': 'assets/images/black_cumin.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'زیره سیاه یکی از گیاهان بومی آسیا است که به خاطر عطر و مزه منحصر به فرد در انواع غذاها به کار می‌رود. این گیاه در مناطق کویری اطراف ایراج به وفور یافت می‌شود. زیره سیاه دارای طبع گرم و خشک است. دانه‌های زیره سیاه کوچک‌تر از زیره سبز بوده و طعم تندتری دارند.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• تسکین دهنده مشکلات شکمی و ضد نفخ قوی\n• کمک به هضم غذا و افزایش آنزیم‌های گوارشی\n• درمان سرفه خشک به عنوان ضد سرفه\n• ضد اسپاسم و تسکین دهنده گرفتگی عضلات\n• مفید برای سلامت قلب به دلیل داشتن پتاسیم\n• کاهش دهنده کلسترول بد خون\n• ادرار آور و کمک به عفونت‌های دستگاه ادراری\n• محرک و کاهش دهنده افسردگی و خستگی\n• افزایش دهنده اشتها\n• ضد عفونی کننده و التیام بخش زخم‌ها\n• کاهش التهاب و پف پوست\n• مبارزه با پیری پوست و کاهش چین و چروک\n• درمان شوره سر و تقویت مو'
        },
        {
          'title': '⚠️ موارد احتیاط',
          'content': 'زنان باردار باید از زیره بسیار کم استفاده کنند. افراد دیابتی باید با احتیاط مصرف کنند. اگر قرار است جراحی انجام دهید، حداقل دو روز پیش از جراحی مصرف را قطع کنید. مصرف بیش از حد زیره ممکن است باعث سوزش معده شود.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: صنایع غذایی، داروسازی، آرایشی و بهداشتی\n• ارزش افزوده: تولید اسانس زیره، بسته‌بندی شکیل برای صادرات\n• فرآوری: تولید عرق زیره، پودر زیره، کپسول‌های گیاهی\n• بسته‌بندی: بسته‌های ۵۰، ۱۰۰ و ۵۰۰ گرمی با طراحی سنتی\n• صادرات: بازارهای هدف شامل کشورهای حاشیه خلیج فارس، اروپا و آمریکا\n• اشتغال‌زایی: ایجاد کسب‌وکار برای زنان روستایی در زمینه فرآوری و بسته‌بندی\n• برندینگ: ثبت برند "زیره ایراج" با نشان جغرافیایی'
        }
      ]
    },
    {
      'title': 'آویشن (اوشون)',
      'icon': Icons.local_florist,
      'imagePath': 'assets/images/thyme.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'آویشن گیاهی مدیترانه‌ای با طبع گرم و خشک است که در مناطق کویری اطراف ایراج می‌روید. گل، برگ و روغن آویشن برای درمان طیف وسیعی از علائم و بیماری‌ها استفاده می‌شود. آویشن حاوی تیمول و کارواکرول است که خاصیت ضدعفونی‌کننده و ضدباکتریایی دارند. نام علمی آن Thymus vulgaris است.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• درمان عفونت‌های تنفسی و برونشیت\n• خلط آور طبیعی برای درمان سرفه\n• موثر در کاهش علائم کرونا\n• ضد عفونت گلو و التهاب لوزه\n• درمان سرماخوردگی و آبریزش بینی\n• بهبود گرفتگی بینی\n• کمک به هضم غذا و درمان نفخ معده\n• تسکین دل درد، دل پیچه و اسهال\n• درمان حالت تهوع و استفراغ\n• موثر در درمان عفونت واژن\n• کاهش فشار خون به دلیل داشتن پتاسیم\n• تقویت سیستم ایمنی با ویتامین‌های A و C\n• ضد پیری و رفع خشکی پوست\n• درمان آکنه و بهبود زخم‌ها\n• درمان شوره سر و ریزش مو\n• تحریک رشد مو'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه دمنوش، یک قاشق چایخوری آویشن را در آب جوش بریزید، ۱۰ دقیقه بماند و سپس صاف کنید. می‌توانید یک قطره آب لیمو به آن اضافه کنید. روزانه تا ۳ فنجان می‌توانید بنوشید. برای غرغره کردن نیز مفید است. همچنین می‌توان از آویشن به عنوان چاشنی در انواع غذاها استفاده کرد.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: صنایع داروسازی، آرایشی، غذایی\n• ارزش افزوده: تولید اسانس آویشن، عرق آویشن، کپسول و قرص\n• فرآوری: خشک کردن صنعتی، بسته‌بندی شکیل\n• بسته‌بندی: بسته‌های ۵۰ گرمی دمنوش، شیشه‌های اسانس\n• صادرات: تقاضای بالا در اروپا برای آویشن ارگانیک\n• کشت قراردادی: عقد قرارداد با شرکت‌های داروسازی برای خرید تضمینی\n• برندینگ: ثبت'

"برند آویشن کویر ایراج"
        }
      ]
    },
    {
      'title': 'تخمه سرخو (قدومه شیرازی)',
      'icon': Icons.eco,
       'imagePath': 'assets/images/thyme1.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'قدومه شیرازی یکی از گیاهان دارویی منطقه کویری ایراج است که در طب سنتی برای درمان مشکلات تنفسی کاربرد فراوان دارد. این گیاه با نام علمی Alyssum homalocarpum شناخته می‌شود. دانه‌های آن ریز و قهوه‌ای رنگ هستند و در تماس با آب تولید لعاب می‌کنند.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• مفید برای سرفه خشک و گرفتگی صدا\n• نرم کننده گلو و التیام بخش سینه درد\n• خلط آور طبیعی\n• درمان التهاب مجاری تنفسی\n• مفید برای زخم معده\n• کاهش دهنده تب\n• ملین طبیعی\n• درمان خشکی گلو در فصل سرما'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه شربت، یک قاشق غذاخوری تخم قدومه را در یک لیوان آب جوش بریزید و بگذارید خیس بخورد تا حالت لعابی پیدا کند. سپس می‌توانید با عسل یا شکر شیرین کرده و میل کنید. بهترین زمان مصرف ناشتا یا قبل از خواب است.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: عطاری‌ها، داروخانه‌ها، صنایع نوشیدنی‌های سالم\n• ارزش افزوده: بسته‌بندی دمنوش‌های ترکیبی (قدومه + آویشن + پونه)\n• فرآوری: تولید شربت گیاهی آماده مصرف\n• بسته‌بندی: بسته‌های ۵۰ و ۱۰۰ گرمی، قاشق‌های یکبارمصرف گیاهی\n• صادرات: کشورهای حاشیه خلیج فارس\n• کشت: توسعه کشت در مزارع ایراج با آبیاری قطره‌ای\n• اشتغال‌زایی: ایجاد واحد بسته‌بندی برای زنان روستایی'
        }
      ]
    },
    {
      'title': 'تخمه سفید (اسفرزه)',
      'icon': Icons.spa,
      'imagePath': 'assets/images/psyllium.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'اسفرزه گیاهی با دانه‌های ریز و لعاب‌دار است که در مناطق کویری مانند ایراج می‌روید. این گیاه یکی از بهترین ملین‌های طبیعی محسوب می‌شود. نام علمی آن Plantago ovata است. پوسته دانه اسفرزه منبع غنی فیبر محلول است.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• ملین طبیعی و درمان یبوست\n• تنظیم کننده سیستم گوارشی\n• کاهش دهنده کلسترول خون\n• کنترل قند خون در بیماران دیابتی\n• کاهش اشتها و کمک به لاغری\n• نرم کننده دستگاه گوارش\n• درمان سندرم روده تحریک‌پذیر\n• پیشگیری از بواسیر\n• سم‌زدایی از بدن'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'یک قاشق چایخوری تخم اسفرزه را در یک لیوان آب سرد یا ولرم حل کرده و بلافاصله بنوشید. پس از مصرف، حتماً آب کافی بنوشید. بهتر است اسفرزه نیم ساعت قبل از غذا مصرف شود. مصرف منظم آن به تنظیم دستگاه گوارش کمک می‌کند.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: داروخانه‌ها، فروشگاه‌های محصولات ارگانیک، صنایع غذایی\n• ارزش افزوده: تولید پودر فیبر اسفرزه، کپسول‌های گیاهی\n• فرآوری: بسته‌بندی پوسته اسفرزه به تنهایی یا ترکیب با پروبیوتیک‌ها\n• بسته‌بندی: بسته‌های ۱۰۰ و ۲۰۰ گرمی، قاشق‌های یکبارمصرف\n• صادرات: تقاضای بالا در اروپا و آمریکا به عنوان مکمل فیبر\n• کشت: توسعه کشت در زمین‌های شور ایراج\n• برندینگ: "فیبر طبیعی ایراج" با نشان ارگانیک'
        }
      ]
    },
    {
      'title': 'خاکشیر',
      'icon': Icons.water_drop,
      'imagePath': 'assets/images/khakshir.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'خاکشیر گیاهی با طبع سرد است که در مناطق کویری مانند ایراج به خوبی رشد می‌کند. این گیاه از قدیم به عنوان خنک‌کننده طبیعی در فصل تابستان استفاده می‌شده است. نام علمی آن Descurainia sophia است. دانه‌های خاکشیر کوچک، قهوه‌ای مایل به قرمز و دارای لعاب هستند.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• خنک کننده بدن در تابستان\n• رفع عطش و تشنگی\n• درمان جوش صورت و التهابات پوستی\n• ادرارآور ملایم\n• ضد یبوست\n• درمان تبخال\n• کاهش فشار خون\n• تصفیه کننده خون\n• درمان گرمازدگی\n• کاهش حرارت کبد'
        },

{
          'title': '🍵 روش مصرف',
          'content': 'دو قاشق غذاخوری خاکشیر را در یک لیوان آب سرد ریخته، کمی شکر یا عسل اضافه کرده و میل کنید. برای رفع عطش در روزهای گرم بسیار مفید است. می‌توانید خاکشیر را با تخم شربتی، سکنجبین یا آب لیمو نیز ترکیب کنید.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: نوشیدنی‌های سالم، عطاری‌ها، فروشگاه‌های مواد غذایی\n• ارزش افزوده: تولید شربت خاکشیر آماده مصرف، پودر خاکشیر فوری\n• فرآوری: بسته‌بندی ترکیبی خاکشیر با تخم شربتی و سکنجبین\n• بسته‌بندی: بسته‌های ۲۰۰ و ۵۰۰ گرمی، بطری‌های شربت آماده\n• صادرات: کشورهای حاشیه خلیج فارس با تقاضای بالا برای شربت‌های سنتی\n• کشت: توسعه کشت در زمین‌های شور ایراج با مصرف آب کم\n• برندینگ: "شربت سنتی ایراج"'
        }
      ]
    },
    {
      'title': 'آنغوزه (هنگ)',
      'icon': Icons.medical_services,
      'imagePath': 'assets/images/anghazeh.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'آنغوزه صمغی است که از ریشه و ساقه گیاه آنغوزه (Ferula assa-foetida) استخراج می‌شود. این گیاه در مناطق کویری اطراف ایراج می‌روید. آنغوزه بوی تند و نامطبوعی دارد اما خواص درمانی بسیاری دارد. شیره آنغوزه به رنگ قهوه‌ای مایل به زرد است.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• ضد نفخ قوی و درمان کننده مشکلات گوارشی\n• ضد انگل و میکروب\n• مسکن دردهای عصبی\n• کاهش دهنده فشار خون\n• مفید برای درمان آسم و برونشیت\n• قاعده‌آور و مفید برای زنان\n• درمان روماتیسم و دردهای مفاصل\n• دافع حشرات\n• ضد تشنج\n• محرک قوای جنسی'
        },
        {
          'title': '⚠️ نکات مصرف',
          'content': 'به دلیل طعم و بوی تند آنغوزه، باید به مقدار کم مصرف شود. بهترین زمان مصرف، قبل از غذا برای باز کردن اشتها و بعد از غذا برای کمک به هضم است. زنان باردار و شیرده باید با احتیاط مصرف کنند. مصرف بیش از حد باعث تهوع و استفراغ می‌شود.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: صنایع داروسازی، عطاری‌ها، صادرات به هند و پاکستان\n• ارزش افزوده: تولید کپسول، قرص و عصاره استاندارد\n• فرآوری: تصفیه شیره آنغوزه، بسته‌بندی درجه‌بندی شده\n• بسته‌بندی: ظروف شیشه‌ای دربسته، بسته‌های وکیوم شده\n• صادرات: هند بزرگترین مصرف‌کننده آنغوزه در جهان\n• کشت: ایجاد مزارع کشت آنغوزه با روش‌های نوین\n• برندینگ: "آنغوزه کویر ایراج" با نشان کیفیت'
        }
      ]
    },
    {
      'title': 'بنه (میوه درخت بنه)',
      'icon': Icons.food_bank,
      'imagePath': 'assets/images/benne.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'بنه میوه درخت بنه (پسته وحشی) است که در مناطق کویری و کوهپایه‌ای اطراف ایراج می‌روید. این میوه خوراکی و بسیار مقوی، طعمی منحصر به فرد دارد و از دیرباز در تغذیه مردم منطقه جایگاه ویژه‌ای داشته است. بنه را به عنوان یک میان‌وعده مغذی و انرژیزا مصرف می‌کنند. درخت بنه مقاوم به خشکی و شوری است.'
        },
        {
          'title': '💊 ارزش غذایی و خواص',
          'content': 'بنه سرشار از پروتئین، چربی‌های سالم، فیبر، ویتامین E و گروه B، املاحی مانند پتاسیم، منیزیم، آهن و کلسیم است. به دلیل داشتن آنتی‌اکسیدان‌ها، ضد التهاب بوده و برای سلامت قلب و عروق مفید است. مصرف بنه انرژی‌زا بوده و به رفع خستگی کمک می‌کند.\n• تقویت‌کننده عمومی بدن\n• افزایش دهنده انرژی و رفع خستگی\n• مفید برای سلامت قلب و عروق\n• کمک به درمان کم‌خونی به دلیل داشتن آهن\n• تقویت سیستم ایمنی بدن\n• مفید برای سلامت پوست و مو به دلیل داشتن ویتامین E\n• کمک به بهبود عملکرد مغز و اعصاب'
        },
        {
          'title': '🍽️ روش مصرف',
          'content': 'بنه به صورت خام و بو داده مصرف می‌شود. معمولاً آن را مانند پسته و بادام به عنوان میان‌وعده یا همراه با تنقلات دیگر سرو می‌کنند. بنه بوداده با کمی نمک طعم دلپذیری پیدا می‌کند. در برخی مناطق از بنه در تهیه غذاهای سنتی و شیرینی‌های محلی نیز استفاده می‌شود. همچنین از بنه برای تهیه روغن بنه استفاده می‌گردد.'
        },
        {

'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: آجیل و خشکبار، صنایع غذایی، صادرات\n• ارزش افزوده: بسته‌بندی لوکس، تولید روغن بنه، بنه بوداده طعم‌دار\n• فرآوری: بو دادن با طعم‌های مختلف (نمکی، سرکه‌ای، زعفرانی)\n• بسته‌بندی: بسته‌های ۱۰۰، ۲۵۰ و ۵۰۰ گرمی، شیشه‌های روغن بنه\n• صادرات: کشورهای حاشیه خلیج فارس، اروپا\n• کشت: ایجاد باغات بنه در زمین‌های شیبدار\n• برندینگ: "بنه ایراج" با طراحی سنتی\n• اشتغال‌زایی: ایجاد کارگاه‌های فرآوری برای زنان روستایی'
        }
      ]
    },
    {
      'title': 'اسفند (اسپند)',
      'icon': Icons.fireplace,
      'imagePath': 'assets/images/esfand.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'اسپند یا اسفند گیاهی علفی و چندساله از تیره قره‌داغیان است که در خاک‌های شور مناطق معتدل بیابانی و کویری می‌روید. این گیاه در دشت‌های اطراف ایراج به وفور یافت می‌شود. نام علمی آن Peganum harmala است و به آن سداب سوری یا هارمل نیز می‌گویند. طبع اسپند در طب سنتی گرم و خشک است. دانه‌های اسپند قهوه‌ای تیره و مثلثی شکل هستند.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• ضد عفونی کننده قوی محیط و میکروب‌کش هوا\n• دفع حشرات موذی و تصفیه کننده هوا\n• درمان آبریزش بینی و زکام\n• ضد التهاب و ضد درد\n• درمان اسهال و مشکلات گوارشی\n• ضد نفخ قوی\n• ملین و تصفیه کننده خون\n• درمان شپش سر (به صورت ضماد ریشه با روغن خردل)\n• کمک به ترک اعتیاد\n• موثر بر لاغری شکم\n• تنظیم قاعدگی\n• کاهش دهنده قند خون\n• ضد انگل و ضد کرم\n• درمان بی‌خوابی و آرامبخش\n• تسکین دندان درد با بخور'
        },
        {
          'title': '🧪 ترکیبات شیمیایی',
          'content': 'دانه‌های اسپند حاوی آلکالوئیدهایی مانند هارمالین، هارمین و هارمالول هستند. همچنین دارای فلاونوئیدها، ویتامین‌های A، C، E، K و ویتامین‌های گروه B، کلسیم، پتاسیم، منیزیم و روی می‌باشد.'
        },
        {
          'title': '🔥 روش‌های مصرف',
          'content': '• دود کردن: برای ضدعفونی محیط، دفع حشرات و رفع انرژی‌های منفی\n• بخور: برای درمان آبریزش بینی و زکام\n• خوراکی: به صورت پودر شده با عسل (مصرف خوراکی باید با احتیاط و مشورت پزشک باشد)\n• ضماد: ریشه کوبیده با روغن خردل برای شپش سر\n• روغن: مالیدن روغن اسپند برای درمان درد مفاصل'
        },
        {
          'title': '⚠️ موارد احتیاط',
          'content': '• مصرف خوراکی اسپند در دوزهای بالا می‌تواند سمی باشد و عوارضی مانند تهوع، استفراغ، تشنج و توهم ایجاد کند\n• در دوران بارداری و شیردهی ممنوع\n• افراد مبتلا به بیماری‌های قلبی، کبدی و کلیوی با احتیاط مصرف کنند\n• با داروهای آنتی‌کولینرژیک، داروهای پارکینسون و داروهای سروتونرژیک تداخل دارد\n• همراه با غذاهای حاوی تیرامین (پنیر کهنه، گوشت فرآوری‌شده، ترشیجات) مصرف نشود'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: عطاری‌ها، صنایع داروسازی، تولید عود و بخور\n• ارزش افزوده: تولید عودهای ترکیبی، روغن اسپند، کپسول‌های گیاهی\n• فرآوری: بسته‌بندی دانه برای دود کردن، تولید اسپند دودکن آماده\n• بسته‌بندی: بسته‌های ۵۰ و ۱۰۰ گرمی همراه با ذغال مخصوص\n• صادرات: کشورهای حاشیه خلیج فارس، ترکیه\n• گردشگری: تولید بسته‌های سوغاتی برای گردشگران\n• برندینگ: "اسپند کویر ایراج" با طراحی سنتی'
        }
      ]
    },
    
    {
      'title': 'بادومو (میوه بادام کوهی)',
      'icon': Icons.favorite,
      'imagePath': 'assets/images/badam.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'بادومو همان میوه درخت بادام کوهی است که در مناطق کویری و کوهپایه‌ای اطراف ایراج به وفور یافت می‌شود. این میوه در حالت خام طعم تلخی دارد و به دلیل وجود ترکیباتی مانند آمیگدالین، مصرف خام آن سمی و خطرناک است. پس از فرآوری و شیرین‌سازی به محصولی خوشمزه به نام "مغزو" تبدیل می‌شود. طبع بادام کوهی گرم و خشک است.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• درمان تنگی نفس، سرفه و ورم‌های سینه و ریه\n• مخلوط آسیاب شده با سرکه برای رفع سردرد و تقویت بینایی\n• مصرف با عسل برای درمان قولنج و سلامت کبد و طحال\n• مفید برای دفع سنگ کلیه (به همراه شیره انگور)\n• درمان درد کلیه (ترکیب با نشاسته و نعناع)\n• خمیر بادام تلخ برای رفع بوی بد پا و زیر بغل\n• درمان اگزما با شستشو با خمیر بادام'
        },
        {
          'title': '🫒 روغن بادام کوهی',
          'content': 'روغن بادام کوهی دارای خاصیت نرم‌کنندگی و ضد التهاب است. مالیدن آن بر صورت، چین و چروک و لکه‌ها را کاهش می‌دهد. برای از بین بردن ترک‌های دست و پا ناشی از سرما مفید است. همچنین در درمان تنگی نفس، سیاه سرفه و خارج کردن سنگ مثانه مؤثر است.'
        },
        {
          'title': '⚠️ هشدار مهم',
          'content': 'بادام کوهی خام به دلیل داشتن سیانید سمی است و مصرف آن می‌تواند باعث مسمومیت شدید، تهوع، اسپاسم، سردرد و مشکلات تنفسی شود. حتماً از محصول فرآوری‌شده و شیرین‌شده (مغزو) توسط افراد باتجربه استفاده کنید. کودکان بیشتر در معرض خطر مسمومیت هستند.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: آجیل و خشکبار، صنایع غذایی، سوغات\n• ارزش افزوده: تولید مغزو با بسته‌بندی شکیل، روغن بادام کوهی\n• فرآوری: ایجاد کارگاه سنتی فرآوری مغزو، تولید بادام بوداده\n• بسته‌بندی: بسته‌های ۱۰۰، ۲۵۰ و ۵۰۰ گرمی با طراحی سنتی\n• صادرات: کشورهای حاشیه خلیج فارس\n• گردشگری: بسته‌بندی به عنوان سوغات منحصر به فرد ایراج\n• برندینگ: "مغزو - شیرین‌ترین یادگار کویر"\n• اشتغال‌زایی: احیای دانش بومی فرآوری، ایجاد اشتغال برای بانوان'
        }
      ]
    },
    {
      'title': 'بارهنگ',
      'icon': Icons.local_florist,
      'imagePath': 'assets/images/barhang.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'بارهنگ گیاهی علفی با برگ‌های پهن و دانه‌های ریز است که در مناطق مرطوب‌تر و کنار قنات‌ها و جویبارهای کویری ایراج می‌روید. این گیاه از دیرباز در طب سنتی برای درمان زخم‌ها و مشکلات تنفسی استفاده می‌شده است. نام علمی آن Plantago major است. برگ‌های آن به صورت روزت و دانه‌های آن در سنبله قرار دارند.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• درمان سرفه و سرماخوردگی\n• درمان زخم معده و روده\n• برگ آن برای درمان زخم‌های پوستی و گزیدگی حشرات\n• ضد التهاب و التیام‌بخش\n• ضد عفونی کننده مجاری ادراری\n• کاهش دهنده تب\n• درمان اسهال\n• ضد خونریزی\n• درمان یبوست با دانه‌های بارهنگ\n• نرم کننده پوست'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه دمنوش برگ بارهنگ، یک قاشق غذاخوری برگ خشک را در آب جوش بریزید و ۱۰ دقیقه دم کنید. برای استفاده موضعی، برگ تازه را له کرده و روی زخم قرار دهید. دانه‌های بارهنگ مانند اسفرزه مصرف می‌شود.'

},
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: داروخانه‌ها، تولید پمادهای گیاهی، عطاری‌ها\n• ارزش افزوده: تولید پماد بارهنگ، کپسول، دمنوش\n• فرآوری: خشک کردن برگ، بسته‌بندی دانه\n• بسته‌بندی: بسته‌های ۵۰ گرمی برگ خشک، بسته‌های ۱۰۰ گرمی دانه\n• صادرات: کشورهای اروپایی علاقمند به گیاهان التیام‌بخش\n• کشت: ایجاد مزارع کشت بارهنگ در کنار قنات‌ها\n• برندینگ: "بارهنگ ایراج - التیام‌بخش طبیعت"'
        }
      ]
    },
    {
      'title': 'کاکوتی',
      'icon': Icons.nightlight,
      'imagePath': 'assets/images/kakooti.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'کاکوتی گیاهی معطر از خانواده نعناعیان است که در مناطق کویری اطراف ایراج می‌روید. این گیاه دارای طبع گرم و خشک است. نام علمی آن Ziziphora tenuior است. برگ‌های آن کوچک و معطر و گل‌های آن صورتی رنگ است. کاکوتی به عنوان سبزی خوراکی و دارویی استفاده می‌شود.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• آرامبخش اعصاب و کاهش استرس\n• درمان بی‌خوابی\n• ضد افسردگی\n• ضد عفونی کننده طبیعی\n• تقویت کننده حافظه\n• ضد سرفه و خلط‌آور\n• درمان سرماخوردگی و آنفولانزا\n• ضد نفخ و کمک به هضم\n• کاهش فشار خون\n• ضد التهاب'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه دمنوش، یک قاشق چایخوری کاکوتی خشک را در آب جوش ریخته و ۱۰ دقیقه دم کنید. می‌توانید با عسل شیرین کنید. همچنین از کاکوتی تازه در تهیه ماست و خیار، دوغ و سالاد استفاده می‌شود.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: عطاری‌ها، تولید دمنوش، صنایع لبنی (طعم‌دهنده)\n• ارزش افزوده: تولید دمنوش‌های ترکیبی، سبزی خشک بسته‌بندی\n• فرآوری: خشک کردن صنعتی، بسته‌بندی مدرن\n• بسته‌بندی: بسته‌های ۵۰ گرمی دمنوش، بسته‌های ۱۰۰ گرمی سبزی خشک\n• صادرات: کشورهای حاشیه خلیج فارس\n• کشت: توسعه کشت در مزارع ایراج\n• برندینگ: "کاکوتی معطر ایراج"'
        }
      ]
    },
    {
      'title': 'کلپوره(مریم نخودی)',
      'icon': Icons.bloodtype,
      'imagePath': 'assets/images/kalpoureh.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'کلپوره گیاهی دارویی از خانواده نعناعیان است که در مناطق کویری اطراف ایراج می‌روید. این گیاه به دلیل خواص متعدد در طب سنتی جایگاه ویژه‌ای دارد. نام علمی آن Teucrium polium است. گل‌های آن سفید مایل به زرد و برگ‌های آن کرکدار است.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• کاهش قند خون و ضد دیابت\n• مقوی معده\n• ضد عفونی کننده مجاری ادراری\n• ضد التهاب\n• تب‌بر\n• درمان اسهال\n• تصفیه کننده خون\n• تقویت کننده سیستم ایمنی\n• کاهش دهنده چربی خون\n• درمان رماتیسم'
        },
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه دمنوش، یک قاشق چایخوری سرشاخه گلدار کلپوره را در آب جوش ریخته و ۱۰ دقیقه دم کنید. روزانه ۱ تا ۲ فنجان مصرف شود. بیماران دیابتی می‌توانند با مشورت پزشک مصرف کنند.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: داروخانه‌ها، تولید داروهای گیاهی دیابت، عطاری‌ها\n• ارزش افزوده: تولید کپسول‌های گیاهی ضد دیابت، دمنوش\n• فرآوری: خشک کردن صنعتی، بسته‌بندی استاندارد\n• بسته‌بندی: بسته‌های ۵۰ گرمی، جعبه‌های دمنوش\n• صادرات: کشورهای اروپایی و حاشیه خلیج فارس\n• کشت: توسعه کشت در زمین‌های مستعد\n• برندینگ: "کلپوره ایراج - هدیه کویر برای دیابت"'
        }
      ]
    },
    {
      'title': 'کمبلو (گرد و دراز)',
      'icon': Icons.circle,
      'imagePath': 'assets/images/kamboloo.jpg',
      'sections': [
        {
          'title': '🌿 معرفی',
          'content': 'کمبلو گیاهی دارویی با دو نوع گرد و دراز است که در مناطق کویری اطراف ایراج می‌روید. این گیاه در طب سنتی منطقه کاربرد فراوانی دارد. نام علمی آن در دست بررسی است. این گیاه به صورت خودرو در دشت‌های اطراف ایراج یافت می‌شود.'
        },
        {
          'title': '💊 خواص درمانی',
          'content': '• درمان زخم معده\n• رفع سوزش سر دل\n• ضد اسپاسم عضلانی\n• اشتها آور\n• تقویت کننده معده\n• ضد نفخ\n• درمان سوء هاضمه\n• کاهش التهاب معده'

},
        {
          'title': '🍵 روش مصرف',
          'content': 'برای تهیه دمنوش، یک قاشق چایخوری از گیاه خشک را در آب جوش ریخته و ۱۰ دقیقه دم کنید. بهتر است نیم ساعت قبل از غذا مصرف شود. همچنین می‌توان از پودر آن به عنوان ادویه در غذا استفاده کرد.'
        },
        {
          'title': '💰 آینده و سرمایه‌گذاری',
          'content': '• بازار هدف: عطاری‌ها، تولید داروهای گیاهی معده\n• ارزش افزوده: بسته‌بندی شکیل، کپسول گیاهی\n• فرآوری: خشک کردن، پودر کردن، بسته‌بندی\n• بسته‌بندی: بسته‌های ۵۰ و ۱۰۰ گرمی\n• صادرات: کشورهای حاشیه خلیج فارس\n• تحقیقات: نیاز به تحقیقات بیشتر برای شناسایی علمی\n• برندینگ: "کمبلو ایراج - درمانگر طبیعی معده"'
        }
      ]
    }
  ];

  // تابع نرمال‌سازی
  String normalize(String text) {
    return text
        .replaceAll("ي", "ی")
        .replaceAll("ك", "ک")
        .replaceAll("\u200c", " ")
        .replaceAll(RegExp(r"\s+"), " ")
        .trim()
        .toLowerCase();
  }

  // تابع هایلایت
  Widget highlight(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          fontFamily: "Vazirmatn",
        ),
      );
    }

    final normalizedText = normalize(text);
    final normalizedQuery = normalize(query);

    if (!normalizedText.contains(normalizedQuery)) {
      return Text(
        text,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          fontFamily: "Vazirmatn",
        ),
      );
    }

    final spans = <TextSpan>[];
    int start = 0;
    final textLower = text.toLowerCase();

    while (true) {
      final index = textLower.indexOf(query.toLowerCase(), start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index)));
      }

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            backgroundColor: Colors.yellow,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      start = index + query.length;
    }

    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: const TextStyle(
          fontFamily: "Vazirmatn",
          fontSize: 15,
          color: Colors.black87,
          height: 1.6,
        ),
        children: spans,
      ),
    );
  }

  // تابع نمایش عکس در دیالوگ
  void _showImageDialog(String imagePath, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,

style: const TextStyle(
                            fontFamily: "Vazirmatn",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey.shade200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "تصویر یافت نشد",
                                style: TextStyle(
                                  fontFamily: "Vazirmatn",
                                  fontSize: 16,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  // ویجت برای کادرهای جزئیات
  Widget sectionBox(String title, String content, String query) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: "Vazirmatn",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 8),
          highlight(content, query),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = plants.where((plant) {
      if (searchText.isEmpty) return true;
      final title = plant['title'] as String;
      return title.toLowerCase().contains(searchText.toLowerCase());
    }).toList();

return Scaffold(
      appBar: AppBar(
        title: const Text(
          "گیاهان دارویی ایراج",
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => searchText = value),
              decoration: InputDecoration(
                hintText: "جستجو در گیاهان دارویی...",
                hintTextDirection: TextDirection.rtl,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "نتیجه‌ای یافت نشد",
                          style: TextStyle(
                            fontFamily: "Vazirmatn",
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final plant = filtered[index];
                      final hasImage = plant['imagePath'] != null;
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent,
                            ),
                            child: ExpansionTile(
                              key: Key(plant['title']!),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (hasImage)
                                    GestureDetector(

onTap: () {
                                        _showImageDialog(
                                          plant['imagePath'] as String,
                                          plant['title'] as String,
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade100,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.photo_camera,
                                          color: Colors.green.shade700,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  Icon(
                                    plant['icon'] as IconData,
                                    color: Colors.green.shade700,
                                    size: 28,
                                  ),
                                ],
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              childrenPadding: EdgeInsets.zero,
                              title: Text(
                                plant['title']!,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32),
                                  fontFamily: "Vazirmatn",
                                ),
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: (plant['sections'] as List).map((section) {
                                      return sectionBox(
                                        section['title'],
                                        section['content'],
                                        searchText,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
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