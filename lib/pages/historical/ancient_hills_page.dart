
import 'package:flutter/material.dart';

class AncientHillsPage extends StatefulWidget {
  const AncientHillsPage({Key? key}) : super(key: key);

  @override
  State<AncientHillsPage> createState() => _AncientHillsPageState();
}

class _AncientHillsPageState extends State<AncientHillsPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/ancient_hills/ancienthill1.jpg',
    'assets/images/historical/ancient_hills/ancienthill2.jpg',
    'assets/images/historical/ancient_hills/ancienthill3.jpg',
    'assets/images/historical/ancient_hills/ancienthill4.jpg',
  ];

  bool _isHistoryExpanded = true;
  bool _isDescriptionExpanded = false;
  bool _isFutureExpanded = false;
  bool _isMuseumExpanded = false; // بخش جدید برای موزه

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
          "تپه‌های باستانی ایراج",
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
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "روستای ایراج با قدمتی بیش از ۵۰۰۰ سال، یادگارهایی از دوره هخامنشیان و ساسانیان را در خود جای داده است. از تپه‌های باستانی این روستا، اشیایی مربوط به ۲ تا ۳ هزار سال قبل از میلاد کشف شده است که حکایت از تمدنی کهن در حاشیه کویر مرکزی ایران دارد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "سفال‌های پراکنده در سطح این تپه‌ها به هزاره‌های چهارم و پنجم پیش از میلاد تعلق دارند و نشان‌دهنده استقرارهای پیش از تاریخ در این منطقه هستند. وجود گورستان‌های گبری در اطراف روستا، این منطقه را به عنوان محلی برای زندگی زرتشتیان در گذشته معرفی می‌کند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "آثار کشف‌شده",
                    icon: Icons.description,
                    isExpanded: _isDescriptionExpanded,
                    onTap: () {
                      setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "در بررسی‌های باستان‌شناسی سطحی تپه‌های باستانی ایراج، آثار ارزشمندی شناسایی شده است:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,


),
                        SizedBox(height: 8),
                        Text(
                          "• سفال‌های منقوش: قطعات سفال با نقوش هندسی و گیاهی متعلق به هزاره‌های پیش از میلاد\n"
                          "• ابزارهای سنگی: شامل سنگ‌ساب‌ها، هاون‌های سنگی و ابزارهای برش\n"
                          "• اشیای تزئینی: مهره‌های کوچک از جنس سنگ و خمیر شیشه\n"
                          "• بقایای معماری خشتی: شواهدی از سازه‌های مسکونی با خشت و گل",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "موزه محل نگهداری آثار",
                    icon: Icons.museum,
                    isExpanded: _isMuseumExpanded,
                    onTap: () {
                      setState(() {
                        _isMuseumExpanded = !_isMuseumExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "آثار و اشیای تاریخی کشف‌شده از تپه‌های باستانی ایراج و سایر نقاط شهرستان نایین، به موزه مردم‌شناسی کویر نایین (خانه پیرنیا) منتقل می‌شود. این موزه در بافت تاریخی شهر نایین و در خانه‌ای با معماری اصیل کویری متعلق به دوره صفوی قرار دارد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در این موزه بیش از هزار شیء تاریخی نگهداری می‌شود از جمله:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• سفالینه‌های باستانی شامل کوزه‌ها و ظروف سفالی\n"
                          "• کتیبه‌های چوبی از دوره ایلخانی\n"
                          "• ظروف فلزی، سینی‌ها و ادوات جنگی\n"
                          "• زیلوهای قدیمی با قدمت ۳۰۰ تا ۴۰۰ سال\n"
                          "• پوشاک سنتی مربوط به دوره قاجار",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "آینده و اهمیت کاوش",
                    icon: Icons.timeline_outlined,
                    isExpanded: _isFutureExpanded,
                    onTap: () {
                      setState(() {
                        _isFutureExpanded = !_isFutureExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ضرورت کاوش‌های علمی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "کاوش‌های باستان‌شناسی در این محوطه‌ها می‌تواند اطلاعات ارزشمندی درباره زبان، فرهنگ و آیین‌های ساکنان گذشته به دست دهد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,


),
                        SizedBox(height: 8),
                        Text(
                          "چالش‌های موجود:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• تملک اراضی باستانی توسط بومیان منطقه\n"
                          "• نیاز به جلب رضایت مردم برای کاوش\n"
                          "• تهدید حفاری‌های غیرمجاز",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "لزوم تخصیص بودجه:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• کاوش‌های سیستماتیک و هدفمند\n"
                          "• خواناسازی و ترسیم پلان معماری\n"
                          "• ایجاد سایت‌موزه برای نمایش آثار\n"
                          "• حفاظت فیزیکی از محوطه",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
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