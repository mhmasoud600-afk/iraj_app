
import 'package:flutter/material.dart';

class OldTexturePage extends StatefulWidget {
  const OldTexturePage({Key? key}) : super(key: key);

  @override
  State<OldTexturePage> createState() => _OldTexturePageState();
}

class _OldTexturePageState extends State<OldTexturePage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/old_texture/oldtexture1.jpg',
    'assets/images/historical/old_texture/oldtexture2.jpg',
    'assets/images/historical/old_texture/oldtexture3.jpg',
    'assets/images/historical/old_texture/oldtexture4.jpg',
  ];

  bool _isHistoryExpanded = true;
  bool _isDescriptionExpanded = false;
  bool _isFutureExpanded = false;
  bool _isRegistrationExpanded = false;

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
          "بافت قدیمی ایراج",
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
                          "روستای ایراج با قدمتی بیش از ۵۰۰۰ سال، یادگارهایی از دوره هخامنشیان و ساسانیان را در خود جای داده است. این روستا در متون قرون سوم و چهارم هجری قمری با نام‌های «ارا» و «ارابه» از آن یاد شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "ساکنان قدیم این روستا دین زرتشتی داشته و بقایای قبرستانی به نام «گبرها» و همچنین دخمه‌های ساده و ابتدایی از گبرها در این روستا موجود می‌باشد. از تپه‌های باستانی روستا، اشیایی مربوط به ۲ تا ۳ هزار سال قبل از میلاد کشف شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "بافت تاریخی روستای ایراج با ساختار معماری خشتی و گلی و سنگ، بر روی بستر غیرمسطح و تپه‌مانند مشرف به دشت شکل گرفته است. فراوانی چشمه‌ها (معروف به روستای سی‌وسه چشمه) و معماری با طاق و قوس، حیاط مرکزی و ایوان‌های رفیع از ویژگی‌های خاص این روستاست.",
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
                          "بافت قدیمی روستای ایراج نمادی از معماری سنتی کویری ایران با خانه‌های خشتی و گلی، کوچه‌های پیچ‌درپیچ و ساباط‌های سایه‌گستر است. ویژگی‌های شاخص این بافت تاریخی عبارتند از:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• معماری خشتی و گلی با مصالح خشت خام، گل و سنگ\n"
                          "• ساختار طاق و قوس با سقف‌های گنبدی و اندود کاهگل\n"
                          "• حیاط مرکزی با ایوان‌های رفیع\n"
                          "• کوچه‌های باریک و ساباط‌های سایه‌گستر برای تنظیم جریان هوا\n"
                          "• چشمه‌های متعدد با مظهر درون خانه‌های قدیم",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در مرکز بافت تاریخی، قلعه ایراج بر روی تپه صخره‌ای خودنمایی می‌کند و سرو کهنسال با قدمت بیش از ۱۰۰۰ سال در ضلع شرقی قلعه، از دیگر نمادهای این بافت تاریخی است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "ثبت ملی",
                    icon: Icons.verified,
                    isExpanded: _isRegistrationExpanded,
                    onTap: () {
                      setState(() {
                        _isRegistrationExpanded = !_isRegistrationExpanded;
                      });
                    },
                    color: _lightPurple,
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
                          "شماره ثبت: ۳۳۴۸۹",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "تاریخ ثبت: ۱۰ آبان ۱۴۰۰",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
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
                    color: _darkPurple,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "با ثبت ملی بافت تاریخی روستای ایراج، توجه به حفظ و مرمت بناهای تاریخی این روستا افزایش یافته است. اقدامات ارزشمندی در سال‌های اخیر صورت گرفته است:",


style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "مرمت بافت تاریخی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• مرمت خانه‌های قدیمی روستا با مشارکت کارشناسان خبره مرمت و جامعه محلی\n"
                          "• مرمت آسیاب آبی و ایجاد آسیاب آبی تازه\n"
                          "• ایجاد طاقی برای گرامیداشت سرو کهنسال با مشارکت داوطلبان فرانسوی",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "توسعه گردشگری و احیای اقتصادی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• ایجاد اقامتگاه‌های بوم‌گردی متنوع با همیاری جامعه محلی\n"
                          "• راه‌اندازی کارگاه‌های صنایع دستی (کرباسبافی، نخریسی، پارچه‌بافی)\n"
                          "• احیای مشاغل سنتی و مهاجرت معکوس جوانان به روستا",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "بافت تاریخی ایراج به عنوان یک میراث ارزشمند فرهنگی، با توسعه گردشگری، زمینه اشتغال و رونق اقتصادی روستا را فراهم آورده و به یکی از نمونه‌های موفق گردشگری در استان اصفهان تبدیل شده است.",
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