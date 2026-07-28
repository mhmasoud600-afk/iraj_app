import 'package:flutter/material.dart';
import '../settings/app_settings.dart';

class GalleryZoomPage extends StatefulWidget {
  final String title;
  final int sectionNumber;
  final int imageCount;

  const GalleryZoomPage({
    Key? key,
    required this.title,
    required this.sectionNumber,
    required this.imageCount,
  }) : super(key: key);

  @override
  State<GalleryZoomPage> createState() => _GalleryZoomPageState();
}

class _GalleryZoomPageState extends State<GalleryZoomPage> with SettingsAwareWidget {
  final PageController _pageController = PageController();
  bool autoPlay = false;
  int _currentPage = 0;

  void _startAutoPlay() async {
    while (autoPlay && mounted) {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted || !autoPlay) break;
      int nextPage = _currentPage + 1;
      if (nextPage >= widget.imageCount) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
        // ===== دکمه نمایش خودکار در AppBar =====
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  autoPlay = !autoPlay;
                  if (autoPlay) _startAutoPlay();
                });
              },
              icon: Icon(
                autoPlay ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 16,
              ),
              label: Text(
                autoPlay ? 'توقف' : 'خودکار',
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: autoPlay ? Colors.red : settings.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(60, 30),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageCount,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final imagePath =
                    'assets/gallery/${widget.sectionNumber} (${index + 1}).jpg';
                return InteractiveViewer(
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 80,
                              color: settings.isDarkMode ? Colors.grey[600] : Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'تصویر ${index + 1}',
                              style: TextStyle(
                                color: settings.isDarkMode ? Colors.grey[500] : Colors.grey,
                                fontFamily: settings.mainFontFamily,
                                fontSize: settings.mainFontSize - 2,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          // ===== نمایش شماره عکس =====
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: settings.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: settings.primaryColor.withOpacity(0.3)),
              ),
              child: Text(
                '${_currentPage + 1} / ${widget.imageCount}',
                style: TextStyle(
                  fontSize: settings.mainFontSize - 2,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
            ),
          ),
          // ===== دکمه‌های ناوبری =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // دکمه قبلی
                IconButton(
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.animateToPage(
                        _currentPage - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: settings.primaryColor,
                    size: 20,
                  ),
                  tooltip: 'تصویر قبلی',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                const SizedBox(width: 12),
                // نقاط نشانگر
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imageCount,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? settings.primaryColor
                                : settings.isDarkMode
                                    ? Colors.grey[600]
                                    : Colors.grey[300],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // دکمه بعدی
                IconButton(
                  onPressed: () {
                    if (_currentPage < widget.imageCount - 1) {
                      _pageController.animateToPage(
                        _currentPage + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: settings.primaryColor,
                    size: 20,
                  ),
                  tooltip: 'تصویر بعدی',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}