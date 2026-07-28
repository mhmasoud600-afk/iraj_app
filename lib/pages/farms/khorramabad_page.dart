
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KhorramabadPage extends StatefulWidget {
  const KhorramabadPage({Key? key}) : super(key: key);

  @override
  State<KhorramabadPage> createState() => _KhorramabadPageState();
}

class _KhorramabadPageState extends State<KhorramabadPage> {
  String searchText = "";
  final Map<String, bool> expandedSections = {
    'khorramabad': false,
    'facilities': false,
    'future': false,
    'location': false,
  };

  final List<String> imagePaths = [
    "assets/images/farms/khorramabad1.jpg",
    "assets/images/farms/khorramabad2.jpg",
    "assets/images/farms/khorramabad3.jpg",
    "assets/images/farms/khorramabad4.jpg",
  ];

  // مختصات جغرافیایی مزرعه خرم‌آباد
  final double latitude = 33.452168;
  final double longitude = 54.860892;

  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> items = [
    {
      "title": "مزرعه خرم‌آباد",
      "content":
          "مزرعه خرم‌آباد در فاصله یک کیلومتری روستای ایراج و در غرب روستا واقع شده است.\n\n"
          "این مزرعه دارای رشته قنات، ساختمان و سرویس بهداشتی می‌باشد. چند سال قبل این مزرعه در سال 1395توسط آقای دکتر فرح‌اله زاهد خریداری شد و قنات آن احیا شد ولی در سال 1398 توسط سیل تخریب کامل شد  از آن زمان هزینه‌های زیادی جهت مرمت قنات و ساختمان آن صرف گردید.\n\n"
          "راه دسترسی به مزرعه ماشین‌رو و خاکی است. با توجه به فاصله نزدیک به روستا، معمولاً افراد به صورت پیاده نیز به این مزرعه تردد دارند.\n\n"
          "در حال حاضر بر روی انتهای قنات آن، یک ساختمان شبیه آب‌انبار به صورت پلکانی تا عمق زمین ساخته شده است."
    }
  ];

  // تابع برای باز کردن نقشه
  Future<void> _openMap() async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final appleMapsUrl = 'https://maps.apple.com/?ll=$latitude,$longitude';
    
    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else if (await canLaunchUrl(Uri.parse(appleMapsUrl))) {
      await launchUrl(Uri.parse(appleMapsUrl));
    } else {
      throw 'Could not open map';
    }
  }

  Widget _buildLocationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "موقعیت جغرافیایی",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.deepPurple,
              ),
            ),
            trailing: Icon(
              expandedSections['location']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.deepPurple,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections['location'] = !expandedSections['location']!;
              });
            },
          ),
          if (expandedSections['location']!)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // نمایش مختصات
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(

color: Colors.deepPurple.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.deepPurple, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              "مختصات جغرافیایی:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Vazirmatn",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "عرض جغرافیایی",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Vazirmatn",
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  latitude.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Vazirmatn",
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.deepPurple.shade300,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "طول جغرافیایی",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Vazirmatn",
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  longitude.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Vazirmatn",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // دکمه مشاهده در نقشه
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _openMap,
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text(
                        "مشاهده در نقشه",

style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Vazirmatn",
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // توضیحات دسترسی
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "برای مسیریابی دقیق‌تر، از دکمه بالا استفاده کنید. راه دسترسی به خرم‌آباد خاکی و ماشین‌رو است. با توجه به فاصله نزدیک به روستا، پیاده‌روی نیز گزینه مناسبی است.",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Vazirmatn",
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFacilitiesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "امکانات فعلی",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.deepPurple,
              ),
            ),
            trailing: Icon(
              expandedSections['facilities']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.deepPurple,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections['facilities'] = !expandedSections['facilities']!;
              });
            },
          ),
          if (expandedSections['facilities']!)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "• رشته قنات فعال\n"
                "• ساختمان مرمت‌شده\n"
                "• سرویس بهداشتی\n"
                "• آب‌انبار پلکانی در انتهای قنات\n"
                "• راه دسترسی خاکی (ماشین‌رو)\n"
                "• فاصله یک کیلومتری از روستا",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  fontFamily: "Vazirmatn",
                ),
              ),
            ),
        ],
      ),
    );
  }

Widget _buildFutureSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "چشم‌انداز آینده (الهام از آبشار جندق)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.deepPurple,
              ),
            ),
            trailing: Icon(
              expandedSections['future']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.deepPurple,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections['future'] = !expandedSections['future']!;
              });
            },
          ),
          if (expandedSections['future']!)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "طبق برنامه‌ریزی‌های انجام‌شده، قرار است مسیر جوی آب و استخر مزرعه نیز سرپوشیده شود تا مکانی زیبا برای گردشگری در روستا ایجاد گردد.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      fontFamily: "Vazirmatn",
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.amber.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              "الگویی موفق: آبشار جندق ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Vazirmatn",
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "مجموعه گردشگری آبشار جندق نمونه‌ای موفق از احیای قنات در دل کویر است . در این مجموعه با استفاده از آب قنات، امکانات متنوعی از جمله استخر پرورش ماهی، محلی برای شنا و استراحت، رستوران زیرزمینی، دریاچه قایقسواری و آلاچیق‌های متعدد ایجاد شده است . این مجموعه توانسته با خلق فضایی دل‌انگیز در دل کویر، گردشگران بسیاری را جذب کند .",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            fontFamily: "Vazirmatn",
                            color: Colors.black87,
                          ),

textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  const Text(
                    "با توجه به این الگوی موفق، خرم‌آباد نیز پتانسیل تبدیل شدن به یکی از نقاط گردشگری مهم منطقه را دارد. مرمت قنات و ساخت آب‌انبار پلکانی گام اول در این مسیر است و با تکمیل پروژه‌های بعدی، این مزرعه می‌تواند به مقصدی جذاب برای گردشگران تبدیل شود.\n\n"
                    "راه دسترسی مناسب و فاصله کم با روستا، از دیگر مزایای این مزرعه برای توسعه گردشگری است.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.7,
                      fontFamily: "Vazirmatn",
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget highlightText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 16,
          height: 1.7,
          fontFamily: "Vazirmatn",
        ),
      );
    }

    final List<TextSpan> spans = [];
    int start = 0;

    while (true) {
      final int index = text.indexOf(query, start);
      if (index < 0) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            height: 1.7,
            fontFamily: "Vazirmatn",
          ),
        ));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            height: 1.7,
            fontFamily: "Vazirmatn",
          ),
        ));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: const TextStyle(
          backgroundColor: Colors.yellow,
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          height: 1.7,
          fontFamily: "Vazirmatn",
        ),
      ));

      start = index + query.length;
    }

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: spans),
    );
  }

  Widget _buildExpandableSection(String sectionKey, String title, String content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.deepPurple.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.deepPurple,
              ),
            ),
            trailing: Icon(
              expandedSections[sectionKey]! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.deepPurple,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections[sectionKey] = !expandedSections[sectionKey]!;
              });
            },
          ),
          if (expandedSections[sectionKey]!)
            Padding(
              padding: const EdgeInsets.all(16),
              child: highlightText(content, searchText),
            ),
        ],
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مزرعه خرم‌آباد (KHORRAMABAD)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            // اسلایدشو تصاویر
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            imagePaths[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.broken_image, 
                                         size: 50, 
                                         color: Colors.grey.shade600),
                                    const SizedBox(height: 10),
                                    Text(
                                      "تصویر ${index + 1}",
                                      style: const TextStyle(
                                        fontFamily: "Vazirmatn",
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  
                  // فلش راست
                  Positioned(
                    right: 15,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_forward_ios,

color: Colors.deepPurple, size: 16),
                        onPressed: () {
                          if (_currentImageIndex < imagePaths.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  
                  // فلش چپ
                  Positioned(
                    left: 15,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios, 
                                       color: Colors.deepPurple, size: 16),
                        onPressed: () {
                          if (_currentImageIndex > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  
                  // نقطه‌های توپر
                  Positioned(
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        imagePaths.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.deepPurple
                                : Colors.deepPurple.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // فیلد جستجو
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                onChanged: (value) => setState(() => searchText = value),
                decoration: InputDecoration(
                  hintText: "جستجو...",
                  hintStyle: const TextStyle(fontFamily: "Vazirmatn"),
                  prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 2),
                  ),
                ),
              ),
            ),

            // لیست بخش‌ها
            Expanded(
              child: ListView(
                children: [
                  _buildExpandableSection('khorramabad', 'مزرعه خرم‌آباد', items[0]["content"]!),
                  _buildLocationSection(),
                  _buildFacilitiesSection(),
                  _buildFutureSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}