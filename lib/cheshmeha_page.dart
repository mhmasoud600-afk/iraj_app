// lib/cheshmeha_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mixins/searchable_mixin.dart';

class CheshmehaPage extends StatefulWidget {
  const CheshmehaPage({Key? key}) : super(key: key);

  @override
  State<CheshmehaPage> createState() => _CheshmehaPageState();
}

class _CheshmehaPageState extends State<CheshmehaPage> with SearchableMixin {
  bool showFullDescription = false;
  bool _showAllCheshmeha = false;
  bool _showFullPoem = false;

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'قنات و چشمه‌ها';
  
  @override
  String get pageSubtitle => 'چشمه‌های طبیعی و قنات‌های روستا';
  
  @override
  String get pageCategory => 'طبیعت';
  
  @override
  IconData get pageIcon => Icons.water;
  
  @override
  Widget get pageWidget => const CheshmehaPage();

  @override
  String getSearchText() {
    String allCheshmehaNames = cheshmehaNames.join('، ');
    
    String allPoemText = '';
    for (var line in poemLines) {
      allPoemText += '${line['right']}\n${line['left']}\n';
    }

    return '''
      قنات و چشمه‌های روستای ایراج:
      
      معرفی:
      ایراج روستایی از توابع شهرستان خور و بیابانک در استان اصفهان است که در حاشیه کویر مرکزی ایران قرار دارد. 
      مهم‌ترین ویژگی این روستا، وجود چشمه‌های طبیعی است که حیات و کشاورزی را در این منطقه کویری امکان‌پذیر کرده است.
      
      اسامی چشمه‌ها و قنات‌ها:
      $allCheshmehaNames
      
      شعر در وصف چشمه‌های ایراج:
      سروده مرحوم فضل الله اکبر
      $allPoemText
      
      کلمات کلیدی:
      قنات، چشمه، کاریز، آب، کویر، طبیعت، ایراج، خور و بیابانک، اصفهان
    ''';
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
  // لیست چشمه‌ها
  // ============================================================
  static const List<String> cheshmehaNames = [
    'قنات و چشمه کهریز',
    'چاله حوضو',
    'چشمه قلعه',
    'چشمه کتل ته جوی',
    'چشمه کتل آسیو',
    'چشمه بیخ درگو',
    'چشمه خواجه خضر',
    'چشمه صحابه',
    'چشمه علی اکبر',
    'چشمه آبگادو',
    'چشمه انجیر کوهی',
    'چشمه پی زر',
    'چشمه چله خونه',
    'چشمه سیما',
    'چشمه باغ نیزار',
    'چشمه کوچه خرمنا',
    'چشمه کلاته پایین',
    'چشمه کلاته بالا',
    'چشمه کهینو',
    'چشمه اوشکو (کاشفیه)',
    'چشمه آفرین (افرنگ)',
    'چشمه بیخ چاه',
    'چشمه دومو',
    'چشمه آخرک',
    'چشمه آبگیشه',
    'چشمه منک',
    'چشمه اسلام دشت',
    'چشمه گولار',
    'چشمه و قنات خرم آباد',
    'چشمه آب یوزگون',
    'چشمه بندر',
    'چشمه بهین',
    'چشمه پاپرده',
    'چشمه زایین',
    'چشمه چاه شور',
    'چشمه گدار نتک',
    'چشمه آب تلخون',
    'چشمه حاجی آبادی',
    'چشمه گودال خجه',
    'چشمه زردو',
    'چشمه جمون',
    'چشمه کتل مرغزار',
    'چشمه شوراب منک',
    'چشمه صنم',
    'چشمه کلاته شرف',
    'چشمه سنجد',
  ];

  static const String fullDescription =
      'ایراج روستایی از توابع شهرستان خور و بیابانک در استان اصفهان است که در حاشیه کویر مرکزی ایران قرار دارد. مهم‌ترین ویژگی این روستا، وجود چشمه‌های طبیعی است که حیات و کشاورزی را در این منطقه کویری امکان‌پذیر کرده است.';

  static const String firstLine =
      'ایراج روستایی از توابع شهرستان خور و بیابانک در استان اصفهان است که در حاشیه کویر مرکزی ایران قرار دارد.';

  static const List<Map<String, String>> poemLines = [
    {'right': 'خوش آن روزی شوم راهی از اینجا', 'left': 'بگیرم در دل ایراج مأوا'},
    {'right': 'خورم آب از درون چاله حوضو', 'left': 'بشویم دست و رو را بر لب جو'},
    {'right': 'روم آبی خورم از چاه کاریز', 'left': 'ز شیرینی تو گویی شکّر آمیز'},
    {'right': 'یکی چشمه بود در پای انجیر', 'left': 'که از زیر درخت است آن سرازیر'},
    {'right': 'دگر چشمه بود گودال پیزُر', 'left': 'که از آن آب باشد چاله ها پر'},
    {'right': 'یکی چشمه بود در چله خانه', 'left': 'که دل می گیرد از بهرش بهانه'},
    {'right': 'دگر چشمه بود در خانه سیما', 'left': 'که آب آن رود جوی جلالا'},
    {'right': 'یکی چشمه بود در باغ نیزار', 'left': 'صفا دارد لب جوی و چمنزار'},
    {'right': 'دگر چشمه بود در کوچه خرمن', 'left': 'بود پایاب نام آن مبرهن'},
    {'right': 'یکی چشمه میان قلعه باشد', 'left': 'که راهش بیش از چل پله باشد'},
    {'right': 'دگر چشمه ز باغی هست جاری', 'left': 'کتل تهجو باشد آبشاری'},
    {'right': 'دگر چشمه است اندر روی میدان', 'left': 'بود جاری میان باغ و بستان'},
    {'right': 'یکی چشمه کتلّ آسیاب است', 'left': 'که گویی آن مکان بر روی آب است'},
    {'right': 'دگر چشمه روان از بیخ درگو', 'left': 'بود ریزان به آب چاله حوضو'},
    {'right': 'بود این چشمه ها مشروب و جاری', 'left': 'سی وسه چشمه در سال بهاری'},
    {'right': 'بسی چشمه که اندر حومه دارد', 'left': 'که صیادی در آنجا کومه دارد'},
    {'right': 'یکی مزرع کلاته باشدش نام', 'left': 'که می گیرد ز باغاتش دل آرام'},
    {'right': 'دگر چشمه که نام آن کهین است', 'left': 'که جنب کوهساران جاگزین است'},
    {'right': 'یکی چشمه که اوشکو ست نامش', 'left': 'در آنجا کشت و کار و جای دام است'},
    {'right': 'اخیراً کاشفیه نام دارد', 'left': 'که از فامیل کاشف وام دارد'},
    {'right': 'یکی چشمه بود پیش صحابه', 'left': 'که در چار فصل آنجا پر ز آبه'},
    {'right': 'قنات و چشمه ساری هست دیگر', 'left': 'که باشد مالکش آقای اکبر'},
    {'right': 'دگر چشمه که نامش آبگادو ست', 'left': 'فراوان اندر آنجا کبک و تیهو ست'},
    {'right': 'یکی چشمه که نامش آفرین است', 'left': 'در آنجا مارها اندر کمین است'},
    {'right': 'به چشمه سنجد ار افتد گذاری', 'left': 'خوری میوه ز انگور و اناری'},
    {'right': 'یکی چشمه که نامش هست گولار', 'left': 'در آنجا کوره گچ می کند کار'},
    {'right': 'قناتی هست نامش خرم آباد', 'left': 'کشاورز ار بود می گردد آباد'},
    {'right': 'یکی چشمه که نامش بیخ چاه است', 'left': 'در آنجا دامداری رو به راه است'},
    {'right': 'دگر چشمه که نامش یوزگان است', 'left': 'عجب آبی ز کوهستان روان است'},
    {'right': 'یکی جایی که دارد نام دومو', 'left': 'که باشد جایگاه کل و آهو'},
    {'right': 'یکی مزرع که نامش آخرک است', 'left': 'که در آنجا کشاورزی کمک است'},
    {'right': 'بهین باشد عجایب جایگاهی', 'left': 'که دارد گنبدی و بارگاهی'},
    {'right': 'چو آب سرد خواهی باشد آنجا', 'left': 'هوایی سرد دارد فصل گرما'},
    {'right': 'دگر چشمه بود پاپرده اش نام', 'left': 'توانی خورد از آن آب یک جام'},
    {'right': 'یکی چشمه به نام آبگیشه', 'left': 'روان آبش بود در توی بیشه'},
    {'right': 'یکی چشمه که اندر کوه و دشت است', 'left': 'اخیراً نام آن اسلامدشت است'},
    {'right': 'به "منک " ار ساعتی سکنی گزینی', 'left': 'تو معنای طبیعت را ببینی'},
    {'right': 'از آن آب و هوا کی می شوی سیر', 'left': 'که جایی خوش بود نه جای دلگیر'},
    {'right': 'دگر جایی که نامش هست بن در', 'left': 'در آنجا هست آهو و گوره خر'},
    {'right': 'حسین آباد خود آباد جاییست', 'left': 'کنار جاده آنجا را صفاییست'},
    {'right': 'کشاورزان همه شادان و خندان', 'left': 'که آنجا میوه ها دارد فراوان'},
    {'right': 'ز هفتومان که خرم جایگاهیست', 'left': 'قناتش بیش از سی حلقه چاهی ست'},
    {'right': 'به بازیاب بس دارد صفاها', 'left': 'که باشد هفت مزرع در آنجا'},
    {'right': 'همه آباد و سر سبز است و زیبا ست', 'left': 'تفرجگاه خوبی فصل گرماست'},
    {'right': 'تمام ساکنین مهمان نوازند', 'left': 'کشاورزان خوب و کارسازند'},
    {'right': 'یکی مزرع که نام آن هجرگ است', 'left': 'به سال خشک بس بی ساز وبرگ است'},
    {'right': 'به پای کوه دارد بارگاهی', 'left': 'نجاتش داد باید از تباهی'},
    {'right': 'گذارت گر فتد بر سوی نیزار', 'left': 'از آن بیشه نمی گردی دل آزار'},
    {'right': 'یکی مزرع که نام خنج دارد', 'left': 'عجب آب و هوای دنج دارد'},
    {'right': 'دگر از دادکین گویم سخن را', 'left': 'که نامش آب اندازد دهن را'},
    {'right': 'بسی آب و هوای خوب دارد', 'left': 'که آنجا مردمی محبوب دارد'},
    {'right': 'دگر "اکبر" ندارد اطلاعات', 'left': 'نوشته چند سطری بی مراعات'},
    {'right': 'سروده با زبان بی زبانی', 'left': 'کنی نفرین اگر شعرش بخوانی'},
    {'right': 'اگر در شعر او صد جور عیب است', 'left': 'ز شعر خویش او سر توی جیب است'},
  ];

  // ============================================================
  // بقیه کدهای UI (بدون تغییر)
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "چشمه‌های ایراج",
            style: TextStyle(
              fontFamily: "Vazirmatn",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDescriptionSection(),
                const SizedBox(height: 24),
                _buildCheshmehaListSection(),
                const SizedBox(height: 24),
                _buildPoemSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "چشمه‌های ایراج",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: "Vazirmatn",
          ),
        ),
        const SizedBox(height: 12),
        Text(
          firstLine,
          style: const TextStyle(
            fontSize: 16,
            height: 1.8,
            fontFamily: "Vazirmatn",
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8),
        if (showFullDescription) ...[
          Text(
            fullDescription.substring(firstLine.length),
            style: const TextStyle(
              fontSize: 16,
              height: 1.8,
              fontFamily: "Vazirmatn",
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 12),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                showFullDescription = !showFullDescription;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              showFullDescription ? "بستن توضیحات" : "اطلاعات بیشتر",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Vazirmatn",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheshmehaListSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "چشمه‌های ایراج",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontFamily: "Vazirmatn",
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.green.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                ),
                itemCount: _showAllCheshmeha
                    ? cheshmehaNames.length
                    : 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}. ${cheshmehaNames[index]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: "Vazirmatn",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              if (cheshmehaNames.length > 4) ...[
                const SizedBox(height: 12),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showAllCheshmeha = !_showAllCheshmeha;
                    });
                  },
                  icon: Icon(
                    _showAllCheshmeha ? Icons.expand_less : Icons.expand_more,
                    color: Colors.green,
                    size: 32,
                  ),
                  tooltip: _showAllCheshmeha ? "نمایش کمتر" : "نمایش بیشتر",
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPoemSection() {
    String getFullPoem() {
      String fullPoem = "در وصف چشمه سارهای ایراج\nسروده مرحوم فضل الله اکبر\n\n";
      for (var line in poemLines) {
        fullPoem += "${line['right']}\n${line['left']}\n\n";
      }
      return fullPoem;
    }

    final displayedPoems =
        _showFullPoem ? poemLines : poemLines.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "در وصف چشمه سارهای ایراج",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontFamily: "Vazirmatn",
              ),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: getFullPoem()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "شعر کپی شد",
                      style: TextStyle(fontFamily: "Vazirmatn"),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.content_copy, color: Colors.purple),
              tooltip: "کپی شعر",
            ),
          ],
        ),
        const Text(
          "سروده مرحوم فضل الله اکبر",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.purple,
            fontFamily: "Vazirmatn",
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.purple.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: displayedPoems.map((line) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      line['right']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Vazirmatn",
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      line['left']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Vazirmatn",
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }).toList(),
          ),
        ),
        if (poemLines.length > 2) ...[
          const SizedBox(height: 12),
          IconButton(
            onPressed: () {
              setState(() {
                _showFullPoem = !_showFullPoem;
              });
            },
            icon: Icon(
              _showFullPoem ? Icons.expand_less : Icons.expand_more,
              color: Colors.purple,
              size: 32,
            ),
            tooltip: _showFullPoem ? "بستن شعر" : "نمایش همه شعر",
          ),
        ],
      ],
    );
  }
}