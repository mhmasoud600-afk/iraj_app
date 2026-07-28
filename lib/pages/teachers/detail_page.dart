import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailPage({super.key, required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isBiographyExpanded = false;
  bool _isPublicationsExpanded = false;
  int _currentImageIndex = 0;

   // لیست کامل تالیفات استاد مهرنوش جمشیدی
  final List<String> publications = [
    "کتاب عالمی از نو بباید ساخت و از نو عالمی (۲ جلدی)",
    "هم نشینی با دانایان (۱ جلدی)",
    "تحمل و تامل (۱ جلدی)",
    "تجربه‌های خانوادگی (۲ جلدی)",
    "از همه چیز و همه جا (۱ جلدی)",
    "قلم سخن می‌گوید (۱ جلدی)",
    "خلاصه قلم سخن می‌گوید (۱ جلدی)",
    "گذری بر تجربه‌های دیگران (۱ جلدی)",
    "قلم سنگ صبور (۱ جلدی)",
    "نکته‌ها و جمله‌ها (۱ جلدی)",
    "برداشت‌های اجتماعی (۱ جلدی)",
    "از قرآن آموختم (۲ جلدی)",
    "گفتگوی قلم و کاغذ (۱ جلدی)",
    "در محضر باستانی پاریزی (۱ جلدی)",
    "خاطرات جوانی (۱ جلدی)",
    "تجربه‌های دیگران در یک نگاه (۱ جلدی)",
    "یادآوری‌های قلم (۱ جلدی)",
    "روزنامه‌های سال ۱۳۵۷ (۲ جلدی)",
    "غزلیات حافظ (۲ جلدی)",
    "نکات کوتاه (۲ جلدی)",
    "خلاصه نامه‌های یغما (۱ جلدی)",
    "مطالب کوتاه (۱ جلدی)",
    "نکته‌های کوتاه (۱ جلدی)",
    "طرح درس کلاس اول (۱ جلدی)",
    "طرح درس خارج کشور (۱ جلدی)",
    "طرح درس دانشگاه (۱ جلدی)",
    "معلم راهنما تهران (۱ جلدی)",
    "حرف و صحبت‌های خودمانی (۴ جلدی)",
  ];

  // تابع تشخیص نوع صفحه و رنگ‌های مربوطه
  (Color appBarColor, Color accentColor, IconData defaultIcon) _getPageColors() {
    final String pageType = widget.item["pageType"] ?? "default";
    
    switch (pageType) {
      case "engineer":
        return (Colors.blue, Colors.blue, Icons.engineering);
      case "employee":
        return (Colors.green, Colors.green, Icons.business_center);
      case "medical":
        return (Colors.pink, Colors.pink, Icons.medical_services);
      case "nurse":
        return (Colors.teal, Colors.teal, Icons.local_hospital);
      case "dentist":
        return (Colors.orange, Colors.orange, Icons.health_and_safety);
      case "entrepreneur":
        return (Colors.purple, Colors.purple, Icons.travel_explore);
      case "cultural":
        return (Colors.brown, Colors.brown, Icons.menu_book);
      case "public_servant":
        return (Colors.indigo, Colors.indigo, Icons.people);
      default:
        return (Colors.red, Colors.red, Icons.person);
    }
  }

  // تابع فرمت‌بندی خطوط با عنوان و محتوا
  List<InlineSpan> _buildFormattedLine(
    String line, {
    TextStyle? normalStyle,
    TextStyle? titleStyle,
  }) {
    final accentColor = _getPageColors().$2;
    
    final effectiveNormalStyle = normalStyle ??
        TextStyle(
          fontSize: 16,
          height: 1.8,
          color: Colors.black87,
        );

    final effectiveTitleStyle = titleStyle ??
        TextStyle(
          fontSize: 16,
          height: 1.8,
          color: accentColor,
          fontWeight: FontWeight.bold,
        );

    if (!line.contains(':')) {
      return [
        TextSpan(
          text: line,
          style: effectiveNormalStyle,
        ),
      ];
    }

    final int colonIndex = line.indexOf(':');
    final String title = line.substring(0, colonIndex + 1);
    final String content = line.substring(colonIndex + 1).trimLeft();

    return [
      TextSpan(
        text: title,
        style: effectiveTitleStyle,
      ),
      if (content.isNotEmpty)
        TextSpan(
          text: ' $content',
          style: effectiveNormalStyle,
        ),
    ];
  }

  List<InlineSpan> _buildBiographySpans(String biography) {
    final lines = biography.split('\n');
    final List<InlineSpan> spans = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      spans.addAll(_buildFormattedLine(line));

      if (i != lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return spans;
  }

  Widget _buildBiographyText(
    String biography, {
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text.rich(
      TextSpan(
        children: _buildBiographySpans(biography),
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      maxLines: maxLines,
      overflow: overflow,
      style: const TextStyle(
        fontSize: 16,
        height: 1.8,
        color: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String name = widget.item["name"] ?? "";
    final String description = widget.item["desc"] ?? "";
    final String image = widget.item["image"] ?? "";
    final String biography = widget.item["biography"] ?? "";
    final String number = widget.item["number"] ?? "";
    final String defaultImage = widget.item["defaultImage"] ?? "assets/images/default_avatar.png";
    final List<String> documents =
        (widget.item["documents"] as List?)?.cast<String>() ?? [];
    
    // دریافت رنگ‌های مناسب بر اساس نوع صفحه
    final colors = _getPageColors();
    final Color appBarColor = colors.$1;
    final Color accentColor = colors.$2;
    final IconData defaultIcon = colors.$3;

    // تعیین مسیر نهایی تصویر
    String finalImagePath = image.isNotEmpty ? image : defaultImage;

    // بررسی نام برای نمایش تالیفات (فقط برای مهرنوش جمشیدی)
    bool isMehrnoosh = name.contains("مهرنوش جمشیدی");

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F1),
      appBar: AppBar(
        title: Text(
          name,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // شماره (برای مهندسان و کارمندان)
              if (number.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: accentColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "شماره: $number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                          fontFamily: "Vazirmatn",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.numbers,
                        size: 20,
                        color: accentColor,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // تصویر بزرگ در وسط صفحه
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      if (finalImagePath.isNotEmpty) {
                        _showFullScreenImage(context, finalImagePath);
                      }
                    },
                    child: Image.asset(
                      finalImagePath,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 300,
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              defaultIcon,
                              size: 80,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // اطلاعات اصلی (نام و توضیحات)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                        fontFamily: "Vazirmatn",
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        color: Colors.black87,
                        fontFamily: "Vazirmatn",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // کادر زندگینامه
              if (biography.trim().isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isBiographyExpanded = !_isBiographyExpanded;
                              });
                            },
                            icon: Icon(
                              _isBiographyExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: accentColor,
                            ),
                          ),
                          Text(
                            "زندگینامه",
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                              fontFamily: "Vazirmatn",
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1), // حذف const

                      // متن زندگینامه
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: _buildBiographyText(
                            biography,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        secondChild: Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: _buildBiographyText(biography),
                        ),
                        crossFadeState: _isBiographyExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                    ],
                  ),
                ),

              // ======================= بخش تالیفات (فقط برای مهرنوش جمشیدی) =======================
              if (isMehrnoosh)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isPublicationsExpanded = !_isPublicationsExpanded;
                              });
                            },
                            icon: Icon(
                              _isPublicationsExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              color: Colors.red,
                            ),
                          ),
                          const Text(
                            '📚 لیست تالیفات استاد',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              fontFamily: "Vazirmatn",
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.red.shade200, thickness: 1), // حذف const

                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 300),
                        firstChild: Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'برای مشاهده لیست کامل تالیفات کلیک کنید...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red.shade400,
                              fontFamily: "Vazirmatn",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        secondChild: Container(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: publications.map((pub) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    const Text(
                                      '📌',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        pub,
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Vazirmatn",
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        crossFadeState: _isPublicationsExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // کادر اسناد قدیمی
              if (documents.isNotEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "اسناد قدیمی",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                          fontFamily: "Vazirmatn",
                        ),
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1), // حذف const
                      const SizedBox(height: 16),

                      // تایم لاین افقی اسناد
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _showFullScreenGallery(
                                  context, documents, index),
                              child: Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    documents[index],
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            color: Colors.grey[400],
                                            size: 30,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'نمایش تصویر',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreenGallery(
      BuildContext context, List<String> images, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'اسناد قدیمی (${initialIndex + 1}/${images.length})',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(images[index]),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
              );
            },
            itemCount: images.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          event.expectedTotalBytes!,
                ),
              ),
            ),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}