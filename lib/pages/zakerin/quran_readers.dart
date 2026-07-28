import 'package:flutter/material.dart';
import 'zakerin_detail.dart';

class QuranReadersPage extends StatelessWidget {
  const QuranReadersPage({Key? key}) : super(key: key);

  final List<ZakerModel> readers = const [
    ZakerModel(
      name: "استاد ابوالحسن اکبر (قاضی)",
      desc: "از مطرح ترین قاریان و حافظان قرآن در ایراج؛ سال‌ها به بچه‌ها قرآن آموزش می‌داد و بسیاری از مردم ایراج قرائت قرآن را محضر ایشان آموزش دیده‌اند.",
      image: "assets/images/ghazi.jpg",
    ),
ZakerModel(
  name: "مرحوم حاج سید کاظم موسوی",
  desc: "قاری برجسته و خوش صدای قرآن در ایراج که همواره در محافل قرآنی و مذهبی حضور فعال داشته است. تلاوت ایشان با صوت و لحن زیبا، در یادها باقی مانده و بسیاری از جوانان ایراجی از محضر ایشان بهره برده‌اند. روحش شاد و یادش گرامی.",
  image: "assets/images/kazem.jpg",
),
    ZakerModel(
      name: "حاج فیض‌الله دانا",
      desc: "از قاریان برجسته و پیشکسوت قرآن در ایراج؛ سال‌ها در محافل قرآنی و هیئات مذهبی به تلاوت قرآن پرداخته و نقش مؤثری در ترویج فرهنگ قرآنی داشته‌اند.",
      image: "assets/images/feizollah.jpg",
    ),
    ZakerModel(
      name: "حاج رسول دانا",
      desc: "ایشان مدت ۴۵ سال مسئول قرآن هیئت چهارده معصوم بوده‌اند. در سال ۵۴ علم تجوید و صوت و لحن را نزد استاد فولادیان در مدرسه باقرالعلوم و نزد مرحوم علی اوسط مشکینی (برادر آیت‌الله مشکینی) آموخته‌اند. همچنین علم تجوید را در ایراج به مرحوم قاضی، مرحوم حسین کاشف و سیدکاظم آموزش داده‌اند.",
      image: "assets/images/rasoul.jpg",
    ),
    ZakerModel(
      name: "ملا بخشعلی",
      desc: "از قاریان قدیمی قرآن در ایراج؛ صدای گرم و تسلط ایشان بر آیات همگان را مجذوب می‌کرد.",
      image: "assets/images/bakhshali.jpg",
    ),
    ZakerModel(
      name: "حبیب نجفی",
      desc: "قاری قرآن در ایراج.",
      image: "assets/images/najafi.jpg",
    ),
    ZakerModel(
      name: "حاج علی اکبر",
      desc: "قاری قرآن در ایراج.",
      image: "assets/images/hajali.jpg",
    ),
    ZakerModel(
      name: "لطف‌الله زاهد",
      desc: "از قاریان خوش صدای قرآن در ایراج.",
      image: "assets/images/lotfollah.jpg",
    ),
    ZakerModel(
      name: "فرج‌الله زاهد",
      desc: "از قاریان پیشکسوت قرآن در ایراج.",
      image: "assets/images/farajollah.jpg",
    ),
    ZakerModel(
      name: "قربانعلی دانا",
      desc: "از قاریان قدیمی و خوش تلاوت قرآن در ایراج.",
      image: "assets/images/ghorbanali.jpg",
    ),
    ZakerModel(
      name: "اسماعیل دانا",
      desc: "از قاریان با سابقه قرآن در ایراج.",
      image: "assets/images/esmaeil.jpg",
    ),
    ZakerModel(
      name: "مرحوم عباسعلی زاهد شیرعلی",
      desc: "از قاریان فقید و نامدار قرآن در ایراج؛ یادش گرامی.",
      image: "assets/images/abbasali.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: readers.length,
      itemBuilder: (context, index) {
        final r = readers[index];

        final Color backgroundColor = index.isEven
            ? Colors.orange.shade50
            : Colors.orange.shade100;
        final Color primaryColor = Colors.orange;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade300, width: 1),
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
                      name: r.name,
                      imagePath: r.image,
                      description: r.desc,
                      audios: r.audios,
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
                        border: Border.all(color: Colors.orange.shade400, width: 2),
                        color: Colors.orange[100],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          r.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.orange[100],
                              child: const Icon(
                                Icons.menu_book,
                                size: 40,
                                color: Colors.orange,
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
                            r.name,
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
                            r.desc.length > 50 ? r.desc.substring(0, 50) + "..." : r.desc,
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