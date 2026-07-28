// lib/pages/music/music_tabs_page.dart
import 'package:flutter/material.dart';
import '../../mixins/searchable_mixin.dart'; // اضافه شد

import 'song_page.dart';
import 'prayer_page.dart';
import 'daily_page.dart';
import 'prayer_times_page.dart';
import 'weather_page.dart';
import 'heaven_page.dart';
import 'tv_page.dart';

class MusicTabsPage extends StatefulWidget {
  const MusicTabsPage({Key? key}) : super(key: key);

  @override
  State<MusicTabsPage> createState() => _MusicTabsPageState();
}

class _MusicTabsPageState extends State<MusicTabsPage> 
    with SingleTickerProviderStateMixin, SearchableMixin {
  
  late TabController _tabController;

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'بخش‌های موسیقی و مذهبی';
  
  @override
  String get pageSubtitle => 'ترانه‌ها، دعا، اوقات شرعی، هواشناسی و ...';
  
  @override
  String get pageCategory => 'موسیقی';
  
  @override
  IconData get pageIcon => Icons.music_note;
  
  @override
  Widget get pageWidget => const MusicTabsPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('بخش‌های موسیقی و مذهبی روستای ایراج:');
    fullText.writeln();
    
    final tabs = [
      'ترانه‌ها',
      'دعا و زیارات',
      'روزانه',
      'اوقات شرعی',
      'هواشناسی',
      'بهشت گمشده',
      'تلویزیون'
    ];
    
    final descriptions = [
      'ترانه‌ها و آهنگ‌های محلی روستا',
      'دعاها و زیارات مذهبی',
      'محتوای روزانه و حدیث روز',
      'اوقات شرعی و زمان‌های نماز',
      'وضعیت آب و هوای روستا',
      'پخش زنده حرم‌های مطهر',
      'پخش تلویزیونی برنامه‌های مذهبی و فرهنگی'
    ];
    
    final keywords = [
      'ترانه آهنگ موسیقی محلی',
      'دعا زیارت مذهبی نماز',
      'روزانه حدیث روز محتوای روز',
      'اوقات شرعی نماز زمان اذان',
      'هواشناسی آب و هوا آبوهوا',
      'بهشت گمشده حرم مطهر پخش زنده',
      'تلویزیون برنامه مذهبی فرهنگی'
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
    _tabController = TabController(length: 7, vsync: this);
    
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _tabController.animateTo(_tabController.index);
      }
    });
    
    registerForSearch();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "بخش‌ها",
          style: TextStyle(fontFamily: "Vazirmatn"),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.grey.shade100,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              indicator: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                fontFamily: "Vazirmatn",
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: "Vazirmatn",
              ),
              tabs: const [
                Tab(text: "ترانه"),
                Tab(text: "دعا و زیارت"),
                Tab(text: "روزانه"),
                Tab(text: "اوقات شرعی"),
                Tab(text: "هواشناسی"),
                Tab(text: "بهشت گمشده"),
                Tab(text: "تلویزیون"),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SongPage(),
          PrayerPage(),
          DailyPage(),
          PrayerTimesPage(),
          WeatherPage(),
          HeavenPage(),
          TvPage(),
        ],
      ),
    );
  }
}