import 'package:flutter/material.dart';
import 'detail_page.dart';

class ClergyPage extends StatefulWidget {
  const ClergyPage({Key? key}) : super(key: key);

  @override
  State<ClergyPage> createState() => _ClergyPageState();
}

class _ClergyPageState extends State<ClergyPage> {
  // لیست طلبه‌ها با اطلاعات کامل
  final List<Map<String, String>> clergy = [
    {
      "name": "محمد مرادی",
      "father": "فرزند حبیب",
      "desc": "استاد برجسته حوزه علمیه قم - تدریس سطوح عالی فقه و اصول",
      "image": "",
      "biography": """
محمد مرادی بیش از بیست و پنج سال است که در حوزه علمیه قم به تدریس دروس فقه و اصول (سطوح عالی و خارج) اشتغال دارند.

ایشان از اساتید برجسته و نامآشنای حوزه علمیه قم هستند که سال‌ها در محضر اساتید بزرگ حوزه تلمذ کرده و اکنون خود به عنوان استاد، شاگردان بسیاری را تربیت کرده‌اند.

**سوابق علمی و تدریس:**
• بیش از ۲۵ سال سابقه تدریس دروس فقه و اصول
• تدریس سطوح عالی حوزه (خارج فقه و اصول)
• تربیت شاگردان متعدد در سطوح مختلف حوزه

**محل سکونت:** شهر مقدس قم
    """
    },

    // ============================================================
    // ۲. مائده مرادی
    // ============================================================
    {
      "name": "مائده مرادی",
      "father": "فرزند عبدالرحیم",
      "desc": "فارغ‌التحصیل سطح ۲ حوزه علمیه (لیسانس) روستای ایراج",
      "image": "",
      "biography": """
سال فارغ‌التحصیلی: ۱۳۹۲
۸ سال مبلغ
۴ سال مربی طرح امین در مدارس (ادامه دارد)
همکاری با خانم فاطمه کاشف در خانه قرآن و عترت طوبی ایراج به مدت ۲ سال (ادامه دارد)
    """
    },

    // ============================================================
    // ۳. فاطمه کاشف
    // ============================================================
    {
      "name": "فاطمه کاشف",
      "father": "فرزند اسماعیل",
      "desc": "فارغ‌التحصیل سطح دو حوزه (لیسانس) - مدیر و موسس خانه قرآن و عترت طوبی ایراج",
      "image": "assets/images/clergy/fatemeh_kashef.jpg",
      "biography": """
سال فارغ‌التحصیلی: ۱۴۰۵
مدیر و موسس خانه قرآن و عترت طوبی ایراج از بهمن ۱۳۹۹
دارای مدرک مربی‌گری قرآن‌خوانی و روان‌خوانی
مدرک مربی‌گری مفاهیم قرآنی از سازمان دارالقرآن کریم اصفهان
برگزاری جلسات و کلاس‌های قرآن از تابستان ۹۳ برای کودکان و نوجوانان دختر و پسر و خواهران تا کنون (ادامه دارد)
    """
    },

    // ============================================================
    // ۴. علی یگانه
    // ============================================================
    {
      "name": "علی یگانه",
      "father": "فرزند حسین (عبدل)",
      "desc": "ساکن شهر نائین",
      "image": "assets/images/clergy/ali_yeganeh.jpg",
      "biography": "ساکن شهر نائین"
    },

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildSectionHeader("طلبه‌های روستای ایراج", Colors.green[50]!),
          const SizedBox(height: 16),
          ...clergy.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> item = entry.value;
            return _buildClergyItem(item, index, context);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
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

  Widget _buildClergyItem(Map<String, String> item, int index, BuildContext context) {
    // رنگ‌بندی یک‌درمیان
    Color bgColor = index % 2 == 0 ? Colors.green[50]! : Colors.green[100]!;
    
    // بررسی وجود عکس
    bool hasImage = (item["image"] ?? "").isNotEmpty;
    
    // تشخیص جنسیت برای نمایش آیکون مناسب
    bool isFemale = item["name"]?.contains("مائده") == true ||
        item["name"]?.contains("فاطمه") == true;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
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
          onTap: () => _navigateToDetail(context, item),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // شماره در سمت راست
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index % 2 == 0 ? Colors.green[300] : Colors.green[500],
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

                // عکس یا آیکون
                Container(
                  width: 70,
                  height: 70,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: hasImage ? null : Colors.green[100],
                  ),
                  child: hasImage
                      ? Image.asset(
                          item["image"]!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isFemale ? Icons.person : Icons.person,
                                size: 30,
                                color: Colors.green[800],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isFemale ? 'خانم' : 'آقا',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                
                const SizedBox(width: 16),
                
                // متن اطلاعات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${item["name"] ?? ""} ${item["father"] ?? ""}",
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
                          fontSize: 15,
                          color: Colors.black54,
                          height: 1.6,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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

  void _navigateToDetail(BuildContext context, Map<String, String> item) {
    // آماده‌سازی داده‌ها برای صفحه جزئیات
    Map<String, dynamic> detailItem = {
      "name": "${item["name"] ?? ""} ${item["father"] ?? ""}",
      "desc": item["desc"] ?? "",
      "image": item["image"] ?? "",
      "biography": item["biography"] ?? "",
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