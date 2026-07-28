// lib/village_intro_page.dart
import 'package:flutter/material.dart';
import '../services/search_service.dart'; // اضافه شد

class VillageIntroPage extends StatelessWidget {
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;

  const VillageIntroPage({
    Key? key,
    this.fontSize = 16,
    this.fontFamily = 'Tahoma',
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  static const List<Map<String, String>> sections = [
    {
      "title": "📍 معرفی کلی روستا",
      "content": "روستای کوهپایه‌ای ایراج با ساختار معماری خشت و گل و سنگ، به روستای سی‌وسه چشمه معروف است، از این روستا در متون قرون سوم و چهارم هجری با نام «ارا» و «ارابه» یاد شده است.\n\nاین روستا دارای قدمتی بیش از 4000 سال است و ساکنان قدیم آن دین زرتشتی داشتند که بقایای قبرستان‌های گبری و همچنین دخمه‌های ساده و ابتدایی از گبرها، گواه بر این ادعا است."
    },
    {
      "title": "🌾 محصولات باغی و زراعی",
      "content": "محصولات باغی این روستا انار، آلو، سیب، گلابی، زردآلو، هلو، گردو، توت سیاه و سفید و انواع انگور و آلبالو و گیلاس و خرما و انجیر سبز و سیاه و زیتون است و محصولات زراعی آن گندم، جو، لوبیا، عدس و کنجد است."
    },
    {
      "title": "🧑‍🌾 مشاغل و معیشت مردم",
      "content": "اهالی روستا به کار کشاورزی و مشاغلی همچون دامداری و کار در معادن اطراف مشغول هستند. جمع‌آوری گیاهان کوهی نیز در کنار امور دیگر به آنان کمک می‌کند. سیستم آبیاری غرقابی مزارع که آب آن از چشمه های روستا تامین می شود و توسط جوی‌های سیمانی به زمین ها منتقل می‌شود."
    },
    {
      "title": "🦊 حیات وحش و محیط زیست",
      "content": "کوه‌های اطراف این روستا به‌شدت مورد حفاظت محیط‌زیست قرار دارد، که دلیل آن وجود صیادان و صید بی‌رویه در این منطقه بسیار زیباست. جانوران وحشی در حاشیه این روستا عبارتند از یوزپلنگ، گرگ، شغال و روباه و پرندگانی چون باز، عقاب، زاغ، کلاغ، و همچنین حیوانات همچون کل، بز کویی،میش و قوچ کوهی ، کبک و طیهو که در این منطقه محافظت می‌شوند."
    },
    {
      "title": "🏡 گردشگری و بوم‌گردی",
      "content": "امروزه روستای ایراج با همیاری جامعه محلی، یکی از مهم‌ترین مراکز گردشگری شهرستان خوروبیابانک است، به گونه‌ای که مردم محلی با ایجاد اقامتگاه‌های بومگردی متنوع و همچنین تربیت راهنما، توانسته‌اند به یکی از نمونه‌های موفق همیاری جوامع محلی در توسعه گردشگری بدل شوند."
    },
    {
      "title": "🌲 سرو کهن ایراج",
      "content": "یکی از نمادهای طبیعی ایراج درخت سرو آن است که در ضلع شرقی قلعه ایراج قرار دارد. قدمت این سرو تنومند بیش از هزار سال است. این سرو زیبا بیش از 70 متر ارتفاع دارد و قطر پایین تنه آن حدود دو متر یا بیشتر می‌باشد. این درخت یادگاری است از نیاکان و ساکنان قدیم این روستا، که گردشگران زیادی را به خود جلب می‌کند."
    },
    {
      "title": "🏰 قلعه ایراج",
      "content": "در مرکز محدوده بافت تاریخی روستای ایراج، بر روی یک تپه صخره‌ای، قلعه تاریخی و کهن با قدمت حدود اوایل اسلامی واقع شده که زیبایی بافت تاریخی روستا را دو چندان کرده است.\n\nساختار معماری این قلعه به‌صورت حیاط مرکزی و چهار ایوانی در چند طبقه با اتاق‌های در اطراف و چهار برج دیده‌بانی در گوشه‌هاست و نشان‌دهنده این است که این بنا یک دژ نظامی بوده است. همچنین این قلعه تاریخی دارای دیوارهای قطور سنگی و خشت و گلی است و چاه آب و راه گریزی در درون قلعه که از آن در مواقع خطر بهره می‌بردند.\n\nاشراف قلعه به دشت و دوردست‌ها و ارتباط و دیدبانی برج‌های نگهبانی در اطراف روستا با قلعه از ویژگی‌های این قلعه‌ی تاریخی است."
    }
  ];

  void _registerForSearch() {
    final service = SearchService();
    
    StringBuffer fullText = StringBuffer();
    fullText.writeln('معرفی روستای ایراج:');
    fullText.writeln();
    
    for (var section in sections) {
      fullText.writeln('${section['title']}');
      fullText.writeln(section['content']);
      fullText.writeln();
    }
    
    service.registerItem(
      SearchItem(
        title: 'معرفی روستا',
        subtitle: 'تاریخ و فرهنگ روستای ایراج',
        searchText: fullText.toString(),
        page: const VillageIntroPage(),
        icon: Icons.home,
        category: 'فرهنگی',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerForSearch();
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(title: const Text("معرفی روستا")),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            final section = sections[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                trailing: const Icon(Icons.category, color: Colors.blueGrey),
                title: Text(
                  section["title"]!,
                  style: TextStyle(
                    fontSize: fontSize + 2,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      section["content"]!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontFamily: fontFamily,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}