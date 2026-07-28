// lib/mixins/searchable_mixin.dart
import 'package:flutter/material.dart';
import '../services/search_service.dart';

mixin SearchableMixin {
  String get pageTitle;
  String get pageSubtitle;
  String get pageCategory;
  IconData get pageIcon;
  Widget get pageWidget;
  
  /// تمام متن‌های قابل جستجوی صفحه را به صورت یک String برگردانید
  String getSearchText();

  void registerForSearch() {
    final service = SearchService();
    service.registerItem(
      SearchItem(
        title: pageTitle,
        subtitle: pageSubtitle,
        searchText: getSearchText(),
        page: pageWidget,
        icon: pageIcon,
        category: pageCategory,
      ),
    );
  }

  // ============================================================
  // متد unregisterFromSearch اضافه شد
  // ============================================================
  void unregisterFromSearch() {
    final service = SearchService();
    service.unregisterItem(pageTitle);
  }
}