// lib/services/search_service.dart
import 'package:flutter/material.dart';

enum SearchMode { partial, startsWith, exact }

class SearchItem {
  final String title;
  final String subtitle;
  final String searchText;
  final Widget page;
  final IconData icon;
  final String category;

  SearchItem({
    required this.title,
    required this.subtitle,
    required this.searchText,
    required this.page,
    required this.icon,
    required this.category,
  });
}

class SearchService {
  static final SearchService _instance = SearchService._internal();
  factory SearchService() => _instance;
  SearchService._internal();

  final List<SearchItem> _items = [];

  void registerItem(SearchItem item) {
    // جلوگیری از ثبت تکراری
    final exists = _items.any((i) => i.title == item.title);
    if (!exists) {
      _items.add(item);
    }
  }

  void registerItems(List<SearchItem> items) {
    for (var item in items) {
      registerItem(item);
    }
  }

  // ============================================================
  // متد unregisterItem اضافه شد
  // ============================================================
  void unregisterItem(String title) {
    _items.removeWhere((item) => item.title == title);
  }

  void clear() {
    _items.clear();
  }

  List<SearchItem> search(String query, {SearchMode mode = SearchMode.partial}) {
    if (query.isEmpty) return [];
    final q = query.trim().toLowerCase();

    return _items.where((item) {
      final fullText = '${item.title} ${item.subtitle} ${item.searchText} ${item.category}'.toLowerCase();
      
      switch (mode) {
        case SearchMode.partial:
          return fullText.contains(q);
        case SearchMode.startsWith:
          return fullText.startsWith(q);
        case SearchMode.exact:
          return fullText.split(' ').contains(q);
      }
    }).toList();
  }

  int get count => _items.length;
}