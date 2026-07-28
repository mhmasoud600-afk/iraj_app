import 'package:flutter/material.dart';
import 'zakerin_detail.dart';

class NoheSingersPage extends StatelessWidget {
  const NoheSingersPage({Key? key}) : super(key: key);

  final List<ZakerModel> nohe = const [
    ZakerModel(
      name: "مرحوم حاج اکبر مسعود",
      desc: "نوحه‌خوان با شور و تاثیرگذاری بالا؛ با نوحه معروف سقای سپاه غریبان ای عمو‌جان یا ابوالفضل آب آور خیمه شهیدان ای عمو‌جان یا ابوالفضل...",
      image: "assets/images/akbar.jpg",
    ),
    ZakerModel(
      name: "مرحوم ذبیح‌اله اکبر",
      desc: "نوحه‌خوان سنتی با صدای حزین؛ نوحه‌های ایشان در مراسم محرم بسیار تاثیرگذار بود.،تولد 1333 وفات 1395",
      image: "assets/images/zabih.jpg",
      audios: [
        ZakerAudio(
          audioPath: "audios/nohe2.ogg",
          title: "نوحه خوانی",
          description: "صوت از مرحوم ذبیح‌اله اکبر",
          duration: Duration(minutes: 8, seconds: 49),
        ),
        ZakerAudio(
          audioPath: "audios/nohe3.ogg",
          title: "صبح روسیاه",
          description: "صوت از مرحوم ذبیح‌اله اکبر",
          duration: Duration(minutes: 21, seconds: 50),
        ),
        ZakerAudio(
          audioPath: "audios/nohe4.ogg",
          title: "نوحه خوانی",
          description: "صوت از مرحوم ذبیح‌اله اکبر",
          duration: Duration(minutes: 12, seconds: 38),
        ),
      ],
    ),
    ZakerModel(
      name: "مرحوم فضل‌اله اکبر",
      desc: "نوحه‌خوان با شور و تاثیرگذاری بالا؛ مجالس ایشان حال و هوای خاصی داشت ،تولد 1328 وفات 1396.",
      image: "assets/images/fazl.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nohe.length,
      itemBuilder: (context, index) {
        final n = nohe[index];

        final Color backgroundColor = index.isEven
            ? Colors.purple.shade50
            : Colors.purple.shade100;
        final Color primaryColor = Colors.purple;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple.shade300, width: 1),
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
                      name: n.name,
                      imagePath: n.image,
                      description: n.desc,
                      audios: n.audios,
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
                        border: Border.all(color: Colors.purple.shade400, width: 2),
                        color: Colors.purple[100],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          n.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.purple[100],
                              child: const Icon(
                                Icons.music_note,
                                size: 40,
                                color: Colors.purple,
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
                            n.name,
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
                            n.desc.length > 50 ? n.desc.substring(0, 50) + "..." : n.desc,
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