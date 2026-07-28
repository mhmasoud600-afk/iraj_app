import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BondarPage extends StatefulWidget {
  const BondarPage({super.key});

  @override
  State<BondarPage> createState() => _BondarPageState();
}

class _BondarPageState extends State<BondarPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _showFarmSection = true;
  bool _showLocationSection = false;
  bool _showFacilitiesSection = false;
  bool _showFutureSection = false;

  final List<String> _images = [
    'assets/images/bondar1.jpg',
    'assets/images/bondar2.jpg',
    'assets/images/bondar3.jpg',
    'assets/images/bondar4.jpg',
  ];

  final String _farmDescription =
      'مزرعه بندر در نزدیکی مناطق شنی و کویری قرار دارد و به دلیل موقعیت جغرافیایی خاص خود، '
      'دارای پوشش گیاهی ویژه‌ای است. در فصل بهار آبشاری به ارتفاع 50 متر در این مزرعه قابل مشاهده است '
      'که بسیار زیباست. این مزرعه معمولاً در فصل بهار بسیار سرسبز می‌شود و منظره‌های بدیعی از تقابل کویر '
      'و سرسبزی را به نمایش می‌گذارد.';

  final List<String> _vegetationItems = [
    'درختان مقاوم به خشکی',
    'گیاهان دارویی کویری',
    'گز و تاغ',
    'گیاهان فصلی بهاری',
  ];

  final List<String> _facilitiesItems = [
    'چشمه آب شیرین',
  ];

  final String _futureDescription =
      'با توجه به راه سخت و طولانی، صرفاً کوهنوردان و طبیعت‌گردان به آن مزرعه سر می‌زنند '
      'مگر اینکه راه دسترسی از پشتکوه برای آن ایجاد شود.';

  // مختصات فرضی موقت
  final double _latitude = 33.500000;
  final double _longitude = 54.900000;

  Future<void> _openMap() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$_latitude,$_longitude',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildSectionCard({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
    IconData icon = Icons.keyboard_arrow_down_rounded,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.orange.shade100,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      icon,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: child,
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
        Container(
          margin: const EdgeInsets.all(16),
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.orange.shade50,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image,
                      size: 60,
                      color: Colors.deepOrange,
                    ),
                  );
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.deepOrange
                    : Colors.orange.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFarmContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _farmDescription,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 15,
            height: 1.9,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'پوشش گیاهی:',
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(height: 10),
        ..._vegetationItems.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•  ',
                  style: TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Vazirmatn',
                      fontSize: 15,
                      height: 1.7,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
'مختصات فعلی به صورت فرضی در نظر گرفته شده‌اند و بعداً قابل اصلاح هستند.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 15,
            height: 1.8,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عرض جغرافیایی: $_latitude',
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'طول جغرافیایی: $_longitude',
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 14,
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
            icon: const Icon(Icons.map_outlined),
            label: const Text(
              'نمایش روی نقشه',
              style: TextStyle(
                fontFamily: 'Vazirmatn',
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _facilitiesItems
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 15,
                        height: 1.8,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFutureContent() {
    return Text(
      _futureDescription,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 15,
        height: 1.9,
        color: Colors.black87,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFDF8F4),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
centerTitle: true,
          elevation: 0,
          title: const Text(
            'مزرعه بُندَر',
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _buildImageSlider(),
            _buildSectionCard(
              title: 'مزرعه بندر',
              isExpanded: _showFarmSection,
              onTap: () {
                setState(() {
                  _showFarmSection = !_showFarmSection;
                });
              },
              child: _buildFarmContent(),
            ),
            _buildSectionCard(
              title: 'موقعیت جغرافیایی',
              isExpanded: _showLocationSection,
              onTap: () {
                setState(() {
                  _showLocationSection = !_showLocationSection;
                });
              },
              child: _buildLocationContent(),
            ),
            _buildSectionCard(
              title: 'امکانات رفاهی',
              isExpanded: _showFacilitiesSection,
              onTap: () {
                setState(() {
                  _showFacilitiesSection = !_showFacilitiesSection;
                });
              },
              child: _buildFacilitiesContent(),
            ),
            _buildSectionCard(
              title: 'چشم انداز آینده',
              isExpanded: _showFutureSection,
              onTap: () {
                setState(() {
                  _showFutureSection = !_showFutureSection;
                });
              },
              child: _buildFutureContent(),
            ),
          ],
        ),
      ),
    );
  }
}