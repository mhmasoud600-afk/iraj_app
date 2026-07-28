
import 'package:flutter/material.dart';

class GabraTombPage extends StatefulWidget {
  const GabraTombPage({Key? key}) : super(key: key);

  @override
  State<GabraTombPage> createState() => _GabraTombPageState();
}

class _GabraTombPageState extends State<GabraTombPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/gabra_tomb/gabra1.jpg',
    'assets/images/historical/gabra_tomb/gabra2.jpg',
    'assets/images/historical/gabra_tomb/gabra3.jpg',
    'assets/images/historical/gabra_tomb/gabra4.jpg',
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
          "مزار گبرا (قبرستان گبرها)",
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
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "روستای ایراج با قدمتی بیش از ۵۰۰۰ سال، یادگارهایی از دوره هخامنشیان و ساسانیان را در خود جای داده است. ساکنان قدیم این روستا دین زرتشتی داشته و بقایای قبرستانی به نام «گبرها» و همچنین دخمه‌ای ساده و ابتدایی از گبرها در این روستا موجود می‌باشد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در کرانه‌های شمالی و جنوبی ایراج، گورستان‌های قدیمی مربوط به زرتشتیان وجود دارد که به «مزار گبرها» معروف است و حکایت از قدمت بسیار زیاد این منطقه دارد. نام ایراج در متون قدیمی «ارابه» و در بعضی متون نیز نام زرتشتی «ارا» آمده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          " گویش خاص این منطقه که گاهی کلماتی با قدمت دوره ساسانی در آن به گوش می‌خورد، از دیگر نشانه‌های حضور کهن زرتشتیان در این دیار است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "معنی واژه گبر",
                    icon: Icons.translate,
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
                          "واژه «گبر» در متون تاریخی ایران به زرتشتیان اطلاق می‌شده است. این واژه ریشه در زبان آرامی دارد و از واژه «گَبْرا» یا «گَوْرا» به معنای «مرد» گرفته شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در دوره ساسانیان برای اشاره به بخشی از زرتشتیان ساکن میانرودان به کار می‌رفته و پس از اسلام میان ایرانیان به عنوان واژه‌ای کلی برای اشاره به زرتشتیان رواج یافته است. در زبان کردی، «گور» به معنی بزرگ و در زبان بلوچی نیز به معنی مرد است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "نکته مهم: زرتشتیان خود را «بهدین» یا «زرتشتی» می‌نامند و واژه گبر را به دلیل بار معنایی تحقیرآمیزی که در طول تاریخ یافته است، نمی‌پذیرند. لهجهٔ زرتشتیان را گبری می‌خوانند که پورداوود آن را بهدینی نامید.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "ویژگی‌ها",
                    icon: Icons.description,
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
                          "مزار گبرا به محل دفن مردگان در آیین زرتشت گفته می‌شود. این قبرها دارای ویژگی‌های خاص زیر هستند:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• موقعیت مکانی: بر روی تپه‌ها و مکان‌های مرتفع ساخته شده‌اند\n"
                          "• جهت‌گیری: رو به خورشید (با باور زرتشتیان به نور و روشنایی)\n"
                          "• ساختار: به صورت گرد یا بیضی با سنگ‌چین در اطراف، ارتفاع از نیم متر تا ۲ متر\n"
                          "• نحوه دفن: به صورت جنینی با دست و پای جمع، سر رو به شرق\n"
                          "• اشیای همراه: کاسه‌های سفالی، خنجر، سپر، زیورآلات و سکه‌ها (نشانه اعتقاد به زندگی پس از مرگ)",
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