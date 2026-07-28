
import 'package:flutter/material.dart';
import 'handicraft_details_page.dart';

class TraditionalToolsPage extends StatefulWidget {
  const TraditionalToolsPage({super.key});

  static const List<Map<String, dynamic>> handicrafts = [
    {
      'title': 'چرخو پنبه',
      'description': '''چرخو پنبه یکی از ابزارهای سنتی قدیمی بود که برای جدا کردن دانه پنبه از الیاف آن به کار می‌رفت. پنبه را میان دو قطعه چوب قرار می‌دادند و با چرخاندن آن، دانه‌ها از الیاف جدا می‌شدند. این وسیله در گذشته برای آماده‌سازی پنبه پیش از نخ‌ریسی استفاده می‌شد.''',
      'extraInfo': '''کاربرد: جدا کردن دانه پنبه
جنس: چوب
ارتباط: آماده‌سازی پنبه برای نخ‌ریسی''',
      'image': 'assets/images/Handicrafts/charkho_panbeh.jpg',
      'icon': Icons.rotate_right,
    },
    {
      'title': 'قالب گلوله',
      'description': '''قالب گلوله ابزاری فلزی بود که در گذشته برای ساخت گلوله‌های سربی استفاده می‌شد. سرب ذوب‌شده را درون قالب می‌ریختند و پس از سرد شدن، گلوله شکل می‌گرفت.''',
      'extraInfo': '''کاربرد: ساخت گلوله سربی
جنس: فلز
ویژگی: ابزار سنتی قدیمی''',
      'image': 'assets/images/Handicrafts/ghaleb_golooleh.jpg',
      'icon': Icons.build,
    },
    {
      'title': 'هنجین',
      'description': '''هنجین وسیله‌ای سنتی برای حمل بار بر پشت حیوانات مانند الاغ و شتر بود. این وسیله معمولاً از پارچه ضخیم یا الیاف محلی ساخته می‌شد.''',
      'extraInfo': '''کاربرد: حمل بار
حوزه استفاده: دامداری و حمل‌ونقل سنتی''',
      'image': 'assets/images/Handicrafts/hanjin.jpg',
      'icon': Icons.work,
    },
    {
      'title': 'کلوخ‌کوب',
      'description': '''کلوخ‌کوب یکی از ابزارهای سنتی کشاورزی بود که برای خرد کردن کلوخ‌های زمین پس از شخم‌زدن استفاده می‌شد.''',
      'extraInfo': '''کاربرد: خرد کردن کلوخ‌های خاک
حوزه: کشاورزی سنتی''',
      'image': 'assets/images/Handicrafts/kolookhkoob.jpg',
      'icon': Icons.agriculture,
    },
    {
      'title': 'هاون سنگی',
      'description': '''هاون سنگی وسیله‌ای قدیمی برای کوبیدن مواد غذایی مانند ادویه، نمک و غلات بود و معمولاً از سنگ ساخته می‌شد.''',
      'extraInfo': '''کاربرد: کوبیدن مواد غذایی
جنس: سنگ''',
      'image': 'assets/images/Handicrafts/havan_sangi.jpg',
      'icon': Icons.food_bank,
    },
    {
      'title': 'آسیاب سنگی',
      'description': '''آسیاب سنگی از ابزارهای سنتی برای آسیاب کردن غلات و تهیه آرد بود و از دو سنگ روی هم تشکیل می‌شد.''',
      'extraInfo': '''کاربرد: آسیاب کردن گندم و غلات
جنس: سنگ''',
      'image': 'assets/images/Handicrafts/asiyaab_sangi.jpg',
      'icon': Icons.settings,
    },
    {
      'title': 'چری',
      'description': '''چری یکی از وسایل سنتی محلی بود که در زندگی روزمره مردم روستا کاربرد داشت.''',
      'extraInfo': '''نوع: وسیله سنتی محلی''',
      'image': 'assets/images/Handicrafts/chari.jpg',
      'icon': Icons.extension,
    },
    {
      'title': 'چرخو',
      'description': '''چرخو یکی از ابزارهای سنتی محلی بود که در برخی کارهای روزمره روستا استفاده می‌شد.''',
      'extraInfo': '''نوع: ابزار سنتی''',
      'image': 'assets/images/Handicrafts/charkho.jpg',
      'icon': Icons.settings_backup_restore,
    },
    {
      'title': 'آکسون',
      'description': '''آکسون یکی از ابزارهای سنتی مورد استفاده در گذشته بود و بخشی از فرهنگ مادی منطقه محسوب می‌شود.''',
      'extraInfo': '''نوع: ابزار سنتی محلی''',
      'image': 'assets/images/Handicrafts/aksoon.jpg',
      'icon': Icons.category,
    },
    {
      'title': 'قلوه سنگ‌چنی',
      'description': '''قلوه سنگ‌چنی ابزاری بود که کشاورزان برای دور کردن پرندگان از مزارع از آن استفاده می‌کردند. با چرخاندن آن و رها کردن بند، سنگ به جلو پرتاب می‌شد.''',
      'extraInfo': '''کاربرد: دور کردن پرندگان از کشتزار
نوع: ابزار کشاورزی سنتی''',
      'image': 'assets/images/Handicrafts/sangchini.jpg',
      'icon': Icons.sports_baseball,
    },
    {
      'title': 'دوک نخ‌ریسی',
      'description': '''دوک نخ‌ریسی وسیله‌ای قدیمی برای تبدیل پنبه یا پشم به نخ بود. با چرخاندن دوک، الیاف تاب می‌خوردند و نخ تولید می‌شد.''',
      'extraInfo': '''کاربرد: تولید نخ
جنس: معمولاً چوب
ارتباط: بافندگی سنتی''',
      'image': 'assets/images/Handicrafts/dook.jpg',
      'icon': Icons.sync,
    },
{
  'title': 'واز',
  'description': '''واز وسیله‌ای چوبی و دسته‌دار است که برای صاف کردن زمین و تسطیح سطح خاک در کشاورزی استفاده می‌شود. این ابزار شبیه به پارو یا فرش چوبی است و کشاورزان پس از شخم زدن زمین، با واز سطح خاک را صاف و هموار می‌کردند تا برای کاشت بذر آماده شود. واز از چوب محلی و با دست ساخته می‌شده و یکی از ابزارهای سنتی کشاورزی در روستای ایراج بوده است.''',
  'extraInfo': '''جنس: چوب
کاربرد: صاف کردن و تسطیح زمین کشاورزی
شکل: شبیه به پارو با دسته بلند
ویژگی: سبک و مقاوم''',
  'image': 'assets/images/Handicrafts/vaz.jpg',
  'icon': Icons.agriculture,
},
  ];


@override
  State<TraditionalToolsPage> createState() => _TraditionalToolsPageState();
}

class _TraditionalToolsPageState extends State<TraditionalToolsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = List.from(TraditionalToolsPage.handicrafts);
    _searchController.addListener(() {
      _search(_searchController.text);
    });
  }

  void _search(String value) {
    setState(() {
      filteredList = TraditionalToolsPage.handicrafts.where((item) {
        final title = item['title'].toString().toLowerCase();
        final desc = item['description'].toString().toLowerCase();
        return title.contains(value.toLowerCase()) ||
            desc.contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "ابزار سنتی روستا",
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'جستجو...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: filteredList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = filteredList[index];
                  return _buildHandicraftItem(item, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandicraftItem(Map<String, dynamic> item, BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HandicraftDetailsPage(item: item),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  item['image'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      item['icon'],
                      size: 40,
                      color: Colors.blue,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['title'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Vazirmatn',
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}