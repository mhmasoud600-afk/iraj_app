// lib/pages/products/products_page.dart
import 'package:flutter/material.dart';
import '../../settings/app_settings.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'handicrafts_page.dart';
import 'traditional_tools_page.dart';
import 'agriculture_page.dart';
import 'processing_page.dart';
import 'local_foods_page.dart';
import 'medicinal_plants_page.dart';

class ProductsPage extends StatefulWidget {
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;
  final Color? backgroundColor;
  final double? buttonFontSize;
  final String? buttonFontFamily;
  final Color? buttonTextColor;
  final Color? buttonBackgroundColor;

  const ProductsPage({
    super.key,
    this.fontSize,
    this.fontFamily,
    this.textColor,
    this.backgroundColor,
    this.buttonFontSize,
    this.buttonFontFamily,
    this.buttonTextColor,
    this.buttonBackgroundColor,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> with SettingsAwareWidget, SearchableMixin {
  
  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'محصولات روستا';
  
  @override
  String get pageSubtitle => 'محصولات کشاورزی و صنایع دستی';
  
  @override
  String get pageCategory => 'محصولات';
  
  @override
  IconData get pageIcon => Icons.shopping_basket;
  
  @override
  Widget get pageWidget => widget;

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('محصولات روستای ایراج:');
    fullText.writeln();
    
    final items = _getItems();
    for (var item in items) {
      fullText.writeln('--- ${item['title']} ---');
      fullText.writeln('دسته‌بندی: ${item['category']}');
      fullText.writeln('کلمات کلیدی: ${item['keywords']}');
      fullText.writeln();
    }
    
    return fullText.toString();
  }

  @override
  void initState() {
    super.initState();
    registerForSearch();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    super.dispose();
  }

  List<Map<String, dynamic>> _getItems() {
    return [
      {
        "title": "صنایع دستی",
        "icon": Icons.handyman,
        "page": const HandicraftsPage(),
        "category": "صنایع دستی",
        "keywords": "قالی گلیم سفال دستبافت صنایع دستی",
      },
      {
        "title": "ابزار سنتی",
        "icon": Icons.build_circle,
        "page": const TraditionalToolsPage(),
        "category": "ابزار",
        "keywords": "ابزار سنتی کشاورزی قدیمی",
      },
      {
        "title": "محصولات باغی و کشاورزی",
        "icon": Icons.agriculture,
        "page": AgriculturePage(),
        "category": "کشاورزی",
        "keywords": "گندم جو انگور گردو بادام زعفران",
      },
      {
        "title": "فرآوری‌ها",
        "icon": Icons.factory,
        "page": ProcessingPage(),
        "category": "فرآوری",
        "keywords": "کمپوت خشک کردن برگه لواشک",
      },
      {
        "title": "غذاهای محلی و نان‌ها",
        "icon": Icons.local_dining,
        "page": LocalFoodsPage(),
        "category": "غذا",
        "keywords": "نان محلی آش غذا سنتی",
      },
      {
        "title": "گیاهان دارویی",
        "icon": Icons.local_florist,
        "page": MedicinalPlantsPage(),
        "category": "گیاهان",
        "keywords": "آویشن آنغوزه زیره زعفران گیاهان دارویی",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    // استفاده از تنظیمات سراسری با اولویت پارامترهای ورودی
    final double mainFontSize = widget.fontSize ?? settings.mainFontSize;
    final String mainFontFamily = widget.fontFamily ?? settings.mainFontFamily;
    final Color mainTextColor = widget.textColor ?? settings.mainTextColor;
    final Color mainBackgroundColor = widget.backgroundColor ?? settings.pageBackgroundColor;
    final double buttonSize = widget.buttonFontSize ?? settings.buttonFontSize;
    final String buttonFamily = widget.buttonFontFamily ?? settings.buttonFontFamily;
    final Color buttonColor = widget.buttonTextColor ?? settings.buttonTextColor;
    final Color buttonBgColor = widget.buttonBackgroundColor ?? settings.buttonBackgroundColor;

    final items = _getItems();

    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        title: Text(
          "محصولات روستا",
          style: TextStyle(
            fontSize: mainFontSize + 2,
            fontFamily: mainFontFamily,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double cardHeight = constraints.maxHeight * 0.28;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, items[0], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCard(context, items[1], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, items[2], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCard(context, items[3], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildCard(context, items[4], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCard(context, items[5], cardHeight, mainBackgroundColor, mainTextColor, buttonSize, buttonFamily, buttonColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    Map<String, dynamic> item,
    double cardHeight,
    Color bgColor,
    Color txtColor,
    double btnSize,
    String btnFamily,
    Color btnColor,
  ) {
    return SizedBox(
      height: cardHeight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item["page"]),
          );
        },
        child: Card(
          elevation: 4,
          color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item["icon"],
                  size: cardHeight * 0.35,
                  color: settings.primaryColor,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    item["title"],
                    style: TextStyle(
                      fontSize: btnSize * 1.1,
                      fontFamily: btnFamily,
                      color: txtColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}