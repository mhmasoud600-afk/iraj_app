
import 'package:flutter/material.dart';

class CypressTreePage extends StatefulWidget {
  const CypressTreePage({Key? key}) : super(key: key);

  @override
  State<CypressTreePage> createState() => _CypressTreePageState();
}

class _CypressTreePageState extends State<CypressTreePage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  
  final List<String> _images = [
    'assets/images/historical/cypress_tree/cypress1.jpg',
    'assets/images/historical/cypress_tree/cypress2.jpg',
    'assets/images/historical/cypress_tree/cypress3.jpg',
    'assets/images/historical/cypress_tree/cypress4.jpg',
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
          "سرو کهنسال ایراج",
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
                          "درخت سرو کهنسال ایراج، یکی از نمادهای طبیعی و تاریخی این روستای کویری است که در ضلع شرقی قلعه ایراج قرار دارد. قدمت این سرو تنومند را بیش از ۱۰۰۰ تا ۱۴۰۰ سال می‌دانند. این درخت یادگاری از زرتشتیان و ساکنان قدیم روستاست که پیش از ورود اسلام به این منطقه در این دیار می‌زیسته‌اند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "سرو در فرهنگ ایرانی نماد آزادگی، پایداری و زندگی توصیف می‌شود. این درخت به عنوان یک درخت درست‌قامت و همیشه‌سبز حتی در سرما پایداری می‌کند. درست‌قامتی سرو از آن جهت مهم است که برخلاف درختان دیگر با تغییر عوامل و فشارها، روند رشد درست خود را حفظ می‌کند، از این‌رو ایرانیان باستان آن را الگوی طبیعی برای انسان می‌دانستند.",
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
                          "این سرو کهنسال با قامتی بلند و تنه‌ای ستبر، در ضلع شرقی قلعه ایراج واقع شده است. ویژگی‌های منحصربه‌فرد این درخت عبارتند از:",


style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "• ارتفاع: بیش از ۵۰ تا ۷۰ متر\n"
                          "• قطر تنه: حدود دو متر یا بیشتر\n"
                          "• موقعیت: ضلع شرقی قلعه ایراج، مشرف به دشت\n"
                          "• قدمت: بیش از ۱۰۰۰ سال",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "پس از پیروزی انقلاب اسلامی، پرچم جمهوری اسلامی ایران بر فراز این درخت کهنسال برافراشته شد و از آن پس هر از چندگاهی پرچم جدیدی جایگزین می‌کنند. اهالی روستا برای این درخت احترام خاصی قائلند و آن را نشانه برکت و پایداری روستا می‌دانند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "برای رسیدن به این سرو کهنسال، باید از طاقی عبور کرد که معمار مرمتگر روستا همراه با نیروهای داوطلب فرانسوی، برای گرامیداشت این درخت برپا کردند.",
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
                          "با توجه به اهمیت زیست‌محیطی و فرهنگی درختان کهنسال، ثبت ملی بافت تاریخی روستای ایراج در سال ۱۴۰۰، نویدبخش برنامه‌هایی برای حفاظت و نگهداری این سرو ارزشمند است. این درخت به عنوان یکی از جاذبه‌های طبیعی شاخص روستای ایراج، سالانه گردشگران زیادی را به خود جذب می‌کند.",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "اهمیت حفاظتی:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• این سرو کهنسال به عنوان یک میراث طبیعی و فرهنگی، نیازمند مراقبت و حفاظت ویژه است\n"
                          "• گردشگران و علاقه‌مندان به طبیعت می‌توانند از این درخت دیدن کرده و با تاریخ شفاهی مرتبط با آن آشنا شوند\n"
                          "• با توجه به خشکسالی‌های اخیر و تغییرات اقلیمی، حفظ این میراث کهنسال اهمیت دوچندانی یافته است",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "پتانسیل گردشگری:",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14, fontWeight: FontWeight.bold),


),
                        SizedBox(height: 4),
                        Text(
                          "سرو کهنسال ایراج در کنار قلعه تاریخی و ۳۳ چشمه آب شیرین روستا، یکی از مهمترین جاذبه‌های گردشگری شهرستان خوروبیابانک محسوب می‌شود. این روستا با همیاری جامعه محلی و ایجاد اقامتگاه‌های بوم‌گردی، به یکی از نمونه‌های موفق گردشگری در استان اصفهان تبدیل شده است.",
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