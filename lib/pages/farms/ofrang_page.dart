
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OfrangPage extends StatefulWidget {
  const OfrangPage({Key? key}) : super(key: key);

  @override
  State<OfrangPage> createState() => _OfrangPageState();
}

class _OfrangPageState extends State<OfrangPage> {
  String searchText = "";
  final Map<String, bool> expandedSections = {
    'ofrang': false,
    'zohron': false,
    'facilities': false,
    'notes': false,
    'location': false, // بخش جدید برای موقعیت مکانی
  };

  final List<String> imagePaths = [
    "assets/images/farms/ofrang1.jpg",
    "assets/images/farms/ofrang2.jpg",
    "assets/images/farms/ofrang3.jpg",
    "assets/images/farms/ofrang4.jpg",
  ];

  // مختصات جغرافیایی مزرعه افرنگ
  final double latitude = 33.489316;
  final double longitude = 54.844889;

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
      "title": "مزرعه افرنگ",
      "content":
          "افرنگ (Ofrang) که با نام آفرین نیز شناخته می‌شود، مزرعه‌ای کوچک در شمال غربی ایراج است که در دل کوه قرار دارد.\n\n"
          "راه دسترسی به این مزرعه مال‌رو می‌باشد، یعنی امکان تردد با وسایل نقلیه وجود ندارد و صرفاً به صورت پیاده یا با الاغ و قاطر می‌توان به آن دسترسی پیدا کرد.\n\n"
          "این مزرعه در دل آفرین کوه قرار گرفته و چشمه کوچکی دارد. استخر ذخیره‌سازی کوچکی نیز در کنار آن ساخته شده که حیوانات وحشی از آن استفاده می‌کنند.\n\n"
          "در قدیم چندین خانواده مخصوصاً مرحوم حاج علی‌اکبر اکبر و برادرش عباسعلی اکبر و خانواده‌های دیگر در آن سکونت داشتند. اتاق‌های این محل با سنگ ساخته شده است و برای زندگی مناسب نیست.\n\n"
          "درخت توت سیاه کنار چشمه آن معروف است که در سال‌های اخیر به دلیل خشکسالی‌های متعدد، قسمتی از آن خشک شده است."
    },
    {
      "title": "مزرعه ظهرون",
      "content":
          "در مسیر افرنگ، مزرعه کوچک‌تری به نام «ظهرون» وجود دارد.\n\n"
          "این مزرعه دارای چشمه کوچکی است که در سال‌های پرآب (سال‌هایی که بارندگی مناسب باشد) چشمه آن پرآب می‌شود.\n\n"
          "ظهرون نیز مانند افرنگ، منطقه‌ای کوهستانی و بکر است که طبیعت‌دوستان می‌توانند از آن بازدید نمایند."
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.shade300,
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
                color: Colors.purple,
              ),
            ),
            trailing: Icon(
              expandedSections['location']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.purple,


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
                      color: Colors.purple.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.purple, size: 20),
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
                              color: Colors.purple.shade300,
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
                        backgroundColor: Colors.purple,
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
                            "برای مسیریابی دقیق‌تر، از دکمه بالا استفاده کنید. راه دسترسی به افرنگ مال‌رو است و فقط به صورت پیاده یا با الاغ و قاطر امکان تردد وجود دارد.",
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.shade300,
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
                color: Colors.purple,
              ),
            ),
            trailing: Icon(
              expandedSections[sectionKey]! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.purple,
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.shade300,
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
                color: Colors.purple,
              ),
            ),
            trailing: Icon(
              expandedSections['facilities']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.purple,
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
                "• چشمه کوچک آب شیرین\n"
                "• استخر ذخیره‌سازی آب (محل استفاده حیوانات وحشی)\n"
                "• اتاق‌های سنگی قدیمی (مناسب برای زندگی نیست)\n"
                "• درخت توت سیاه معروف کنار چشمه\n"
                "• دسترسی صرفاً پیاده یا با الاغ و قاطر\n"
                "• منطقه بکر و مناسب برای کوه‌نوردی و طبیعت‌گردی",
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.purple.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "توضیحات تکمیلی",
              style: TextStyle(
                fontSize: 18,


fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
                color: Colors.purple,
              ),
            ),
            trailing: Icon(
              expandedSections['notes']! 
                ? Icons.keyboard_arrow_up 
                : Icons.keyboard_arrow_down,
              color: Colors.purple,
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
                "مزرعه افرنگ امکانات خاصی ندارد و فقط کوه‌نوردان و دوست‌داران طبیعت در فصل بهار به آنجا سری می‌زنند.\n\n"
                "متأسفانه در سال‌های اخیر به دلیل خشکسالی‌های متعدد، درخت توت سیاه معروف کنار چشمه که سال‌ها نماد این مزرعه بود، تا حدی خشک شده است.\n\n"
                "این منطقه با طبیعت بکر و دسترسی دشوار، مقصدی مناسب برای علاقه‌مندان به کوه‌پیمایی و تجربه طبیعت وحشی است.",
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
          "مزرعه افرنگ (OFRANG)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: Colors.purple,
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
                        color: Colors.purple.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_forward_ios, 
                                       color: Colors.purple, size: 16),
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
                        color: Colors.purple.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_back_ios, 
                                       color: Colors.purple, size: 16),
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
                                ? Colors.purple
                                : Colors.purple.withOpacity(0.3),
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
                  prefixIcon: const Icon(Icons.search, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.purple.shade400, width: 2),
                  ),
                ),
              ),
            ),

            // لیست بخش‌ها
            Expanded(
              child: ListView(
                children: [
                  _buildExpandableSection('ofrang', 'مزرعه افرنگ (آفرین)', items[0]["content"]!),
                  _buildExpandableSection('zohron', 'مزرعه ظهرون', items[1]["content"]!),
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