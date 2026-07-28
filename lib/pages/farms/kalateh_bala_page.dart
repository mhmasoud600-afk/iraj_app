
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KalatehBalaPage extends StatefulWidget {
  const KalatehBalaPage({Key? key}) : super(key: key);

  @override
  State<KalatehBalaPage> createState() => _KalatehBalaPageState();
}

class _KalatehBalaPageState extends State<KalatehBalaPage> {
  String searchText = "";
  final Map<String, bool> expandedSections = {
    'kalateh': false,
    'history': false,
    'facilities': false,
    'notes': false,
    'location': false,
  };

  final List<String> imagePaths = [
    "assets/images/farms/kalateh_bala1.jpg",
    "assets/images/farms/kalateh_bala2.jpg",
   
  ];

  // مختصات جغرافیایی مزرعه کلاته بالا
  final double latitude = 33.467841;
  final double longitude = 54.872238;

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
      "title": "مزرعه کلاته بالا",
      "content":
          "مزرعه کلاته بالا در کنار مزرعه کلاته پایین قرار دارد. وجه تسمیه آن به این دلیل است که چشمه آن بر روی بلندی قرار گرفته و زمین‌های کشاورزی آن نیز در ارتفاع واقع شده‌اند.\n\n"
          "این مزرعه دارای چشمه آب شیرین و استخر ذخیره‌سازی کوچکی است که در گذشته کشاورزی در آن انجام می‌شده است.\n\n"
          "متأسفانه در سال‌های اخیر به دلیل خشکسالی‌های متوالی، آب چشمه آن بشدت کاهش یافته و درختان آن نیز خشکیده‌اند.\n\n"
          "امکانات خاصی در این مزرعه وجود ندارد."
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
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightGreen.shade300,
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
                color: Colors.lightGreen,
              ),
            ),
            trailing: Icon(
              expandedSections['location']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
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
                      color: Colors.lightGreen.shade100,


borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.lightGreen, size: 20),
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
                              color: Colors.lightGreen.shade300,
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
                        const SizedBox(height: 8),
                        const Text(
                          "موقعیت: در کنار مزرعه کلاته پایین",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Vazirmatn",
                            color: Colors.grey,
                          ),
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
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                       ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightGreen.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "وجه تسمیه و پیشینه",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.lightGreen,
              ),
            ),
            trailing: Icon(
              expandedSections['history']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
              size: 28,
            ),
            onTap: () {
              setState(() {
                expandedSections['history'] = !expandedSections['history']!;
              });
            },
          ),
          if (expandedSections['history']!)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "علت نام‌گذاری این مزرعه به «کلاته بالا» این است که چشمه آن بر روی بلندی قرار گرفته و زمین‌های کشاورزی آن نیز در ارتفاع واقع شده‌اند.\n\n"
                "در گذشته کشاورزی در این مزرعه رونق داشته و از آب چشمه آن برای آبیاری زمین‌ها استفاده می‌شده است.",
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

  Widget _buildFacilitiesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightGreen.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "امکانات و ویژگی‌ها",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.lightGreen,
              ),
            ),
            trailing: Icon(
              expandedSections['facilities']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
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
                "• چشمه آب شیرین (با کاهش شدید آب به دلیل خشکسالی)\n"
                "• استخر ذخیره‌سازی کوچک\n"
                "• زمین‌های کشاورزی در ارتفاع\n"
                "• درختان (بیشتر آنها خشکیده‌اند)\n"
                "• فاقد امکانات رفاهی خاص",
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
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightGreen.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "وضعیت فعلی",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.lightGreen,
              ),
            ),
            trailing: Icon(
              expandedSections['notes']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
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
                "متأسفانه در سال‌های اخیر به دلیل خشکسالی‌های متوالی، آب چشمه این مزرعه بشدت کاهش یافته و درختان آن نیز خشکیده‌اند.\n\n"
                "این مزرعه مانند همسایه خود (کلاته پایین) با مشکل کم‌آبی و خشکسالی مواجه است و احیای آن نیازمند توجه و سرمایه‌گذاری است.",
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
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.lightGreen.shade300,
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
                color: Colors.lightGreen,
              ),
            ),
            trailing: Icon(
              expandedSections[sectionKey]! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.lightGreen,
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
          "مزرعه کلاته بالا (KALATEH BALA)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.lightGreen,
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
                        color: Colors.lightGreen.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_forward_ios, 
                                       color: Colors.lightGreen, size: 16),
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
                        color: Colors.lightGreen.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios, 
                                       color: Colors.lightGreen, size: 16),
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
                                ? Colors.lightGreen
                                : Colors.lightGreen.withOpacity(0.3),
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
                  prefixIcon: const Icon(Icons.search, color: Colors.lightGreen),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.lightGreen.shade400, width: 2),
                  ),
                ),
              ),
            ),

            // لیست بخش‌ها
            Expanded(
              child: ListView(
                children: [
                  _buildExpandableSection('kalateh', 'مزرعه کلاته بالا', items[0]["content"]!),
                  _buildHistorySection(),
                  _buildLocationSection(),
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