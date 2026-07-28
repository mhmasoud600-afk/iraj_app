
import 'package:flutter/material.dart';

class GardenAlleysPage extends StatefulWidget {
  const GardenAlleysPage({Key? key}) : super(key: key);

  @override
  State<GardenAlleysPage> createState() => _GardenAlleysPageState();
}

class _GardenAlleysPageState extends State<GardenAlleysPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/garden_alleys/alleys1.jpg',
    'assets/images/historical/garden_alleys/alleys2.jpg',
    'assets/images/historical/garden_alleys/alleys3.jpg',
    'assets/images/historical/garden_alleys/alleys4.jpg',
  ];

  bool _isHistoryExpanded = true;
  bool _isDescriptionExpanded = false;
  bool _isFutureExpanded = false;

  final Color _lightPurple = const Color(0xFFE1D5F0);
  final Color _darkPurple = const Color(0xFFB39DDB);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    setState(() {
      if (_currentImageIndex < _images.length - 1) {
        _currentImageIndex++;
      } else {
        _currentImageIndex = 0;
      }
    });
    _pageController.animateToPage(
      _currentImageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousImage() {
    setState(() {
      if (_currentImageIndex > 0) {
        _currentImageIndex--;
      } else {
        _currentImageIndex = _images.length - 1;
      }
    });
    _pageController.animateToPage(
      _currentImageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "کوچه باغ‌ها",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_images[index]),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                  
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 20),
                          onPressed: _previousImage,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: _nextImage,


),
                      ),
                    ),
                  ),
                  
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _images.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.purple
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildExpandableCard(
                    title: "پیشینه",
                    icon: Icons.history_edu,
                    isExpanded: _isHistoryExpanded,
                    onTap: () {
                      setState(() {
                        _isHistoryExpanded = !_isHistoryExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Text(
                      "کوچه باغ‌ها از عناصر شاخص معماری بومی و منظر فرهنگی ایران هستند که در حاشیه روستاها و شهرهای کویری شکل گرفته‌اند. این گذرهای باریک که بین باغ‌ها و زمین‌های کشاورزی قرار دارند، علاوه بر دسترسی، عملکرد اقلیمی داشته و با ایجاد سایه و هدایت باد، شرایط خرداقلیمی مطلوبی فراهم می‌کنند.",
                      style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "توضیحات",
                    icon: Icons.description,
                    isExpanded: _isDescriptionExpanded,
                    onTap: () {
                      setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: const Text(
                      "کوچه باغ‌های این منطقه با دیوارهای خشتی و گلی، درختان کهنسال چنار و بید، و نهرهای آب جاری، مناظر بی‌بدیلی را خلق کرده‌اند. این مسیرها در فصول مختلف سال جلوه‌های متفاوتی دارند: در بهار سرسبز و پرطراوت، در تابستان خنک و سایه‌گستر، در پاییز رنگارنگ و رؤیایی، و در زمستان آرام و شاعرانه. قدم زدن در این کوچه باغ‌ها تجربه‌ای فراموش‌نشدنی از طبیعت بکر ایران است.",
                      style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "آینده",
                    icon: Icons.timeline_outlined,
                    isExpanded: _isFutureExpanded,
                    onTap: () {
                      setState(() {
                        _isFutureExpanded = !_isFutureExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Text(
                      "با توجه به ارزش بالای منظر فرهنگی کوچه باغ‌ها، طرح‌هایی برای حفاظت از این میراث طبیعی و تاریخی در دست اجراست. ایجاد مسیرهای گردشگری پیاده، مرمت دیوارهای خشتی، و ساماندهی نهرهای آب از جمله اقداماتی است که برای حفظ و احیای این فضاهای ارزشمند انجام می‌شود.",


style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableCard({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onTap,
    required Color color,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, color: Colors.purple[900]),
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: "Vazirmatn",
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              onPressed: onTap,
            ),
            onTap: onTap,
          ),
          
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: content,
            ),
        ],
      ),
    );
  }
}