
import 'package:flutter/material.dart';

class CastlePage extends StatefulWidget {
  const CastlePage({Key? key}) : super(key: key);

  @override
  State<CastlePage> createState() => _CastlePageState();
}

class _CastlePageState extends State<CastlePage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/castle/castle1.jpg',
    'assets/images/historical/castle/castle2.jpg',
    'assets/images/historical/castle/castle3.jpg',
    'assets/images/historical/castle/castle4.jpg',
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
          "قلعه ایراج",
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
                          "از روستای ایراج در متون قرون سوم و چهارم هجری قمری با نام‌های «ارا» و «ارابه» یاد شده است. این روستا دارای قدمتی ۵۰۰۰ ساله است و از تپه‌های باستانی آن اشیایی مربوط به ۲ تا ۳ هزار سال قبل از میلاد کشف شده است. ساکنان قدیم آن دین زرتشتی داشته و بقایای قبرستانی به نام «گبرها» در این روستا موجود می‌باشد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "این قلعه بر اساس منابع، یکی از قلعه‌های متعلق به دوره اسماعیلیه در قرن چهارم هجری قمری است که در دوران قاجار بازسازی شده است. بر اساس شجره‌نامه امامزاده بیاضه و روایات محلی، این قلعه در زمان ورود اعراب به منطقه (حدود ۱۳۰۰ سال پیش) وجود داشته و به دلیل استحکام بالا، تسخیرناپذیر بوده است. در این شجره‌نامه آمده که ساکنان قلعه با پرداخت جزیه، بر دین خود باقی ماندند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "این روستا در گذشته بارها مورد تهاجم قرار گرفته است. از جمله گروهی از ایل باصری به سرکردگی رمضان خان باصری با کشتن مسعود لشکر، قلعه ایراج را به تسخیر خود درآورد. این قلعه در طول تاریخ یکبار توسط اعراب و دیگر بار توسط قوای دولتی برای بیرون راندن رمضان خان باصری تخریب شده است. در درگیری میان قوای دولتی و رمضان خان باصری در سال ۱۳۲۷ هجری قمری (حدود ۱۲۸۸ شمسی) بخشی از قلعه آسیب دید و سرانجام در تاریخ ۲۸ فروردین ۱۲۹۸ قلعه سقوط کرد.",
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
                          "این قلعه دیدنی یک سازه مشهور و شگفت‌انگیز است که از آن دیدن می‌کنید. جنس این سازه از خشت بوده و ترکیبی از گل نیز در آن وجود دارد. قلعه‌ای در میان روستا و بر روی تپه‌ها که از زیبایی و نمای دیدنی آن بازدید می‌کنید. این قلعه قدمت بالایی داشته و یک معماری قدیمی داشته که از نزدیک شاهد آن هستید. در ساخت این بنا از خشت استفاده شده و دارای دیوارهای بلندی است.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "ویژگی‌های معماری:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• این بنا روی تپه‌ای در وسط بافت قدیم روستا و مشرف به دشت ساخته شده است\n"
                          "• قلعه دارای سه طبقه بوده که هم‌اکنون به صورت مخروبه‌ای از آن باقی مانده است\n"
                          "• قلعه چهار برج در چهار گوشه داشته که دو برج آن هنوز تقریباً سالم مانده است\n"
                          "• دو راهرو طویل و باریک شرقی-غربی در دو طرف بنا وجود دارد که به همه اتاق‌ها، هال مرکزی و برج‌ها راهرسی دارد\n"
                          "• دو در بزرگ و یک چاه آب از دیگر بخش‌های دیدنی قلعه است\n"
                          "• مصالح به کار رفته خشت خام و گل است\n"
                          "• تا حدود ۴۰ سال پیش، از اتاق‌های آن به‌عنوان مکتب‌خانه استفاده می‌شده است",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "موقعیت راهبردی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "قلعه در مکانی واقع شده که دیدبان‌ها می‌توانستند از چند کیلومتری متجاوزین را رصد کنند. به جز از سمت غرب به دلیل وجود کوه‌ها و تپه‌ها، برجی دیدبانی در قسمت غربی قلعه بر روی تپه‌ای واقع شده تا ساکنین قلعه غافلگیر نشوند.",
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
                          "قلعه ایراج در تاریخ ۱۰ آبان ۱۴۰۰ با شماره ۳۳۴۹۰ در فهرست آثار ملی ایران به ثبت رسیده است.",


style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "شماره ثبت: ۳۳۴۹۰",
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
                          "با ثبت ملی قلعه در سال ۱۴۰۰، انتظار می‌رود برنامه‌هایی برای حفاظت و مرمت این اثر ارزشمند در دستور کار قرار گیرد. این منطقه پتانسیل بالایی برای توسعه گردشگری تاریخی دارد.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "جاذبه‌های طبیعی همراه:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• در ضلع شرقی قلعه، یک سرو کهنسال با قدمت بیش از ۱۰۰۰ سال قرار دارد که یادگاری از زرتشتیان و ساکنان قدیم روستا است\n"
                          "• در این روستا ۳۳ چشمه آب شیرین وجود دارد",
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