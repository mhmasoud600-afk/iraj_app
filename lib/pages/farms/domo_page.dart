
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DomoPage extends StatefulWidget {
  const DomoPage({super.key});

  @override
  State<DomoPage> createState() => _DomoPageState();
}

class _DomoPageState extends State<DomoPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _showFarmSection = false;
  bool _showLocationSection = false;
  bool _showFacilitiesSection = false;
  bool _showFutureSection = false;

  final double latitude = 28.1234;
  final double longitude = 51.5678;

  final List<String> images = [
    "assets/images/farms/domo1.jpg",
    "assets/images/farms/domo2.jpg",
    "assets/images/farms/domo3.jpg",
    "assets/images/farms/domo4.jpg",
  ];

  Future<void> _openMap() async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );

    final Uri appleMapsUrl = Uri.parse(
      'https://maps.apple.com/?q=$latitude,$longitude',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('امکان باز کردن نقشه وجود ندارد')),
      );
    }
  }

  Widget _buildSectionCard({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.deepPurple.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.deepPurple,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: content,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Column(
      children: [
        const SizedBox(height: 16),


Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: PageView.builder(
              controller: _pageController,
              itemCount: images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.deepPurple.shade50,
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_outlined,
                            size: 48,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'تصویر یافت نشد',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.deepPurple
                    : Colors.deepPurple.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFarmContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'مزرعه دومو در منطقه‌ای خوش آب‌وهوا قرار دارد. دسترسی به آن از طریق بیخ چاه، گذر از گدار دومو و سپس حدود سه ساعت پیاده‌روی امکان‌پذیر است.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15.5,
            height: 1.9,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'این مزرعه در گذشته متعلق به یکی از اهالی روستای ایراج بوده و دارای چشمه آب شیرین، نخلستان خرما و زمین‌های کشاورزی است. امروزه آثار خانه‌های گلی و درختان خرما در آن مشهود است.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15.5,
            height: 1.9,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'مزرعه دومو در منطقه‌ای با موقعیت طبیعی و اقلیمی خاص قرار گرفته و در گذشته به عنوان محل استقرار فصلی برای کشاورزان و دامداران محلی شناخته می‌شده است.',


textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15.5,
            height: 1.9,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'عرض جغرافیایی: $latitude',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'طول جغرافیایی: $longitude',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14.5,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _openMap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.map_outlined),
            label: const Text(
              'مشاهده در نقشه',
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesContent() {
    final List<String> facilities = [
      'چشمه آب شیرین',
      'زمین‌های کشاورزی فعال',
      'نخلستان خرما',
      'موقعیت دیداری زیبا',
      'مناسب برای طبیعت‌گردی در بهار و پاییز',
    ];

    return Column(
      children: facilities.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.deepPurple,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15.5,
                    height: 1.8,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFutureContent() {
    return const Text(
      'با گذر زمان و به دلیل کاهش منابع آب، فعالیت کشاورزی در مزرعه دومو محدود شده است. این منطقه اکنون بیش از گذشته برای گردش، بازدید و تجربه سکوت و طبیعت کویری مورد توجه قرار می‌گیرد و می‌تواند در آینده به عنوان یکی از مقاصد آرام و بومی طبیعت‌گردی معرفی شود.',
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 15.5,
        height: 1.9,
        color: Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F5FF),
        appBar: AppBar(
          title: const Text(
            'مزرعه دومو',
            style: TextStyle(


fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _buildImageSlider(),
            _buildSectionCard(
              title: 'مزرعه دومو',
              isExpanded: _showFarmSection,
              onTap: () {
                setState(() {
                  _showFarmSection = !_showFarmSection;
                });
              },
              content: _buildFarmContent(),
            ),
            _buildSectionCard(
              title: 'موقعیت جغرافیایی',
              isExpanded: _showLocationSection,
              onTap: () {
                setState(() {
                  _showLocationSection = !_showLocationSection;
                });
              },
              content: _buildLocationContent(),
            ),
            _buildSectionCard(
              title: 'امکانات رفاهی',
              isExpanded: _showFacilitiesSection,
              onTap: () {
                setState(() {
                  _showFacilitiesSection = !_showFacilitiesSection;
                });
              },
              content: _buildFacilitiesContent(),
            ),
            _buildSectionCard(
              title: 'چشم انداز آینده',
              isExpanded: _showFutureSection,
              onTap: () {
                setState(() {
                  _showFutureSection = !_showFutureSection;
                });
              },
              content: _buildFutureContent(),
            ),
          ],
        ),
      ),
    );
  }
}