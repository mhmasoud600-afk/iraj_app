import 'package:flutter/material.dart';
import 'detail_page.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({Key? key}) : super(key: key);

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  // لیست پزشکان
  final List<Map<String, String>> doctors = [
    {"name": "دکتر فرج اله زاهد", "desc": "دندانپزشک-فارغ التحصیل دانشگاه آزاد تهران -مطب در شهرک قائم  ", "image": "assets/images/doctors/dr_zahed.jpg"},
    {"name": "دکتر حسین اکبر( حاج علی )", "desc": "دندانپزشک", "image": "assets/images/doctors/dr_h_akbar.jpg"},
    {"name": "دکتر مهرناز یازان", "desc": " جراح و دندانپزشک-کلینیک دندانپزشکی تیام  اهواز-مطب دندانپزشکی  تهران بلوار مرزداران", "image": "assets/images/doctors/dr_mehr_yazan.jpg"},
    {"name": "دکتر زکیه مسعود(مهدی)", "desc": "پزشک عمومی-دانش آموخته دانشگاه جندی شاپوراهواز -میمه", "image": "assets/images/doctors/zakiyeh_masoud.jpg"},


  ];

  // لیست پرستاران وکارشناسان
  final List<Map<String, String>> nurses = [
    {"name": "یلدا مسعود( یزدان)", "desc": "تکنسین اتاق عمل - بیمارستان فیروزگر تهران", "image": "assets/images/nurses/yalda_masoud.jpg"},
    {"name": "زهرا دانا(حاج علی )", "desc": "تکنسین اتاق عمل - بیمارستان فیروزگر تهران", "image": "assets/images/nurses/zahra_dana.jpg"},
    {"name": "الهه اکبر( رضا خیاط)", "desc": "کارشناس کاردرمانی- ارتوپدکار- بیمارستان یزد", "image": "assets/images/nurses/elahe_akbar.jpg"},
     {"name": "حدیثه مسعود(مهدی)", "desc": "کارشناس رادیولوژی", "image": "assets/images/nurses/fatemeh_masoud.jpg"},
 {"name": "آرمین مسعود(پرویز)", "desc": "کارشناس رادیولوژی", "image": "assets/images/nurses/armin.jpg"},

     {"name": "ملیحه نجفی(محمدرضا)", "desc": "متولد 1368،کارشناس ارشد مهندسی بهداشت محیط - کانون بازنشستگان اردستان", "image": "assets/images/nurses/malihe.jpg"},


 {"name": "محیا شکوهی فر", "desc": "کارشناس ارشد مشاوره در مامایی،دانشجوی دکترای سلامت باروری و جنسی ،محل کار:بیمارستان تخصصی و فوق تخصصی امام زمان(عج)،بیمارستان تخصصی و فوق تخصصی پاسارگاد", "image": "assets/images/nurses/mahya.jpg"},
    {"name": "فاطمه عشقی(حاج امیرحسین)", "desc": " پرستار زن بخش داخلی یزد", "image": "assets/images/nurses/fatemeh_eshghi.jpg"},
    {"name": "احمد نجفی(محمدرضا)", "desc": "بیمارستان شهید بهشتی اردستان و بیمارستان خورشید اصفهان ،بیمارستان یثربی کاشان، بیمارستان حشمتیه نائین ،کلنیک نگاره شهرک سلامت اصفهان-پرستار مرد بخش داخلی", "image": "assets/images/nurses/ahmad_najafi.jpg"},
    {"name": "معصومه یگانه(شهید علی یگانه)", "desc": " متولد ۱۳۶۱کارشناس پرستاری  ,شاغل در بیمارستان تامین اجتماعی تهران", "image": "assets/images/nurses/masoumeh_yeganeh.jpg"},
    {"name": "امید اکبری(محمدرضا)", "desc": "پرستار بخش داخلی-دانش آموخته دانشگاه شهید بهشتی تهران - تهران", "image": "assets/images/nurses/omid_akbari.jpg"},
{"name": "محبوبه رحمانی(محمدرضا)", "desc": "پرستار", "image": "assets/images/nurses/mahboubeh_rahmani.jpg"},
  {"name": "زهرا یزدانی (اصغر)", "desc": "پرستار", "image": "assets/images/nurses/zahra_yazdani.jpg"},
{
    "name": "امیر مسعود (ناصر)",
    "desc": "پرستار اورژانس ۱۱۵ - بیمارستان تهران پارس، پرستار پاکدشت ۱۱۵ با آمبولانس",
    "image": "assets/images/nurses/amir_masoud.jpg",
  },
  ];

  // لیست دندانپزشکان تجربی
  final List<Map<String, String>> experimentalDentists = [
    {"name": "حاج علی اکبر زاهد", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
    {"name": "حاج امیر قلی عشقی", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/amirfgoli.jpg"},
    {"name": "حاج علی اکبر", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
    {"name": "حاج روح الله زاهد", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمدحسن عامری", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
    {"name": " محمد علی محمدی", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
    {"name": " دکتر محمد یازان", "desc": "دندانپزشک تجربی", "image": "assets/images/dentists/1.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSectionHeader("پزشکان", Colors.pink[50]!),
          ...doctors.map((item) => _buildMedicalItem(item, doctors.indexOf(item), context)).toList(),
          _buildSectionHeader("پرستاران و کارشناسان", Colors.pink[50]!),
          ...nurses.map((item) => _buildMedicalItem(item, nurses.indexOf(item), context)).toList(),
          _buildSectionHeader("دندانپزشکان تجربی", Colors.amber[50]!),
          ...experimentalDentists.map((item) => _buildMedicalItem(item, experimentalDentists.indexOf(item), context)).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.8), width: 2),
      ),
      child: Text(
        title,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildMedicalItem(Map<String, String> item, int index, BuildContext context) {
    Color backgroundColor = index.isEven ? Colors.pink[50]! : Colors.pink[100]!;
    bool hasImage = (item["image"] ?? "").isNotEmpty && item["image"] != "assets/images/dentists/1.jpg";
    bool isDoctor = (item["name"] ?? "").contains("دکتر");
    IconData icon = isDoctor ? Icons.medical_services : Icons.local_hospital;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToDetail(context, item, "medical"),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: hasImage ? null : Colors.pinkAccent[100],
                  ),
                  child: hasImage
                      ? Image.asset(
                          item["image"]!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        )
                      : Center(
                          child: Icon(
                            icon,
                            size: 40,
                            color: Colors.pink[800],
                          ),
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item["name"] ?? "",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["desc"] ?? "",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          height: 1.6,
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
  }

  void _navigateToDetail(BuildContext context, Map<String, String> item, String pageType) {
    Map<String, dynamic> detailItem = {
      "name": item["name"] ?? "",
      "desc": item["desc"] ?? "",
      "image": item["image"] ?? "",
      "biography": "",
      "documents": [],
    };
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(item: detailItem),
      ),
    );
  }
}