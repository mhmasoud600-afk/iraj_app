import 'package:flutter/material.dart';
import 'zakerin_detail.dart';

class AhlulBaytSpeakersPage extends StatelessWidget {
  const AhlulBaytSpeakersPage({Key? key}) : super(key: key);

  final List<ZakerModel> speakers = const [
    ZakerModel(
      name: "ملا غضنفر",
      desc: "ذاکر اهل بیت با صدای گرم و تاثیرگذار؛ سال‌ها در مراسم عزاداری ایراج حضور فعال داشت.،تولد 1267 وفات 1351",
      image: "assets/images/ghazanfarr.jpg",
    ),
    ZakerModel(
      name: "ملا میرزا",
      desc: "از ذاکرین قدیمی و محبوب ایراج؛ مجالس ایشان با شور و حال خاصی برگزار می‌شد.",
      image: "assets/images/mirza.jpg",
    ),
    ZakerModel(
      name: "ملا احمد",
      desc: "ذاکر اهل بیت و برگزارکننده مجالس سنتی؛ با صدای حزین خود دل‌ها را می‌لرزاند.",
      image: "assets/images/ahmad.jpg",
    ),
    ZakerModel(
      name: "ملا محمد ابراهیم زاهد",
      desc: "ذاکر بسیار خوش صدای اهل بیت که محتشم می‌خوانده است؛ صدای دلنشین ایشان در مجالس مذهبی طنین‌انداز بوده و اشعار محتشم را با حال و هوایی خاص می‌خوانده‌اند.",
      image: "assets/images/mohammad_ebrahim_zahed.jpg",
    ),
    ZakerModel(
      name: "حاج سید مرتضی موسوی",
      desc: "ذاکر اهل بیت و خطیب توانمند؛ سخنان ایشان همواره با استناد به منابع معتبر همراه بود.،تولد 1280 وفات 1356",
      image: "assets/images/morteza.jpg",
    ),
    ZakerModel(
      name: "استاد ابوالحسن اکبر (قاضی)",
      desc: "ذاکر اهل بیت با شور حسینی؛ مجالس ایشان حال و هوای خاصی داشت.،تولد 1304 وفات 1382",
      image: "assets/images/ghazi.jpg",
    ),
    ZakerModel(
      name: "حاج سید کاظم موسوی",
      desc: "ذاکر اهل بیت و مداح شناخته‌شده؛ در بسیاری از مراسم مذهبی ایراج حضور داشت.",
      image: "assets/images/kazem.jpg",
      audios: [
        ZakerAudio(
          audioPath: "audios/kazem1.ogg",
          title: "قرائت سوره الرحمن",
          description: "صوت از مرحوم حاج سید کاظم موسوی",
          duration: Duration(minutes: 3, seconds: 45),
        ),
      ],
    ),
    ZakerModel(
      name: "حاج محمدحسن موبد",
      desc: "ذاکر اهل بیت با شور حسینی؛ مجالس ایشان حال و هوای خاصی داشت ،تولد1305 وفات 1403.",
      image: "assets/images/mobed.jpg",
      audios: [
        ZakerAudio(
          audioPath: "audios/mobed1.ogg",
          title: "روضه ",
          description: "صوت از مرحوم حاج محمدحسن موبد",
          duration: Duration(minutes: 3, seconds: 45),
        ),
      ],
    ),
    ZakerModel(
      name: "حاج حسین کاشف",
      desc: "ذاکر اهل بیت و برگزارکننده مراسم عاشورا؛ صدای پرشور ایشان در یادها مانده است.",
      image: "assets/images/kashef.jpg",
    ),
    ZakerModel(
      name: "حاج فتح اله رفیع",
      desc: "ذاکر اهل بیت و برگزارکننده مراسم عاشورا؛ صدای پرشور ایشان در یادها مانده است.",
      image: "assets/images/fath.jpg",
    ),
    ZakerModel(
      name: "حاج جعفر اکبر",
      desc: "ذاکر اهل بیت و مداح سنتی؛ با اشعار قدیمی و اصیل مردم را به گریه می‌آورد.",
      image: "assets/images/jafar.jpg",
    ),
    ZakerModel(
      name: "مرحوم حاج فیض اله دانا",
      desc: "ذاکر اهل بیت و مداح سنتی؛ با اشعار قدیمی و اصیل مردم را به گریه می‌آورد.",
      image: "assets/images/feyz.jpg",
    ),
    ZakerModel(
      name: "حاج رسول دانا",
      desc: "ذاکر اهل بیت و خطیب مذهبی؛ سخنان ایشان همواره همراه با نصیحت و پند است.",
      image: "assets/images/rasool.jpg",
    ),
    ZakerModel(
      name: "حاج رضا عشقی",
      desc: "ذاکر اهل بیت با صدای تاثیرگذار؛ مجالس ایشان با حال و هوای خاصی برگزار می‌شود.",
      image: "assets/images/reza.jpg",
    ),
    ZakerModel(
      name: "کربلایی علی یگانه ",
      desc: "ذاکر  جوان  و خوش صدای اهل بیت با صدای تاثیرگذار ؛ مجالس ایشان با حال و هوای خاصی برگزار می‌شود.",
      image: "assets/images/ali_yeganeh.jpg",
    ),
    ZakerModel(
      name: "کربلایی مهدی مرادی ( حبیب ) ",
      desc: "ذاکر جوان  اهل بیت با صدای دلنشنین و تاثیرگذار؛ مجالس ایشان با حال و هوای خاصی برگزار می‌شود.",
      image: "assets/images/mehdi_moradi.jpg",
    ),
    ZakerModel(
      name: "کربلایی حسن ثابتی",
      desc: "ذاکر اهل بیت با صدای رسا و تاثیرگذار.",
      image: "assets/images/hassan_sabati.jpg",
    ),
ZakerModel(
      name: "فاطمه کاشف",
      desc: "مدیر و موسس خانه قرآن و عترت طوبی ایراج از بهمن ۱۳۹۹. فارغ‌التحصیل سال ۱۴۰۵. دارای مدرک مربی‌گری روخوانی و روان خوانی و مدرک مربی‌گری مفاهیم قرآنی از سازمان دارالقرآن کریم اصفهان. از تابستان ۱۳۹۳ تا کنون، جلسات و کلاس‌های قرآن را برای کودکان، نوجوانان (دختر و پسر) و خواهران برگزار می‌کند. همچنین در مجالس بانوان به مدیحه‌سرایی برای اهل بیت (ع) می‌پردازند.",
      image: "assets/images/fatemeh_kashef.jpg",
    ),
    ZakerModel(
      name: "معصومه کاشف",
      desc: "دارای بیش از ده سال سابقه مداحی برای بانوان. در مجالس بانوان به مدیحه‌سرایی برای اهل بیت (ع) می‌پردازند و با صدای دلنشین خود، فضای معنوی مجالس را عطرآگین می‌سازند. دارای مدرک مداحی، آشنایی با مقتل‌شناسی و مقتل‌خوانی از دانشگاه علمی کاربردی فرهنگ و هنر در سال ۱۳۹۴. همچنین گذراندن دوره آموزشی (بانوی هیئت) در اداره تبلیغات اسلامی شهرستان فلاورجان سال ۱۳۹۱.",
      image: "assets/images/masoumeh_kashef.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: speakers.length,
      itemBuilder: (context, index) {
        final s = speakers[index];

        final Color backgroundColor = index.isEven
            ? Colors.green.shade50
            : Colors.green.shade100;
        final Color primaryColor = Colors.green;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade300, width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ZakerinDetail(
                      name: s.name,
                      imagePath: s.image,
                      description: s.desc,
                      audios: s.audios,
                      primaryColor: primaryColor,
                      lightColor: backgroundColor,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  children: [
                    // ========== بخش تصویر اصلاح شده ==========
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade400, width: 2),
                        color: Colors.green[100],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          s.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // اگر تصویر وجود نداشت، آیکون در پس‌زمینه سبز نمایش داده شود
                            return Container(
                              color: Colors.green[100],
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // بخش متن
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            s.name,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 18,
                              fontFamily: "Vazirmatn",
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            s.desc.length > 50 ? s.desc.substring(0, 50) + "..." : s.desc,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontFamily: "Vazirmatn",
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}