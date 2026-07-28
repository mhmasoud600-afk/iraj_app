import 'package:flutter/material.dart';
import '../settings/app_settings.dart';

class GalleryItem {
  final String title;
  final int sectionNumber;
  final int imageCount;
  final IconData icon;

  GalleryItem({
    required this.title,
    required this.sectionNumber,
    required this.imageCount,
    required this.icon,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) {
    return GalleryItem(
      title: json['title'] ?? '',
      sectionNumber: json['sectionNumber'] ?? 0,
      imageCount: json['imageCount'] ?? 0,
      icon: _mapIcon(json['icon'] ?? ''),
    );
  }

  static IconData _mapIcon(String name) {
    switch (name) {
      case 'account_balance': return Icons.account_balance;
      case 'mosque': return Icons.mosque;
      case 'nature': return Icons.nature;
      case 'park': return Icons.park;
      case 'landscape': return Icons.landscape;
      case 'water': return Icons.water;
      case 'apartment': return Icons.apartment;
      case 'music_note': return Icons.music_note;
      case 'restaurant': return Icons.restaurant;
      case 'hotel': return Icons.hotel;
      case 'house': return Icons.house;
      case 'history': return Icons.history;
      case 'agriculture': return Icons.agriculture;
      case 'architecture': return Icons.account_balance;
      case 'more_horiz': return Icons.more_horiz;
      default: return Icons.image;
    }
  }

  // متد برای دریافت رنگ با توجه به تنظیمات
  Color getPrimaryColor() {
    return AppSettings.instance.primaryColor;
  }

  // متد برای دریافت رنگ پس‌زمینه با توجه به تنظیمات
  Color getBackgroundColor() {
    final settings = AppSettings.instance;
    return settings.isDarkMode ? Colors.grey[850]! : Colors.white;
  }

  // متد برای دریافت رنگ متن با توجه به تنظیمات
  Color getTextColor() {
    return AppSettings.instance.mainTextColor;
  }

  // متد برای دریافت فونت با توجه به تنظیمات
  String getFontFamily() {
    return AppSettings.instance.mainFontFamily;
  }
}