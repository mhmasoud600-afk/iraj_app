// lib/pages/mosque/mosque_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد
import 'mosque_detail.dart';

class MosquePage extends StatefulWidget {
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;

  const MosquePage({
    Key? key,
    required this.fontSize,
    required this.fontFamily,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<MosquePage> createState() => _MosquePageState();
}

class _MosquePageState extends State<MosquePage> with SearchableMixin {
  
  final List<Map<String, String>> mosques = const [
    {
      "name": "مسجد امام حسین (ع)",
      "desc": """مسجد امام‌حسین (ع) بزرگترین مسجد روستاست که بسیاری از مراسمات ملی و مذهبی و مراسمات ختم در این مسجد برگزار می‌شود. پایه‌ریزی این مسجد توسط مرحوم‌حاج مهدی نجفی انجام شد و نقش ایشان در توسعه و تکمیل این مسجد بسیار حائز اهمیت بود. همچنین جناب آقای حاج جعفر اکبر نیز از مؤسسین و اعضای هیات امنای مسجد است که سالهای سال زحمت جمع‌آوری پول برای ساخت و توسعه و نگهداری مسجد را برعهده داشته‌اند.

به دلیل اینکه این مسجد با کمک‌های مردمی ساخته شده است، بسیاری از مردم این مسجد را بر حق می‌دانند و در گرفتاری‌های خود نذر این مسجد می‌کنند و در بسیاری از مواقع حاجت‌روا می‌شوند.

در حال حاضر مسجد دارای هیات امنا و روحانی مقیم می‌باشد. همچنین کانون فرهنگی شهدای روستا و پایگاه بسیج شهدای روستا نیز در این مسجد مستقر هستند و برنامه‌های فرهنگی را برگزار می‌کنند.""",
      "image": "assets/images/mosque/imam_hossein.jpg"
    },
    {
      "name": "مسجد جامع ایراج",
      "desc": """این مسجد از قدیمی‌ترین مساجد روستا بوده است که بنای قبلی آن تخریب و بنای جدید ساخته شده است. این مسجد دارای موقوفاتی می‌باشد که سالهاست مرحوم‌حاج اکبر یزدانی زحمت ساخت و تعمیر و نگهداری آن را بعهده داشت.

از این مسجد برای برگزاری نماز جماعت در محله توده استفاده می‌شود و برخی از مراسمات در ایام خاص (عید نوروز و..) نیز در آن برگزار می‌گردد.""",
      "image": "assets/images/mosque/jame_mosque.jpg"
    },
    {
      "name": "حسینیه",
      "desc": """حسینیه روستا با سبک قدیمی و شبستانی آن یکی از نقاط زیبای گردشگری روستاست.

در تمام سال در شب‌های سه‌شنبه و جمعه مراسم دعای پرفیض توسل و کمیل برگزار می‌شود و در کل ماه محرم و صفر، هرشب مراسم عزاداری و نوحه‌خوانی آقا عبدالله الحسین (ع) در این محل برگزاری می‌شود. در برخی از ایام سال مثل دهه فاطمیه هم با توجه به حضور مداح اهل بیت حاج رسول دانا نیز مراسماتی برگزار می‌گردد.

چند سالی است به همت و حمایت دکتر اسماعیل نجفی و دکتر محمدیازان و آقای مصطفی ایزدی و... در دهه اول محرم سقف حیاط حسینیه پوشانده می‌شود و مراسم سوگواری هر شب برگزار می‌گردد که فضایی بسیار دلنشین ایجاد شده است.

مردم روستا هم در ایام دهه اول محرم هم در مسجد امام حسین (ع) و هم در حسینیه حضور پیدا می‌کنند و به عزاداری می‌پردازند.""",
      "image": "assets/images/mosque/hoseinieh.jpg"
    },
    {
      "name": "مسجد امام حسن (ع)",
      "desc": "این مسجد یک مسجد محلی کوچک است که اهالی محل برای اقامه نماز از آن استفاده می‌کنند.",
      "image": "assets/images/mosque/imam_hassan.jpg"
    },
    {
      "name": "مسجد امام جعفر صادق (ع)",
      "desc": "این مسجد یک مسجد محلی کوچک است که اهالی محل برای اقامه نماز از آن استفاده می‌کنند.",
      "image": "assets/images/mosque/imam_sadegh.jpg"
    },
    {
      "name": "(کلا ابراهیم) مسجد کربلایی ابراهیم",
      "desc": "این مسجد یک مسجد محلی کوچک است که اهالی محل برای اقامه نماز از آن استفاده می‌کنند.",
      "image": "assets/images/mosque/kola_ebrahim.jpg"
    },
    {
      "name": "مسجد لب جوب",
      "desc": "این مسجد یک مسجد محلی کوچک است که اهالی محل برای اقامه نماز از آن استفاده می‌کنند.",
      "image": "assets/images/mosque/lab_hoz.jpg"
    },
    {
      "name": "مسجد کنار خونه سید کاظم موسوی",
      "desc": "این مسجد یک مسجد محلی کوچک است که اهالی محل برای اقامه نماز از آن استفاده می‌کنند.",
      "image": "assets/images/mosque/kazem.jpg"
    },
  ];

  final List<Map<String, String>> shrines = const [
    {
      "name": "امامزاده بالا",
      "desc": """زیارتگاه بالا به دلیل اینکه در بالای روستا و در بلندی قرار دارد به این نام نامگذاری شده است. لیکن از شخص مدفون اطلاعاتی در دست نیست. برخی از افراد بومی روستا با توجه به خوابی که دیده‌اند شخص مدفون را یک زن می‌دانند، لیکن تاکنون شجره‌نامه‌ای برای ایشان تهیه نشده است.""",
      "image": "assets/images/mosque/emamzadeh_bala.jpg"
    },
    {
      "name": "امامزاده پایین",
      "desc": """این زیارتگاه هم مثل زیارتگاه بالا به دلیل قرارگیری در پایین روستا به این اسم نامگذاری شده است و شجره‌نامه‌ای برای ایشان تهیه نشده است.""",
      "image": "assets/images/mosque/emamzadeh_paein.jpg"
    },
    {
      "name": "بقعه خضر نبی (ع)",
      "desc": """بقعه خضر نبی (ع) در بافت قدیم شمال غربی ایراج واقع گردیده است. خضر پیامبر در حال گذر از این روستا، در محل مذکور توقف کوتاهی داشته و یکی از موحّدین این روستا ایشان را به چشم دیده و گفتگویی بین آنها صورت گرفته است که پس از آن گنبد و ایوان کوچکی جهت احترام به این پیامبر احداث گردیده که زیارتگاه مردم خداجوی این روستا است و در بعضی از ایام سال در این محل آش نذری طبخ و توزیع می‌گردد.""",
      "image": "assets/images/mosque/khajeh_khezr.jpg"
    },
    {
      "name": "مزار حاج عیسی بیابانکی",
      "desc": " ایشان یکی از عارفان منطقه بیابانک بودند که مزار ایشان در ایراج و کنار منزل عالم ( روحانی ) می باشد .",
      "image": "assets/images/mosque/haj_isa.jpg"
    },
    {
      "name": "زیارتگاه صحابه",
      "desc": """این زیارتگاه به نام صحابه نامگذاری شده است، لیکن اطلاعات دقیقی از شخص مدفون در دست نیست. احتمال می‌رود که ایشان یکی از صحابه امام رضا (ع) باشند که بعد از هجرت ایشان به طوس، در این محل فوت یا کشته شده باشند. مردم روستا برای زیارت بر سر قبر ایشان حاضر می‌شوند محل آرامگاه ایشان ابتدای گلزار شهدای ایراج می باشد .""",
      "image": "assets/images/mosque/sahabeh.jpg"
    },
  ];

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'مساجد روستا';
  
  @override
  String get pageSubtitle => 'مساجد قدیمی و جدید روستا';
  
  @override
  String get pageCategory => 'مذهبی';
  
  @override
  IconData get pageIcon => Icons.mosque;
  
  @override
  Widget get pageWidget => MosquePage(
        fontSize: widget.fontSize,
        fontFamily: widget.fontFamily,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
      );

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو از مساجد و زیارتگاه‌ها
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('مساجد و زیارتگاه‌های روستای ایراج:');
    fullText.writeln();
    
    fullText.writeln('--- مساجد ---');
    for (var mosque in mosques) {
      fullText.writeln('نام: ${mosque['name']}');
      fullText.writeln('توضیحات: ${mosque['desc']}');
      fullText.writeln();
    }
    
    fullText.writeln('--- زیارتگاه‌ها ---');
    for (var shrine in shrines) {
      fullText.writeln('نام: ${shrine['name']}');
      fullText.writeln('توضیحات: ${shrine['desc']}');
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: AppBar(
          title: Text(
            "مساجد و زیارتگاه‌ها",
            style: TextStyle(
              fontSize: widget.fontSize + 4,
              fontFamily: widget.fontFamily,
              color: widget.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "مساجد",
                  style: TextStyle(
                    fontSize: widget.fontSize + 2,
                    fontFamily: widget.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "زیارتگاه‌ها",
                  style: TextStyle(
                    fontSize: widget.fontSize + 2,
                    fontFamily: widget.fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(context, mosques, isMosque: true),
            _buildList(context, shrines, isMosque: false),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Map<String, String>> items, {required bool isMosque}) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        final Color backgroundColor;
        if (isMosque) {
          backgroundColor = index % 2 == 0
              ? Colors.blue.shade50
              : Colors.blue.shade100;
        } else {
          backgroundColor = index % 2 == 0
              ? Colors.green.shade50
              : Colors.green.shade100;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: backgroundColor,
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: GestureDetector(
              onTap: () {
                _showImageDialog(context, item, isMosque: isMosque);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: isMosque ? Colors.blue.shade300 : Colors.green.shade300,
                    width: 2,
                  ),
                ),
                child: item["image"]!.startsWith("assets/images/mosque/") && item["image"]! != "assets/images/mosque/.jpg"
                    ? ClipOval(
                        child: Image.asset(
                          item["image"]!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              isMosque ? Icons.mosque : Icons.account_balance,
                              color: isMosque ? Colors.blue : Colors.green,
                              size: 28,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Icon(
                          isMosque ? Icons.mosque : Icons.account_balance,
                          color: isMosque ? Colors.blue : Colors.green,
                          size: 28,
                        ),
                      ),
              ),
            ),
            title: Row(
              children: [
                Icon(
                  isMosque ? Icons.mosque_outlined : Icons.place_outlined,
                  color: isMosque ? Colors.blue : Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize,
                      fontFamily: widget.fontFamily,
                      color: widget.textColor,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item["desc"]!.length > 100
                    ? '${item["desc"]!.substring(0, 100)}...'
                    : item["desc"]!,
                style: TextStyle(
                  fontSize: widget.fontSize - 2,
                  fontFamily: widget.fontFamily,
                  color: widget.textColor.withOpacity(0.8),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MosqueDetail(
                    name: item["name"]!,
                    imagePath: item["image"]!,
                    description: item["desc"]!,
                    fontSize: widget.fontSize,
                    fontFamily: widget.fontFamily,
                    textColor: widget.textColor,
                    backgroundColor: backgroundColor,
                    isMosque: isMosque,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showImageDialog(BuildContext context, Map<String, String> item, {required bool isMosque}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: item["image"]!.startsWith("assets/images/mosque/") && item["image"]! != "assets/images/mosque/.jpg"
                    ? DecorationImage(
                        image: AssetImage(item["image"]!),
                        fit: BoxFit.contain,
                      )
                    : null,
                color: isMosque ? Colors.blue.shade100 : Colors.green.shade100,
              ),
              child: item["image"]!.isEmpty || item["image"] == "assets/images/mosque/.jpg" || !item["image"]!.startsWith("assets/images/mosque/")
                  ? Center(
                      child: Icon(
                        isMosque ? Icons.mosque : Icons.account_balance,
                        size: 100,
                        color: isMosque ? Colors.blue : Colors.green,
                      ),
                    )
                  : null,
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}