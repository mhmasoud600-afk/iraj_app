import 'package:flutter/material.dart';
import 'detail_page.dart';

class DentistsPage extends StatefulWidget {
  const DentistsPage({Key? key}) : super(key: key);

  @override
  State<DentistsPage> createState() => _DentistsPageState();
}

class _DentistsPageState extends State<DentistsPage> {
  // کنترل‌کننده باز و بسته شدن
  bool _showAll = false;

  // لیست دندانسازان (بدون هیچ مرتب‌سازی)
  final List<Map<String, String>> dentists = [
    {"name": "علی جمشیدی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "اسماعیل نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "امیر احمد نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
 {"name": "صمد کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  {"name": "حاج صادق موبد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
 {"name": "حاج نعمت اله زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  {"name": "حاج مهدی زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  {"name": "محمدعلی زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حمید نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "سعید نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "احمد اقبال", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمود کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "نصرت کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
   
    {"name": "ذبیح اله کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمد کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "داود کاشف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا محمدی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مصطفی نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "کریم عشقی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "سعید هدایت", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  
  
   
    {"name": "حسین زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "علی عشقی (حسن)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مختار عشقی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "هادی مرادی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "ابوالقاسم اشرف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا اشرف", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "جلال نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محسن نجفی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا عشقی (حاج امیر حسین)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا اشرف (علی حسین)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حامد مرادی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "سعید یگانه", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "هادی یگانه", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حسین وهاب", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "بهمن محتشم", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  
    {"name": "مرحوم علی عامری", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا عامری (محمدآقا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
  {"name": "مژگان عشقی ", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمدحسن موبد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم یعقوب ابوالحسنی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "علی بهمن", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم مصطفی بهمن", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرتضی بهمن", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "احمد زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "داود اکبر", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم محمدرضا یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محسن یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محسن زاهد (حاج روح اله)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمدجواد زاهد( حاج اکبر)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم علی رضا زاهد (اسماعیل ملاحسین)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "کمیل یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "شعیب یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "عبدالرضا یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رمضان یزدانی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حسین عشقی (مهدی عبدالله)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم سعید اقبال", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمود اقبال", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حسین یگانه (نظر)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مرحوم عباسعلی زاهد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حبیب اله مسعود( میرزا محمد)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "امیر معتمدی( اسفندیار )", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "رضا معتمدی (اسفندیار)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "صادق مسعود (حاج فرهاد)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "غلامرضا حسنی (حاج سکینه )", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "ابوالفضل یگانه", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "کسری مسعود (حاج حسین)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حسام الدین موبد", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حجت اله مسعود(علیرضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مجتبی نجفی(حاج محمدرضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "جواد عشقی (رضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حاج اصغر عشقی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "داود عشقی (حاج اصغر)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "حاج رمضان ایزدی", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مظاهر اقبال", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محسن یگانه (عبدالرضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمد زاهد(حاج مهدی)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمد زاهد( حاج روح اله)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مهدی اشرف(حاج امیر)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "علیرضا مسعود(شیرعلی)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "فیض اله مسعود (قربانعلی)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "ولی اله مسعود (قربانعلی)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "محمد مسعود (قربانعلی)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "مهدی مرادی (محمدرضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "شبنم عامری", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
    {"name": "عقیل اکبر(محمدرضا)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
{"name": "نادر مسعود (خسرو)", "desc": "دندانساز", "image": "assets/images/dentists/1.jpg"},
{"name": "محمود مسعود (حبیب اله)", "desc": "دندانساز - کرج", "image": "assets/images/dentists/1.jpg"},
  {"name": "داود مسعود (حبیب اله)", "desc": "دندانساز - کرج", "image": "assets/images/dentists/1.jpg"},

  ];

  // تبدیل عدد به فارسی
  String toPersianNumber(int number) {
    const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String englishNumber = number.toString();
    String persianNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      int digit = int.parse(englishNumber[i]);
      persianNumber += persianDigits[digit];
    }
    return persianNumber;
  }

  @override
  Widget build(BuildContext context) {
    // تعیین تعداد آیتم‌هایی که نمایش داده می‌شود
    int displayCount = _showAll ? dentists.length : 5;
    List<Map<String, String>> displayItems = dentists.take(displayCount).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSectionHeader("دندانسازان", Colors.orange[50]!),
          const SizedBox(height: 16),
          
          // لیست اسامی
          ...displayItems.asMap().entries.map((entry) {
            int idx = entry.key;
            Map<String, String> item = entry.value;
            return _buildDentistItem(item, idx);
          }).toList(),
          
          // فلش جمع‌شونده (اگر تعداد کل بیشتر از ۵ باشد)
          if (dentists.length > 5)
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // فلش
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showAll = !_showAll;
                      });
                    },
                    icon: Icon(
                      _showAll ? Icons.expand_less : Icons.expand_more,
                      color: Colors.purple[700],
                      size: 32,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
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
Widget _buildDentistItem(Map<String, String> item, int index) {
  // رنگ‌بندی یک‌درمیان برای هر سطر
  Color bgColor = index % 2 == 0 ? Colors.purple[50]! : Colors.purple[100]!;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        _navigateToDetail(context, item, "dentist");
      },
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // شماره در سمت راست
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index % 2 == 0 ? Colors.purple[300] : Colors.purple[500],
            ),
            child: Center(
              child: Text(
                toPersianNumber(index + 1),
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // متن در سمت چپ شماره
          Expanded(
            child: Text(
              item["name"] ?? "",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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