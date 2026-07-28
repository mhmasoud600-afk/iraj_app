import 'package:flutter/material.dart';
import 'handicraft_details_page.dart'; 

class HandicraftsPage extends StatefulWidget {
  const HandicraftsPage({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> handicrafts = [
    {
  'title': 'قالی ایراج',
  'description': '''قالی‌بافی یکی از مهم‌ترین صنایع دستی روستاست. زنان روستا با استفاده از پشم گوسفندان محلی و رنگ‌های طبیعی، قالی‌های زیبا و با دوامی می‌بافند. نقش‌های قالی ایراج برگرفته از طبیعت کویر و باورهای مردم منطقه است.''',
  'extraInfo': '''مواد اولیه: پشم گوسفند، رنگ‌های طبیعی
نقوش سنتی: برگرفته از کویر، نخل و باورهای محلی
کاربرد: زیرانداز، تزئینات، جهیزیه عروس''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/carpet.jpg',
  'icon': Icons.home,
},
    {
  'title': 'سرجل',
  'description': '''سرجل نوعی دستبافت سنتی است که از تکه‌های پارچه‌های زائد (دورریز) و به روش گلیم‌بافی ساخته می‌شود. این اثر هنری نمونه‌ای برجسته از هنر بازیافت در صنایع دستی ایران است که برای تزئین اسب و حیوانات در مراسمات خاص استفاده می‌شود.''',
  'extraInfo': '''مواد اولیه: تکه‌های پارچه اضافی، ضایعات خیاطی، نخ‌های پشمی برای تار
کاربرد اصلی: تزئین اسب و حیوانات در جشن‌ها و عروسی‌ها
ویژگی: هر سرجل دارای پالت رنگی منحصر به فرد و بافت ناهمگون است''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/sarjol.jpg',
  'icon': Icons.celebration,
},
    {
      'title': 'کرباس بافی',
      'description':
          'کاربافی یا کرباس بافی هنر بافت پارچه‌های ضخیم پنبه‌ای است که برای لباس کار و کیسه‌های کشاورزی استفاده می‌شود.',
      'image': 'assets/images/Handicrafts/karbaf.jpg',
      'icon': Icons.construction,
    },
    {
  'title': 'مشک ',
  'description': '''مشک‌دوزی هنر ساخت ظروف چرمی از پوست بز و گوسفند است که برای نگهداری آب، دوغ، ماست و تهیه کره استفاده می‌شود. مشک‌ها به دلیل تخلخل طبیعی پوست، خاصیت خنک‌کنندگی دارند و آب را مدت طولانی خنک نگه می‌دارند. این هنر در روستای ایراج از دیرباز رواج داشته و انواع مختلف مشک شامل سرمشک، قاتق‌دون و تُلمب می‌شود.''',
  'extraInfo': '''مواد اولیه: پوست بز یا گوسفند، روغن حیوانی برای چرب کردن
انواع مشک:
• سرمشک: مشک کوچک برای حمل آب و دوغ
• قاتق‌دون: مخصوص نگهداری ماست
• تُلمب: مشک بزرگ برای زدن ماست و تهیه کره
کاربرد: نگهداری آب، دوغ، ماست و تهیه کره محلی''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/mashk.jpg',
  'icon': Icons.water_drop,
},


{
  'title': 'سرمشک',
  'description': '''سرمشک یا مشک کوچک، نوعی ظرف چرمی کوچک است که از پوست بز یا گوسفند تهیه می‌شود. این مشک‌ها برای حمل آب، دوغ یا شیر در مسافت‌های کوتاه استفاده می‌شدند. اندازه کوچک آن امکان حمل آسان را فراهم می‌کرد و معمولاً کوله‌پشتی یا به کمر بسته می‌شد.''',
  'extraInfo': '''مواد اولیه: پوست بز یا گوسفند دباغی شده
کاربرد: حمل آب، دوغ و شیر
ویژگی: کوچک، سبک و قابل حمل''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/sarmashk.jpg',
  'icon': Icons.water_drop,
},
{
  'title': 'مشک قاتق‌دون',
  'description': '''مشک قاتق‌دون، مشک مخصوص نگهداری و حمل ماست است. این مشک از پوست بز تهیه می‌شود و به دلیل خاصیت چرمی خود، ماست را مدت طولانی‌تری تازه و خنک نگه می‌دارد. در قدیم، زنان روستا ماست تازه را در این مشک‌ها می‌ریختند و برای مصرف روزانه یا مهمانی‌ها نگهداری می‌کردند.''',
  'extraInfo': '''مواد اولیه: پوست بز دباغی شده
کاربرد: نگهداری و حمل ماست
ویژگی: خنک نگه داشتن ماست، مقاوم در برابر ترشیدگی''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/ghatoghdon.jpg',
  'icon': Icons.water_drop,
},
{
  'title': 'تُلمب ',
  'description': '''تُلمب نوعی مشک بزرگ و مخصوص است که برای زدن ماست و تهیه کره محلی (مسکه) استفاده می‌شود. این مشک از پوست کامل بز یا گوسفند تهیه می‌شود و دارای دهانه‌ای گشاد برای ریختن ماست است. برای زدن ماست، تُلمب را با طناب به چوبی آویزان می‌کردند و با تکان دادن مداوم، کره از ماست جدا می‌شد. این روش سنتی تهیه کره در مناطق کویری و روستایی رایج بوده است.''',
  'extraInfo': '''مواد اولیه: پوست کامل بز یا گوسفند
کاربرد: زدن ماست و تهیه کره (مسکه)
روش کار: آویزان کردن با طناب و تکان دادن مداوم
ویژگی: بزرگ، مقاوم و با دوام''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/tolomb.jpg',
  'icon': Icons.water_drop,
},
{
      'title': 'گوهر تراشی',
      'description': """
ابتدا سنگ را برش زده به صورت ورق‌های اسلایس می‌کنیم. سپس با شابلون، قسمتی از سنگ که طرح و منظره دارد را علامت‌گذاری کرده و دور آن را خط می‌کشیم. با استفاده از دستگاه برش، آن را به صورت نگین‌های کوچک (شکل اشک، قلب، بیضی و یا هر طرح دیگر) برش می‌دهیم.

در مرحله بعد با دستگاه کف‌ساب و سگمنت یا CBN، دوربرداری کرده و حالت دامله یا گنبدی به سنگ می‌دهیم. سپس با استفاده از سنباده‌های زبر (۱۸۰، ۲۲۰، ۴۰۰، ۸۰۰، ۱۲۰۰) پولیش می‌دهیم تا به جلا و برق مورد نظر بررسد.

این کار نیاز به دقت، حوصله و تجربه دارد و هر سنگ بسته به سختی و نوع آن، زمان متفاوتی برای تراش نیاز دارد.
""",
      'extraInfo': """
سنگ خام از بهترین معادن خراسان و شهرستان خور و بیابانک تهیه می‌شود.
انواع سنگ‌های عقیق معدنی تراش دست
برای کسب اطلاعات بیشتر و خرید:
""",
      'hasLink': true,
      'image': 'assets/images/Handicrafts/gohar_tarashi.jpg',
      'icon': Icons.diamond,
    },
    
    {
  'title': 'کلید و کلیدون',
  'description': '''قفل و کلید چوبی که برای درب‌های قدیمی چوبی در گذشته استفاده می‌شد. هر کلید مختص یک کلیدون (قفل) بود و این ابزار نشان‌دهنده دانش و مهارت نجاری سنتی در روستاهای کویری مانند ایراج است.''',
  'extraInfo': '''جنس: چوب
کاربرد: قفل درب‌های چوبی قدیمی
ویژگی: هر کلید منحصر به فرد و مختص یک قفل خاص بود''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/key.jpg',
  'icon': Icons.water_drop,
},
  // جِلت
{
  'title': 'جِلت',
  'description': '''جِلت ظرفی بزرگ و مقاوم است که از برگ خرما بافته می‌شود. این ظرف مخصوص نگهداری و حمل خرما بوده و به دلیل اندازه بزرگ خود، بین ۵ تا ۶ من خرما (حدود ۱۵ تا ۱۸ کیلوگرم) را در خود جای می‌داده است.''',
  'extraInfo': '''مواد اولیه: برگ خشک خرما (گشگ)، پیچ برگ خرما (ملار)
کاربرد: نگهداری و حمل خرما
ظرفیت: ۵ تا ۶ من خرما (۱۵ تا ۱۸ کیلوگرم)''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/jelt.jpg',
  'icon': Icons.shopping_basket,  // ← اصلاح شده
},

{
  'title': 'رشمه (سازو)',
  'description': '''رشمه یا سازو نوعی طناب یا ریسمان سنتی است که از موی بز یا نخ پنبه‌ای تهیه می‌شود. برای ساخت آن، چند نخ باریک را به هم تاب می‌دادند (تابیدن) تا یک طناب محکم و مقاوم به دست آید. از این طناب‌ها برای بستن بار، اتصال وسایل کشاورزی، آویزان کردن مشک‌ها و کاربردهای فراوان دیگر در زندگی روزمره روستایی استفاده می‌شد. رشمه نشان‌دهنده مهارت زنان و مردان روستا در استفاده از مواد طبیعی موجود در منطقه است.''',
  'extraInfo': '''مواد اولیه: موی بز یا نخ پنبه‌ای
روش ساخت: تابیدن چند نخ باریک به هم
کاربردها: بستن بار، اتصال وسایل کشاورزی، آویزان کردن مشک، بستن درب‌ها
ویژگی: محکم، بادوام، انعطاف‌پذیر''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/rasmeh.jpg',
  'icon': Icons.construction,
},  
    
    {


'title': 'پوزه بند',
      'description':
          'وسیله ای که برای بستن دهان الاغ استفاده می شد که بتوان از دندان گرفتن یا چرای ناخواسته الاغ در زمین های کشاورزی مردم جلوگیری شود. این ابزار از پیچ های درخت خرما که به هم بافته می شد و به آن ملار می گفتند ساخته می‌شود.',
      'image': 'assets/images/Handicrafts/poozeh.jpg',
      'icon': Icons.water_drop,
    },
    {
  'title': 'سبدبافی',
  'description': '''سبدبافی با شاخه بادام کوهی (ارژن) یکی از کهن‌ترین صنایع دستی در مناطق کوهستانی ایران است. در روستای ایراج، از شاخه‌های بادام کوهی برای بافت سبدهای مقاوم و کاربردی استفاده می‌شود. این هنر که با نام محلی "چوِ بادوم" شناخته می‌شود، پیوند عمیقی با فرهنگ و زندگی روزمره مردم کویر دارد.''',
  'extraInfo': '''مواد مورد نیاز: شاخه‌های بادام کوهی، چاقوی تیز، ظرف آب، قالب چوبی
موارد استفاده: نگهداری میوه، نان و خشکبار، تزئینات دکوراتیو، بسته‌بندی هدیه
وضعیت کنونی: در حال فراموشی - کمتر از ۵ استادکار فعال در ایراج''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/basket.jpg',
  'icon': Icons.bakery_dining,
},
    {
  'title': 'زنبیل و آشار',
  'description': '''زنبیل و آشار دو نوع سبد سنتی از برگ خرما هستند. آشار محصولی کوچکتر  با برگ نرم خرما که به هم بافته می شد و به آن گشگ گفته شد درست می شد ، و زنبیل محصولی بزرگ و مقاوم با گشگ و ملار( پیج‌های به هم بافته شد ه )است. این هنر در ایراج همواره همراه با نخل‌داری و کشاورزی معیشت اصلی مردم بوده است.''',
  'extraInfo': '''مواد اولیه: برگ خرما(گشگ) ، پیج برگ خرما(ملار) 
موارد استفاده آشار: نان‌خوری، میوه‌خوری، وسایل خیاطی
موارد استفاده زنبیل: حمل خرما، علوفه‌کشی، انبارداری''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/zenbil.jpg',
  'icon': Icons.agriculture,
},
    {
  'title': 'جارو (برگه ای)',
  'description': '''ساخت جاروی دستی سنتی با برگ خرما که در گویش محلی "مَکَّه" یا "مَرَک" نامیده می‌شود. این جاروها با استفاده از برگ‌های بلند و خشک خرما و دسته‌ای از شاخه‌های گز یا تاغ ساخته می‌شوند و برای نظافت حیاط و خانه‌های گلی کاربرد داشته‌اند.''',
  'extraInfo': '''مواد مورد نیاز: برگ‌های بلند خرما، ریسمان محکم، چوب دسته از گز یا تاغ
روش ساخت: برگ‌ها را خیس کرده، دسته‌های ۵-۷ تایی به چوب می‌بندند
کاربرد: جارو کردن حیاط و داخل خانه‌های گلی''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/broom.jpg',
  'icon': Icons.clean_hands,
},
    {
  'title': 'لیف (طناب سنتی)',
  'description': '''لیف یا طناب سنتی از پیچ‌های اطراف برگ خرما (الیاف قهوه‌ای رنگ)  که به هم بافته می شد و به آن ملار می گفتند ساخته می‌شود. این طناب‌های محکم و بادوام کاربردهای فراوانی در زندگی روزمره مردم روستای ایراج داشته است و نشان‌دهنده استفاده بهینه از تمام اجزای نخل است.''',
  'extraInfo': '''مواد اولیه: پیچ‌های اطراف برگ خرما
کاربردها: بستن بار خرما، آویزان کردن سبدها، بستن درب خانه‌های گلی، آبکش کردن پنیر و ماست
وضعیت: جای خود را به طناب‌های پلاستیکی داده، اما برخی مردان مسن هنوز این مهارت را دارند''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/lif.jpg',
  'icon': Icons.spa,
},
    {
      'title': 'واله',
      'description':
          'واله وسیله ای که از پیج درخت خرما که بهم بافته شده است و به آن ملار می گویند درست می شود و بر روی الاغ می اندازند و با آن خاک و خاشاک را حمل منتقل می کنند .',
      'image': 'assets/images/Handicrafts/vale.jpg',
      'icon': Icons.nature,
    },
    {
  'title': 'کلاه (برگ خرما)',
  'description': '''کلاه‌بافی با برگ خرما ( از گشگ که برگه های به هم بافته شده را می گفتند درست می شد ) در ایراج، هنری مکمل و همزاد زنبیل‌بافی است. مردان کشاورز و دامدار در فصل گرما از این کلاه‌های سبک، خنک و مقاوم در برابر آفتاب سوزان کویر استفاده می‌کردند. بانوان ایراج این کلاه‌ها را برای پدران، همسران و برادران خود می‌بافتند.''',
  'extraInfo': '''مواد اولیه: برگ خرما (آشار)، پیج برگ خرما برای لبه
کاربرد سنتی: محافظت از سر و صورت در برابر آفتاب، باران و گرد و غبار
کاربرد امروزی: صنایع دستی تزئینی، دکوری، سوغات گردشگران
وضعیت: در آستانه فراموشی - نیازمند احیا''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/hat.jpg',
  'icon': Icons.home,
},
    {
  'title': 'دولنده',
  'description': '''دولنده سبدی سنتی از برگ خرماست( گشگ) که برای نگهداری نان و خرما در خانه‌های روستایی کاربرد دارد. بافت آن به صورت شطرنجی (یکی زیر، یکی رو) انجام می‌شود و به دلیل تهویه مناسب، نان و خرما را مدت طولانی‌تری تازه نگه می‌دارد.''',
  'extraInfo': '''مواد مورد نیاز: برگ خشک خرما، الیاف نازک خرما، سوزن درشت
مراحل: آماده‌سازی برگ‌ها، شروع بافت کف، بافت دیواره، تکمیل لبه
کاربردها: نگهداری نان، خرما، برنج، حبوبات - همچنین دکوراسیون مدرن''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/dolande.jpg',
  'icon': Icons.kitchen,
},
    


{
  'title': 'تخته‌گو',
  'description': '''تخته‌گو یک دست‌سازه سنتی و آیین‌محور از روستای ایراج است که از دانه‌های خشک شده گیاه اسفند (حرمل) ساخته می‌شود. این اثر هنری نمادی از دفع چشم‌زخم، برکت و امید در دل کویر است و فراتر از یک تزئین صرف، کارکرد محافظتی دارد.''',
'extraInfo': '''مواد اولیه: دانه‌های اسفند، نخ نایلونی محکم، حلقه فلزی، تکه‌های پارچه رنگی
کاربرد فرهنگی: محافظت از خانه در برابر انرژی منفی، نماد شادی و برکت
ساختار: رشته‌های عمودی از دانه‌های اسفند با تزئینات پارچه‌های رنگی''',
  'hasSteps': true,
  'image': 'assets/images/Handicrafts/takhtah.jpg',
  'icon': Icons.kitchen,
},

  ];

  @override
  State<HandicraftsPage> createState() => _HandicraftsPageState();
}

class _HandicraftsPageState extends State<HandicraftsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(HandicraftsPage.handicrafts);
    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  void _search(String value) {
    setState(() {
      filteredList = HandicraftsPage.handicrafts.where((item) {
        final title = item['title'].toString().toLowerCase();
        final desc = item['description'].toString().toLowerCase();
        return title.contains(value.toLowerCase()) ||
            desc.contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "صنایع دستی روستا",
            style: TextStyle(


fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            /// کادر جستجو
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'جستجو...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _search('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            /// گرید آیتم‌ها
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredList[index];
                  return _buildHandicraftItem(item, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// کارت هر آیتم با نمایش عکس یا آیکون
  Widget _buildHandicraftItem(
      Map<String, dynamic> item, BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HandicraftDetailsPage(item: item),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// تصویر یا آیکون داخل دایره
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  item['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // اگر تصویر نبود، آیکون نمایش داده شود
                    return Icon(
                      item['icon'],
                      size: 40,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vazirmatn',
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
