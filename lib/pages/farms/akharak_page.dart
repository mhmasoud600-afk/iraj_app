import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AkharakPage extends StatefulWidget {
  const AkharakPage({Key? key}) : super(key: key);

  @override
  State<AkharakPage> createState() => _AkharakPageState();
}

class _AkharakPageState extends State<AkharakPage> {
  String searchText = "";
  final Map<String, bool> expandedSections = {
    'akharak': false,
    'facilities': false,
    'notes': false,
    'location': false, // بخش جدید برای موقعیت مکانی
  };

  final List<String> imagePaths = [
    "assets/images/farms/akharak1.jpg",
    "assets/images/farms/akharak2.jpg",
    
  ];

  // مختصات جغرافیایی مزرعه آخرک
  final double latitude = 33.402961;
  final double longitude = 54.858330;

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
      "title": "مزرعه آخرک",
      "content":
          "مزرعه آخرک در ۵ کیلومتری جنوب روستای ایراج قرار دارد. این مزرعه دارای مالکیت خصوصی است و تعدادی از اهالی در آن سهم دارند.\n\n"
          "راه تردد به این مزرعه خاکی است و هر از چند گاهی بر اثر سیلاب‌های فصلی، راه تردد آن توسط سیل از بین می‌رود.\n\n"
          "این مزرعه دارای چشمه آب و استخر ذخیره‌سازی و زمین‌های کشاورزی است، لیکن به دلیل مالکیت ارث و میراثی کمتر کسی برای آبادانی آن تمایلی نشان می‌دهد. از طرفی راه خاکی آن و نبود امکانات، این مزرعه را صرفاً محلی برای تفریح اهالی روستا و سایر مردم منطقه تبدیل کرده است.\n\n"
          "این مزرعه در کنار کوه قرار گرفته است و در فصل بهار، بوته‌های اسپند (اسفند) زیادی در اطراف آن می‌روید."
    }
  ];

  // تابع برای باز کردن نقشه
  Future<void> _openMap() async {
    // باز کردن در Google Maps
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    
    // باز کردن در برنامه نقشه پیش‌فرض
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
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade300,
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
                color: Colors.green,
              ),
            ),
            trailing: Icon(
              expandedSections['location']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.green,
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
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.green, size: 20),
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
                              color: Colors.green.shade300,
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
                        backgroundColor: Colors.green,
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
                            "برای مسیریابی دقیق‌تر، از دکمه بالا استفاده کنید. راه دسترسی خاکی است و پس از بارندگی ممکن است تردد با مشکل مواجه شود.",
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
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),


border: Border.all(
          color: Colors.green.shade300,
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
                color: Colors.green,
              ),
            ),
            trailing: Icon(
              expandedSections[sectionKey]! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.green,
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

  Widget _buildFacilitiesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "امکانات رفاهی",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.green,
              ),
            ),
            trailing: Icon(
              expandedSections['facilities']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.green,
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
                "• چند تخت سیمانی برای استراحت و اطراق\n"
                "• دستشویی (نیازمند بازسازی)\n"
                "• آب شیرین چشمه\n"
                "• چند اتاق مسقف قدیمی\n"
                "• دسترسی مناسب به کوه",
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

  Widget _buildNotesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "توضیحات",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.green,
              ),
            ),
            trailing: Icon(
              expandedSections['notes']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.green,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections['notes'] = !expandedSections['notes']!;


});
            },
          ),
          if (expandedSections['notes']!)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "این مزرعه با وجود داشتن پتانسیل‌های طبیعی و منابع آبی، به دلیل مسائل ارث و میراثی و راه دسترسی دشوار، کمتر مورد توجه برای آبادانی قرار گرفته است. با این حال به عنوان یک مکان تفریحی برای اهالی منطقه و علاقه‌مندان به طبیعت مورد استفاده قرار می‌گیرد.",
                textAlign: TextAlign.justify,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مزرعه آخرک (AKHARAK)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.green,
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
                        color: Colors.green.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_forward_ios, 
                                       color: Colors.green, size: 16),
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
                        color: Colors.green.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios, 
                                       color: Colors.green, size: 16),
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
                                ? Colors.green
                                : Colors.green.withOpacity(0.3),
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
                  prefixIcon: const Icon(Icons.search, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green.shade400, width: 2),
                  ),
                ),
              ),
            ),

// لیست بخش‌ها
            Expanded(
              child: ListView(
                children: [
                  _buildExpandableSection('akharak', 'مزرعه آخرک', items[0]["content"]!),
                  _buildLocationSection(), // بخش جدید موقعیت مکانی
                  _buildFacilitiesSection(),
                  _buildNotesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}