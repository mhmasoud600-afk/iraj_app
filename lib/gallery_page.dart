import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'gallery_item.dart';
import 'gallery_zoom_page.dart';
import '../settings/app_settings.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with SettingsAwareWidget {
  List<GalleryItem> items = [];

  @override
  void initState() {
    super.initState();
    _loadGalleryData();
  }

  Future<void> _loadGalleryData() async {
    try {
      final String response =
      await rootBundle.loadString('assets/gallery_data.json');
      final data = json.decode(response) as List;
      setState(() {
        items = data.map((e) => GalleryItem.fromJson(e)).toList();
      });
    } catch (e) {
      debugPrint("خطا در بارگذاری داده‌های گالری: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "گالری تصاویر روستای ایراج",
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
      ),
      body: items.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: settings.primaryColor,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = constraints.maxWidth;
                
                // تعیین تعداد ستون‌ها بر اساس عرض صفحه
                int crossAxisCount;
                double iconSize;
                double fontSize;
                double spacing;
                double aspectRatio;
                
                if (screenWidth < 380) {
                  crossAxisCount = 2;
                  iconSize = 32;
                  fontSize = 11;
                  spacing = 8;
                  aspectRatio = 1.0;
                } else if (screenWidth < 480) {
                  crossAxisCount = 3;
                  iconSize = 36;
                  fontSize = 12;
                  spacing = 10;
                  aspectRatio = 1.1;
                } else if (screenWidth < 600) {
                  crossAxisCount = 3;
                  iconSize = 40;
                  fontSize = 13;
                  spacing = 12;
                  aspectRatio = 1.2;
                } else if (screenWidth < 800) {
                  crossAxisCount = 4;
                  iconSize = 44;
                  fontSize = 14;
                  spacing = 14;
                  aspectRatio = 1.2;
                } else {
                  crossAxisCount = 5;
                  iconSize = 48;
                  fontSize = 15;
                  spacing = 16;
                  aspectRatio = 1.3;
                }

                // محاسبه ارتفاع مناسب
                final totalItems = items.length;
                final rowsNeeded = (totalItems / crossAxisCount).ceil();
                final availableHeight = constraints.maxHeight - kToolbarHeight - 24;
                final itemHeight = availableHeight / rowsNeeded;
                final itemWidth = (screenWidth - (spacing * (crossAxisCount - 1)) - 24) / crossAxisCount;
                
                if (itemWidth > 0 && itemHeight > 0) {
                  aspectRatio = itemWidth / itemHeight;
                  if (aspectRatio > 1.5) aspectRatio = 1.5;
                  if (aspectRatio < 0.8) aspectRatio = 0.8;
                }

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: aspectRatio,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GalleryZoomPage(
                                title: item.title,
                                sectionNumber: item.sectionNumber,
                                imageCount: item.imageCount,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon,
                                size: iconSize,
                                color: settings.primaryColor,
                              ),
                              SizedBox(height: screenWidth < 400 ? 4 : 6),
                              Flexible(
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: settings.mainFontFamily,
                                    color: settings.mainTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}