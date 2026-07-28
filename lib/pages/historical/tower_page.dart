
import 'package:flutter/material.dart';

class TowerPage extends StatefulWidget {
  const TowerPage({Key? key}) : super(key: key);

  @override
  State<TowerPage> createState() => _TowerPageState();
}

class _TowerPageState extends State<TowerPage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/tower/tower1.jpg',
    'assets/images/historical/tower/tower2.jpg',
    
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
          "برج دیدبانی ایراج",
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
                    title: "پیشینه و موقعیت",
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
                          "برج ایراج بر روی تپه‌ای بلند واقع شده است و محل دیدبانی بوده است. این برج بر کل منطقه منجمله قلعه روستا تا فرسنگ‌ها تسلط داشته است. در گذشته، قلعه‌های نظامی دارای برج‌های متعددی برای دیده‌بانی بوده‌اند؛ برای مثال، قلعه ایرج ورامین دارای ۱۴۸ برج دیدبانی بوده است .",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "موقعیت راهبردی این برج به گونه‌ای انتخاب شده که دیدبان‌ها می‌توانستند از چند کیلومتری متجاوزین را رصد کنند. در قدیم سارقان و دزدان زیادی برای سرقت به روستاها حمله می‌کردند. از این محل برای دیدبانی و اطلاع‌رسانی در خصوص رویت آنها استفاده می‌شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "برج‌های دیدبانی معمولاً بر نوک تپه‌ها و کوه‌پایه‌ها ساخته می‌شدند و شکل ظاهری آنها مانند یک برج کوتاه و گرد بوده که بام آنها دورچین داشته تا دیدبان‌ها از آنجا تمام منطقه را رصد کنند .",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "ویژگی‌های معماری",
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
                          "این برج با مصالح بوم‌آورد شامل خشت خام و گل ساخته شده است. نکته مهم و قابل توجه، وجود برجی دیدبانی در قسمت غربی قلعه بر روی تپه‌ای مجزاست.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "دلیل ساخت این برج جداگانه این بوده که به دلیل وجود کوه‌ها و تپه‌ها در سمت غرب، امکان دیدبانی از روی قلعه وجود نداشته، بنابراین برجی بر روی تپه‌ای در غرب ساخته شده تا ساکنین قلعه غافلگیر نشوند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "در معماری سنتی، برج‌ها را در دید همدیگر می‌ساختند تا اگر اولین برجی که دشمن را رویت کرد، به وسیله دود و آتش به برج بعدی خبر دهد و به همین ترتیب خبر ورود دشمن به منطقه را به مقامات خودی برسانند .",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "سیستم اطلاع‌رسانی",
                    icon: Icons.notifications_active,
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
                          "در صورت مشاهده خطر، به سرعت با آتش یا روش‌های دیگر به اهالی قلعه در خصوص وجود تهدید اطلاع‌رسانی می‌شده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "این سیستم هشدار سریع به ساکنان قلعه امکان می‌داد تا پیش از رسیدن مهاجمان، آمادگی دفاعی لازم را کسب کنند. استفاده از آتش و دود برای انتقال خبر در فواصل دور، روشی سریع و مؤثر در دوران باستان بوده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "برج‌های دیدبانی در تنگه‌ها و گذرگاه‌های کاروانیان نیز ساخته می‌شدند تا از امنیت دو طرف تنگه اطلاع حاصل شود .",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  
                  _buildExpandableCard(
                    title: "ثبت ملی و آینده",
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
                          "قلعه ایراج در تاریخ ۱۰ آبان ۱۴۰۰ با شماره ۳۳۴۹۰ در فهرست آثار ملی ایران به ثبت رسیده است. همچنین بافت تاریخی روستای ایراج نیز با شماره ۳۳۴۸۹ به ثبت ملی رسیده است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "وضعیت کنونی: این برج در حال حاضر تا حدودی بازسازی شده است. مرمت و بازسازی این برج دیدبانی می‌تواند به حفظ این میراث تاریخی و همچنین جذب گردشگر کمک شایانی نماید.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "با توجه به ثبت ملی این اثر ارزشمند، برنامه‌هایی برای حفاظت و مرمت برج‌های باقیمانده در دستور کار قرار دارد. ایجاد مسیر دسترسی مناسب و نورپردازی می‌تواند این برج را به یکی از نقاط دیدنی روستا تبدیل کند.",
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