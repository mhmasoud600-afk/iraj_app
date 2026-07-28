
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChelehKhonePage extends StatefulWidget {
  const ChelehKhonePage({Key? key}) : super(key: key);

  @override
  State<ChelehKhonePage> createState() => _ChelehKhonePageState();
}

class _ChelehKhonePageState extends State<ChelehKhonePage> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  final List<String> _images = [
    'assets/images/eghamatgah/chelehkhone/chelehkhone1.jpg',
    'assets/images/eghamatgah/chelehkhone/chelehkhone2.jpg',
    'assets/images/eghamatgah/chelehkhone/chelehkhone3.jpg',
    'assets/images/eghamatgah/chelehkhone/chelehkhone4.jpg',
  ];

  bool _isIntroExpanded = true;
  bool _isFacilitiesExpanded = false;
  bool _isPhoneExpanded = false;
  bool _isSocialExpanded = false;

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
          "اقامتگاه چله خونه",
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
                    title: "معرفی",
                    icon: Icons.info_outline,
                    isExpanded: _isIntroExpanded,
                    onTap: () {
                      setState(() {
                        _isIntroExpanded = !_isIntroExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Text(
                      "اقامتگاه چله خونه به میزبانی خانم حیدری واقع در بافت سنتی روستا، یک فضای سنتی و خودمانی را برای شما مهیا کرده است.",
                      style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  _buildExpandableCard(
                    title: "امکانات",
                    icon: Icons.room_service_outlined,
                    isExpanded: _isFacilitiesExpanded,
                    onTap: () {
                      setState(() {
                        _isFacilitiesExpanded = !_isFacilitiesExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFacilityItem("اتاق خواب یک"),
                        _buildFacilityItem("اتاق خواب دو"),
                        _buildFacilityItem("اتاق خواب سه"),
                        _buildFacilityItem("صبحانه"),
                        _buildFacilityItem("ناهار"),
                        _buildFacilityItem("شام"),
                      ],
                    ),
                  ),
                  _buildExpandableCard(
                    title: "آدرس و شماره تماس",
                    icon: Icons.phone,
                    isExpanded: _isPhoneExpanded,
                    onTap: () {
                      setState(() {
                        _isPhoneExpanded = !_isPhoneExpanded;
                      });
                    },
                    color: _lightPurple,
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "آدرس: روستای ایراج، خیابان ارابه، کوچه پایاب، اقامتگاه چله خونه",
                          style: TextStyle(fontFamily: "Vazirmatn", fontSize: 14),


),
                      ],
                    ),
                  ),
                  _buildExpandableCard(
                    title: "راه ارتباط مجازی",
                    icon: Icons.chat_bubble_outline,
                    isExpanded: _isSocialExpanded,
                    onTap: () {
                      setState(() {
                        _isSocialExpanded = !_isSocialExpanded;
                      });
                    },
                    color: _darkPurple,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSocialItem("تلگرام", ""),
                        _buildSocialItem("واتساپ", ""),
                        _buildSocialItem("اینستاگرام", ""),
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

  Widget _buildFacilityItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.purple, size: 16),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialItem(String platform, String value) {
    IconData getIcon() {
      if (platform == "تلگرام") return Icons.send;
      if (platform == "واتساپ") return Icons.chat;
      if (platform == "اینستاگرام") return Icons.camera_alt;
      return Icons.link;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(getIcon(), color: Colors.purple, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? platform : "$platform: $value",
              style: const TextStyle(fontFamily: "Vazirmatn", fontSize: 14),
            ),
          ),
          if (value.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.copy, size: 18, color: Colors.purple),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(


content: Text(
                      "$platform کپی شد",
                      style: const TextStyle(fontFamily: "Vazirmatn"),
                      textDirection: TextDirection.rtl,
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}