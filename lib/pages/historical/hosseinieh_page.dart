
import 'package:flutter/material.dart';

class HosseiniehPage extends StatefulWidget {
  const HosseiniehPage({Key? key}) : super(key: key);

  @override
  State<HosseiniehPage> createState() => _HosseiniehPageState();
}

class _HosseiniehPageState extends State<HosseiniehPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/hosseinieh/hosseinieh1.jpg',
    'assets/images/historical/hosseinieh/hosseinieh2.jpg',
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
          "حسینیه ایراج",
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
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "روستای ایراج با قدمتی ۴۰۰۰ تا ۵۰۰۰ ساله، یادگارهایی از دوره هخامنشیان و ساسانیان را در خود جای داده است. ساکنان قدیم این روستا دین زرتشتی داشته و بقایای قبرستانی به نام «گبرها» در این روستا موجود می‌باشد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "با ورود اسلام به ایران و گسترش آن در مناطق کویری، ساکنان ایراج به دین اسلام گرویدند و بناهای مذهبی اسلامی در این روستا شکل گرفت. حسینیه‌ها به عنوان مکان‌هایی برای برگزاری مراسم مذهبی به ویژه در ایام محرم، ریشه در فرهنگ شیعی ایران دارند و از دوران صفویه به بعد در شهرها و روستاهای ایران شکل گرفتند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
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
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "حسینیه روستای ایراج با معماری سنتی کویری و مصالح بوم‌آورد شامل خشت خام و گل ساخته شده است. این بنا که در بافت قدیم روستا قرار دارد، دارای ویژگی‌های زیر می‌باشد:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),


Text(
                          "• حیاط مرکزی\n"
                          "• ایوان‌ها و سکوهای گلی و خشتی برای نشستن مردم در مراسم\n"
                          "• منبر چوبی قدیمی با نقوش هندسی ساده\n"
                          "• طاق‌های گنبدی شکل (ویژگی معماری کویری)",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در ایام محرم، مراسم‌های مختلفی در این حسینیه برگزار می‌شود که از جمله می‌توان به سینه‌زنی، روضه‌خوانی، علم‌کشی و نخل‌گردانی در شب تاسوعا و عاشورا اشاره کرد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "آینده و چشم‌انداز",
                    icon: Icons.timeline_outlined,
                    isExpanded: _isFutureExpanded,
                    onTap: () {
                      setState(() {
                        _isFutureExpanded = !_isFutureExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "با ثبت بافت تاریخی روستای ایراج در فهرست آثار ملی ایران به شماره ۳۳۴۸۹ در تاریخ ۱۰ آبان ۱۴۰۰، توجه به حفظ و مرمت بناهای تاریخی این روستا از جمله حسینیه افزایش یافته است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "برنامه‌های حفاظتی و رونق‌بخشی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• مرمت و حفظ حسینیه با مشارکت میراث فرهنگی و اهالی روستا\n"
                          "• معرفی این مکان به عنوان جاذبه گردشگری مذهبی\n"
                          "• ثبت مراسم سنتی (مانند نخل‌گردانی) در فهرست میراث ناملموس",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "روستای ایراج با داشتن جاذبه‌های متعدد از جمله قلعه تاریخی، سرو کهنسال، ۳۳ چشمه آب شیرین و بافت تاریخی ارزشمند، به یکی از مقاصد مهم گردشگری شهرستان خوروبیابانک تبدیل شده است.",
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