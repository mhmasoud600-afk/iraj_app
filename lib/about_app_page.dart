// lib/about_app_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'services/search_service.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  // ============================================================
  // متد ثبت صفحه در سرویس جستجو
  // ============================================================
  void _registerForSearch() {
    final service = SearchService();
    
    // حذف خطی که به _items دسترسی داشت
    // مستقیماً ثبت می‌کنیم (سرویس خودش از ثبت تکراری جلوگیری می‌کند)
    service.registerItem(
      SearchItem(
        title: 'درباره نرم‌افزار',
        subtitle: 'معرفی و اطلاعات نرم‌افزار روستای ایراج',
        searchText: '''
          درباره نرم‌افزار روستای ایراج:
          
          این نرم‌افزار برای معرفی روستای ایراج طراحی شده است.
          هدف آن حفظ فرهنگ، تاریخ و سنت‌های روستا و ارائه اطلاعات مفید به علاقه‌مندان است.
          امکانات نرم‌افزار شامل گالری تصاویر، معرفی شهدای روستا، فرهنگیان، 
          آداب و رسوم و بسیاری بخش‌های دیگر می‌باشد.
          
          توسعه‌دهندگان نرم‌افزار:
          مسعود خدایی، مهرنوش جمشیدی، دکتر مهدی مسعود، دکتر مهدی نجفی،
          اباذر نجفی، شهره اکبر، حاج رسول دانا، حاج صادق موبد،
          جواد نجفی، حاج نبی اله موبد، حامد اکبر، حمید اکبر،
          حمیدرضا زاهد، محمدحسن یزدانی، فاطمه اکبر، الهه اکبر،
          شهربانو دانا، طیبه نجفی، محمدحسین اشرف، مهندس احمد عشقی،
          هما یگانه، فرید اکبر، محمدرضا نجفی، محمد یازان،
          محمد زاهد، دکتر فرج اله زاهد، مهندس حسن اشرف، فاطمه جان عشقی،
          لیلی نجفی، بتول نجفی
          
          ارتباط با توسعه‌دهندگان:
          آیدی ایتا: @mh_masoud
          نسخه نرم‌افزار: ۱.۰.۰
        ''',
        page: const AboutAppPage(),
        icon: Icons.info,
        category: 'درباره',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ثبت صفحه در سرویس جستجو (فقط یک بار)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _registerForSearch();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("درباره نرم‌افزار"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ======== لوگو ========
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal.shade100,
              child: const Icon(Icons.apps, size: 60, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            
            // ======== عنوان ========
            const Text(
              "نرم‌افزار روستای ایراج",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            
            // ======== نسخه ========
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.teal.shade200),
              ),
              child: const Text(
                "نسخه ۱.۰.۰",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // ======== توضیحات ========
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "این نرم‌افزار برای معرفی روستای ایراج طراحی شده است.\n"
                  "هدف آن حفظ فرهنگ، تاریخ و سنت‌های روستا و ارائه اطلاعات مفید به علاقه‌مندان است.\n"
                  "امکانات نرم‌افزار شامل گالری تصاویر، معرفی شهدای روستا، فرهنگیان، آداب و رسوم و بسیاری بخش‌های دیگر می‌باشد.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // ======== توسعه‌دهندگان ========
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "توسعه‌دهندگان",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "این نرم‌افزار توسط علاقه‌مندان به فرهنگ و تاریخ روستا توسعه داده شده است.\n"
                      "هدف اصلی آن ایجاد بستری برای معرفی و حفظ میراث فرهنگی روستا می‌باشد.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "در توسعه این برنامه افراد زیادی کمک نمودند که به شرح ذیل می‌باشند:",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    _buildContributorList(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // ======== ارتباط با ما ========
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "راه ارتباطی",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "همشهریان عزیز می‌توانند پیشنهادات و انتقادات سازنده خود را از طریق آی دی زیر در برنامه ایتا ارسال نمایند",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    _buildEitaaButton(context),
                    const SizedBox(height: 12),
                    const Text(
                      "با احترام محمدحسن مسعود",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ویجت لیست توسعه‌دهندگان
  // ============================================================
  Widget _buildContributorList() {
    List<List<Map<String, String>>> rows = [
      [
        {"number": "۱", "name": "مسعود خدایی"},
        {"number": "۲", "name": "مهرنوش جمشیدی"}
      ],
      [
        {"number": "۳", "name": "دکتر مهدی مسعود"},
        {"number": "۴", "name": "دکتر مهدی نجفی"}
      ],
      [
        {"number": "۵", "name": "اباذر نجفی"},
        {"number": "۶", "name": "شهره اکبر"}
      ],
      [
        {"number": "۷", "name": "حاج رسول دانا"},
        {"number": "۸", "name": "حاج صادق موبد"}
      ],
      [
        {"number": "۹", "name": "جواد نجفی"},
        {"number": "۱۰", "name": "حاج نبی اله موبد"}
      ],
      [
        {"number": "۱۱", "name": "حامد اکبر"},
        {"number": "۱۲", "name": "حمید اکبر"}
      ],
      [
        {"number": "۱۳", "name": "حمیدرضا زاهد"},
        {"number": "۱۴", "name": "محمدحسن یزدانی"}
      ],
      [
        {"number": "۱۵", "name": "فاطمه اکبر( حسن)"},
        {"number": "۱۶", "name": "الهه اکبر ( نورمحمد)"}
      ],
      [
        {"number": "۱۷", "name": "شهربانو دانا"},
        {"number": "۱۸", "name": "طیبه نجفی"}
      ],
      [
        {"number": "۱۹", "name": "محمدحسین اشرف"},
        {"number": "۲۰", "name": "مهندس احمد عشقی"}
      ],
      [
        {"number": "۲۱", "name": "هما یگانه"},
        {"number": "۲۲", "name": "فرید اکبر"}
      ],
      [
        {"number": "۲۳", "name": "محمدرضا نجفی"},
        {"number": "۲۴", "name": " محمد یازان"}
      ],
      [
        {"number": "۲۵", "name": "محمد زاهد(غلامرضا)"},
        {"number": "۲۶", "name": " دکتر فرج اله زاهد"}
      ],
      [
        {"number": "۲۷", "name": "مهندس حسن اشرف"},
        {"number": "۲۸", "name": " فاطمه جان عشقی"}
      ],
      [
        {"number": "۲۹", "name": "لیلی نجفی(صفر)"},
        {"number": "۳۰", "name": " بتول نجفی( صفر)"}
      ],
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 400) {
          return Column(
            children: rows.map((row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: _buildPersonCard(
                        row[0]["number"]!,
                        row[0]["name"]!,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPersonCard(
                        row[1]["number"]!,
                        row[1]["name"]!,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return ExpansionTile(
            title: const Text(
              "مشاهده لیست توسعه‌دهندگان",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: rows.map((row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: _buildPersonCard(row[0]["number"]!, row[0]["name"]!),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildPersonCard(row[1]["number"]!, row[1]["name"]!),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildPersonCard(String number, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEitaaButton(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => _launchEitaa(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.teal.shade300, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        'ایتا',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '@mh_masoud',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.copy, size: 20, color: Colors.teal),
              onPressed: () {
                Clipboard.setData(const ClipboardData(text: '@mh_masoud'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('آیدی کپی شد'),
                    backgroundColor: Colors.teal,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEitaa(BuildContext context) async {
    const username = 'mh_masoud';
    final eitaaAppUrl = Uri.parse('eitaa://$username');
    
    try {
      if (await canLaunchUrl(eitaaAppUrl)) {
        await launchUrl(eitaaAppUrl, mode: LaunchMode.externalApplication);
        return;
      } else {
        final webUrl = Uri.parse('https://eitaa.com/$username');
        if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } else {
          _showErrorSnackBar(context, 'لینک معتبر نیست');
        }
      }
    } catch (e) {
      final webUrl = Uri.parse('https://eitaa.com/$username');
      if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, 'خطا در باز کردن لینک');
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}