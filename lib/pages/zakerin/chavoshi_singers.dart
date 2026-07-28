import 'package:flutter/material.dart';
import 'zakerin_detail.dart';

class ChavoshiSingersPage extends StatelessWidget {
  const ChavoshiSingersPage({Key? key}) : super(key: key);

  final List<ZakerModel> singers = const [
    ZakerModel(
      name: "مرحوم روشنعلی دانا",
      desc: "چاوشی‌خوان سنتی ایراج؛ صدای پرشور ایشان در مراسم بدرقه و استقبال کاروان‌ها شنیده می‌شد.",
      image: "assets/images/roshanali.jpg",
    ),
    ZakerModel(
      name: "مرحوم حاج عباسعلی دانا",
      desc: "چاوشی‌خوان با صدای پرشور؛ در مراسم مذهبی و سنتی نقش مهمی ایفا می‌کرد.",
      image: "assets/images/abbasali.jpg",
    ),
    ZakerModel(
      name: "مرحوم آقا محمد رحمانی (آق ممد)",
      desc: "چاوشی‌خوان با صدای پرشور؛ یکی از کارهای ارزشمند ایشان، شب‌خونی ماه رمضان بود که مردم را برای سحر بیدار می‌کرد: یا رب تو بخشنده و ما گنهکار یا الله...",
      image: "assets/images/aghmohammad.jpg",
    ),
    ZakerModel(
      name: "مرحوم استاد مشهدی",
      desc: "از چاوشی‌خوان‌های نامدار و پیشکسوت ایراج؛ صدای دلنشین ایشان در خاطره‌ها مانده است.",
      image: "assets/images/mashhadi.jpg",
    ),
    ZakerModel(
      name: "مرحوم یوسف اکبر",
      desc: "چاوشی‌خوان با صدای رسا و تأثیرگذار در مراسم مذهبی ایراج.",
      image: "assets/images/yousefakbar.jpg",
    ),
    ZakerModel(
      name: "مرحوم حاج رضا علی معتمدی",
      desc: "از چاوشی‌خوان‌های با اخلاص ایراج؛ در مراسم بدرقه و استقبال زائران حضور فعال داشت.",
      image: "assets/images/moatamedi.jpg",
    ),
    ZakerModel(
      name: "مرحوم ابوالحسن اکبر",
      desc: "چاوشی‌خوان و قاری برجسته ایراج؛ علاوه بر قرائت قرآن، در چاوشی‌خوانی نیز تبحر داشت.",
      image: "assets/images/ghazi_chavoshi.jpg",
    ),
    ZakerModel(
      name: "مرحوم محمد حسن موبد",
      desc: "از چاوشی‌خوان‌های مشهور و با سابقه ایراج؛ صدای گرم ایشان در مراسم مختلف شنیده می‌شد.",
      image: "assets/images/mobed.jpg",
    ),
    ZakerModel(
      name: "مرحوم سید کاظم موسوی",
      desc: "چاوشی‌خوان با صدای پرشور و تأثیرگذار؛ از مفاخر ایراج در حوزه چاوشی‌خوانی.",
      image: "assets/images/mousavi.jpg",
    ),
    ZakerModel(
      name: "حاج علی ثابتی",
      desc: "چاوشی‌خوان با اخلاص و صدای دلنشین؛ در مراسم مذهبی ایراج فعال بوده است.",
      image: "assets/images/ali_sabti.jpg",
    ),
    ZakerModel(
      name: "حاج محمد دانا",
      desc: "چاوشی‌خوان و مداح با سابقه ایراج؛ در مجالس مذهبی به چاوشی‌خوانی می‌پرداخت.",
      image: "assets/images/mohammad_dana.jpg",
    ),
    ZakerModel(
      name: "حاج محمدعلی دانا",
      desc: "چاوشی‌خوان سنتی ایراج؛ صدای پرشور ایشان در مراسم بدرقه و استقبال کاروان‌ها شنیده می‌شد.",
      image: "assets/images/mohammadali_dana.jpg",
    ),
    ZakerModel(
      name: "حاج عبدالحسین اکبر",
      desc: "از چاوشی‌خوان‌های خوش صدای ایراج؛ در مراسم مذهبی و سنتی حضور فعال داشت.",
      image: "assets/images/abdolhosein_akbar.jpg",
    ),
    ZakerModel(
      name: "کربلایی حسن عشقی (حسن دکتر)",
      desc: "چاوشی‌خوان با صدای پرشور و تأثیرگذار؛ در مراسم سوگواری ایراج چاوشی می‌خواند و در محافل مذهبی با صدای خوش خود حضور داشت.",
      image: "assets/images/eshghi.jpg",
    ),
    ZakerModel(
      name: "رمضانعلی یگانه",
      desc: "چاوشی‌خوان با سابقه و خوش صدای ایراج؛ در مراسم مذهبی و سنتی چاوشی می‌خواند.",
      image: "assets/images/ramazani_yeganeh.jpg",
    ),
    ZakerModel(
      name: "حاج رسول دانا",
      desc: "چاوشی‌خوان و پیشکسوت ایراج؛ با صدای پرشور خود در مراسم بدرقه و استقبال کاروان‌ها حضور فعال داشته است.",
      image: "assets/images/rasoul_dana.jpg",
    ),
    ZakerModel(
      name: "حاج کربلایی غلامرضا زاهد",
      desc: "چاوشی‌خوان با سابقه و خوش صدای ایراج؛ در مراسم مذهبی و سنتی چاوشی می‌خواند و صدای پرشور ایشان در خاطره‌ها مانده است.",
      image: "assets/images/gholamreza_zahed.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: singers.length,
      itemBuilder: (context, index) {
        final s = singers[index];

        final Color backgroundColor = index.isEven
            ? Colors.blue.shade50
            : Colors.blue.shade100;
        final Color primaryColor = Colors.blue;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade300, width: 1),
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
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade400, width: 2),
                        color: Colors.blue[100],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          s.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.blue[100],
                              child: const Icon(
                                Icons.music_note,
                                size: 40,
                                color: Colors.blue,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
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