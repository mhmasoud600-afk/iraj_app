// lib/search_page.dart
import 'package:flutter/material.dart';
import 'services/search_service.dart';
import 'settings/app_settings.dart';

class SearchPage extends StatefulWidget {
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;

  const SearchPage({
    Key? key,
    required this.fontSize,
    required this.fontFamily,
    required this.textColor,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  SearchMode _searchMode = SearchMode.partial;
  List<SearchItem> _results = [];
  bool _isLoading = false;
  
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() { _results = []; _isLoading = false; });
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(milliseconds: 200), () {
      final results = SearchService().search(query, mode: _searchMode);
      setState(() {
        _results = results;
        _isLoading = false;
        _animController.forward(from: 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance;
    final bool isDark = s.isDarkMode;

    return Scaffold(
      backgroundColor: s.pageBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ======== هدر ========
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [s.primaryColor, s.primaryColor.withOpacity(0.7)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: s.primaryColor.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          'جستجوی سراسری',
                          style: TextStyle(
                            fontSize: s.mainFontSize + 4,
                            fontFamily: s.mainFontFamily,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${SearchService().count}',
                          style: TextStyle(
                            fontSize: s.mainFontSize - 2,
                            fontFamily: s.mainFontFamily,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // ======== کادر جستجو ========
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        Icon(Icons.search, color: s.primaryColor, size: 26),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'متن مورد نظر را در کل برنامه جستجو کنید...',
                              hintStyle: TextStyle(
                                fontFamily: s.mainFontFamily,
                                color: s.mainTextColor.withOpacity(0.4),
                                fontSize: s.mainFontSize - 2,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            style: TextStyle(
                              fontSize: s.mainFontSize,
                              fontFamily: s.mainFontFamily,
                              color: s.mainTextColor,
                            ),
                            textDirection: TextDirection.rtl,
                            onChanged: _search,
                          ),
                        ),
                        if (_controller.text.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.clear, color: s.mainTextColor.withOpacity(0.4)),
                            onPressed: () {
                              _controller.clear();
                              setState(() { _results = []; _isLoading = false; });
                            },
                          ),
                        PopupMenuButton<SearchMode>(
                          icon: Icon(Icons.tune, color: s.primaryColor),
                          onSelected: (mode) {
                            setState(() => _searchMode = mode);
                            if (_controller.text.isNotEmpty) _search(_controller.text);
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: SearchMode.partial,
                              child: Text('جستجوی جزئی'),
                            ),
                            const PopupMenuItem(
                              value: SearchMode.startsWith,
                              child: Text('شروع با'),
                            ),
                            const PopupMenuItem(
                              value: SearchMode.exact,
                              child: Text('تطابق کامل'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ======== محتوای اصلی ========
            Expanded(
              child: _buildBody(s, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(AppSettings s, bool isDark) {
    if (_controller.text.isEmpty) {
      return _emptyState(s, isDark);
    }
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_results.isEmpty) {
      return _noResultState(s);
    }
    return _resultList(s, isDark);
  }

  Widget _emptyState(AppSettings s, bool isDark) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: s.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_rounded,
                size: 60,
                color: s.primaryColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'چه چیزی می‌خواهید پیدا کنید؟',
              style: TextStyle(
                fontSize: s.mainFontSize + 4,
                fontFamily: s.mainFontFamily,
                color: s.mainTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'در تمام محتوای برنامه جستجو کنید',
              style: TextStyle(
                fontSize: s.mainFontSize - 2,
                fontFamily: s.mainFontFamily,
                color: s.mainTextColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: ['معرفی', 'تاریخ', 'قنات', 'مسجد', 'شهدا', 'موسیقی'].map((tag) {
                return GestureDetector(
                  onTap: () {
                    _controller.text = tag;
                    _search(tag);
                  },
                  child: Chip(
                    label: Text(
                      tag,
                      style: TextStyle(
                        fontFamily: s.mainFontFamily,
                        fontSize: s.mainFontSize - 2,
                      ),
                    ),
                    backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                    avatar: Icon(Icons.search, size: 16, color: s.primaryColor),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResultState(AppSettings s) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 80,
              color: s.mainTextColor.withOpacity(0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'نتیجه‌ای یافت نشد',
              style: TextStyle(
                fontSize: s.mainFontSize + 4,
                fontFamily: s.mainFontFamily,
                color: s.mainTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'کلمه "${_controller.text}" در هیچ صفحه‌ای یافت نشد',
              style: TextStyle(
                fontSize: s.mainFontSize - 2,
                fontFamily: s.mainFontFamily,
                color: s.mainTextColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _controller.clear();
                setState(() { _results = []; _isLoading = false; });
                _focusNode.requestFocus();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('جستجوی جدید'),
              style: ElevatedButton.styleFrom(
                backgroundColor: s.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultList(AppSettings s, bool isDark) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final item = _results[index];
          final keyword = _controller.text;
          
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            color: isDark ? Colors.grey[850] : Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.page),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: s.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item.icon,
                        color: s.primaryColor,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxHeight: 30),
                            child: _highlightText(
                              item.title,
                              keyword,
                              s,
                              isTitle: true,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            constraints: const BoxConstraints(maxHeight: 44),
                            child: _highlightText(
                              item.subtitle,
                              keyword,
                              s,
                              isTitle: false,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: s.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.category,
                              style: TextStyle(
                                fontFamily: s.mainFontFamily,
                                fontSize: s.mainFontSize - 6,
                                color: s.primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: s.mainTextColor.withOpacity(0.2),
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

  Widget _highlightText(String text, String keyword, AppSettings s, {bool isTitle = true}) {
    if (keyword.isEmpty || !text.toLowerCase().contains(keyword.toLowerCase())) {
      return Text(
        text,
        style: TextStyle(
          fontFamily: s.mainFontFamily,
          fontSize: isTitle ? s.mainFontSize : s.mainFontSize - 4,
          color: isTitle ? s.mainTextColor : s.mainTextColor.withOpacity(0.7),
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        ),
        maxLines: isTitle ? 1 : 2,
        overflow: TextOverflow.ellipsis,
      );
    }

    final lowerText = text.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    final startIndex = lowerText.indexOf(lowerKeyword);
    
    if (startIndex == -1) {
      return Text(
        text,
        style: TextStyle(
          fontFamily: s.mainFontFamily,
          fontSize: isTitle ? s.mainFontSize : s.mainFontSize - 4,
          color: isTitle ? s.mainTextColor : s.mainTextColor.withOpacity(0.7),
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }

    final beforeText = text.substring(0, startIndex);
    final highlightedText = text.substring(startIndex, startIndex + keyword.length);
    final afterText = text.substring(startIndex + keyword.length);

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: beforeText,
            style: TextStyle(
              fontFamily: s.mainFontFamily,
              fontSize: isTitle ? s.mainFontSize : s.mainFontSize - 4,
              color: isTitle ? s.mainTextColor : s.mainTextColor.withOpacity(0.7),
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: highlightedText,
            style: TextStyle(
              fontFamily: s.mainFontFamily,
              fontSize: isTitle ? s.mainFontSize : s.mainFontSize - 4,
              color: s.primaryColor,
              fontWeight: FontWeight.bold,
              backgroundColor: s.primaryColor.withOpacity(0.15),
            ),
          ),
          TextSpan(
            text: afterText,
            style: TextStyle(
              fontFamily: s.mainFontFamily,
              fontSize: isTitle ? s.mainFontSize : s.mainFontSize - 4,
              color: isTitle ? s.mainTextColor : s.mainTextColor.withOpacity(0.7),
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}