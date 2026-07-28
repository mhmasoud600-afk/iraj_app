
import 'package:flutter/material.dart';

class ChaleHozoPage extends StatefulWidget {
  const ChaleHozoPage({Key? key}) : super(key: key);

  @override
  State<ChaleHozoPage> createState() => _ChaleHozoPageState();
}

class _ChaleHozoPageState extends State<ChaleHozoPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/chale_hozo/chalehozo1.jpg',
    'assets/images/historical/chale_hozo/chalehozo2.jpg',
    'assets/images/historical/chale_hozo/chalehozo3.jpg',
    'assets/images/historical/chale_hozo/chalehozo4.jpg',
    'assets/images/historical/chale_hozo/chalehozo5.jpg',
  ];

  bool _isHistoryExpanded = true;
  bool _isDescriptionExpanded = false;
  bool _isFishExpanded = false;
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
          "چاله حوضو (دکتر فیش ۲ ایراج)",
          style: TextStyle(
            fontFamily: "Vazirmatn",
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
                            fit: BoxFit.cover,
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
                    title: "موقعیت و پیشینه",
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
                          "چاله حوضو یکی از اصلی‌ترین چشمه‌های روستای ایراج است که در محله پشت قلعه و کنار منزل قدیم مرحوم استاد مشهدی قرار دارد. این مکان نقطه شروع چشمه است .",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          " این مکان یکی از نقاط دیدنی روستای ایراج در دل کویر می‌باشد",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "کارکرد سنتی",
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
                          "در قدیم که ماشین لباسشویی و ظرفشویی نبود و جمعیت روستا هم زیاد بود، چاله حوضو یکی از محل‌های اصلی شستشوی ظرف و لباس بوده است. در این محل و در امتداد این چشمه، خانم‌های روستا اقدام به شستن لباس و ظرف و فرش می‌کردند.",

style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در حال حاضر نیز، ساکنین قدیمی این محل هنوز برای شستشو از این مکان استفاده می‌کنند و این سنت دیرینه همچنان پابرجاست.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "دکتر فیش ایراج",
                    icon: Icons.clean_hands,
                    isExpanded: _isFishExpanded,
                    onTap: () {
                      setState(() {
                        _isFishExpanded = !_isFishExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "از نکات جالب این مکان دسترسی راحت به چشمه روستاست. همانند آنچه در روستای گرمه با عنوان دکتر فیش معروف است، در این محل نیز ماهی‌های بومی گوشت‌خوار وجود دارد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "این ماهی‌ها که با نام علمی «گارا روفا» (Garra rufa) شناخته می‌شوند، در حوضچه‌های طبیعی برخی از سیستم‌های رودخانه‌ای ایران، ترکیه، سوریه و اردن زندگی می‌کنند. تخمین زده شده که این چشمه‌ها احتمالاً مربوط به دوره ساسانیان است و از دیرباز مورد توجه مردم بوده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "خواص درمانی ماهی‌های گارا روفا:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "• تغذیه از سلول‌های مرده پوست و لایه‌برداری طبیعی\n"
                          "• بزاق این ماهی‌ها حاوی آنزیم‌هایی است که باعث تسریع فرآیند بازسازی پوست می‌شود\n"
                          "• کمک به درمان بیماری‌های پوستی مانند پسوریازیس، اگزما و آکنه\n"
                          "• جوانسازی پوست و کاهش چین‌وچروک",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "ترکیبات معدنی آب چشمه:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "• گوگرد: دارای خاصیت ضدالتهابی و ضدعفونی‌کننده\n"
                          "• کلسیم و منیزیم: کمک به تقویت بافت پوست و ترمیم سلولی\n"
                          "• بیکربنات و سدیم: تسکین دردهای عضلانی و کاهش التهاب\n"
                          "• سولفات: کاهش التهاب و تحریک فرآیندهای بازسازی پوست",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "زمانی که شخصی وارد آب شود، ماهی‌ها به دور پاهای وی هجوم می‌برند و اقدام به گاز گرفتن‌های کوچک می‌کنند. این حس و حال عجیب و غریبی به انسان دست می‌دهد و تجربه‌ای منحصربه‌فرد محسوب می‌شود.",

style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "عملاً این مکان دکتر فیش دیگری در منطقه و در روستای ایراج است که بسیار مورد توجه توریست‌ها می‌باشد. با توجه به شباهت کامل این مکان با چشمه دکتر فیش گرمه، پیشنهاد می‌شود این مکان با عنوان «دکتر فیش ۲ ایراج» نامگذاری شود تا به عنوان دومین جاذبه درمانی-طبیعی منطقه معرفی گردد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "بازسازی و آینده",
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
                          "در سال‌های اخیر به همت دهیاری روستا، این مکان مورد بازسازی قرار گرفته است. همچنین برای شب‌هنگام، نورپردازی شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "چاله حوضو یکی از نقاط دیدنی روستای ایراج در دل کویر می‌باشد و در کنار دیگر جاذبه‌های این روستا (قلعه تاریخی، سرو کهنسال، آسیاب آبی و بافت قدیمی) مقصدی جذاب برای گردشگران است. با توجه به خواص درمانی منحصربه‌فرد این مکان، پتانسیل بالایی برای جذب گردشگران سلامت (توریسم درمانی) وجود دارد.",
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