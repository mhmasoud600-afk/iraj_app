import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HeavenPage extends StatefulWidget {
  const HeavenPage({Key? key}) : super(key: key);

  @override
  State<HeavenPage> createState() => _HeavenPageState();
}

class _HeavenPageState extends State<HeavenPage> {
  // ======================= لیست اماکن متبرکه با رنگ‌های اختصاصی =======================
  final List<Map<String, dynamic>> shrines = [
    // ======================= حرم امام رضا (ع) - رنگ سبز (یک عنوان) =======================
    {
      'name': 'حرم امام رضا (ع) - مشهد مقدس',
      'nameEn': 'Imam Reza Shrine - Mashhad',
      'url': 'https://haram.razavi.ir/live', // لینک رسمی حرم
      'category': 'حرم امام رضا (ع)',
      'gradient': const [Color(0xFF2E7D32), Color(0xFF1B5E20)],
      'icon': Icons.location_city,
      'color': Colors.green,
      'location': 'مشهد، ایران',
    },
    // ======================= حرم امام حسین (ع) - رنگ قرمز =======================
    {
      'name': 'حرم امام حسین (ع) - کربلا',
      'nameEn': 'Imam Hussain Shrine - Karbala',
      'url': 'https://www.alharamlive.com/fa/playing-live-imam-hussain', // لینک جدید
      'category': 'حرم امام حسین (ع)',
      'gradient': const [Color(0xFFC62828), Color(0xFFB71C1C)],
      'icon': Icons.mosque,
      'color': Colors.red,
      'location': 'کربلا، عراق',
    },
    // ======================= حرم حضرت عباس (ع) - رنگ آبی آسمانی =======================
    {
      'name': 'حرم حضرت عباس (ع) - کربلا',
      'nameEn': 'Hazrat Abbas Shrine - Karbala',
      'url': 'https://www.alharamlive.com/fa/playing-live-hazrat-abbas',
      'category': 'حرم حضرت عباس (ع)',
      'gradient': const [Color(0xFF1565C0), Color(0xFF0D47A1)],
      'icon': Icons.flag,
      'color': Colors.blue,
      'location': 'کربلا، عراق',
    },
    // ======================= حرم کاظمین - رنگ بنفش =======================
    {
      'name': 'حرم کاظمین - کاظمین',
      'nameEn': 'Kadhimiya Shrine',
      'url': 'https://www.alharamlive.com/fa/playing-live-kadhimiya', // لینک جدید
      'category': 'حرم کاظمین',
      'gradient': const [Color(0xFF6A1B9A), Color(0xFF4A148C)],
      'icon': Icons.account_balance,
      'color': Colors.purple,
      'location': 'کاظمین، عراق',
    },
    // ======================= حرم سامرا - رنگ طلایی =======================
    {
      'name': 'حرم عسکریین - سامرا',
      'nameEn': 'Samarra Shrine',
      'url': 'https://www.alharamlive.com/fa/playing-live-samarra',
      'category': 'حرم سامرا',
      'gradient': const [Color(0xFFF9A825), Color(0xFFF57F17)],
      'icon': Icons.church,
      'color': Colors.amber,
      'location': 'سامرا، عراق',
    },
    // ======================= حرم حضرت معصومه (س) - رنگ صورتی =======================
    {
      'name': 'حرم حضرت معصومه (س) - قم',
      'nameEn': 'Hazrat Masoumeh Shrine - Qom',
      'url': 'https://amfm.ir/live/', // لینک جدید
      'category': 'حرم حضرت معصومه (س)',
      'gradient': const [Color(0xFFAD1457), Color(0xFF880E4F)],
      'icon': Icons.landscape,
      'color': Colors.pink,
      'location': 'قم، ایران',
    },
    // ======================= مسجدالحرام - رنگ آبی تیره =======================
    {
      'name': 'مسجدالحرام - مکه مکرمه',
      'nameEn': 'Masjid al-Haram - Mecca',
      'url': 'https://www.alharamlive.com/fa/playing-live-mecca', // لینک جدید
      'category': 'مسجدالحرام',
      'gradient': const [Color(0xFF0D47A1), Color(0xFF01579B)],
      'icon': Icons.holiday_village,
      'color': Colors.blue.shade900,
      'location': 'مکه، عربستان',
    },
    // ======================= مسجدالنبی - رنگ فیروزه‌ای =======================
    {
      'name': 'مسجدالنبی - مدینه منوره',
      'nameEn': 'Masjid an-Nabawi - Medina',
      'url': 'https://www.alharamlive.com/fa/playing-live-madinah', // لینک جدید
      'category': 'مسجدالنبی',
      'gradient': const [Color(0xFF00838F), Color(0xFF004D40)],
      'icon': Icons.church,
      'color': Colors.teal,
      'location': 'مدینه، عربستان',
    },
    // ======================= حرم امام علی (ع) - رنگ قهوه‌ای =======================
    {
      'name': 'حرم امام علی (ع) - نجف اشرف',
      'nameEn': 'Imam Ali Shrine - Najaf',
      'url': 'https://www.aparat.com/nooralabbastv_fa/live', // لینک جدید
      'category': 'حرم امام علی (ع)',
      'gradient': const [Color(0xFF4E342E), Color(0xFF3E2723)],
      'icon': Icons.mosque,
      'color': Colors.brown,
      'location': 'نجف، عراق',
    },
  ];

  // ======================= دسته‌بندی اماکن =======================
  Map<String, List<Map<String, dynamic>>> get _groupedShrines {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var shrine in shrines) {
      final category = shrine['category'] as String;
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(shrine);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupedShrines;
    final categories = grouped.keys.toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A237E),
            Color(0xFF0D47A1),
            Color(0xFF004D40),
          ],
        ),
      ),
      child: Column(
        children: [
          // هدر
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 12),
            child: Column(
              children: [
                const Icon(Icons.landscape, size: 50, color: Colors.white),
                const SizedBox(height: 6),
                const Text(
                  'بهشت گمشده',
                  style: TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'مشاهده پخش زنده اماکن متبرکه',
                  style: TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // لیست با دسته‌بندی
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final items = grouped[category]!;
                return _buildCategorySection(context, category, items);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String category,
    List<Map<String, dynamic>> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان دسته‌بندی با رنگ اختصاصی
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.folder_open,
                size: 16,
                color: Colors.white.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${items.length}',
                  style: TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        // کارت‌های آن دسته‌بندی
        ...items.map((shrine) => _buildShrineCard(context, shrine)),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildShrineCard(BuildContext context, Map<String, dynamic> shrine) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: shrine['gradient'],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _openShrineStream(context, shrine);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // آیکون با رنگ اختصاصی
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (shrine['color'] as Color).withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: shrine['color'] as Color,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    shrine['icon'],
                    size: 26,
                    color: shrine['color'] as Color,
                  ),
                ),
                const SizedBox(width: 12),
                // اطلاعات
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shrine['name'],
                        style: const TextStyle(
                          fontFamily: 'Vazirmatn',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        shrine['location'],
                        style: TextStyle(
                          fontFamily: 'Vazirmatn',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: (shrine['color'] as Color).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.live_tv,
                              size: 12,
                              color: shrine['color'] as Color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'پخش زنده',
                              style: TextStyle(
                                fontFamily: 'Vazirmatn',
                                fontSize: 10,
                                color: shrine['color'] as Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.6),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openShrineStream(BuildContext context, Map<String, dynamic> shrine) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _ShrineStreamPage(
          shrine: shrine,
          streamUrl: shrine['url'],
        ),
      ),
    );
  }
}

// ======================= صفحه پخش زنده =======================

class _ShrineStreamPage extends StatefulWidget {
  final Map<String, dynamic> shrine;
  final String streamUrl;

  const _ShrineStreamPage({
    required this.shrine,
    required this.streamUrl,
  });

  @override
  State<_ShrineStreamPage> createState() => _ShrineStreamPageState();
}

class _ShrineStreamPageState extends State<_ShrineStreamPage> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
          onHttpError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.streamUrl));

    // تایمر 20 ثانیه
    Future.delayed(const Duration(seconds: 20), () {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    });
  }

  void _retryLoad() {
    setState(() {
      _hasError = false;
      _isLoading = true;
    });
    _initWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.shrine['name'],
              style: const TextStyle(
                fontFamily: 'Vazirmatn',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              'پخش زنده',
              style: TextStyle(
                fontFamily: 'Vazirmatn',
                color: Colors.white.withOpacity(0.6),
                fontSize: 11,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: _hasError ? Colors.red : Colors.white,
            ),
            onPressed: _retryLoad,
            tooltip: 'تلاش مجدد',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                        strokeWidth: 3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'در حال بارگذاری پخش زنده...',
                      style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_hasError && !_isLoading)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 44,
                      color: Colors.red[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'خطا در بارگذاری پخش',
                      style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'ممکن است پخش موقتاً قطع شده باشد',
                      style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _retryLoad,
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text(
                            'تلاش مجدد',
                            style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, size: 18),
                          label: const Text(
                            'بازگشت',
                            style: TextStyle(fontFamily: 'Vazirmatn', fontSize: 13),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}