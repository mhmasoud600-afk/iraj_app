// lib/pages/zakerin/zakerin_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'quran_readers.dart';
import 'ahlulbayt_speakers.dart';
import 'chavoshi_singers.dart';
import 'nohe_singers.dart';

class ZakerinPage extends StatefulWidget {
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;

  final double buttonFontSize;
  final String buttonFontFamily;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;

  const ZakerinPage({
    Key? key,
    required this.fontSize,
    required this.fontFamily,
    required this.textColor,
    required this.backgroundColor,
    required this.buttonFontSize,
    required this.buttonFontFamily,
    required this.buttonTextColor,
    required this.buttonBackgroundColor,
  }) : super(key: key);

  @override
  State<ZakerinPage> createState() => _ZakerinPageState();
}

class _ZakerinPageState extends State<ZakerinPage> with SearchableMixin {
  
  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'اساتید قرآنی و ذاکرین';
  
  @override
  String get pageSubtitle => 'اساتید قرآنی، مداحان و ذاکرین اهل بیت';
  
  @override
  String get pageCategory => 'مذهبی';
  
  @override
  IconData get pageIcon => Icons.mic;
  
  @override
  Widget get pageWidget => ZakerinPage(
        fontSize: widget.fontSize,
        fontFamily: widget.fontFamily,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        buttonFontSize: widget.buttonFontSize,
        buttonFontFamily: widget.buttonFontFamily,
        buttonTextColor: widget.buttonTextColor,
        buttonBackgroundColor: widget.buttonBackgroundColor,
      );

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('اساتید قرآنی و ذاکرین روستای ایراج:');
    fullText.writeln();
    
    final tabs = [
      'قاریان قرآن',
      'ذاکرین اهل بیت',
      'چاوشی‌خوانان',
      'نوحه‌خوانان'
    ];
    
    final descriptions = [
      'قاریان و حافظان قرآن کریم روستا',
      'مداحان و ذاکرین اهل بیت علیهم السلام',
      'چاوشی‌خوانان و مداحان سنتی',
      'نوحه‌خوانان و مرثیه‌سرایان'
    ];
    
    final keywords = [
      'قاری قرآن حافظ تجوید قرائت',
      'ذاکر مداح اهل بیت روضه',
      'چاوشی مداحی سنتی',
      'نوحه مرثیه سینه زنی'
    ];
    
    for (int i = 0; i < tabs.length; i++) {
      fullText.writeln('--- ${tabs[i]} ---');
      fullText.writeln('توضیحات: ${descriptions[i]}');
      fullText.writeln('کلمات کلیدی: ${keywords[i]}');
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

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      Tab(
        child: Text(
          "قاریان قرآن",
          style: TextStyle(
            fontSize: widget.buttonFontSize,
            fontFamily: widget.buttonFontFamily,
            color: widget.buttonTextColor,
          ),
        ),
      ),
      Tab(
        child: Text(
          "ذاکرین اهل بیت",
          style: TextStyle(
            fontSize: widget.buttonFontSize,
            fontFamily: widget.buttonFontFamily,
            color: widget.buttonTextColor,
          ),
        ),
      ),
      Tab(
        child: Text(
          "چاوشی‌خوانان",
          style: TextStyle(
            fontSize: widget.buttonFontSize,
            fontFamily: widget.buttonFontFamily,
            color: widget.buttonTextColor,
          ),
        ),
      ),
      Tab(
        child: Text(
          "نوحه‌خوانان",
          style: TextStyle(
            fontSize: widget.buttonFontSize,
            fontFamily: widget.buttonFontFamily,
            color: widget.buttonTextColor,
          ),
        ),
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: AppBar(
          title: Text(
            "اساتید قرآنی و ذاکرین",
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              color: widget.textColor,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
            indicatorColor: widget.buttonTextColor,
          ),
        ),
        body: const TabBarView(
          children: [
            QuranReadersPage(),
            AhlulBaytSpeakersPage(),
            ChavoshiSingersPage(),
            NoheSingersPage(),
          ],
        ),
      ),
    );
  }
}