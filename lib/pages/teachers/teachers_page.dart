// lib/pages/teachers/teachers_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'cultural_page.dart';
import 'public_servants_page.dart';
import 'medical_page.dart';
import 'dentists_page.dart';
import 'entrepreneurs_page.dart';
import 'engineers_page.dart';
import 'employees_page.dart';
import 'clergy_page.dart';
import 'jobs_page.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key? key}) : super(key: key);

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> with SearchableMixin {
  
  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'فرهیختگان و خادمین';
  
  @override
  String get pageSubtitle => 'فرهیختگان، معلمان و خادمین روستا';
  
  @override
  String get pageCategory => 'فرهنگی';
  
  @override
  IconData get pageIcon => Icons.school;
  
  @override
  Widget get pageWidget => const TeachersPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('فرهیختگان و خادمین روستای ایراج:');
    fullText.writeln();
    
    final tabs = [
      'فرهنگیان',
      'مهندسان',
      'کارمندان',
      'خادمین مردم',
      'پزشکان و پرستاران',
      'دندانسازان',
      'کارآفرینان',
      'طلبه‌ها',
      'معرفی مشاغل'
    ];
    
    final descriptions = [
      'معلمان، اساتید و فرهنگیان روستا',
      'مهندسان و متخصصان فنی روستا',
      'کارمندان ادارات و سازمان‌ها',
      'خادمین و خدمتگزاران مردم روستا',
      'پزشکان، پرستاران و کادر درمان',
      'دندانپزشکان و دندانسازان',
      'کارآفرینان و سرمایه‌گذاران محلی',
      'طلاب علوم دینی و روحانیون',
      'معرفی مشاغل و حرفه‌های مختلف روستا'
    ];
    
    final keywords = [
      'معلم استاد فرهنگیان فرهنگ',
      'مهندس فنی متخصص',
      'کارمند اداره سازمان',
      'خادم خدمتگزار مردم',
      'پزشک پرستار درمان بهداشت',
      'دندانپزشک دندانساز',
      'کارآفرین سرمایه‌گذار',
      'طلب علوم دینی روحانی',
      'مشاغل شغل حرفه'
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
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "خادمین روستا",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.blue[100],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.red,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black87,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(text: "فرهنگیان"),
              Tab(text: "مهندسان"),
              Tab(text: "کارمندان"),
              Tab(text: "خادمین مردم"),
              Tab(text: "پزشکان و پرستاران"),
              Tab(text: "دندانسازان"),
              Tab(text: "کارآفرینان"),
              Tab(text: "طلبه‌ها"),
              Tab(text: "معرفی مشاغل"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CulturalPage(),
            EngineersPage(),
            EmployeesPage(),
            PublicServantsPage(),
            MedicalPage(),
            DentistsPage(),
            EntrepreneursPage(),
            ClergyPage(),
            JobsPage(),
          ],
        ),
      ),
    );
  }
}