
import 'package:flutter/material.dart';

class ChenMadoCavePage extends StatefulWidget {
  const ChenMadoCavePage({Key? key}) : super(key: key);

  @override
  State<ChenMadoCavePage> createState() => _ChenMadoCavePageState();
}

class _ChenMadoCavePageState extends State<ChenMadoCavePage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/chenmado_cave/cave1.jpg',
    'assets/images/historical/chenmado_cave/cave2.jpg',
    'assets/images/historical/chenmado_cave/cave3.jpg',
    'assets/images/historical/chenmado_cave/cave4.jpg',
  ];

  bool _isHistoryExpanded = true;
  bool _isEtymologyExpanded = false;  // بخش جدید برای نام‌شناسی
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
          "غار چنمادو (چونمادو)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
                          "روستای ایراج با قدمتی بیش از ۴۰۰۰ تا ۵۰۰۰ سال، یادگارهایی از دوره هخامنشیان و ساسانیان را در خود جای داده است. از تپه‌های باستانی این روستا اشیایی مربوط به ۴۵۰۰ تا ۵۰۰۰ سال پیش بدست آمده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در میان آثار باستانی این روستا، غاری کوچک به نام «چونمادو» وجود دارد. در ادوار مختلف، مردم روستا از این غار به عنوان پناهگاه استفاده می‌نمودند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "وجه تسمیه و نام‌شناسی",
                    icon: Icons.translate,
                    isExpanded: _isEtymologyExpanded,
                    onTap: () {
                      setState(() {
                        _isEtymologyExpanded = !_isEtymologyExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "بررسی ریشه‌شناسی نام «چونمادو» حاوی نکات جالبی است:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• «چون» در گویش محلی به معنی سوراخ و غار است\n"


"• «مادو» در گویش محلی معنی خاصی ندارد\n"
                          "• در گویش محلی به تمامی اسم‌ها حرف «و» اضافه می‌کنند\n"
                          "• وجود این غار باید از زمان مادها که پیش از هخامنشیان بودند به یادگار مانده باشد",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "شواهد تاریخی منطقه",
                    icon: Icons.description,
                    isExpanded: _isDescriptionExpanded,
                    onTap: () {
                      setState(() {
                        _isDescriptionExpanded = !_isDescriptionExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "چندین شاهد تاریخی، قدمت کهن این منطقه را تأیید می‌کند:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• نام قدیمی «ارا» در گویش محلی که باید یک نام زرتشتی باشد\n"
                          "• وجود گورستان‌های گبری معروف به «مزار گبرها»\n"
                          "• این آثار و گویش‌ها حکایت از زرتشتی بودن اهالی در گذشته دارد\n"
                          "• قدمت روستا به عهد ساسانیان بازمی‌گردد، زمانی که دین رسمی ایرانیان زرتشتی بود",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "آینده و حفاظت",
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
                          "بافت تاریخی روستای ایراج در تاریخ ۱۰ آبان ۱۴۰۰ با شماره ۳۳۴۸۹ در فهرست آثار ملی ایران به ثبت رسیده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "برنامه‌های پیشنهادی برای غار چنمادو:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• مطالعه و کاوش علمی غار توسط باستان‌شناسان\n"
                          "• مستندسازی ویژگی‌های زمین‌شناختی و تاریخی\n"
                          "• حفاظت از غار در برابر تخریب‌های طبیعی و انسانی\n"
                          "• معرفی غار به عنوان بخشی از میراث کهن منطقه",
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