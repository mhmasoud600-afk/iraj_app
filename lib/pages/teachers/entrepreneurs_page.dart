import 'package:flutter/material.dart';
import 'detail_page.dart';

class EntrepreneursPage extends StatefulWidget {
  const EntrepreneursPage({Key? key}) : super(key: key);

  @override
  State<EntrepreneursPage> createState() => _EntrepreneursPageState();
}

class _EntrepreneursPageState extends State<EntrepreneursPage> {
  final List<Map<String, String>> entrepreneurs = [
    {
      "name": "دکتر حاج علی اکبر",
      "desc": "دندانپزشک تجربی که چندین منزل قدیمی را با هزینه زیاد در ایراج بازسازی و اولین اقامتگاه بوم‌گردی ایراج بنام ارابه را احداث نمود که باعث رونق گردشگری در ایراج شده است.",
      "image": "assets/images/elites/1.jpg",
      "biography": """
دکتر حاج علی اکبر از چهره‌های شاخص و پیشرو در حوزه گردشگری و احیای بافت تاریخی ایراج هستند. 
ایشان با هزینه شخصی و با هدف حفظ و احیای معماری سنتی، چندین منزل قدیمی را بازسازی نمودند.
اولین اقامتگاه بوم‌گردی ایراج به نام «ارابه» توسط ایشان احداث شد که نقش مهمی در رونق گردشگری منطقه داشته است.
تلاش‌های ایشان در حفظ هویت تاریخی ایراج، الگویی برای دیگر سرمایه‌گذاران منطقه شده است.
      """
    },
    {
      "name": "دکتر محمد یازان",
      "desc": "دندانپزشک تجربی که یک باغ در کنار تهجوی ایراج را خریداری و با هزینه زیاد به سفره‌خانه سنتی و آسیاب آبی تبدیل نمود که مکانی دلنواز برای همشهریان و گردشگران ایجاد شده است. این سفره خانه به نام مادر مرحوم ایشان، جیران، نامگذاری شده است.",
      "image": "assets/images/elites/1.jpg",
      "biography": """
دکتر محمد یازان با نگاه کارآفرینانه و عشق به زادگاهش، یکی از زیباترین فضاهای گردشگری ایراج را خلق کرده است.
ایشان باغی کنار تهجوی ایراج را خریداری و با سرمایه‌گذاری گسترده، آن را به سفره‌خانه سنتی و آسیاب آبی تبدیل نمودند.
این مجموعه به نام مادر مرحوم ایشان، «جیران» نام‌گذاری شده و به یکی از مقاصد محبوب گردشگران و همشهریان تبدیل شده است.
ایشان نشان دادند که با عشق به وطن و سرمایه‌گذاری هوشمندانه، می‌توان رونق و نشاط را به منطقه بازگرداند.
      """
    },
    {
      "name": "امید شجاعی",
      "desc": "یکی از افراد تحصیلکرده در رسته معماری سنتی است که سال‌ها در مناطق مختلف کشور کار کرده بودند (شهر میمند کرمان) و بعد از اینکه به ایراج آمدند تعداد زیادی از منازل قدیمی که در حال تخریب بود را برای همشهریان بازسازی نمودند.",
      "image": "assets/images/elites/1.jpg",
      "biography": """
امید شجاعی از متخصصان برجسته معماری سنتی است که سال‌ها تجربه کار در مناطق مختلف کشور، از جمله شهر تاریخی میمند کرمان، را دارد.
ایشان پس از بازگشت به ایراج، با تخصص و تجربه خود، تعداد زیادی از منازل قدیمی که در حال تخریب بودند را بازسازی نمودند.
تلاش‌های ایشان در حفظ بافت تاریخی و احیای معماری سنتی ایراج، نقشی اساسی در ماندگاری هویت معماری این روستا داشته است.
امید شجاعی با کار خود، نشان داد که می‌توان با حفظ اصالت، به معماری سنتی جان دوباره بخشید.
      """
    },
    {
      "name": "احمد مسعود",
      "desc": "ایشان فرزند شهید کوچعلی مسعود هستند که چند سال قبل مرغداری ایراج را راه‌اندازی نمودند و چند سال نیز اقدام به جوجه‌ریزی کردند و در حال حاضر نیز این مرغداری به‌صورت اجاره‌ای در حال کار می‌باشد.",
      "image": "assets/images/elites/1.jpg",
      "biography": """
احمد مسعود، فرزند شهید کوچعلی مسعود، با روحیه کارآفرینی و تلاش، مرغداری ایراج را راه‌اندازی نمودند.
ایشان با سرمایه‌گذاری در این حوزه، علاوه بر ایجاد اشتغال در منطقه، نقش مهمی در تأمین نیازهای غذایی مردم داشته‌اند.
با وجود چالش‌های مختلف، این مرغداری همچنان به‌صورت اجاره‌ای فعال است و به اقتصاد منطقه کمک می‌کند.
ایشان نشان دادند که می‌توان با پشتکار و تلاش، در مسیر توسعه روستا گام برداشت.
      """
    },
    {
      "name": "دکتر فرج اله زاهد",
      "desc": "ایشان دندانپزشک هستند و ساکن تهران؛ و در سال ۱۳۹۵ مزرعه خرم‌آباد را خریداری و تاکنون هزینه‌های زیادی برای قنات آن انجام داده‌اند و برنامه‌های خوبی برای توسعه آن در نظر دارند.",
      "image": "assets/images/elites/drzahed.jpg",
      "biography": """
دکتر فرج اله زاهد، دندانپزشک ساکن تهران، از سرمایه‌گذاران علاقه‌مند به زادگاه خود ایراج هستند.
ایشان در سال ۱۳۹۵ مزرعه خرم‌آباد را خریداری نمودند و از آن زمان تاکنون هزینه‌های زیادی برای احیای قنات و توسعه این مزرعه انجام داده‌اند.
برنامه‌های خوبی برای توسعه این مجموعه در نظر دارند که می‌تواند نقش مهمی در رونق کشاورزی و گردشگری منطقه داشته باشد.
ایشان با این سرمایه‌گذاری، نشان دادند که حتی با وجود سکونت در تهران، همچنان دلبسته زادگاه خود هستند.
      """
    },
    {
      "name": "مهندس حسن اشرف",
      "desc": "ایشان مهندس شیمی و ساکن کرج هستند و چند سال قبل به همراه دکتر محمود کاشف (دندانساز) مزرعه اوشکوه را خریداری نمودند و تا کنون هزینه‌های زیادی برای بحث استخر و کاشت درخت و ساختمان انجام داده‌اند.",
      "image": "assets/images/elites/1.jpg",
      "biography": """
مهندس حسن اشرف، مهندس شیمی ساکن کرج، به همراه دکتر محمود کاشف (دندانساز)، مزرعه اوشکوه را خریداری نمودند.
ایشان تاکنون هزینه‌های زیادی برای احداث استخر، کاشت درختان مختلف و ساخت ساختمان‌های مورد نیاز در این مزرعه انجام داده‌اند.
تلاش‌های ایشان در توسعه و آبادانی این مزرعه، نشان‌دهنده عشق و علاقه به زادگاه خود است.
این سرمایه‌گذاری می‌تواند به الگویی برای دیگر افراد مقیم خارج از روستا تبدیل شود.
      """
    },
    {
      "name": "فرهاد نجفی",
      "desc": "کارآفرین خوش‌فکر ایراج که کارگاه بلوک‌زنی را در ایراج راه‌اندازی کرده و باعث اشتغالزایی برای جوانان منطقه شده است. تولید بلوک‌های ساختمانی با کیفیت بالا، نقش مهمی در توسعه عمرانی روستا داشته است.",
      "image": "assets/images/elites/default.jpg",
      "biography": """
فرهاد نجفی از کارآفرینان موفق و پرتلاش ایراج هستند که با راه‌اندازی کارگاه بلوک‌زنی، نقش مهمی در توسعه عمرانی منطقه ایفا کرده‌اند.
ایشان با سرمایه‌گذاری شخصی و با استفاده از نیروی کار جوانان منطقه، توانسته‌اند واحد تولیدی موفقی را ایجاد نمایند.
تولید بلوک‌های ساختمانی با کیفیت بالا، نیاز منطقه به مصالح ساختمانی را تأمین کرده و باعث کاهش هزینه‌های ساخت‌وساز در ایراج شده است.
فرهاد نجفی با کار خود نشان داده که می‌توان با ایجاد کسب‌وکارهای کوچک، به اشتغالزایی و توسعه منطقه کمک کرد.
ایشان الگویی برای جوانان جویای کار در روستا هستند.
      """
    },
    {
      "name": "خانم رحیمی",
      "desc": "کارآفرین خلاق و هنرمند ایراج که کارگاه کرباس‌بافی را در ایراج ایجاد کرده است. احیای هنر سنتی کرباس‌بافی و تولید محصولات با کیفیت، باعث معرفی فرهنگ و هنر ایراج به دیگر مناطق شده است.",
      "image": "assets/images/elites/default.jpg",
      "biography": """
خانم رحیمی از کارآفرینان خلاق و هنرمند ایراج هستند که با احیای هنر سنتی کرباس‌بافی، گامی مؤثر در حفظ و ترویج صنایع دستی منطقه برداشته‌اند.
ایشان با راه‌اندازی کارگاه کرباس‌بافی، علاوه بر ایجاد اشتغال برای بانوان منطقه، محصولات باکیفیتی تولید می‌کنند که مورد توجه گردشگران و هنردوستان قرار گرفته است.
تلاش‌های ایشان در احیای این هنر ارزشمند، نقش مهمی در معرفی فرهنگ و هنر ایراج به سایر مناطق داشته است.
خانم رحیمی با کار خود، به بانوان منطقه نشان داده که می‌توانند با هنر و خلاقیت خود، هم به اشتغالزایی بپردازند و هم به حفظ میراث فرهنگی کمک کنند.
      """
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: entrepreneurs.length,
      itemBuilder: (context, index) =>
          _buildEntrepreneurItem(entrepreneurs[index], index, context),
    );
  }

  Widget _buildEntrepreneurItem(
      Map<String, String> item, int index, BuildContext context) {
    Color backgroundColor =
        index.isEven ? Colors.purple[50]! : Colors.purple[100]!;
    bool hasImage = (item["image"] ?? "").isNotEmpty &&
        item["image"] != "assets/images/elites/1.jpg" &&
        item["image"] != "assets/images/elites/default.jpg";
    IconData icon =
        _getIconForEntrepreneur(item["name"] ?? "", item["desc"] ?? "");

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
          onTap: () => _navigateToDetail(context, item),
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
                    color: hasImage ? null : Colors.purpleAccent[100],
                  ),
                  child: hasImage
                      ? Image.asset(
                          item["image"]!,
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                icon,
                                size: 40,
                                color: Colors.purple[800],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            icon,
                            size: 40,
                            color: Colors.purple[800],
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          height: 1.5,
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

  IconData _getIconForEntrepreneur(String name, String desc) {
    if (desc.contains("گردشگری") || desc.contains("بوم‌گردی")) {
      return Icons.travel_explore;
    } else if (desc.contains("دندانپزشک")) {
      return Icons.medical_services;
    } else if (desc.contains("مرغداری") || desc.contains("جوجه")) {
      return Icons.agriculture;
    } else if (desc.contains("معماری") || desc.contains("بازسازی")) {
      return Icons.architecture;
    } else if (desc.contains("مزرعه") || desc.contains("قنات")) {
      return Icons.park;
    } else if (desc.contains("شیمی")) {
      return Icons.science;
    } else if (desc.contains("بلوک") || desc.contains("ساختمانی")) {
      return Icons.factory;
    } else if (desc.contains("کرباس") || desc.contains("بافی")) {
      return Icons.brush;
    }
    return Icons.person;
  }

  void _navigateToDetail(BuildContext context, Map<String, String> item) {
    Map<String, dynamic> detailItem = {
      "name": item["name"] ?? "",
      "desc": item["desc"] ?? "",
      "image": item["image"] ?? "",
      "biography": item["biography"] ?? """
زندگینامه ${item["name"]}:

${item["name"]} از کارآفرینان موفق و پیشرو ایراج هستند که با سرمایه‌گذاری و تلاش خود، نقش مهمی در توسعه و آبادانی منطقه داشته‌اند.

ایشان با عشق به زادگاه خود و با بهره‌گیری از تخصص و تجربه، توانسته‌اند کسب‌وکارهای موفقی را ایجاد نمایند و برای جوانان منطقه اشتغالزایی کنند.

${item["desc"]}
      """,
      "documents": item["documents"] ?? [],
      "pageType": "entrepreneur",
    };
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(item: detailItem),
      ),
    );
  }
}