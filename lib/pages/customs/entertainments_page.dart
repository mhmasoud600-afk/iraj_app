
import 'package:flutter/material.dart';

class EntertainmentsPage extends StatefulWidget {
  const EntertainmentsPage({super.key});

  @override
  State<EntertainmentsPage> createState() => _EntertainmentsPageState();
}

class _EntertainmentsPageState extends State<EntertainmentsPage> {
  // متن جستجو
  String _searchText = "";
  
  // نوع دسته‌بندی انتخاب شده
  String _selectedCategory = "همه";

  // لیست دسته‌بندی‌ها
  final List<String> _categories = [
    "همه",
    "تله سقوطی خودکار",
    "تله سقوطی با کنترل از راه دور",
    "تله سقوطی با طعمه",
    "تله گیردار",
    "وسیله پرتابی",
    "بازی مهارتی",
    "بازی‌های شیطنت‌آمیز",
    "بازی‌های دوران کار",
    "بازی‌های دست‌ساز",
    "بازی‌های رقابتی",       
    "بازی‌های ماجراجویانه", 
    "بازی‌های کودکانه با حشرات", 
    "بازی‌های شبانه", 
    "طبیعت‌گردی بهاری",  
];      
  

  // تابع نرمال‌سازی متن برای جستجو
  String _normalizeText(String text) {
    return text
        .replaceAll('ي', 'ی')
        .replaceAll('ك', 'ک')
        .replaceAll('\u200c', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
  }

  // فیلتر بر اساس جستجو و دسته‌بندی
  List<Map<String, dynamic>> _filterEntertainments() {
    // ابتدا بر اساس دسته‌بندی فیلتر کن
    List<Map<String, dynamic>> categoryFiltered = _selectedCategory == "همه"
        ? entertainments
        : entertainments.where((item) {
            return item['type'] == _selectedCategory;
          }).toList();

    // سپس بر اساس جستجو فیلتر کن
    if (_searchText.isEmpty) return categoryFiltered;

    final normalizedQuery = _normalizeText(_searchText);

    return categoryFiltered.where((item) {
      return _normalizeText(item['name']).contains(normalizedQuery) ||
          _normalizeText(item['description']).contains(normalizedQuery) ||
          _normalizeText(item['method']).contains(normalizedQuery) ||
          _normalizeText(item['details']).contains(normalizedQuery) ||
          _normalizeText(item['history']).contains(normalizedQuery) ||
          (item['type'] as String).contains(normalizedQuery) ||
          (item['mechanism'] as String).contains(normalizedQuery);
    }).toList();
  }

  // رنگ پس‌زمینه بر اساس نوع تله
  Color _getCategoryColor(String type) {
    switch (type) {
      case "تله سقوطی خودکار":
        return Colors.amber.shade50;
      case "تله سقوطی با کنترل از راه دور":
        return Colors.green.shade50;
      case "تله سقوطی با طعمه":
        return Colors.grey.shade100;
      case "تله گیردار":
        return Colors.purple.shade50;
      case "وسیله پرتابی":
        return Colors.orange.shade50;
      case "بازی مهارتی":
        return Colors.blue.shade50;
      case "بازی‌های شیطنت‌آمیز":   
        return Colors.amber.shade50;
      case "بازی‌های دوران کار":     
        return Colors.brown.shade100;
      case "بازی‌های دست‌ساز":      
  return Colors.green.shade50;
     case "بازی‌های رقابتی":
  return Colors.orange.shade50;
     case "بازی‌های ماجراجویانه":
  return Colors.red.shade50;
case "بازی‌های کودکانه با حشرات":
  return Colors.red.shade50;
case "بازی‌های شبانه": 
      return Colors.indigo.shade50;
case "طبیعت‌گردی بهاری": 
      return Colors.lightGreen.shade50;
    default:
      return Colors.grey.shade50;



    }
  }

  // تابع کمکی برای تیره‌تر کردن رنگ
  Color _darken(Color color, double amount) {
    return Color.fromARGB(
      color.alpha,
      (color.red * amount).round().clamp(0, 255),
      (color.green * amount).round().clamp(0, 255),
      (color.blue * amount).round().clamp(0, 255),
    );
  }

  // تابع کمکی برای روشن‌تر کردن رنگ
  Color _lighten(Color color, double amount) {
    return Color.fromARGB(
      color.alpha,
      (color.red + (255 - color.red) * amount).round().clamp(0, 255),
      (color.green + (255 - color.green) * amount).round().clamp(0, 255),
      (color.blue + (255 - color.blue) * amount).round().clamp(0, 255),
    );
  }

  // نشانگر نوع تله - اصلاح شده برای جلوگیری از Overflow
  Widget _buildTypeChip(String type, String mechanism) {
    Color chipColor;
    switch (type) {
      case "تله سقوطی خودکار":
        chipColor = Colors.amber;
        break;
      case "تله سقوطی با کنترل از راه دور":
        chipColor = Colors.green;
        break;
      case "تله سقوطی با طعمه":
        chipColor = Colors.grey;
        break;
      case "تله گیردار":
        chipColor = Colors.purple;
        break;
      case "وسیله پرتابی":
        chipColor = Colors.orange;
        break;
      case "بازی مهارتی":
        chipColor = Colors.blue;
case "بازی‌های شیطنت‌آمیز":   
      chipColor = Colors.amber;
      break;
    case "بازی‌های دوران کار":     
      chipColor = Colors.brown;
        break;

case "بازی‌های رقابتی":
  chipColor = Colors.orange;
  break;
case "بازی‌های ماجراجویانه":
  chipColor = Colors.red;
  break;
case "بازی‌های کودکانه با حشرات":
  chipColor = Colors.red;
  break;
case "بازی‌های شبانه":  
      chipColor = Colors.indigo;
      break;
case "طبیعت‌گردی بهاری":  
      chipColor = Colors.lightGreen;
      break;
      default:
        chipColor = Colors.grey;
    }


return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline,
            size: 14,
            color: _darken(chipColor, 0.7),
          ),
          const SizedBox(width: 4),
          // نوع تله با محدودیت عرض
          Flexible(
            child: Text(
              type,
              style: TextStyle(
                fontSize: 12,
                color: _darken(chipColor, 0.7),
                fontFamily: 'Vazir',
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 1,
            height: 12,
            color: _lighten(chipColor, 0.3),
          ),
          const SizedBox(width: 4),
          // مکانیسم با محدودیت عرض
          Flexible(
            child: Text(
              mechanism,
              style: TextStyle(
                fontSize: 11,
                color: _darken(chipColor, 0.6),
                fontFamily: 'Vazir',
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filterEntertainments();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سرگرمی‌های سنتی روستا',
          style: TextStyle(
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          // نوار جستجو
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'جستجو در سرگرمی‌ها...',
                hintStyle: const TextStyle(fontFamily: 'Vazir'),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          // فیلتر دسته‌بندی
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 13,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,


),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: Colors.brown.shade600,
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected ? Colors.transparent : Colors.grey.shade300,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // نمایش تعداد نتایج
          if (_searchText.isNotEmpty || _selectedCategory != "همه")
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${filteredItems.length} نتیجه ${_searchText.isNotEmpty ? 'برای "$_searchText" ' : ''}در دسته "$_selectedCategory"',
                  style: const TextStyle(
                    fontFamily: 'Vazir',
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),

          // لیست سرگرمی‌ها با ExpansionTile
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final Color headerColor = item['color'] as Color;
                final IconData icon = item['icon'] as IconData;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ExpansionTile(
                        key: Key(item['name'] as String),
                        trailing: Icon(
                          icon,
                          color: headerColor,
                          size: 28,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'] as String,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: _darken(headerColor, 0.7),
                                fontFamily: 'Vazir',
                              ),
                              overflow: TextOverflow.ellipsis,


maxLines: 2,
                            ),
                            const SizedBox(height: 6),
                            _buildTypeChip(
                              item['type'] as String, 
                              item['mechanism'] as String
                            ),
                          ],
                        ),
                        children: [
                          _buildEntertainmentContent(item, context),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // محتوای داخلی ExpansionTile
  Widget _buildEntertainmentContent(Map<String, dynamic> item, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getCategoryColor(item['type'] as String),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- تایم‌لاین تصاویر (اسلایدر افقی) ---
          if (item['images'] != null && (item['images'] as List).isNotEmpty)
            _buildImageSlider(item),

          // دسته‌بندی و مکانیسم (نمایش دوباره در محتوا) - اصلاح شده
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.category,
                  size: 16,
                  color: item['color'] as Color,
                ),
                const SizedBox(width: 4),
                // استفاده از Expanded برای جلوگیری از Overflow
                Expanded(
                  child: Text(
                    '${item['type']} | ${item['mechanism']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _darken(item['color'] as Color, 0.7),
                      fontFamily: 'Vazir',
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),

          // توضیحات
          _buildInfoSection(
            '📝 توضیحات',
            item['description'] as String,
            item['color'] as Color,
          ),
          const SizedBox(height: 12),

          // روش ساخت/اجرا
          _buildInfoSection(
            '🛠️ روش ساخت و اجرا',
            item['method'] as String,
            item['color'] as Color,
          ),
          const SizedBox(height: 12),

          // جزئیات
          if ((item['details'] as String).isNotEmpty)
            _buildInfoSection(
              '📋 جزئیات بیشتر',
              item['details'] as String,
              item['color'] as Color,
            ),
          const SizedBox(height: 12),

          // تاریخچه
          if ((item['history'] as String).isNotEmpty)
            _buildInfoSection(
              '📜 تاریخچه',
              item['history'] as String,
              item['color'] as Color,
            ),
          
          // پیشینه فرهنگی (برای تله‌ها)
          if (item.containsKey('cultural_note') && (item['cultural_note'] as String).isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 12),
                _buildInfoSection(
                  '🌍 پیشینه جهانی',


item['cultural_note'] as String,
                  item['color'] as Color,
                ),
              ],
            ),
          
          // فواید (برای تیله‌بازی)
          if (item.containsKey('benefits') && (item['benefits'] as String).isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 12),
                _buildInfoSection(
                  '✨ فواید و مهارت‌ها',
                  item['benefits'] as String,
                  item['color'] as Color,
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ویجت اسلایدر تصاویر با فلش‌های کناری
  Widget _buildImageSlider(Map<String, dynamic> item) {
    // کنترلر برای PageView
    final PageController _pageController = PageController();
    
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 200,
          margin: const EdgeInsets.only(bottom: 16),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              // PageView برای نمایش تصاویر
              PageView.builder(
                controller: _pageController,
                itemCount: (item['images'] as List).length,
                onPageChanged: (index) {
                  setState(() {}); // برای به‌روزرسانی نشانگرها
                },
                itemBuilder: (ctx, imgIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        (item['images'] as List)[imgIndex],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Icon(
                                item['icon'] as IconData,
                                size: 60,
                                color: item['color'] as Color,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              
              // فلش سمت راست (بعدی)
              Positioned(
                left: 5,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        final currentPage = _pageController.page?.toInt() ?? 0;
                        if (currentPage < (item['images'] as List).length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),


// فلش سمت چپ (قبلی)
              Positioned(
                right: 5,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        final currentPage = _pageController.page?.toInt() ?? 0;
                        if (currentPage > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              
              // نشانگر صفحه (دایره‌های پایین)
              Positioned(
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      (item['images'] as List).length,
                      (dotIndex) {
                        int currentIndex = _pageController.hasClients 
                            ? _pageController.page?.round() ?? 0 
                            : 0;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: dotIndex == currentIndex ? 10 : 6,
                          height: dotIndex == currentIndex ? 10 : 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dotIndex == currentIndex
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ویجت سازنده بخش‌های اطلاعاتی
  Widget _buildInfoSection(String title, String content, Color titleColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: _darken(titleColor, 0.7),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Vazir',
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 3,
            color: titleColor.withOpacity(0.3),
          ),
          const SizedBox(height: 12),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              content,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 15,
                fontFamily: 'Vazir',
                height: 1.7,
              ),
              softWrap: true, // شکستن خطوط خودکار
            ),
          ),
        ],
      ),
    );
  }
}


// -------------------- دیتای کامل سرگرمی‌ها --------------------
final List<Map<String, dynamic>> entertainments = [
  // 1. تله سنگی
  {
    'name': 'تله سنگی (شکار پرندگان)',
    'type': 'تله سقوطی با کنترل از راه دور',
    'mechanism': 'فعال‌شونده با کشیدن نخ توسط شکارچی',
    'description': 'یکی از روش‌های سنتی و هوشمندانه برای شکار پرندگانی مانند تیهو و کبک در حوالی چشمه‌ها. این روش که امروزه کمتر استفاده می‌شود، نشان‌دهنده درک عمیق نیاکان ما از محیط‌زیست و رفتار پرندگان است.',
    'method': 'برای ساخت تله، گودالی به ابعاد تقریبی ۱۰ تا ۲۰ سانتی‌متر در زمین حفر می‌کردند. دیواره‌ها را صاف و قائم درست می‌کردند. سپس چهار سنگ در چهار طرف گودال قرار داده و سنگ پنجمی به عنوان سقف روی آنها می‌گذاشتند. سنگ سقف با کمک سه تکه چوب کوچک (سیخ) روی دهانه مهار می‌شد.',
    'details': 'در کف گودال دانه می‌ریختند. پرنده برای خوردن دانه وارد گودال می‌شد و با برخورد به سیخ‌ها، تعادل سنگ سقف را به هم می‌زد. سنگ سقف بلافاصله فرو می‌افتاد و پرنده درون گودال زنده محبوس می‌شد. شکارچی بعداً برمی‌گشت و پرنده را از تله بیرون می‌آورد.\n\nاگر پرندگان پس از مدتی متوجه تله می‌شدند و به دام نمی‌افتادند، شکارچیان چند گودال بدون تله ایجاد کرده و در آنها دانه می‌ریختند تا پرندگان خیالشان راحت شود. سپس یکی از همان گودال‌ها را به تله سنگی تبدیل می‌کردند.',
    'history': 'این روش شکار عمدتاً در مناطق کویری و کوهستانی ایران، به ویژه در اطراف روستاها و چشمه‌هایی که پرندگانی مانند کبک و تیهو برای آب خوردن به آنجا می‌آمدند، رواج داشت.',
    'color': Colors.brown,
    'icon': Icons.catching_pokemon,
    'images': [
      'assets/images/entertainments/stone_trap_1.jpg',
      'assets/images/entertainments/stone_trap_2.jpg',
      'assets/images/entertainments/stone_trap_3.jpg',
    ],
  },
  
  // 2. تیرکمان سنگی
  {
    'name': 'تیرو‌کمان سنگی (تیرکمان)',
    'type': 'وسیله پرتابی',
    'mechanism': 'پرتاب دستی با نیروی کشسانی',
    'description': 'یک وسیله ساده اما بسیار دقیق برای پرتاب سنگ‌های کوچک. این وسیله دست‌ساز، تفریحی مهیج برای نوجوانان و وسیله‌ای برای تمرین دقت و هدف‌گیری بود.',
    'method': 'تیرکمان سنگی معمولاً از یک شاخه چوبی محکم به شکل حرف Y (Y شکل) ساخته می‌شد. دو نوار لاستیک (که اغلب از تیوپ دوچرخه یا وسایل لاستیکی کهنه بریده می‌شد) به دو سر شاخه محکم بسته می‌شد. سر دیگر این دو نوار لاستیک به یک تکه چرم کوچک و محکم (تیمه) متصل می‌شد. سنگ کوچک درون این تکه چرم قرار می‌گرفت.',
    'details': 'برای استفاده، سنگ را در چرم گذاشته، لاستیک‌ها را می‌کشیدند و نشانه می‌رفتند. با رها کردن چرم، نیروی ذخیره شده در لاستیک‌ها با شتاب زیادی به سنگ منتقل می‌شد و آن را به سمت هدف پرتاب می‌کرد. این وسیله نیازمند مهارت بالا در نشانه‌گیری و تخمین مسیر بود.',
    'history': 'تیرکمان در میان کودکان و نوجوانان روستاها و شهرها از محبوبیت بالایی برخوردار بود. وسیله‌ای برای بازی، رقابت در هدف‌گیری و گاهی برای شکار پرندگان کوچک یا ترساندن حیوانات موذی از مزارع.',
    'color': Colors.orange.shade800,
    'icon': Icons.track_changes,
    'images': [
      'assets/images/entertainments/slingshot_1.jpg',
      'assets/images/entertainments/slingshot_2.jpg',
    ],
  },
  
  // 3. تیله‌بازی در ایراج
  {
    'name': 'تیله‌بازی در ایراج',
    'type': 'بازی مهارتی',
    'mechanism': 'پرتاب انگشتی با دقت و تمرکز',
    'description': 'تیله‌بازی یکی از سرگرمی‌های قدیمی و پرطرفدار در روستای ایراج بوده است. این بازی با گوی‌های شیشه‌ای کوچک و رنگارنگ (تیله) انجام می‌شود و مهارت، تمرکز و دقت بازیکنان را به چالش می‌کشد.',
    'method': 'بازیکنان معمولاً دو یا چند نفر بودند. ابتدا با روش شیر یا خط یا سنگ-کاغذ-قیچی فرد آغازگر مشخص می‌شد. برای ضربه زدن به تیله، انگشت اشاره یا میانی را پشت تیله قرار داده و با رها کردن ناگهانی، به تیله ضربه می‌زدند تا به سمت هدف حرکت کند. روش دیگر «شان زدن» بود که انگشت کوچک روی زمین قرار می‌گرفت و با انگشت میانی تیله با شدت پرتاب می‌شد.',
    'details': '🎯 انواع روش‌های تیله‌بازی در ایراج:\n\n**۱. روش بیخ دیواری:**\nبازیکنان در فاصله حداقل ۲ متری دیوار می‌ایستادند و تیله‌های خود را به سمت دیوار پرتاب می‌کردند. هرکس تیله‌اش نزدیک‌تر به دیوار بود برنده می‌شد:\n• تیله چسبیده به دیوار: ۳ امتیاز\n• تیله با فاصله یک وجب یا کمتر: ۲ امتیاز\n• تیله نزدیک‌تر از بقیه: ۱ امتیاز\n\n**۲. روش گودال (مات یا خان):**\nچند گودال کوچک به قطر ۱۰ سانتی‌متر و عمق ۵ سانتی‌متر با فواصل معین حفر می‌کردند.'


'بازیکنان باید تیله‌های خود را به داخل گودال‌ها می‌انداختند. هرکس گودال‌های بیشتری را تصاحب می‌کرد برنده بود.\n\n**۳. روش صحرایی:**\nیک تیله به عنوان هدف روی زمین قرار می‌گرفت و بازیکنان تلاش می‌کردند با تیله خود به آن ضربه بزنند. برخورد موفق به معنای برنده شدن تیله حریف بود.\n\n**۴. روش دایره‌ای:**\nدایره‌ای به قطر حدود ۹۰ سانتی‌متر روی زمین کشیده می‌شد و ۵ تا ۱۰ تیله در مرکز آن قرار می‌گرفت. بازیکنان از بیرون دایره تلاش می‌کردند با تیله خود، تیله‌های داخل را از دایره خارج کنند. هر تیله‌ای که خارج می‌شد، از آن پرتاب‌کننده بود.',
    'history': 'تیله‌بازی قدمتی چند هزار ساله دارد و به دوران انسان‌های غارنشین بازمی‌گردد که با سنگریزه‌ها و گلوله‌های گلی بازی می‌کردند. در ایران، قدیمی‌ترین منبع مکتوب درباره این بازی به دوره صفویه و سفرنامه ژان شاردن بازمی‌گردد. در گذشته از سنگ‌های تراشیده شده یا گردو برای بازی استفاده می‌شد و بعدها تیله‌های شیشه‌ای رنگی جایگزین شدند. در روستای ایراج نیز این بازی نسل‌به‌نسل منتقل شده و بخشی از سرگرمی‌های کودکان و نوجوانان در فصل تابستان بوده است.',
    'benefits': '• تقویت هماهنگی چشم و دست\n• افزایش تمرکز و دقت\n• تقویت مهارت‌های انگشتی و حرکتی ظریف\n• فعال‌سازی هر دو نیمکره مغز\n• آموزش صبوری، پذیرش شکست و پیروزی\n• تقویت روحیه رقابت سالم و تعامل اجتماعی\n• هزینه بسیار کم و قابل اجرا در فضاهای کوچک',
    'color': Colors.blue.shade700,
    'icon': Icons.circle,
    'images': [
      'assets/images/entertainments/marble_1.jpg',
      'assets/images/entertainments/marble_2.jpg',
      'assets/images/entertainments/marble_3.jpg',
    ],
  },

  // 4. تله دبوک
  {
    'name': 'تله دبوک (شکار کبک با قوطی روغن)',
    'type': 'تله سقوطی خودکار',
    'mechanism': 'فعال‌شونده با وزن پرنده',
    'description': 'تله‌ای هوشمندانه با استفاده از قوطی‌های ۵ یا ۱۸ کیلویی روغن نباتی که در دل زمین کار گذاشته می‌شد. درب بالای قوطی کاملاً برش داده می‌شد و دو در حلبی روی آن سوار می‌گردید که حالت فنری داشتند.',
    'method': 'ابتدا قوطی روغن نباتی را برمی‌داشتند و درب بالایی آن را کامل برش می‌دادند. سپس دو در حلبی به اندازه‌ای که کاملاً روی دهانه قوطی را بپوشاند می‌بریدند و با مکانیسم فنری به قوطی متصل می‌کردند. قوطی را درون زمین کار می‌گذاشتند طوری که فقط درب‌ها همسطح زمین دیده شوند. روی درب‌ها را با کاه می‌پوشاندند و چند دانه روی آن می‌ریختند.',
    'details': '🪤 مکانیسم عملکرد:\n\nکبک با دیدن دانه‌ها روی درب دو‌لته می‌نشست. وزن پرنده باعث می‌شد دو در حلبی به سمت پایین باز شوند و پرنده به داخل سقوط کند. بلافاصله پس از سقوط، مکانیسم فنری درب‌ها را به حالت اولیه برمی‌گرداند و پرنده درون قوطی زندانی می‌شد.\n\n🔧 مراحل ساخت:\n۱. برش کامل درب بالای قوطی\n۲. ساخت دو در حلبی\n۳. نصب مکانیسم فنری\n۴. تنظیم فنرها\n۵. دفن قوطی در زمین\n۶. پوشاندن درب‌ها با کاه\n\n🐦 پرندگان هدف:\nکبک، تیهو، بلدرچین',
    'history': 'این تله در مناطق روستایی و کوهستانی ایران رواج داشت. نام "دبوک" احتمالاً برگرفته از صدای "دَب" هنگام بسته شدن سریع درب‌ها است.',
    'cultural_note': 'نمونه‌های مشابه: "تله جعبه‌ای" در اروپا، تله‌های کدویی در آفریقا، تله‌های بامبو در آسیای جنوب شرقی.',
    'color': Colors.amber.shade800,
    'icon': Icons.water_drop_outlined,
    'images': [
      'assets/images/entertainments/dabok_trap_1.jpg',
      'assets/images/entertainments/dabok_trap_2.jpg',
      'assets/images/entertainments/dabok_trap_3.jpg',
    ],
  },

  // 5. تله غربالی
  {
    'name': 'تله غربالی (شکار با نخ بلند)',
    'type': 'تله سقوطی با کنترل از راه دور',
    'mechanism': 'فعال‌شونده با کشیدن نخ توسط شکارچی',
    'description': 'تله‌ای هوشمندانه با استفاده از یک غربال و نخ بلند که شکارچی از فاصله دور آن را کنترل می‌کرد.',
    'method': 'یک غربال را وارونه روی زمین قرار می‌دادند. یک لبه آن را با چوب کوتاهی بالا می‌گرفتند. یک نخ بلند به این چوب می‌بستند و سر دیگر نخ در دستان شکارچی بود. زیر غربال دانه می‌ریختند.',
    'details': '🪤 مکانیسم عملکرد:\n\nپرنده جذب دانه‌ها می‌شد و وارد فضای زیر غربال می‌گردید. شکارچی در لحظه مناسب نخ را می‌کشید، چوب تکیه‌گاه می‌افتاد و غربال سقوط می‌کرد.\n\n🎯 مزایا:\n• انتخاب بهترین لحظه برای شکار\n• دقت بیشتر',


'history': 'این روش در سراسر ایران رواج داشته. نمونه سنگی آن یکی از کهن‌ترین روش‌هاست.',
    'cultural_note': 'در مصر باستان، اروپای قرون وسطی، و میان بومیان استرالیا نیز مشابه این تله دیده شده.',
    'color': Colors.green.shade700,
    'icon': Icons.filter_frames,
    'images': [
      'assets/images/entertainments/gharbal_trap_1.jpg',
      'assets/images/entertainments/gharbal_trap_2.jpg',
    ],
  },

  // 6. تله پارچه‌ای با گره هوک
  {
    'name': 'تله پارچه‌ای با گره هوک',
    'type': 'تله گیردار',
    'mechanism': 'فعال‌شونده با حرکت حیوان و باز شدن گره هوک',
    'description': 'تله‌ای مبتکرانه با استفاده از پارچه، چوب و گره مخصوص "هوک" برای شکار پرندگان و حیوانات کوچک.',
    'method': 'یک حلقه از چوب نرم می‌ساختند و دو طرف آن را با پارچه می‌پوشاندند. گره مخصوص "هوک" روی نخ زده می‌شد.',
    'details': '🪢 گره هوک چیست؟\n\nهوک یک گره موقت و حساس است که با کوچکترین فشار باز می‌شود.\n\n📿 تفاوت هوک با گره معمولی:\n• گره معمولی: با کشیدن محکم‌تر می‌شود\n• گره هوک: با فشار باز می‌شود\n\n🐱 هدف شکار:\nپرندگان کوچک، گربه صحرایی، روباه کوچک',
    'history': 'این تله در حاشیه مزارع و باغ‌ها برای کنترل حیوانات موذی استفاده می‌شد.',
    'cultural_note': 'گره‌های حساس مشابه در ژاپن، فرهنگ اسکیمو و قبایل هندی دیده می‌شود.',
    'color': Colors.purple.shade600,
    'icon': Icons.circle_outlined,
    'images': [
      'assets/images/entertainments/hook_trap_1.jpg',
      'assets/images/entertainments/hook_trap_2.jpg',
    ],
  },

  // 7. تله گرگین
  {
    'name': 'تله گرگین (شکار گرگ با تونل سنگی)',
    'type': 'تله سقوطی با طعمه',
    'mechanism': 'فعال‌شونده با کشیدن گوشت توسط گرگ',
    'description': 'تله‌ای بزرگ و هوشمندانه برای شکار گرگ که با سنگ‌های بزرگ به شکل تونل ساخته می‌شد.',
    'method': 'با سنگ‌های بزرگ، تونلی به درازای ۱/۵ متر می‌ساختند. انتهای تونل مسدود بود و گوشت در آنجا قرار می‌گرفت. سنگ بزرگی جلوی دهانه تونل کار گذاشته می‌شد که با نخ به گوشت متصل بود.',
    'details': '🪤 مکانیسم عملکرد:\n\nگرگ با بوی گوشت جذب می‌شد و وارد تونل می‌گردید. وقتی گوشت را می‌کشید، نخ سنگ جلوی تونل را می‌کشید و سنگ سقوط می‌کرد و دهانه را مسدود می‌نمود.\n\n🔧 مراحل ساخت:\n۱. ساخت تونل سنگی به طول ۱/۵ متر\n۲. مسدود کردن انتهای تونل\n۳. آماده‌سازی سنگ درب\n۴. اتصال گوشت به سنگ با نخ\n\n🐺 هدف شکار:\nگرگ، شغال، پلنگ',
    'history': 'این تله در مناطق کوهستانی ایران برای محافظت از گله‌ها در برابر گرگ استفاده می‌شد.',
    'cultural_note': 'نمونه‌های مشابه در آلپ اروپا، مغولستان، و میان بومیان آمریکا دیده شده.',
    'color': Colors.grey.shade800,
    'icon': Icons.terrain,
    'images': [
      'assets/images/entertainments/gorgin_trap_1.jpg',
      
    ],
  },

// 8. چوب داخل لانه زنبور کردن (قال زنبور)
{
  'name': 'چوب داخل لانه زنبور کردن (قال زنبور)',
  'type': 'بازی‌های شیطنت‌آمیز',
  'mechanism': 'ایجاد مزاحمت و فرار',
  'description': 'یکی از خاطره‌انگیزترین و در عین حال شیطنت‌آمیزترین تفریحات بچه‌های نسل قدیم در روستای ایراج! دیوارهای کاهگلی خانه‌ها و باغ‌ها محل مناسبی برای لانه‌زنبورها بود که در زبان محلی به آن "قال" می‌گفتند. بچه‌ها با چوب به جان زنبورها می‌افتادند تا ببینند چه کسی بیشتر می‌خندد!',
  'method': 'بچه‌ها یک چوب بلند برمی‌داشتند و به آرامی به سمت "قال زنبور" که روی دیوارهای کاهگلی قرار داشت می‌رفتند. سپس چوب را با احتیاط داخل سوراخ قال می‌کردند و سریع فرار می‌کردند. زنبورهای عصبانی برای دفاع از قال بیرون می‌ریختند و هر کس از آن نزدیکی رد می‌شد را نیش می‌زدند! به این کار می‌گفتند "چوب در قال زنبور کردن".',
  'details': '🐝 **قال زنبور چیست؟**\n\nدر زبان محلی ایراج، به لانه زنبور "قال" می‌گفتند. قال زنبورها معمولاً در سوراخ‌های دیوارهای کاهگلی، لابه‌لای سنگ‌ها، یا روی شاخه درختان ساخته می‌شد.\n\n🪵 **چوب در قال زنبور کردن:**\n\nاین عبارت محلی به معنی فرو کردن چوب در لانه زنبور و عصبانی کردن آنها بود. بچه‌ها وقتی این کار را می‌کردند، می‌گفتند: "بریم سراغ قال زنبور!"\n\n😄 **ماجرا از این قرار بود:**\n\nدیوارهای کاهگلی خانه‌ها و باغ‌های ایراج پر بود از قال زنبور. بچه‌های بازیگوش با چوب به سراغ این قال‌ها می‌رفتند و با فرو کردن چوب، زنبورها را عصبانی می‌کردند. زنبورها مثل برق و باد بیرون می‌ریختند و هر انسانی را در شعاع چند متری نیش می‌زدند!\n\n😄 **لحظه‌های خنده‌دار:**\n• اگر یک خردسال یا بزرگسال بی‌خبر از آنجا رد می‌شد، زنبورها او را بی‌نصیب نمی‌گذاشتند\n• فرد بیچاره با صورت و دست‌های ورم‌کرده، فحش‌های آب‌دار نثار بچه‌ها می‌کرد\n• بچه‌ها از دور می‌خندیدند و فرار می‌کردند\n\n🕌 **باور جالب:**\nبعضی از بچه‌ها وقتی چوب را داخل قال می‌کردند، این جمله را می‌گفتند: "من سیدم"! باورشان این بود که زنبورها سید را نیش نمی‌زنند! (البته که این باور هیچ پایه و اساسی نداشت و خیلی‌ها با وجود گفتن این جمله، فرار را بر قرار ترجیح می‌دادند!)\n\n🤣 **نتیجه:**\n• عده‌ای نیش می‌خوردند\n• عده‌ای می‌خندیدند\n• زنبورها بیچاره قال‌شان خراب می‌شد\n• و فردا دوباره همان قصه تکراری اما دوست‌داشتنی!\n\n🗣️ **ضرب‌المثل محلی:**\n\nقدیمی‌ها وقتی کسی کار خطرناکی می‌کرد، می‌گفتند: "مثل اینکه چوب زدی تو قال زنبور!" یعنی داری خودت را به دردسر می‌اندازی.\n\n📝 **خاطره‌بازی:**\n\nیکی از ریش‌سفیدان ایراج تعریف می‌کند: "یادش بخیر، بچگی‌ها قال زنبور پیدا می‌کردیم، چوب می‌زدیم تو قال، بعد فرار می‌کردیم. یک بار پسرخاله‌ام  گفت بریم سراغ قال زنبور. ما هم رفتیم. زنبورها ریختند دنبالش، دوید تا خانه، در را بست، زنبورها ماندند بیرون. تا شب مادرش دعایش می‌کرد!"',
  'history': 'این تفریح شیطنت‌آمیز در تمام روستاهای ایران که دیوارهای کاهگلی داشتند رواج داشت. در ایراج به لانه زنبور "قال" می‌گفتند و این اصطلاح هنوز هم در خاطره‌ها زنده است. با نابودی خانه‌های کاهگلی و کاهش جمعیت زنبورها، این تفریح هم کمکم به خاطرات پیوست. اما هنوز هم هر کس از نسل قدیم این خاطره را تعریف کند، لبخند روی لب‌ها می‌نشیند!',
  'cultural_note': 'در بسیاری از فرهنگ‌ها، شیطنت‌های کودکانه با زنبورها وجود داشته. مثلاً در روستاهای ترکیه، بچه‌ها با تیرکمان به لانه زنبورها شلیک می‌کردند! در یونان باستان هم بچه‌ها سنگ به لانه زنبور می‌انداختند. به نظر می‌رسد عصبانی کردن زنبورها یک سرگرمی جهانی بوده!',
  'color': Colors.amber.shade600,
  'icon': Icons.pest_control,
  'images': [
    'assets/images/entertainments/bee_hive_1.jpg',
    
  ],
},
// 9. الاغ‌سواری و واله‌بری (ترکیب کار و تفریح)
{
  'name': 'الاغ‌سواری و واله‌بری (کار و تفریح)',
  'type': 'بازی‌های دوران کار',
  'mechanism': 'سوارکاری سنتی با خر',
  'description': 'در روزگاری نه‌چندان دور که خبری از چاه فاضلاب و ماشین نبود، الاغ (خر) بهترین دوست و همکار بچه‌های ایراج بود. ترکیب کار و تفریح با این حیوان صبور، خاطرات نابی ساخته که هنوز هم در خاطر بزرگترها زنده است.',
  'method': 'در پایان هر هفته، بچه‌ها باید فضولات انسانی و حیوانی را که با خاک قاطی شده بود جمع می‌کردند و با الاغ به بیرون روستا می‌بردند. برای این کار از "واله" استفاده می‌کردند؛ وسیله‌ای که از پیچ خرما بافته می‌شد و روی پشت الاغ قرار می‌گرفت. بعد از اتمام کار، یا حتی در حین رفت و برگشت، نوبت به قسمت شیرین ماجرا می‌رسید: الاغ‌سواری!',
  'details': '🏡 واله چیست؟\n\nواله وسیله‌ای سنتی بود که از پیچ خرما (شاخه‌های نازک خرما) بافته می‌شد و روی پشت الاغ قرار می‌گرفت تا بتوان خاک و فضولات را حمل کرد. این وسیله دست‌بافت، سبک و در عین حال محکم بود و عمر طولانی داشت.\n\n🧹 کار پایان هفته:\nدر قدیم هیچ‌کدام از خانه‌های بافت قدیم روستا چاه فاضلاب نداشتند. به همین خاطر، پایان هر هفته بچه‌ها باید:\n۱. فضولات حیوانی را با خاک مخلوط می‌کردند\n۲. این مخلوط را با دست (بیل یا کلنگ) جمع می‌کردند\n۳. داخل واله می‌ریختند\n۴. با الاغ به بیرون روستا می‌بردند\n۵. خاک زاینه (خاک تمیز) را از پشت برج می‌آوردند و داخل آغل و طویله می‌انداختند\n\n🐴 الاغ‌سواری؛ جایزه آخر هفته:\nبعد از اتمام کار سخت، یا حتی در بین راه، بچه‌ها با هم قرار می‌گذاشتند و سوار بر الاغ‌ها مسابقه می‌دادند.'


'خنده و شادی در تمام کوچه‌های روستا می‌پیچید.\n\n🎮 قوانین نانوشته الاغ‌سواری:\n• هر کس زودتر کارش تمام می‌شد، سوار الاغ می‌شد و بقیه را صدا می‌زد\n• گاهی چند نفر سوار یک الاغ می‌شدند (که کار سختی برای حیوان بیچاره بود!)\n• مسابقه‌های خودجوش بین بچه‌ها برگزار می‌شد\n• کسی که بهتر می‌توانست الاغ را کنترل کند، قهرمان محله می‌شد\n\n💚 خاطرات ماندگار:\nبزرگترهای ایراج هنوز هم وقتی یاد آن روزها می‌افتند، با حسرت می‌گویند: "چه روزهایی داشتیم... هم کار می‌کردیم، هم تفریح. الاغ‌ها هم بودند و ما هم سوار بر آن‌ها، دنیا را تاخت می‌زدیم!',
  'history': 'این شیوه زندگی تا قبل از ورود ماشین‌آلات مدرن به روستاها و ایجاد شبکه فاضلاب در تمام روستاهای ایران رایج بود. الاغ به عنوان "حیوان بارکش" نقش مهمی در زندگی روزمره داشت و بچه‌ها از کودکی با او انس می‌گرفتند. واله‌بافی هم یکی از صنایع دستی رایج در مناطق خرما خیز بود که متأسفانه امروزه کمتر کسی آن را بلد است.',
  'cultural_note': 'در بسیاری از فرهنگ‌ها، الاغ (خر) نقش مهمی در زندگی روزمره داشته:\n• مصر باستان: الاغ حیوان مقدسی بود\n• یونان: الاغ در جشن‌های دیونیزوس حضور داشت\n• آمریکای لاتین: هنوز هم در برخی مناطق از الاغ برای حمل بار استفاده می‌شود\n• هند: الاغ در جشن‌های محلی شرکت داده می‌شود\nدر همه این فرهنگ‌ها، بچه‌ها الاغ‌سواری را به عنوان تفریح دوست داشتند.',
  'color': Colors.brown.shade500,
  'icon': Icons.pets,  // آیکون حیوان
  'images': [
    'assets/images/entertainments/donkey_ride_1.jpg',
    'assets/images/entertainments/donkey_ride_2.jpg',
    'assets/images/entertainments/donkey_ride_3.jpg',
  ],
},
// 10. کرستو (ترکاندن گِل با فشار هوا)
{
  'name': 'کرستو (قابلمه گلی یا تاس گلی)',
  'type': 'بازی‌های مهارتی',
  'mechanism': 'ایجاد صدای ترکیدن با فشار هوا',
  'description': 'کرستو یکی از سرگرمی‌های ساده اما مهیج بچه‌های قدیم بود که با کمی گِل و آب درست می‌شد. این بازی کوچک، لحظه‌های پر از هیجان و خنده را برای بچه‌ها رقم می‌زد، مخصوصاً وقتی صدای ترکیدن بلندی ایجاد می‌شد!',
  'method': 'ابتدا خاک رس یا خاک معمولی را با آب مخلوط می‌کردند تا گِل نرم و انعطاف‌پذیری به دست بیاید. سپس با این گِل، یک حجم قابلمه‌مانند به اندازه تقریبی کف دست می‌ساختند. دیواره‌ها را ضخیم و کف آن را صاف درست می‌کردند تا هوای داخل محبوس شود. بعد از آماده شدن، کرستو را محکم روی زمین می‌کوبیدند. هوای داخل آن ناگهان فشرده می‌شد و دیواره‌ها را می‌ترکاند و صدای مهیبی تولید می‌کرد!',
  'details': '🏺 روش ساخت کرستو:\n\n۱. گِل نرم و چسبنده آماده کنید (ترکیب خاک رس با آب)\n۲. از گِل یک کاسه کوچک به اندازه کف دست بسازید\n۳. دیواره‌ها را به ضخامت نیم سانتیمتر درست کنید\n۴. کف آن را کاملاً صاف و مسطح کنید\n۵. لبه‌ها را کمی باریک‌تر بگیرید\n۶. بگذارید کمی خشک شود (نه زیاد!)\n\n💥 روش بازی:\nکرستو را طوری در دست می‌گیرید که قسمت توخالی رو به پایین باشد. سپس با یک حرکت سریع و محکم، آن را بر روی زمین صاف می‌کوبید. هوای داخل کرستو ناگهان فشرده می‌شود و برای رهایی، دیواره‌ها را می‌ترکاند.\n\n🎶 صداهای مختلف:\n• اگر خوب ساخته شده بود: صدای مهیب و بلندی مثل ترقه ایجاد می‌کرد\n• اگر گِل شل بود: بی‌صدا له می‌شد و هیچ صدایی نمی‌داد\n• اگر دیواره نازک بود: زود می‌ترکید و صدای نازکی داشت\n• اگر دیواره کلفت بود: شاید اصلاً نترکید!\n\n😄 رقابت بچه‌ها:\nبچه‌ها با هم مسابقه می‌گذاشتند ببینند کرستوی کی صدای بلندتری دارد. هر کس می‌توانست کرستویی بسازد که مثل بمب بترکد، قهرمان روز می‌شد!\n\n🧠 نکته علمی:\nکرستو در واقع یک بازی فیزیکی ساده است. وقتی کرستو به زمین کوبیده می‌شود، حجم هوای داخل ناگهان کاهش می‌یابد و فشار آن بالا می‌رود. این فشار ناگهانی دیواره‌های گِلی را می‌ترکاند و صدا ایجاد می‌کند. همان قانونی که در موتورهای دیزل و ترقه‌ها هم وجود دارد!',
  'history': 'کرستو در بسیاری از مناطق ایران با نام‌های مختلف شناخته می‌شده. در برخی مناطق به آن "چورتکه" یا "ترکوندک" هم می‌گفتند. این بازی ساده هزاران سال قدمت دارد و شاید یکی از قدیمی‌ترین سرگرمی‌های بشریت باشد که با گِل ساخته می‌شده. بچه‌های روستای ایراج هم در فصل بهار که خاک نرم و مناسب بود، ساعتها با کرستو سرگرم می‌شدند.',
  'cultural_note': 'نمونه‌های مشابه این بازی در فرهنگ‌های دیگر:\n• آفریقا: کودکان با گِل قوری‌های کوچک می‌سازند و با کف زدن روی آن‌ها صدا ایجاد می‌کنند\n• آمریکای لاتین: بازی "پومپا" شبیه کرستو است\n• هند: کودکان با خمیر بازی کرستوهای رنگی می‌سازند\n• یونان باستان: در جشن‌های کودکان، گِل‌بازی و ترکاندن آن مرسوم بوده',
  'color': Colors.orange.shade700,
  'icon': Icons.science,  // آیکون آزمایش علمی
  'images': [
    'assets/images/entertainments/kresto_1.jpg',
    'assets/images/entertainments/kresto_2.jpg',
    'assets/images/entertainments/kresto_3.jpg',
  ],
},

// 11. فَلقوی شیطون (فرفره با برگ خرما)
{
  'name': 'فَلقوی شیطون (فرفره با برگ خرما)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'چرخیدن با باد',
  'description': 'فَلقوی شیطون یک فرفره ساده و زیباست که با برگ خرما و کمی خلاقیت ساخته می‌شد. این اسباب‌بازی دست‌ساز، با کوچکترین نسیمی به چرخش درمی‌آمد و دل بچه‌ها را می‌برد. در برخی نقاط ایران به آن "فرفره خرما" هم می‌گفتند.',
  'method': 'برای ساخت فَلقوی شیطون، دو توپک کوچک گِلی به اندازه‌ای کمی بزرگتر از تیله درست می‌کردند. سپس یک برگ خرما را به شکل نوار باریکی می‌بریدند و دو سر آن را به دو توپک گِلی وصل می‌کردند. سپس این مجموعه را از وسط روی یک سیخ باریک (از چوب خرما یا چوب محکم) قرار می‌دادند. با وزش باد، برگ خرما مثل پره‌های فنر می‌چرخید و توپک‌های گِلی هم با آن می‌چرخیدند!',
  'details': '🌴 مواد لازم:\n• برگ خرما (یا برگ نخل)\n• گِل نرم برای ساخت توپک‌ها\n• یک سیخ باریک از چوب خرما\n• کمی آب برای چسباندن\n\n🛠️ مراحل ساخت:\n\n**۱. ساخت توپک‌های گلی:**\nدو توپک کوچک گِلی به اندازه تقریبی ۱٫۵ سانتیمتر (کمی بزرگتر از تیله) درست کنید. بگذارید کمی در آفتاب خشک شوند تا محکم شوند اما کاملاً خشک نباشند که ترک بخورند.\n\n**۲. آماده‌سازی برگ خرما:**\nیک برگ خرما را به شکل نوار باریکی به طول حدود ۱۵ سانتیمتر و عرض نیم سانتیمتر ببرید.'


'دقت کنید که برگ خرما انعطاف‌پذیر و محکم باشد.\n\n**۳. اتصال توپک‌ها به برگ:**\nدو سر برگ خرما را با گِل تازه به دو توپک گِلی بچسبانید. طوری این کار را انجام دهید که برگ بین دو توپک کشیده شود.\n\n**۴. نصب روی سیخ:**\nیک سیخ باریک از چوب خرما (یا هر چوب نازک) بردارید. برگ خرما را از وسط روی نوک سیخ قرار دهید، طوری که دو توپک در دو طرف سیخ آویزان باشند.\n\n**۵. تنظیم نهایی:**\nمطمئن شوید که برگ آزادانه روی سیخ می‌چرخد و به جایی گیر نمی‌کند.\n\n🌬️ روش بازی:\nفَلقوی شیطون را در جایی قرار دهید که باد می‌وزد. با وزش باد، برگ خرما مثل پره‌های یک فنر شروع به چرخیدن می‌کند و توپک‌های گِلی هم با آن می‌چرخند. هر چه باد تندتر باشد، فَلقوی تندتر می‌چرخد و شیطنت بیشتری می‌کند!\n\n🎨 نوع دیگر (فرفره خرما):\nدر برخی نقاط ایران، به جای توپک گلی، برگ خرما را به شکل‌های زیبا می‌بریدند و یک سیخ از وسط آن رد می‌کردند تا فرفره ساده‌تری بسازند. این فرفره‌ها را بچه‌ها در بادهای بهاری به دست می‌گرفتند و می‌دویدند تا تندتر بچرخد.\n\n🧠 نکته علمی:\nفَلقوی شیطون یک نمونه ساده از توربین‌های بادی است. برگ خرما نقش پره‌های توربین را بازی می‌کند و نیروی باد را به انرژی چرخشی تبدیل می‌کند. این همان اصلی است که در آسیاب‌های بادی و توربین‌های مدرن استفاده می‌شود!',
  'history': 'ساخت اسباب‌بازی با برگ خرما در مناطقی که نخلستان دارند (مثل جنوب ایران، خوزستان، بوشهر، هرمزگان و همچنین سیستان و بلوچستان) رواج داشته. روستای ایراج هم با توجه به نخلستان‌های اطراف، این هنر را حفظ کرده بود. فَلقوی شیطون یکی از خلاقانه‌ترین اسباب‌بازی‌های دست‌ساز بچه‌ها بود که فقط با برگ خرما و کمی گِل ساخته می‌شد.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• ژاپن: فرفره‌های کاغذی "کازاگوروما" بسیار شبیه فَلقوی است\n• آفریقا: کودکان با برگ درخت نخل فرفره می‌سازند\n• آمریکای جنوبی: فرفره‌های چوبی با پره‌های برگ\n• هند: "پنکا" فرفره‌های سنتی با برگ خرما\n• مصر باستان: در نقاشی‌های دیواری، تصاویری از بازی با فرفره دیده شده',
  'color': Colors.green.shade600,
  'icon': Icons.toys,  // آیکون اسباب‌بازی
  'images': [
    'assets/images/entertainments/flaghui_1.jpg',
    
  ],
},

// 12. پرتاب سنگ تبرو (مسابقه قدرت و مهارت) - نسخه کامل با دو بخش
{
  'name': 'سنگ تبرو (قدرت‌نمایی و لی لی روی آب)',
  'type': 'بازی‌های رقابتی',
  'mechanism': 'پرتاب سنگ برای مسافت یا لی لی روی آب',
  'description': 'سنگ تبرو یکی از محبوب‌ترین بازی‌های پسرهای ایراج بود که هم در خشکی و هم در آب انجام می‌شد. این بازی دو نسخه داشت: یکی برای نمایش قدرت در پرتاب مسافت، و دیگری برای مهارت در لی لی دادن سنگ روی آب.',
  'method': 'بچه‌ها سنگ‌های نازک و تخت (تبرو) را جمع می‌کردند. دو نوع بازی با این سنگ‌ها انجام می‌دادند: ۱. پرتاب از بلندی برای مسافت بیشتر ۲. پرتاب روی آب برای ایجاد بیشترین تعداد لی لی (چکیده)',
  'details': '🪨 سنگ تبرو چیست؟\n\nتبرو به سنگ‌های نازک، تخت و سبک گفته می‌شد که مانند بشقابک‌های کوچکی بودند. این سنگ‌ها به دلیل شکل خاصشان، هم در هوا برش می‌زدند و مسافت بیشتری طی می‌کردند، هم روی آب لی لی می‌زدند.\n\n---\n\n**🏔️ بخش اول: مسابقه قدرت (پرتاب از بلندی)**\n\nپسرها برای عرض اندام، بر بالای تپه‌ها و بلندی‌ها می‌رفتند. هر کدام سنگی را با تمام قدرت به سمتی خالی پرتاب می‌کردند. هر کس سنگش دورتر می‌رفت، قوی‌تر بود.\n\n❌ سنگ‌های نامناسب:\nسنگ‌های گرد و قلوه‌سنگی اصلاً مناسب نبودند چون:\n• مقاومت هوا روی آنها بیشتر بود\n• سریع به زمین می‌افتادند\n• مسافت خیلی کمی را طی می‌کردند\n\n💪 قوانین مسابقه قدرت:\n• هر کس سنگ را دورتر پرتاب کند، برنده است\n• باید به سمتی پرتاب کنند که چیزی نباشد (آسیب نزند)\n• گاهی روی سنگ را علامت می‌زدند تا سنگ خود را بشناسند\n• مسابقات گاهی تیمی برگزار می‌شد\n\n---\n\n**💧 بخش دوم: لی لی روی آب (بعد از باران)**\n\nوقتی باران می‌بارید و در گودال‌های بزرگ آب جمع می‌شد، بچه‌ها با شور و شوق فراوان به سمت آن گودال‌ها می‌رفتند. اینجا نوبت مهارت بود، نه قدرت!\n\n🎯 روش بازی روی آب:\n\n۱. بعد از باران، دور یک گودال بزرگ پر از آب جمع می‌شدند\n۲. هر کس یک سنگ تبرو (نازک و تخت) انتخاب می‌کرد\n۳. سنگ را با ارتفاع کم و زاویه مناسب روی آب پرتاب می‌کردند\n۴. سنگ باید چند بار به آب برخورد کند و دوباره بلند شود (لی لی کند)\n۵. هر چه تعداد "چکیده‌ها" (برخوردها) بیشتر بود، آن شخص امتیاز بیشتری می‌گرفت\n\n📏 تکنیک‌های حرفه‌ای:\n• سنگ باید کاملاً تخت و صاف باشد\n• زاویه پرتاب نسبت به آب خیلی مهم است (حدود ۲۰ درجه)\n• ارتفاع پرتاب نباید زیاد باشد\n• چرخش سنگ به آن پایداری می‌دهد\n• سرعت پرتاب باید مناسب باشد\n\n🏆 رکوردها و قهرمانان:\nبعضی از بچه‌ها آنقدر ماهر بودند که سنگشان ۵، ۶ و حتی ۷ بار روی آب لی لی می‌زد! اینها قهرمانان محله بودند و بقیه بچه‌ها از آنها یاد می‌گرفتند.\n\n😄 خاطره‌بازی:\nبزرگترهای ایراج هنوز هم با حسرت از آن روزها یاد می‌کنند: "یادش بخیر، بعد از هر بارون، همه بچه‌های محله دور بزرگترین گودال جمع می‌شدیم. هر کس سنگ بهتری پیدا کرده بود، سنگش را نشان می‌داد. کلی مسابقه می‌دادیم و می‌خندیدیم..."\n\n🧠 نکته علمی:\nلی لی کردن سنگ روی آب یک پدیده فیزیکی جالب است. وقتی سنگ با سرعت و زاویه مناسب به آب برخورد می‌کند، نیروی رو به بالای آب باعث می‌شود سنگ دوباره به هوا بلند شود. هر چه سنگ تخت‌تر و سبک‌تر باشد و زاویه مناسب‌تری داشته باشد، تعداد لی لی‌ها بیشتر می‌شود. این همان اصلی است که در هواپیماهای آبی خاکی استفاده می‌شود!',
  'history': 'پرتاب سنگ تبرو در دو نسخه خشکی و آب، از قدیمی‌ترین بازی‌های پسرانه در روستاهای ایران بوده. این بازی ساده اما پر از مهارت، نسل به نسل منتقل شده تا اینکه امروزه با وجود بازی‌های کامپیوتری، کمکم فراموش شده است. اما هر کس از نسل قدیم ایراج این خاطره را تعریف کند، چشمانش برق می‌زند.',
  'cultural_note': 'لی لی کردن سنگ روی آب در بسیاری از فرهنگ‌ها وجود دارد:\n• انگلیس: به آن "سنگ‌لی لی" (Stone skipping) می‌گویند و مسابقات جهانی دارد!\n• اسکاتلند: رکورد جهانی لی لی سنگ ۸۸ بار است!\n• آمریکا: مسابقات سالانه لی لی سنگ برگزار می‌شود\n• استرالیا: بومیان استرالیا این بازی را "بومرنگ آبی" می‌نامیدند',
  'color': Colors.brown.shade400,
  'icon': Icons.water_drop,
  'images': [
    'assets/images/entertainments/stone_throw_1.jpg',
    'assets/images/entertainments/stone_skip_1.jpg',
    'assets/images/entertainments/stone_skip_2.jpg',
  ],
},
// 13. چغو گرفتن (شکار گنجشک‌های نوجوان)
{
  'name': 'چغو گرفتن (شکار گنجشک از لانه)',
  'type': 'بازی‌های ماجراجویانه',
  'mechanism': 'صید پرندگان از لانه',
  'description': 'در فصل بهار، وقتی گنجشک‌ها (چغو) تخم می‌گذاشتند و جوجه‌ها بزرگ می‌شدند و پر درمی‌آوردند، بچه‌های ایراج به سراغ لانه‌هایشان می‌رفتند. این یک ماجراجویی پرخطر اما هیجان‌انگیز بود که مهارت بالا رفتن از دیوار و شجاعت می‌خواست.',
  'method': 'بچه‌ها به سراغ قلعه قدیمی و دیوارهای گلی می‌رفتند که پر از سوراخ و حفره (لانه گنجشک) بود. از این دیوارها بالا می‌رفتند و قبل از اینکه جوجه‌ها پرواز یاد بگیرند و بپرند، آنها را می‌گرفتند. به لانه گنجشک "کُج" می‌گفتند.',
  'details': '🐦 چغو چیست؟\n\nدر اصطلاح محلی ایراج، به گنجشک "چغو" می‌گویند. این پرندگان کوچک و خوش‌آواز در بهار لانه‌سازی می‌کردند و جوجه‌هایشان را بزرگ می‌نمودند.\n\n🏰 مکان‌های لانه:\n• قلعه قدیمی ایراج (که پر از سوراخ بود)\n• دیوارهای گلی خانه‌ها\n• دیوارهای باغ‌ها\n• هر جایی که سوراخ و حفره داشت\n\n📅 زمان مناسب:\nبعد از اینکه جوجه‌ها از تخم بیرون می‌آمدند و بزرگ می‌شدند و اصطلاحاً "پرا" می‌شدند (پر درمی‌آوردند)، بهترین زمان برای گرفتن آنها بود. هنوز پرواز یاد نگرفته بودند و می‌شد به راحتی آنها را از لانه بیرون آورد.\n\n⚠️ خطرات ماجراجویی:\n• سقوط از ارتفاع: دیوارهای گلی بلند بودند و افتادن خطر جدی داشت\n• مار در لانه: گاهی مارها در لانه‌های خالی گنجشک پنهان می‌شدند\n• ریزش دیوار: دیوارهای گلی قدیمی ممکن بود ریزش کنند\n• عصبانیت پرنده‌های مادر: گنجشک‌های مادر برای دفاع از جوجه‌ها حمله می‌کردند\n\n🏚️ کُج چیست؟\n\nبه لانه گنجشک "کُج" می‌گفتند. این کلمه هنوز هم در زبان محلی ایراج برای اشاره به لانه پرندگان استفاده می‌شود.\n\n😄 خاطره‌بازی:\nبزرگترهای ایراج هنوز هم با خنده از آن روزها یاد می‌کنند. یکی از آنها می‌گوید: "یادش بخیر، کلی از این دیوارها بالا می‌رفتیم.'


'بعضی‌ها می‌افتادند و دست و پاشون می‌شکست، اما باز هم فردا دوباره می‌رفتیم! چه روزهایی بود..."',
  'history': 'این بازی در تمام روستاهای ایران که دیوارهای گلی و قلعه‌های قدیمی داشتند رواج داشت. با نابودی خانه‌های گلی و کاهش جمعیت گنجشک‌ها، این تفریح هم کمکم فراموش شد. اما خاطراتش هنوز در ذهن نسل قدیم زنده است.',
  'cultural_note': 'در بسیاری از فرهنگ‌ها، کودکان به شکار پرندگان از لانه علاقه داشتند:\n• اروپا: در روستاهای انگلستان، کودکان به شکار پرندگان از لانه می‌رفتند\n• آمریکای جنوبی: بچه‌های روستایی از درختان بالا می‌رفتند و لانه پرندگان را پیدا می‌کردند\n• آفریقا: شکار پرندگان از لانه یکی از تفریحات رایج کودکان بود',
  'color': Colors.blue.shade600,
  'icon': Icons.egg,
  'images': [
    'assets/images/entertainments/bird_nest_1.jpg',
    'assets/images/entertainments/bird_nest_2.jpg',
  ],
},

// 14. فرفره نخی (با درب نوشابه)
{
  'name': 'فرفره نخی (با درب نوشابه)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'چرخش با کشیدن نخ',
  'description': 'یک اسباب‌بازی ساده اما جذاب که با درب نوشابه و یک نخ بلند ساخته می‌شد. بچه‌ها با درست کردن این فرفره‌ها، ساعت‌ها سرگرم می‌شدند و از صدای جالبی که تولید می‌کرد لذت می‌بردند.',
  'method': 'یک درب نوشابه برمی‌داشتند و آن را کاملاً تخت و صاف می‌کردند. سپس دو سوراخ در دو طرف درب ایجاد می‌کردند و یک نخ بلند را از داخل این دو سوراخ رد می‌کردند. بعد دو سر نخ را به هم گره می‌زدند. با حرکت دادن نخ، فرفره شروع به چرخیدن می‌کرد و صدای جالبی شبیه ویزویز تولید می‌نمود.',
  'details': '🔄 مراحل ساخت فرفره نخی:\n\n**۱. آماده‌سازی درب:**\nیک درب نوشابه فلزی بردارید. با چکش یا یک سنگ صاف، آن را کاملاً تخت و صاف کنید. دقت کنید که لبه‌های آن تیز نباشد تا دستتان را نبرد.\n\n**۲. ایجاد سوراخ:**\nبا یک میخ تیز یا یک پیچ‌گوشتی، دو سوراخ در دو طرف درب (مقابل هم) ایجاد کنید. سوراخ‌ها باید به اندازه‌ای باشند که نخ به راحتی از آنها عبور کند.\n\n**۳. نخ‌کشی:**\nیک نخ بلند (حدود ۵۰ تا ۷۰ سانتی‌متر) بردارید. نخ را از یک سوراخ به داخل و از سوراخ دیگر به بیرون بکشید. طوری که درب در وسط نخ قرار بگیرد.\n\n**۴. گره زدن:**\nدو سر نخ را محکم به هم گره بزنید تا یک حلقه ایجاد شود.\n\n🎮 روش بازی:\nحلقه نخ را با دو دست می‌گیرید. با حرکت دادن دست‌ها به طرفین، نخ می‌پیچد و باز می‌شود و فرفره شروع به چرخیدن می‌کند. هر چه سریع‌تر دست‌ها را حرکت دهید، فرفره تندتر می‌چرخد.\n\n🎶 صدای جالب:\nوقتی فرفره با سرعت می‌چرخد، صدای ویزویز یا وزوز مانندی تولید می‌کند که بچه‌ها خیلی دوست داشتند. این صدا به خاطر ارتعاش درب فلزی در هوا ایجاد می‌شود.\n\n✨ نکته خلاقانه:\nبعضی از بچه‌ها روی درب را با گچ یا رنگ، نقاشی‌های ساده می‌کشیدند تا وقتی فرفره می‌چرخد، طرح‌های زیبایی ایجاد کند.\n\n🧠 نکته علمی:\nفرفره نخی یک نمونه ساده از ژیروسکوپ است. وقتی نخ را می‌کشید، نیروی پیچشی به فرفره وارد می‌شود و آن را به چرخش درمی‌آورد. این همان اصلی است که در فرفره‌های اسباب‌بازی فروشگاهی هم وجود دارد.',
  'history': 'این اسباب‌بازی ساده در دهه‌های ۱۳۵۰ و ۱۳۶۰ در ایران بسیار رایج بود. با رواج نوشابه‌های خانواده و تولید درب‌های فلزی، بچه‌ها این فرصت را پیدا کردند که با کمترین هزینه، بهترین اسباب‌بازی را برای خود بسازند.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• ژاپن: فرفره‌های نخی با دکمه (کمانوری)\n• اروپا: فرفره‌های چوبی با نخ\n• آمریکا: فرفره‌های پلاستیکی تجاری\n• هند: فرفره‌های فلزی با نخ (لاتو)"',
  'color': Colors.cyan.shade600,
  'icon': Icons.rotate_right,
  'images': [
    'assets/images/entertainments/string_top_1.jpg',
    'assets/images/entertainments/string_top_2.jpg',
  ],
},

// 15. ساخت سوت با حلب (سوت دست‌ساز)
{
  'name': 'سوت حلبی (سوت دست‌ساز)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'تولید صدا با ارتعاش',
  'description': 'در قدیم خبری از سوت‌های پلاستیکی و آماده نبود. بچه‌های ایراج با خلاقیت خود، از تکه‌های نازک حلب (ورق فلزی) سوت می‌ساختند. این سوت‌های دست‌ساز صداهای مختلفی داشتند و هر بچه‌ای می‌توانست سوت مخصوص خود را بسازد.',
  'method': 'یک تکه نازک از حلب (معمولاً از قوطی‌های کنسرو یا روغن) برمی‌داشتند. آن را به شکل مستطیل باریکی می‌بریدند. سپس با کمی ظرافت، آن را خم می‌کردند و زبانک‌ای در آن ایجاد می‌نمودند که با دمیدن، بلرزد و صدا تولید کند.',


'details': '🔧 مراحل ساخت سوت حلب:\n\n**۱. تهیه مواد:**\nیک قوطی کنسرو یا روغن خالی پیدا کنید. بهتر است حلب نازک و انعطاف‌پذیر باشد.\n\n**۲. برش حلب:**\nبا قیچی مخصوص یا یک وسیله تیز، یک مستطیل باریک به ابعاد تقریبی ۲×۵ سانتی‌متر ببرید. مراقب باشید لبه‌های تیز دستتان را نبرد.\n\n**۳. صاف کردن لبه‌ها:**\nلبه‌های بریده شده را با یک سنگ یا سوهان صاف کنید تا تیز نباشد.\n\n**۴. ایجاد زبانک:**\nدر یک سر حلب، یک شکاف کوچک ایجاد کنید و یک زبانه باریک را کمی بالا بیاورید. این زبانه همان قسمتی است که با دمیدن می‌لرزد و صدا تولید می‌کند.\n\n**۵. خم کردن:**\nحلب را به شکل U خم کنید تا کانالی برای عبور هوا ایجاد شود.\n\n**۶. تنظیم صدا:**\nبا کم و زیاد کردن زاویه زبانک، می‌توانید صدای سوت را تغییر دهید.\n\n🎵 انواع صداها:\n• سوت نازک: صدای زیر و تیز\n• سوت کلفت: صدای بم و گرفته\n• سوت دوقلو: بعضی‌ها دو سوت را کنار هم می‌بستند و صدای دوگانگی تولید می‌کردند\n\n👂 کاربرد سوت‌ها:\n• صدا زدن دوستان از فاصله دور\n• علامت دادن در بازی‌های گروهی\n• ترساندن پرندگان از مزارع\n• خوشحالی و سروصدا در جشن‌ها\n\n⚠️ نکته ایمنی:\nساختن سوت حلب مهارت می‌خواست و گاهی بچه‌ها دستشان با لبه تیز حلب بریده می‌شد. بزرگترها همیشه هشدار می‌دادند که مراقب باشید.\n\n🧠 نکته علمی:\nسوت حلب مانند همه سوت‌ها، با ارتعاش هوا کار می‌کند. وقتی هوا به زبانک فلزی برخورد می‌کند، آن را به لرزش درمی‌آورد و این لرزش به امواج صوتی تبدیل می‌شود. هر چه زبانک نازک‌تر باشد، صدای زیرتری تولید می‌کند.',
  'history': 'ساختن سوت با حلب در ایران قدمت طولانی دارد. از زمانی که قوطی‌های فلزی وارد ایران شدند، بچه‌ها یاد گرفتند چگونه از آنها سوت بسازند. این هنر ساده نسل به نسل منتقل شد تا اینکه سوت‌های آماده و پلاستیکی جای آن را گرفتند.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• آفریقا: سوت‌های چوبی و فلزی دست‌ساز\n• آمریکای لاتین: سوت‌های سفالی\n• اروپا: سوت‌های حلبی در قرون وسطی\n• هند: سوت‌های فلزی با طرح‌های سنتی',
  'color': Colors.grey.shade600,
  'icon': Icons.music_note,
  'images': [
    'assets/images/entertainments/tin_whistle_1.jpg',
    'assets/images/entertainments/tin_whistle_2.jpg',
  'assets/images/entertainments/tin_whistle_3.jpg',
 
  ],
},
// 16. سوتک (سوت با ساقه گندم)
{
  'name': 'سوتک (سوت با ساقه گندم)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'تولید صدا با ارتعاش ساقه',
  'description': 'یکی از ساده‌ترین و در عین حال لذت‌بخش‌ترین سرگرمی‌های بچه‌های ایراج در فصل بهار، درست کردن سوتک با ساقه سبز گندم بود. با کمی مهارت، هر بچه‌ای می‌توانست برای خودش یک سوت بسازد و تا روزها با آن سرگرم شود.',
  'method': 'در فصل بهار، وقتی گندم‌ها هنوز کاملاً نرسیده بودند و ساقه‌شان سبز و تازه بود، بچه‌ها به مزارع می‌رفتند. یک ساقه گندم را از نزدیک زمین می‌بریدند. سپس قسمتی به اندازه ۲ تا ۳ سانتی‌متر از ساقه را جدا می‌کردند. این قطعه کوچک را روی لب می‌گذاشتند و با دقت در آن می‌دمیدند. اگر ساقه سالم بود و درست انتخاب شده بود، صدای سوت زیبایی از آن بیرون می‌آمد!',
  'details': '🌾 مراحل ساخت سوتک:\n\n**۱. زمان مناسب:**\nاواخر بهار، وقتی گندم‌ها قد کشیده بودند ولی هنوز خوشه‌شان سبز بود و ساقه‌ها کاملاً تازه و آبدار بودند. اگر ساقه خشک می‌شد، دیگر سوتک درست نمی‌شد.\n\n**۲. انتخاب ساقه:**\nساقه‌ای را انتخاب کنید که:\n• قطر مناسبی داشته باشد (نه خیلی کلفت، نه خیلی نازک)\n• کاملاً سالم و بدون ترک باشد\n• بین دو گره ساقه، فاصله مناسبی باشد\n\n**۳. برش ساقه:**\nساقه را از نزدیک زمین ببرید. سپس قسمتی به طول ۲ تا ۳ سانتی‌متر از بین دو گره ساقه را جدا کنید. این قطعه کوچک، بدنه اصلی سوتک است.\n\n**۴. آماده‌سازی:**\nمطمئن شوید دو سر قطعه بریده شده صاف و باز باشد. اگر پوست اضافی دارد، آن را با ناخن یا دندان تمیز کنید.\n\n**۵. نواختن سوتک:**\nقطعه ساقه را روی لب‌های خود بگذارید، طوری که یک سر آن کاملاً در تماس با لب باشد. سپس با دقت و ملایمت در آن بدمید. هوا باید از داخل ساقه عبور کند و باعث ارتعاش دیواره‌ها شود.\n\n🎵 انواع صداها:\n• اگر ساقه نازک‌تر باشد، صدای زیر و تیز تولید می‌کند\n• اگر ساقه کلفت‌تر باشد، صدای بم و گرفته‌تری دارد\n• با کم و زیاد کردن فشار هوا، می‌توان زیر و بمی صدا را تغییر داد\n• بعضی از بچه‌ها می‌توانستند با سوتک آهنگ‌های ساده هم بنوازند!\n\n❌ چرا بعضی سوتک‌ها صدا نمی‌دادند؟\n• ساقه خشک بود و رطوبت کافی نداشت\n• ساقه ترک خورده یا آسیب دیده بود\n• قطر ساقه نامناسب بود\n• دو سر ساقه کاملاً باز نبود\n• تکنیک دمیدن اشتباه بود\n\n👂 کاربردهای سوتک:\n• سرگرمی و بازی در مزارع\n• علامت دادن به دوستان از فاصله دور\n• تقلید صدای پرندگان\n• همراهی با آواز خواندن\n\n😄 خاطره‌بازی:\nیکی از بزرگان ایراج تعریف می‌کند: "یادش بخیر، موقع چوپانی کلی سوتک درست می‌کردیم. هر کدام از بچه‌ها یک جور صدا از سوتکش درمی‌آورد. گاهی با هم گروهی سوت می‌زدیم، انگار یک ارکستر بودیم! مادرها از دور صدای سوتک ما را می‌شناختند و می‌فهمیدند کجاییم."\n\n🧠 نکته علمی:\nسوتک درست مانند یک نی ساده عمل می‌کند. وقتی هوا از داخل ساقه عبور می‌کند، دیواره‌های نازک آن به لرزش درمی‌آید و این لرزش به امواج صوتی تبدیل می‌شود. هر چه ساقه کوتاه‌تر باشد، صدای زیرتری تولید می‌کند و هر چه بلندتر باشد، صدای بم‌تری دارد. این همان اصلی است که در سازهای بادی مانند فلوت و نی وجود دارد!',
  'history': 'سوتک با ساقه گندم یکی از قدیمی‌ترین اسباب‌بازی‌های بشریت است. از زمانی که انسان‌ها کشاورزی را یاد گرفتند و گندم کاشتند، بچه‌ها فهمیدند که می‌توانند با ساقه آن سوت درست کنند. در ایران، این سرگرمی در تمام مناطق کشاورزی رواج داشته و نسل به نسل منتقل شده است. متأسفانه امروزه با机械化 شدن کشاورزی و کاهش رفت و آمد بچه‌ها به مزارع، این هنر ساده هم در حال فراموشی است.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• اروپا: کودکان روستایی در فرانسه و آلمان با ساقه گندم سوت می‌ساختند\n• چین: ساز سنتی "دیزی" شبیه سوتک است\n• آمریکای جنوبی: بومیان آمازون با ساقه گیاهان سوت می‌سازند\n• آفریقا: سوت‌های ارتباطی با ساقه نی و گندم\n• ترکیه: "بوغای" سوت سنتی با ساقه گندم',
  'color': Colors.amber.shade700,
  'icon': Icons.grass,
  'images': [
    'assets/images/entertainments/wheat_whistle_1.jpg',
    'assets/images/entertainments/wheat_whistle_2.jpg',
  ],
},
// 17. قاسملیو (بازی با کفشدوزک)
{
  'name': 'قاسملیو (بازی با کفشدوزک)',
  'type': 'بازی‌های کودکانه با حشرات',
  'mechanism': 'شعرخوانی و رها کردن کفشدوزک',
  'description': 'یکی از لطیف‌ترین و شاعرانه‌ترین بازی‌های بچه‌های ایراج، بازی با کفشدوزک بود. به این حشره کوچک و خال‌دار "قاسملیو" می‌گفتند. بچه‌ها وقتی کفشدوزکی می‌دیدند، آرام آن را برمی‌داشتند و با خواندن شعر مخصوص، از او می‌خواستند پرواز کند و برود.',
  'method': 'بچه‌ها در حیاط خانه یا میان کشتزارها به دنبال کفشدوزک (قاسملیو) می‌گشتند. وقتی یکی را پیدا می‌کردند، آرام آن را روی دست یا انگشت خود می‌نشاندند. سپس با خواندن شعر مخصوص، از قاسملیو می‌خواستند که پرواز کند. بعد از تمام شدن شعر، اجازه می‌دادند کفشدوزک بپرد و برود.',
  'details': '🐞 قاسملیو کیست؟\n\nقاسملیو نام محلی کفشدوزک در روستای ایراج است. این حشره کوچک و دوست‌داشتنی با بال‌های قرمز و خال‌های سیاهش، همیشه مورد علاقه بچه‌ها بوده. در بسیاری از فرهنگ‌ها، کفشدوزک نماد خوش‌اقبالی و شانس است.\n\n📜 شعر قاسملیو:\n\nبچه‌ها وقتی قاسملیو را روی دست می‌نشاندند، این شعر را برایش می‌خواندند:\n\n**"قاسملیو، مادر و پدرت**\n**سر کوه بلند**\n**دارن نون شیره می‌خورن**\n**گفتن قاسملیوی ما**\n**بگو کفشاش را پاش کنه**\n**تنگش را پر آب کنه**\n**پرواز کنه بیاد**\n**پرواز کن، پرواز کن..."**\n\n🦋 معنی شعر:\nاین شعر روایتگر انتظار و دلتنگی است. قاسملیو از بچه‌ها می‌خواهد که به مادر و پدرش بگویند منتظرش هستند. مادر و پدر در کوه بلند مشغول خوردن نان و شیره هستند و قاسملیو را صدا می‌زنند که کفش‌هایش را بپوشد، تنگ آب را پر کند و پرواز کند تا به آنها برسد.\n\n🎵 آهنگ شعر:\nاین شعر با آهنگ مخصوص و یکنواختی خوانده می‌شد. بچه‌ها کلمات را کشیده و با نوای مخصوص تکرار می‌کردند. ریتم آرام شعر باعث می‌شد کفشدوزک آرام بگیرد و بعد از تمام شدن شعر، پرواز کند.\n\n👐 آداب بازی:\n۱. کفشدوزک را آرام روی دست یا انگشت می‌نشاندند\n۲. شعر را با دقت و احترام برایش می‌خواندند\n۳. اگر کفشدوزک زودتر پرواز می‌کرد، دوباره می‌گرفتند و شعر را از اول می‌خواندند\n۴. بعد از تمام شدن شعر، کفشدوزک را به آسمان تعارف می‌کردند\n۵. تماشای پرواز کفشدوزک هم بخشی از لذت بازی بود\n\n😄 خاطره‌بازی:\nیکی از مادربزرگ‌های ایراج تعریف می‌کند: "وقتی بچه بودیم، بهارها کلی قاسملیو پیدا می‌شد. دورش جمع می‌شدیم و هر کسی می‌خواست اول شعر بخواند. بعضی‌ها آنقدر شعر می‌خواندند تا قاسملیو بالاخره پرواز می‌کرد. باور داشتیم اگر قاسملیو پرواز کند، حاجتمان گرفته می‌شود!"\n\n🧠 نکته جالب:\nکفشدوزک‌ها وقتی روی دست می‌نشینند، معمولاً چند لحظه صبر می‌کنند تا محیط را بشناسند و بعد پرواز می‌کنند. بچه‌ها این رفتار طبیعی را به شعر خواندن خود نسبت می‌دادند و فکر می‌کردند قاسملیو به حرفشان گوش می‌دهد.\n\n✨ باورهای عامیانه:\n• اگر قاسملیو روی دستت بنشیند و پرواز کند، خوش‌شانسی می‌آوری\n• تعداد خال‌های قاسملیو نشان‌دهنده ماه‌های خوش‌شانسی است\n• اگر قاسملیو روی سر کسی بنشیند، او فرد خوبی است\n• قاسملیو پیغام‌رسان خداست و دعاها را به آسمان می‌برد',
  'history': 'بازی با کفشدوزک و خواندن شعر برای آن، در بسیاری از فرهنگ‌های جهان وجود دارد. در ایران، این بازی با نام‌های محلی مختلفی مانند "خانم‌گاو" در مناطق ترک‌نشین، "پری‌خاتون" در برخی مناطق و "قاسملیو" در ایراج شناخته می‌شود. این بازی نشان‌دهنده ارتباط عمیق کودکان با طبیعت و موجودات کوچک آن است.',
  'cultural_note': 'بازی با کفشدوزک در فرهنگ‌های مختلف:\n• انگلیس: شعر "Ladybug, ladybug, fly away home" بسیار معروف است\n• آلمان: کودکان برای کفشدوزک شعر "Marienkäfer, flieg" می‌خوانند\n• ترکیه: به کفشدوزک "اوچ‌نوک" می‌گویند و شعر مخصوص دارند\n• فرانسه: شعر "Bête à bon Dieu" برای کفشدوزک می‌خوانند\n• ایتالیا: کفشدوزک را "خانم کوچولو" صدا می‌زنند و برایش دعا می‌خوانند',
  'color': Colors.red.shade600,
  'icon': Icons.bug_report,
  'images': [
    'assets/images/entertainments/ladybug_1.jpg',
    
  ],
},
// 18. سوت گلی (سوت با گل رس)
{
  'name': 'سوت گلی (سوت دست‌ساز با گل)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'تولید صدا با دمیدن در گل',
  'description': 'یکی از خلاقانه‌ترین سرگرمی‌های بچه‌های ایراج، ساختن سوت با گل رس بود. با کمی گل نرم و حوصله، می‌توانستند سوت‌هایی با صداهای مختلف بسازند و ساعت‌ها با آنها سرگرم شوند.',
  'method': 'ابتدا گل رس (مخلوط خاک و آب) را خوب ورز می‌دادند تا نرم و یکدست شود. سپس با آن یک شکل زرد (بیضی مانند) می‌ساختند. ته آن را کاملاً می‌بستند. از یک طرف سوراخی برای دمیدن ایجاد می‌کردند و از طرف دیگر سوراخی برای خروج هوا. این دو سوراخ باید به هم می‌رسیدند. بعد از خشک شدن، در آن می‌دمیدند و صدای سوت از آن بیرون می‌آمد.',
  'details': '🏺 **مراحل ساخت سوت گلی:**\n\n**۱. آماده‌سازی گل:**\nخاک رس را با آب مخلوط می‌کردند و خوب ورز می‌دادند تا گلی نرم، چسبنده و بدون ترک به دست بیاید.\n\n**۲. شکل دادن:**\nاز گل یک شکل زرد (شبیه تخم‌مرغ یا قایق کوچک) درست می‌کردند. اندازه آن معمولاً ۵ تا ۷ سانتی‌متر بود.\n\n**۳. بستن ته:**\nته سوت را کاملاً می‌بستند تا هوا از آنجا خارج نشود. این خیلی مهم بود!\n\n**۴. ایجاد سوراخ‌ها:**\nیک سوراخ در قسمت بالایی برای دمیدن ایجاد می‌کردند. یک سوراخ دیگر در قسمت جلویی برای خروج هوا. این دو سوراخ باید در داخل به هم می‌رسیدند.\n\n**۵. تنظیم صدا:**\nبا بزرگ یا کوچک کردن سوراخ‌ها، می‌توانستند صدای سوت را تغییر دهند.\n\n**۶. خشک کردن:**\nسوت را چند روز در سایه می‌گذاشتند تا آرام آرام خشک شود. اگر در آفتاب سریع خشک می‌شد، ترک برمی‌داشت.\n\n🎵 **انواع صداها:**\n• سوت‌های کوچک: صدای زیر و تیز\n• سوت‌های بزرگ: صدای بم و گرفته\n• سوت‌های دو سوراخه: قابلیت تغییر صدا با انگشت\n\n❌ **نکته مهم:**\nاگر ته سوت بسته نمی‌بود، هوا از ته خارج می‌شد و هیچ صدایی تولید نمی‌گردید.\n\n🧠 **نکته علمی:**\nسوت گلی مانند یک ساز بادی ساده عمل می‌کند. هوا از سوراخ دمیده می‌شود، به دیواره‌های داخلی برخورد می‌کند و به لرزش درمی‌آید. این لرزش از سوراخ خروجی خارج می‌شود و به صدا تبدیل می‌گردد.',
  'history': 'ساختن سوت با گل، یکی از قدیمی‌ترین سرگرمی‌های بشریت است. باستان‌شناسان سوت‌های گلی مربوط به هزاران سال پیش را پیدا کرده‌اند. در ایران نیز این هنر در روستاها رایج بوده و بچه‌ها در کنار بازی، با خواص خاک‌ها هم آشنا می‌شدند.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **آمریکای لاتین:** سوت‌های سفالی با اشکال حیوانات\n• **آفریقا:** سوت‌های گلی برای مراسم‌های سنتی\n• **هند:** سوت‌های گلی به شکل پرندگان\n• **اروپا:** سوت‌های سفالی در موزه‌ها',
  'color': Colors.orange.shade500,
  'icon': Icons.architecture,
  'images': [],
},

// 19. تیروکمان خوشه خرما (کمان رستم)
{
  'name': 'تیروکمان خوشه خرما (کمان رستم)',
  'type': 'بازی‌های دست‌ساز',
  'mechanism': 'پرتاب با نیروی کشسانی',
  'description': 'یکی از هیجان‌انگیزترین بازی‌های پسرهای ایراج، ساختن تیروکمان با خوشه خرما بود. این کمان‌های دست‌ساز را "کمان رستم" می‌نامیدند و با آن مسابقات تیراندازی راه می‌انداختند.',
  'method': 'از خوشه خرما استفاده می‌کردند. قسمتی از خوشه که از دل درخت خرما بیرون می‌آید تا انتهای آن را می‌بریدند. این قسمت حالت نیم‌هلالی طبیعی داشت. وسط چوب را سوراخ می‌کردند به اندازه‌ای که یک چوب صاف به کلفتی انگشت اول دست از آن رد شود (به طول نیم متر). سپس یک کش شلوار یا تیوپ موتور را باریک می‌بریدند و به بالا و پایین چوب می‌بستند. با این کمان، چوب باریک را پرتاب می‌کردند.',
  'details': '🏹 **مراحل ساخت کمان رستم:**\n\n**۱. انتخاب خوشه خرما:**\nاز قسمت ابتدایی خوشه خرما (جایی که از دل درخت بیرون می‌آید) تا انتهای آن را انتخاب می‌کردند. این قسمت به طور طبیعی حالت خمیده (نیم‌هلالی) داشت.\n\n**۲. آماده‌سازی کمان:**\nخوشه را به طول مناسب (حدود ۷۰ سانتی‌متر) می‌بریدند. پوست اضافی آن را می‌گرفتند.\n\n**۳. ایجاد سوراخ:**\nوسط چوب خوشه را سوراخ می‌کردند. این سوراخ باید به اندازه‌ای می‌بود که یک چوب صاف به کلفتی انگشت اول دست از آن رد شود.\n\n**۴. ساخت تیر:**\nیک چوب صاف و مستقیم به طول نیم متر و به کلفتی انگشت اول دست انتخاب می‌کردند. این چوب نقش تیر را داشت.\n\n**۵. نصب زه:**\nیک کش شلوار یا تیوپ موتور را باریک می‌بریدند. این کش را به دو سر کمان (بالا و پایین) محکم می‌بستند.\n\n**۶. نحوه استفاده:**\nتیر (چوب باریک) را از سوراخ وسط کمان رد می‌کردند. سپس کش را می‌کشیدند و رها می‌کردند تا تیر پرتاب شود.\n\n🎯 **مسابقات تیراندازی:**\nبچه‌ها هدف‌هایی مثل قوطی کنسرو یا تکه‌های چوب را در فاصله‌های مختلف می‌گذاشتند و با کمان رستم به سمت آنها تیراندازی می‌کردند.\n\n💪 **کمان رستم؛ نامی پرشکوه:**\nاین نام را از روی رستم، پهلوان بزرگ شاهنامه، انتخاب کرده بودند. هر پسری دوست داشت کمانی مثل رستم داشته باشد.\n\n🧠 **نکته جالب:**\nاین کمان‌ها کاملاً ارگانیک و طبیعی بودند. از خوشه خرما که معمولاً دور ریخته می‌شد، بهترین اسباب‌بازی ساخته می‌شد.',
  'history': 'در مناطق خرما خیز ایران مثل بوشهر، هرمزگان، خوزستان و سیستان و بلوچستان، استفاده از برگ و خوشه خرما برای ساخت اسباب‌بازی رایج بوده. روستای ایراج هم با داشتن نخلستان‌های فراوان، این هنر را حفظ کرده بود.',
  'cultural_note': 'تیروکمان یکی از قدیمی‌ترین ابزارهای بشریت است. نمونه‌های مشابه:\n• **مغولستان:** کمان‌های سنتی با شاخ حیوانات\n• **آمریکای شمالی:** کمان‌های بومیان با چوب درختان\n• **آفریقا:** کمان‌های شکار با تیرهای چوبی',
  'color': Colors.brown.shade600,
  'icon': Icons.sports_mma,
  'images': [],
},

// 20. انگشت سیاه (بازی تقلید و خنده)
{
  'name': 'انگشت سیاه (بازی تقلید و خنده)',
  'type': 'بازی‌های شیطنت‌آمیز',
  'mechanism': 'تقلید و سیاه کردن صورت',
  'description': 'یک بازی شیطنت‌آمیز که در آن یک نفر با انگشت سیاه شده، دیگری را غافلگیر می‌کرد و صورتش را سیاه می‌نمود. این بازی بیشتر اطراف اجاق‌های آتشی و نزدیک حمام عمومی انجام می‌شد تا طرف بتواند خودش را تمیز کند!',
  'method': 'یک نفر انگشت خود را با دوده یا زغال سیاه می‌کرد. دستش را طوری می‌گرفت که انگشت سیاه دیده نشود. به دیگری می‌گفت: "اگه تونستی هر کار من کردم تو هم بکنی، یه جایزه بهت می‌دم." روبروی هم می‌نشستند و شروع می‌کردند به تقلید حرکات. لحظه آخر، انگشت سیاه را روی صورت طرف مقابل می‌کشید و او را سیاه می‌کرد. بقیه بچه‌ها می‌خندیدند!',
  'details': '🖤 **شرح بازی:**\n\n**۱. آماده‌سازی:**\nیک نفر انگشت خود را با دوده کف دیگ یا زغال سیاه می‌کرد. انگشتش را طوری در مشت می‌گرفت که سیاهی دیده نشود.\n\n**۲. انتخاب قربانی:**\nاین بازی معمولاً روی بچه‌ای اجرا می‌شد که تا آن موقع این بازی را ندیده بود و غافلگیر می‌شد.\n\n**۳. شروع بازی:**\nبازی‌گر به قربانی می‌گفت: "اگه تونستی هر کار من کردم تو هم بکنی، یه جایزه بهت می‌دم."\n\n**۴. تقلید حرکات:**\nروبروی هم می‌نشستند. بازی‌گر حرکات مختلفی انجام می‌داد مثلاً:\n• دست به سر می‌زد\n• دست به پیشانی می‌زد\n• دست به بینی می‌زد\n• دست به چانه می‌زد\nو طرف مقابل باید همان حرکت را تکرار می‌کرد.\n\n**۵. لحظه غافلگیری:**\nهمین طور که مشغول تقلید بودند، بازی‌گر یک حرکت معمولی انجام می‌داد اما این بار با انگشت سیاه! مثلاً دست به پیشانی می‌زد و پیشانی خود را سیاه می‌کرد. طرف مقابل هم بدون اینکه متوجه شود، همان کار را می‌کرد و پیشانی خود را سیاه می‌نمود.\n\n**۶. ادامه سیاه‌کاری:**\nبازی‌گر حرکات مختلفی انجام می‌داد و هر بار قسمتی از صورت خود را سیاه می‌کرد:\n• از پیشانی تا چانه\n• دو طرف گونه‌ها\n• نوک بینی\nو طرف مقابل هم همان کار را می‌کرد و آرام آرام تمام صورتش سیاه می‌شد!\n\n**۷. پایان بازی:**\nبازی‌گر ناگهان انگشت سیاه خود را نشان می‌داد و می‌گفت: "ببین! انگشت من سیاه بود!" قربانی تازه می‌فهمید چه بلایی سرش آمده.\n\n😂 **واکنش قربانی:**\n• اول شوکه می‌شد\n• بعد به صورت خود دست می‌کشید و سیاهی را می‌دید\n• بقیه بچه‌ها از دور می‌خندیدند\n• بعضی‌ها تا خانه می‌رفتند و نمی‌فهمیدند صورتشان سیاه است!\n\n🔥 **مکان‌های محبوب بازی:**\n• اطراف اجاق‌های آتشی (چون دوده و زغال دم دست بود)\n• نزدیک حمام عمومی (اگر دستش رنگ می‌داد، می‌رفت تو تون حمام دوباره سیاه می‌کرد!)\n\n🧼 **نکته بهداشتی:**\nاگر دوده با آب مخلوط می‌شد، به سختی پاک می‌شد و ممکن بود تا چند ساعت روی صورت بماند!\n\n😄 **خاطره‌بازی:**\nیکی از ریش‌سفیدان ایراج تعریف می‌کند: "یک بار یکی از بچه‌ها را همین‌جوری سیاه کردیم. تا خانه‌اش رفت و مادرش در را باز کرد، از ترس جیغ کشید! فکر کرد دیو آمده! بعد که فهمید چی شده، کلی خندید و ما را دعوا کرد!"',
  'history': 'بازی انگشت سیاه در بسیاری از نقاط ایران با نام‌های مختلفی مثل "سیاه‌بازی"، "دوده‌بازی" و "مشتی سیاه" شناخته می‌شده. این بازی ساده باعث می‌شد بچه‌ها ساعتها بخندند و لحظات خوشی داشته باشند.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **ترکیه:** بازی "سیاه‌انگشت" معروف است\n• **یونان:** در جشنواره‌ها صورت‌ها را سیاه می‌کنند\n• **هند:** در هولی، رنگ‌پاشی می‌کنند\n• **آفریقا:** مراسم‌های سنتی با رنگ‌آمیزی صورت',
  'color': Colors.grey.shade800,
  'icon': Icons.face,
  'images': [],
},
// 21. باغ نیزار (بازی شبانه قبل از خواب)
{
  'name': 'باغ نیزار (شتر باغ نیزار)',
  'type': 'بازی‌های شبانه',
  'mechanism': 'قصه‌گویی و ایجاد سکوت',
  'description': 'یکی از جذاب‌ترین و پرماجراترین خاطرات شبانه بچه‌های ایراج، ماجرای "شتر باغ نیزار" بود. بزرگ‌ترها با این قصه، بچه‌های پرجنب‌وجوش را آرام و ساکت می‌کردند تا به خواب بروند.',
  'method': 'شب‌ها وقتی بچه‌ها حرف می‌زدند و نمی‌خوابیدند، بزرگ‌ترها ماجرای شتر باغ نیزار را تعریف می‌کردند. می‌گفتند: "یه شتر تو باغ نیزاره، دوتا پستون داره، یکیش شیر و عسل داره، یکیش چرک و خون. هرکی حرف بزنه، چرک و خونش را می‌خوره، هرکی حرف نزنه، شیر و عسل می‌خوره." بعد صدای خاصی شبیه سوت درمی‌آوردند و بعد از آن، همه بچه‌ها ساکت می‌شدند.',
  'details': '🌾 **باغ نیزار کجاست؟**\n\nباغ نیزار یکی از باغ‌های اصلی و قدیمی روستای ایراج است که نی‌های بلند و انبوهی در آن رشد می‌کرده. این باغ با آن نی‌زارهای پرپیچ‌وخم، جای مناسبی برای قصه‌های شبانه بود.\n\n🐪 **داستان شتر باغ نیزار:**\n\nشب‌ها وقتی بچه‌ها در خانه دور هم جمع می‌شدند و حرف می‌زدند، یکی از بزرگ‌ترها (معمولاً مادربزرگ یا پدربزرگ) این قصه را شروع می‌کرد:\n\n**"بچه‌ها! بدونید یه شتر تو باغ نیزار هست..."**\n\nهمین جمله کافی بود تا همه ساکت شوند و با دقت گوش دهند.\n\n**"این شتر دوتا پستون داره. یکیش پر از شیر و عسلِ خوشمزه، یکیش پر از چرک و خونِ بدبو!"**\n\nبچه‌ها با چشم‌های گردشده به دهان بزرگ‌تر خیره می‌شدند.\n\n**"هر کدوم از شما بچه‌ها که حرف بزنه، فردا صبح که بیدار بشه، می‌بینه شتر اومده و چرک و خون رو بهش داده!"**\n\nاین جا بود که بعضی از بچه‌های کوچک‌تر می‌ترسیدند.\n\n**"اما هر کی ساکت باشه و خوب بخوابه، فردا صبح شیر و عسل می‌خوره!"**\n\n🎵 **صدای جادویی:**\n\nبعد از این حرف‌ها، بزرگ‌تر صدای خاصی شبیه سوت یا زمزمه درمی‌آورد. بعضی‌ها می‌گفتند این صدای شتر باغ نیزار است که می‌آید بچه‌ها را ببیند.\n\nاین صدا معمولاً این‌طور بود: **"هومممم... هومممم..."** یا **"شیشششش..."**\n\n😴 **نتیجه:**\n\nبعد از این قصه و صدا، همه بچه‌ها ساکت می‌شدند و چشم‌هایشان را می‌بستند. بعضی‌ها از ترس، بعضی‌ها برای اینکه شیر و عسل بگیرند. تا صبح هیچکس حرف نمی‌زد!\n\n🧠 **روانشناسی جالب:**\n\nاین قصه یک روش هوشمندانه برای مدیریت خواب بچه‌ها بود:\n• **ترس سالم:** ترس از خوردن چرک و خون باعث سکوت می‌شد\n• **امید به پاداش:** وعده شیر و عسل انگیزه می‌داد\n• **صدای خاص:** آن صدا مثل کلیدی بود که همه می‌فهمیدند زمان خواب است\n• **ایجاد آرامش:** بعد از سکوت، کمکم خواب به سراغ بچه‌ها می‌آمد\n\n🌿 **خاطرات ماندگار:**\n\nبزرگ‌ترهای ایراج هنوز هم وقتی یاد آن شب‌ها می‌افتند، لبخند می‌زنند. یکی از آنها تعریف می‌کند: "یادش بخیر، ما پنج تا خواهر و برادر بودیم. شب‌ها تا مادربزرگ نمی‌گفت شتر باغ نیزار، خوابمون نمی‌برد. هنوز هم صداش تو گوشمه!"\n\n🌟 **نکته جالب:**\n\nبعضی از بچه‌ها آنقدر از شتر باغ نیزار می‌ترسیدند که حتی روزها هم حرف کمتری می‌زدند! و بچه‌های شیطان‌تر گاهی به شوخی به هم می‌گفتند: "اگه حرف بزنی، شتر باغ نیزار میاد سراغت!"',
  'history': 'باغ نیزار یکی از باغ‌های قدیمی و معروف ایراج بوده که نی‌های فراوانی داشته. نی‌زارها همیشه در فرهنگ عامه جا برای داستان‌های ترسناک و جذاب هستند. در بسیاری از روستاهای ایران، قصه‌های مشابهی برای خواباندن بچه‌ها وجود داشته، اما "شتر باغ نیزار" مختص ایراج بوده و هنوز هم در خاطره‌ها زنده است.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **آلمان:** قصه "بوگیمن" برای ترساندن بچه‌های بد\n• **ژاپن:** موجودی به نام "ناماهاگه" که بچه‌های بد را می‌ترساند\n• **مکزیک:** "کوکو" موجودی شبانه برای ساکت کردن بچه‌ها\n• **ترکیه:** "اوزان" موجودی که بچه‌های بد را می‌برد\n• **عرب‌ها:** "ابو رجل مسلوخه" برای ترساندن بچه‌ها',
  'color': Colors.green.shade700,
  'icon': Icons.nights_stay,
  'images': [
    'assets/images/entertainments/bagh_nizar_1.jpg',
    'assets/images/entertainments/bagh_nizar_2.jpg',
  ],
},
// 22. بازی با کرم سیب (پیله بده)
{
  'name': 'بازی با کرم سیب (پیله بده)',
  'type': 'بازی‌های کودکانه با حشرات',
  'mechanism': 'تعامل با کرم و تماشای تنیدن پیله',
  'description': 'یکی از بازی‌های جالب و پرخاطره بچه‌های ایراج در فصل سیب، بازی با کرم‌های داخل سیب بود. وقتی سیبی را گاز می‌زدند و کرم داخل آن را می‌دیدند، به جای ترسیدن، با آن بازی می‌کردند و شعر می‌خواندند تا کرم پیله ببافد!',
  'method': 'بچه‌ها سیبی را که کرم داشت برمی‌داشتند و کرم را به آرامی روی دست می‌گذاشتند. سپس با خواندن شعر "سیب منو خوردی پیله بده" و تکرار آن، منتظر می‌ماندند تا کرم از دهانش تار تنیده و آویزان شود. این کار را "پیله دادن" کرم می‌گفتند.',
  'details': '🐛 کرم سیب چیست؟\n\nکرم سیب همان لارو پروانه‌ای است که داخل سیب‌ها تخم گذاشته و لاروها از گوشت سیب تغذیه می‌کنند. این کرم‌ها وقتی بزرگ می‌شوند، از خودشان تار تنیده و تبدیل به پیله می‌شوند تا بعداً پروانه شوند.\n\n🍎 چطور کرم پیدا می‌کردند؟\n\nبچه‌ها وقتی سیب را "کَلَفت" می‌زدند (گاز می‌زدند)، اگر سیب کرم داشت، کرم را می‌دیدند. بعضی وقت‌ها هم سیب‌های افتاده زیر درخت را جمع می‌کردند و کرم‌های داخلشان را بیرون می‌آوردند.\n\n📜 شعر بازی:\n\nبچه‌ها کرم را روی دست می‌گذاشتند و آرام آرام این شعر را می‌خواندند:\n\n**"سیب منو خوردی، پیله بده"**\n**"سیب منو خوردی، پیله بده"**\n\nاین شعر را بارها تکرار می‌کردند تا کرم شروع به تنیدن تار کند.\n\n🪢 لحظه جادویی:\n\nبعد از چند بار تکرار شعر، کرم از دهانش تاری تنیده و کمکم از دست آویزان می‌شد. بچه‌ها با دقت تماشا می‌کردند که کرم دارد پیله می‌بافد. این لحظه برایشان هیجان‌انگیز بود!\n\n🧠 چرا کرم پیله می‌دهد؟\n\nکرم‌ها وقتی احساس خطر می‌کنند یا وقتی آماده تبدیل شدن به شفیره هستند، شروع به تنیدن تار می‌کنند. گرمای دست بچه‌ها و تکرار شعر (که نوعی لرزش صوتی ایجاد می‌کرد) باعث می‌شد کرم فکر کند وقت پیله بافتن است!\n\n😄 خاطره‌بازی:\n\nیکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، تو باغ سیب کلی سیب کرم‌دار پیدا می‌کردیم. می‌نشستیم دور هم و هر کس یه کرم داشت، شعر می‌خوند. هر کی زودتر کرمش پیله می‌داد، قهرمان می‌شد!"\n\n🌟 ادب بازی:\n\n• اگر کرم پیله می‌داد، بچه‌ها خوشحال می‌شدند و کرم را نمی‌کشتند\n• بعضی‌ها کرم را با تارش روی درخت می‌گذاشتند تا پروانه شود\n• به هم یاد می‌دادند چطور آرام شعر بخوانند تا کرم نترسد\n\n🌿 ارتباط با طبیعت:\n\nاین بازی نشان می‌دهد که بچه‌های قدیم چقدر با طبیعت مأنوس بودند. آنها از کرم سیب نمی‌ترسیدند، بلکه با آن دوست می‌شدند و بازی می‌کردند. این نوع بازی‌ها باعث می‌شد بچه‌ها چرخه زندگی را بهتر درک کنند.',
  'history': 'این بازی در تمام مناطقی که درخت سیب داشته، رواج داشته. در ایراج با توجه به باغ‌های سیب فراوان، این بازی بسیار محبوب بود. بچه‌ها در فصل پاییز که سیب‌ها می‌رسید، ساعتها با کرم‌ها بازی می‌کردند و شعر می‌خواندند.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• ژاپن: کودکان با کرم ابریشم بازی می‌کنند و برایشان شعر می‌خوانند\n• اروپا: بازی با کرم‌های میوه در باغ‌ها\n• آمریکای لاتین: بچه‌ها با لارو حشرات بازی می‌کنند\n• ترکیه: بازی مشابهی با کرم‌های سیب وجود دارد',
  'color': Colors.green.shade400,
  'icon': Icons.bug_report,
  'images': [
    'assets/images/entertainments/worm_play_1.jpg',
    'assets/images/entertainments/worm_play_2.jpg',
  ],
},
// 22. شکار سنجاقک و ساخت تسبیح (باور کودکانه)
{
  'name': 'شکار سنجاقک و ساخت تسبیح',
  'type': 'بازی‌های کودکانه با حشرات',
  'mechanism': 'صید سنجاقک و باورهای کودکانه',
  'description': 'در تابستان‌های داغ ایراج، وقتی سنجاقک‌های رنگارنگ در آسمان پرواز می‌کردند، بچه‌ها با شوق و ذوق فراوان به دنبالشان می‌دویدند. اما این شکار فقط برای بازی نبود؛ باوری جالب در بین بچه‌ها وجود داشت که چشم‌های سنجاقک اگر زیر خاک باغچه دفن شوند، تبدیل به مهره می‌شوند!',
  'method': 'بچه‌ها سنجاقک‌ها را با زحمت زیاد و با دست می‌گرفتند. باید خیلی آرام و بی‌صدا به سنجاقک نزدیک می‌شدند و بال‌هایش را می‌گرفتند. سپس چشم‌های درشت و زیبای سنجاقک را جدا کرده و در خاک نرم باغچه یا زمین فرو می‌کردند. باورشان این بود که بعد از چند روز، این چشم‌ها به مهره‌های کوچک و سفت تبدیل می‌شوند. بعد از چند روز، خاک را کنار می‌زدند و مهره‌های فرضی را جمع می‌کردند تا با آنها تسبیح درست کنند.',
  'details': '🪰 **سنجاقک‌های تابستانی ایراج:**\n\nتابستان‌های ایراج پر بود از سنجاقک‌های رنگارنگ. آبی، سبز، قرمز و زرد. آنها با بال‌های شیشه‌ای و درخشنده، مثل جواهرات پرنده در آسمان پرواز می‌کردند. بچه‌ها ساعتها به تماشای پروازشان می‌نشستند.\n\n🎯 **هنر شکار سنجاقک:**\n\nشکار سنجاقک کار آسانی نبود. بچه‌ها باید:\n• خیلی آرام و بی‌صدا حرکت می‌کردند\n• دستشان را به آرامی پشت سر سنجاقک می‌بردند\n• در یک لحظه مناسب، بال‌هایش را می‌گرفتند\n• مراقب بودند به بال‌های ظریفش آسیب نزنند\n\nگاهی ساعتها طول می‌کشید تا یکی دو تا سنجاقک گیر بیاورند. هر چه سنجاقک رنگ‌ارنگ‌تر بود، ارزش بیشتری داشت!\n\n✨ **باور جالب کودکانه:**\n\nباور بچه‌ها این بود که چشم‌های سنجاقک اگر زیر خاک باغچه دفن شوند، کمکم سفت و سخت می‌شوند و به مهره تبدیل می‌گردند. چشم‌های درشت و براق سنجاقک واقعاً شبیه مهره‌های کوچک و قیمتی بودند!\n\n🌱 **مراحل ساخت تسبیح خیالی:**\n\n**۱. شکار سنجاقک:**\nبا صبر و حوصله زیاد، سنجاقک‌ها را شکار می‌کردند.\n\n**۲. جدا کردن چشم‌ها:**\nبا ظرافت تمام، چشم‌های سنجاقک را جدا می‌کردند.\n\n**۳. دفن در خاک:**\nیک گودال کوچک در خاک نرم باغچه یا زمین کنار خانه کندن و چشم‌ها را در آن می‌گذاشتند و رویشان را با خاک نرم می‌پوشاندند.\n\n**۴. انتظار کشیدن:**\nچند روز صبر می‌کردند. باور داشتند چشم‌ها کم کم تبدیل به مهره می‌شوند.\n\n**۵. بیرون آوردن:**\nبعد از چند روز، خاک را کنار می‌زدند و مهره‌های فرضی را بیرون می‌آوردند.\n\n**۶. ساخت تسبیح:**\nمهره‌ها را نخ می‌کردند و برای خود تسبیح درست می‌کردند.\n\n🧵 **تسبیح‌های کودکانه:**\n\nبچه‌ها با افتخار تسبیح‌های خود را به گردن می‌آویختند و به دوستانشان نشان می‌دادند. بعضی‌ها آنقدر این کار را تکرار می‌کردند تا تسبیح‌های بلندی بسازند. مسابقه می‌گذاشتند ببینند کی تسبیح بلندتری دارد!\n\n😄 **خاطره‌بازی:**\n\nیکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، تابستان‌ها کلی سنجاقک می‌گرفتیم. من که کوچک‌تر بودم، باور کرده بودم واقعاً مهره می‌شوند. کلی چشم سنجاقک زیر خاک باغچه مادربزرگ دفن کردم. چند روز بعد کندم دیدم هیچ خبری نیست! مادربزرگ خندید و گفت: اونها که مهره نمی‌شن، برات مهره می‌خرم. ولی باز هم سال بعد دوباره امتحان می‌کردیم!"\n\n🧠 **روانشناسی باور کودکانه:**\n\nاین باور نشان می‌دهد که:\n• کودکان به دنبال توضیح پدیده‌های طبیعی هستند\n• تخیل قوی آنها واقعیت را با خیال مخلوط می‌کند\n• اشیاء براق و درخشان برایشان جذابیت دارد\n• دوست دارند از چیزهای ساده، وسایل جدید بسازند\n\n🌟 **نکته جالب:**\n\nبعضی از بچه‌های بزرگتر که دیگر این باور را نداشتند، باز هم سنجاقک می‌گرفتند و چشم‌هایش را دفن می‌کردند، اما فقط برای سرگرم کردن بچه‌های کوچک‌تر و دیدن ذوق و شوق آنها!\n\n🦋 **سنجاقک در فرهنگ ایرانی:**\n\nسنجاقک در فرهنگ ایرانی نماد زیبایی، ظرافت و تابستان است. در بسیاری از روستاها، بچه‌ها باورهای جالبی درباره سنجاقک داشتند. در ایراج، این باور خاص درباره تبدیل چشم سنجاقک به مهره، سال‌ها نسل به نسل منتقل شده بود.',
  'history': 'این باور کودکانه در روستای ایراج و احتمالاً در بسیاری از روستاهای ایران وجود داشته است. سنجاقک‌ها با چشم‌های درشت و براقشان، همیشه برای کودکان جذاب بوده‌اند. در قدیم که اسباب‌بازی چندانی نبود، کودکان با طبیعت بازی می‌کردند و برای هر پدیده طبیعی داستان‌ها و باورهای خود را داشتند. این بازی نشان‌دهنده خلاقیت و تخیل قوی کودکان روستایی است.',
  'cultural_note': 'باورهای مشابه در فرهنگ‌های دیگر:\n• **ژاپن:** سنجاقک نماد شجاعت است و کودکان باورهای خاصی درباره آن دارند\n• **اروپا:** در برخی مناطق، بچه‌ها باور دارند سنجاقک‌ها پیغام‌رسان پری‌ها هستند\n• **آمریکای جنوبی:** بومیان آمازون برای سنجاقک داستان‌های اساطیری دارند\n• **ترکیه:** کودکان باور دارند سنجاقک خوش‌شانسی می‌آورد\n• **هند:** در بعضی مناطق، سنجاقک را با رنگ‌هایش فال می‌گیرند',
  'color': Colors.teal.shade600,
  'icon': Icons.bug_report,
  'images': [
    'assets/images/entertainments/dragonfly_1.jpg',
    'assets/images/entertainments/dragonfly_2.jpg',
    'assets/images/entertainments/dragonfly_3.jpg',
  ],
},
// 23. مسابقه گاب خدا (سوسک‌های بی‌آزار)
{
  'name': 'مسابقه گاب خدا (سوسک‌های بی‌آزار)',
  'type': 'بازی‌های کودکانه با حشرات',
  'mechanism': 'مسابقه سرعت با حشرات',
  'description': 'در تابستان‌های گرم ایراج، یکی از سرگرمی‌های جالب و خنده‌دار بچه‌ها، مسابقه با "گاب خدا" بود. سوسک‌های سیاه و بی‌آزاری که به آرامی روی زمین راه می‌رفتند و بچه‌ها با صبر و حوصله تماشایشان می‌کردند.',
  'method': 'بچه‌ها به دنبال گاب خداها می‌گشتند و چند تا از آنها را جمع می‌کردند. سپس روی زمین، یک خط شروع و یک خط پایان می‌کشیدند. هر کس گاب خدای خود را پشت خط شروع می‌گذاشت و مسابقه شروع می‌شد. تماشای راه رفتن آرام و بی‌حوصله این حشرات، کلی خنده و هیجان برای بچه‌ها داشت.',
  'details': '🐞 **گاب خدا چیست؟**\n\nدر اصطلاح محلی ایراج، به سوسک‌های سیاه و درشتی که به آرامی روی زمین حرکت می‌کردند، "گاب خدا" می‌گفتند. این سوسک‌ها:\n• کاملاً بی‌آزار بودند\n• بسیار آرام و سنگین راه می‌رفتند\n• معمولاً بعد از باران بیشتر دیده می‌شدند\n• رنگ سیاه و براقی داشتند\n• بچه‌ها هیچ ترسی از آنها نداشتند\n\n🗣️ **ریشه نام "گاب خدا":**\n\nقدیمی‌های ایراج می‌گفتند: **"خدا این گاب (گاو) را نمی‌خواهد، چون نه شیر می‌دهد، نه بار می‌برد!"**\n\n"گاب" در زبان محلی به معنی گاو است. این حشره به خاطر جثه درشت و حرکت آرامش، شبیه گاوهای کوچکی بود که نه شیر می‌دهند و نه باری حمل می‌کنند. به همین دلیل به شوخی می‌گفتند خدا این گاو را نیافریده که فایده‌ای داشته باشد، فقط برای تماشاست!\n\n🏁 **قوانین مسابقه:**\n\n**۱. مرحله انتخاب:**\nبچه‌ها دور هم جمع می‌شدند و هر کدام یک گاب خدا انتخاب می‌کردند. سعی می‌کردند چاق‌ترین و سالم‌ترین‌ها را پیدا کنند.\n\n**۲. مرحله آماده‌سازی:**\nیک خط شروع و یک خط پایان روی زمین خاکی یا حیاط خانه می‌کشیدند. فاصله بین خطوط معمولاً نیم متر تا یک متر بود.\n\n**۳. مرحله مسابقه:**\nهر کس گاب خدای خود را پشت خط شروع می‌گذاشت. با گفتن "سه، دو، یک، شروع!" همه گاب خداها را رها می‌کردند.\n\n**۴. مرحله تشویق:**\nبچه‌ها با صدای بلند گاب خدای خود را تشویق می‌کردند:\n• "بیا بیا، زودتر برو!"\n• "گاب خدای من، تو می‌تونی!"\n• "بجنب، اون داره ازت جلو می‌زنه!"\n\n**۵. مرحله پایان:**\nاولین گاب خدایی که از خط پایان می‌گذشت، برنده مسابقه بود.\n\n😄 **لحظه‌های خنده‌دار:**\n\n• بعضی از گاب خداها اصلاً حرکت نمی‌کردند و همان جا می‌ماندند! (بچه‌ها می‌گفتند: این که مثل گاب خدا بی‌خاصیت شده!)\n• بعضی‌ها برعکس به سمت خط شروع می‌رفتند!\n• گاهی گاب خدا وسط راه می‌ایستاد و استراحت می‌کرد!\n• بچه‌ها با شاخه کوچک آرام به پشتشان می‌زدند تا حرکت کنند!\n• وقتی گاب خدایی برنده می‌شد، صاحبش فریاد می‌زد: "گاب خدای من از اون گاب‌های بی‌خاصیت نیست!"\n\n🎯 **استراتژی‌های بچه‌ها:**\n\n• بعضی‌ها معتقد بودند گاب خدای چاق‌تر، آرام‌تر راه می‌رود\n• بعضی فکر می‌کردند گاب خدای لاغرتر، سریع‌تر است\n• برخی گاب خداهایی را انتخاب می‌کردند که شاخک‌های بلندتری داشتند\n• بعضی‌ها قبل از مسابقه به گاب خدایشان آب می‌دادند تا سرحال بیاید!\n\n🧠 **نکته جالب:**\n\nاین مسابقه به بچه‌ها صبر و حوصله یاد می‌داد. گاب خداها آنقدر آرام راه می‌رفتند که گاهی یک مسابقه چند دقیقه طول می‌کشید! بچه‌ها در این مدت یاد می‌گرفتند منتظر بمانند و عجله نکنند.\n\n🌟 **خاطره‌بازی:**\n\nیکی از ریش‌سفیدان ایراج تعریف می‌کند: "یادش بخیر، ما توی حیاط خانه، کلی مسابقه گاب خدا می‌گذاشتیم. یک بار برادرم گاب خدایش را برداشت زد تو جیبش تا برای مسابقه فردا نگه دارد. فردا صبح دیدیم گاب خدا رفته بود تو جیبش و کلی ترسیده بود! از آن به بعد می‌گفتیم گاب خدا را باید آزاد بگذاری تا برای مسابقه بعدی زنده بماند!"\n\n🌱 **آموزه‌های غیرمستقیم:**\n\n• احترام به موجودات زنده (چون گاب خدا بی‌آزار بود)\n• صبر و حوصله (چون مسابقه طول می‌کشید)\n• رقابت سالم (بدون دعوا و قهر)\n• طبیعت‌دوستی (آشنایی با حشرات)\n\n🪲 **تفاوت گاب خدا با سوسک معمولی:**\n\nگاب خدا نوعی سوسک سیاه و درشت است که در باغ‌ها و مزارع زندگی می‌کند. برخلاف سوسک‌های حمام که مردم از آنها بدشان می‌آید، گاب خدا حشره محبوبی بود چون:\n• تمیز و براق بود\n• بوی بد نمی‌داد\n• آرام و بی‌آزار بود\n• بچه‌ها می‌توانستند با او بازی کنند',
  'history': 'این بازی در روستای ایراج و احتمالاً در بسیاری از روستاهای ایران رایج بوده است. نام "گاب خدا" ریشه در فرهنگ کشاورزی منطقه دارد، جایی که گاو (گاب) حیوان ارزشمندی برای شیر و باربری بود. قدیمی‌ها با شوخی می‌گفتند این حشره گاو خداست اما هیچ فایده‌ای ندارد!',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **ترکیه:** بچه‌ها با سوسک‌های سیاه مسابقه می‌دهند\n• **یونان:** در برخی جزایر، مسابقه حلزون برگزار می‌شود\n• **انگلستان:** مسابقه سوسک‌های آلمانی!\n• **ژاپن:** مسابقه سوسک‌های شاخ‌دار',
  'color': Colors.brown.shade600,
  'icon': Icons.bug_report,
  'images': [
    'assets/images/entertainments/gabe_khoda_1.jpg',
    'assets/images/entertainments/gabe_khoda_2.jpg',
  ],
},
// 24. کمبلو (گیاه شیرین بیابان)
{
  'name': 'کمبلو (گیاه شیرین بیابان)چیدن',
  'type': 'طبیعت‌گردی بهاری',
  'mechanism': 'جستجوی گیاهان خوراکی',
  'description': 'اواخر اسفند و اوایل فروردین که هوا کم‌کم خوب می‌شد، بیابان‌های اطراف ایراج سرسبز می‌گشتند. در این فصل، بچه‌ها به دنبال گیاهی به نام "کمبلو" می‌گشتند؛ گیاهی با برگ‌های شیرین و ریشه‌ای خوشمزه که پیدا کردنش مهارت خاصی می‌خواست.',
  'method': 'بچه‌ها برای پیدا کردن کمبلو به بیابان می‌رفتند. چون برگ‌های کمبلو شبیه سنگ‌های بیابان بود، تشخیص آن سخت بود. به همین خاطر شعر می‌خواندند: "کمبل کمبل صحرایی، بیا که رفیق مایی". بعد از پیدا کردن، برگ‌هایش را می‌چیدند و می‌خوردند یا برای سرخ کردن به خانه می‌بردند. ریشه را هم از خاک درمی‌آوردند و مغز سفید و شیرین آن را می‌خوردند.',
  'details': '🌱 **کمبلو چیست؟**\n\nکمبلو گیاهی خودرو در بیابان‌های اطراف ایراج است که در اواخر زمستان و اوایل بهار سبز می‌شود. این گیاه دو نوع دارد:\n\n**۱. کمبلو با برگ‌های دراز:** برگ‌های باریک و کشیده\n**۲. کمبلو با برگ‌های گرد:** برگ‌های پهن و گرد\n\n🍃 **برگ کمبلو:**\n• برگ‌های هر دو مدل شیرین و پرآب است\n• طعم مطبوعی دارد\n• می‌توان آن را به صورت خام خورد\n• برخی افراد برگ‌ها را سرخ می‌کنند و با رب انار می‌خورند (بسیار خوشمزه!)\n\n🥕 **ریشه کمبلو:**\n• ریشه از پوستی قهوه‌ای و مغزی سفید تشکیل شده\n• مغز سفید آن بسیار شیرین است\n• اگر کمبلو جوان باشد، ریشه ترد و خوشمزه است\n• اگر کمبلو خیلی بزرگ شده باشد، ریشه حالت آدامسی پیدا می‌کند (شیرین است ولی ترد نیست)\n\n🎵 **شعر جستجوی کمبلو:**\n\nچون برگ‌های کمبلو شبیه سنگ‌های بیابان بود، بچه‌ها برای پیدا کردن آن شعر می‌خواندند:\n\n**"کمبل کمبل صحرایی، بیا که رفیق مایی"**\n\nاین شعر را بارها تکرار می‌کردند تا کمبلوها پیدا شوند. انگار که گیاه جواب شعر را می‌داد!\n\n😋 **روش‌های خوردن کمبلو:**\n\n• **خام:** برگ‌ها را می‌چیدند و همانطور می‌خوردند\n• **سرخ شده:** برگ‌ها را سرخ می‌کردند و با رب انار می‌خوردند\n• **ریشه:** مغز سفید ریشه را می‌خوردند\n• **ترشی:** بعضی‌ها از آن ترشی درست می‌کردند\n\n🧺 **خاطره‌بازی:**\n\nیکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، اول بهار که می‌شد، من و دوستانم سبد به دست می‌گرفتیم و می‌رفتیم بیابون دنبال کمبلو. کلی می‌گشتیم تا پیدا کنیم. وقتی پیدا می‌کردیم، انگار گنج پیدا کرده بودیم! همونجا می‌نشستیم و برگ‌هاش رو می‌خوردیم. بقیه رو می‌آوردیم خونه تا مادر سرخ کنه با رب انار. چه مزه‌ای داشت..."\n\n🌟 **نکته جالب:**\n\nکمبلو فقط یک گیاه نبود، بلکه بهانه‌ای بود برای:\n• دورهمی بچه‌ها در طبیعت\n• یادگیری شناخت گیاهان\n• لذت بردن از طعم‌های طبیعی\n• حفظ سنت‌های محلی',
  'history': 'کمبلو از دیرباز در ایراج شناخته شده بوده. قدیمی‌ها خواص این گیاه را می‌شناختند و آن را به نسل‌های بعد منتقل می‌کردند. با تغییر سبک زندگی و کم شدن رفت‌وآمد به بیابان‌ها، این سنت کمکم کمرنگ شده اما خاطراتش هنوز زنده است.',
  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **ترکیه:** گیاه "کره‌پیز" شبیه کمبلو\n• **اروپا:** گیاهان خودروی بهاری مثل "رمپ" در آمریکای شمالی\n• **ژاپن:** جوانه‌های بهاری گیاهان کوهی "سانسای"\n• **هند:** گیاهان خودرو در هیمالیا',
  'color': Colors.green.shade600,
  'icon': Icons.grass,
  'images': [
    'assets/images/entertainments/kambalu_1.jpg',
   
  ],
},

// 25. هنگ (انغوزه) - گیاه تند کوه‌ها
{
  'name': 'هنگ (انغوزه) چیدن',
  'type': 'طبیعت‌گردی بهاری',
  'mechanism': 'شناخت گیاهان و برداشت محصول',
  'description': 'در کنار کمبلو، گیاه دیگری هم در کوه‌های اطراف ایراج سبز می‌شد به نام "هنگ" (انغوزه). گیاهی با مزه تند و بوی خاص شبیه گاز شهری که برگ‌هایش را برای ترشی، سرخ کردن و حتی آش استفاده می‌کردند. در تابستان هم شیره این گیاه که "انغوزه" نام دارد، جمع‌آوری می‌شد و به کشورهای دیگر صادر می‌گردید!',
  'method': 'در فصل بهار، بچه‌ها و بزرگترها به کوه می‌رفتند و برگ‌های تازه هنگ را می‌چیدند. این برگ‌ها را یا سرخ می‌کردند و با رب انار می‌خوردند، یا از آن ترشی و آش درست می‌کردند. برگ‌های اضافه را خشک می‌کردند تا در فصل‌های دیگر هم بتوانند از آن استفاده کنند. در تابستان هم شیره گیاه را جمع‌آوری می‌کردند که به انغوزه معروف است و کاربردهای فراوانی دارد.',
  'details': '🌿 **هنگ (انغوزه) چیست؟**\n\nهنگ گیاهی خودرو در کوه‌های اطراف ایراج است. نام علمی آن "Ferula assa-foetida" است و در جهان به "انغوزه" (Asafoetida) معروف می‌باشد. این گیاه:\n• در بهار سبز می‌شود\n• برگ‌های سبز و پرپشت دارد\n• مزه بسیار تند و تیزی دارد\n• بوی خاصی شبیه **گاز شهری** یا گوگرد دارد\n• همین بوی تند باعث می‌شود بعضی‌ها از آن خوششان نیاید!\n\n🍽️ **برگ هنگ (در بهار):**\n\nبرگ‌های تازه هنگ را در بهار می‌چیدند و به چند صورت مصرف می‌کردند:\n\n**۱. سرخ شده با رب انار:**\nبرگ‌ها را سرخ می‌کردند تا تندی‌اش کم شود، سپس با رب انار ترش و شیرین مخلوط می‌کردند. غذایی لذیذ و محلی!\n\n**۲. ترشی هنگ:**\nبرگ‌ها را همراه با سبزی‌های دیگر، سرکه و ادویه، ترشی می‌زدند. ترشی‌ای خوشمزه و مقوی.\n\n**۳. آش هنگ (مهمترین کاربرد):**\nاز برگ‌های تازه یا خشک شده هنگ برای پخت آش استفاده می‌کردند. **آش هنگ** یکی از غذاهای سنتی ایراج بود که:\n• طعم خاص و تندی داشت\n• بسیار مقوی بود\n• **خاصیت ضد انگل** داشت (برای دفع کرم‌های روده مفید بود)\n• در فصل بهار که بدن نیاز به پاکسازی داشت، مصرف می‌شد\n\n🍜 **طرز تهیه آش هنگ:**\nبرگ‌های تازه یا خشک هنگ را با حبوبات (نخود، لوبیا، عدس)، سبزی‌های محلی، پیاز داغ و نعناع داغ می‌پختند. طعم تند و منحصر‌به‌فرد آن زبانزد بود!\n\n💧 **شیره هنگ (انغوزه) در تابستان:**\n\nدر فصل تابستان، شیره گیاه هنگ را جمع‌آوری می‌کردند که به "انغوزه" معروف است. این شیره:\n• بسیار تند و قوی است\n• بوی تند گاز شهری دارد\n• خواص دارویی فراوان دارد (ضد انگل، ضد نفخ، هضم‌کننده)\n• در صنایع غذایی و دارویی استفاده می‌شود\n\n🌬️ **بوی خاص هنگ:**\n\nجالب است بدانید بوی تند هنگ شبیه بوی **گاز شهری** (گاز سوختنی) است که عمداً به گاز اضافه می‌کنند تا نشتی آن تشخیص داده شود. این بو برای خیلی‌ها آزاردهنده است، اما در طب سنتی بسیار ارزشمند است!\n\n🌍 **صادرات به کشورهای دیگر:**\n\nانغوزه ایران شهرت جهانی دارد. شیره این گیاه مستقیماً به کشورهای زیر صادر می‌شود:\n• هندوستان (بیشترین مصرف را در طب سنتی هند دارند)\n• پاکستان\n• کشورهای عربی\n• برخی کشورهای اروپایی\n\nدر هند از انغوزه به عنوان چاشنی در بسیاری از غذاها استفاده می‌کنند.\n\n💰 **ارزش اقتصادی:**\n\nانغوزه یکی از محصولات باارزشی است که از طبیعت ایراج به دست می‌آید و منبع درآمدی برای برخی خانواده‌هاست.\n\n😋 **طعم هنگ:**\n\n• برگ تازه: بسیار تند و تیز (همه‌کس نمی‌تواند بخورد)\n• برگ سرخ شده: تندی‌اش کم می‌شود و خوشمزه می‌گردد\n• آش هنگ: طعم خاص و لذیذی دارد\n• شیره انغوزه: فوق‌العاده تند (یک قطره کوچک کافی است)\n\n🧺 **خاطره‌بازی:**\n\nیکی از زنان ایراج تعریف می‌کند: "بهار که می‌شد، من و خواهرها می‌رفتیم کوه، هم کمبلو می‌چیدیم، هم برگ هنگ. مادربزرگم آش هنگ می‌پخت، بوی عجیبی توی خونه می‌پیچید، اول همه می‌گفتن چه بوی بدی، اما وقتی آش می‌خوردیم، همه کیف می‌کردیم. مادربزرگ می‌گفت این آش کرم‌های شکم را می‌کشد!"\n\n🍃 **خشک کردن برگ هنگ:**\n\nبرگ‌های اضافه هنگ را در سایه خشک می‌کردند و در کیسه‌های پارچه‌ای نگه می‌داشتند تا در پاییز و زمستان هم بتوانند از آن استفاده کنند. برگ خشک شده هم خاصیت خود را حفظ می‌کند.\n\n⚠️ **نکته ایمنی:**\n\nچیدن برگ هنگ باید با احتیاط انجام شود، چون:\n• شیره گیاه اگر به چشم برود، سوزش شدید ایجاد می‌کند\n• بوی تند آن ممکن است برای بعضی‌ها آزاردهنده باشد\n• بهتر است با دستکش چیده شود',
  'history': 'هنگ (انغوزه) از دیرباز در ایران شناخته شده بوده. در طب سنتی ایران و هند، از انغوزه برای درمان بسیاری از بیماری‌ها استفاده می‌شده. در ایراج نیز قدیمی‌ها خواص این گیاه را می‌شناختند و از آن برای درمان دل‌درد، نفخ، انگل‌های روده و مشکلات گوارشی استفاده می‌کردند. آش هنگ یکی از غذاهای سنتی منطقه بود که در فصل بهار پخته می‌شد. صادرات انغوزه به هندوستان سابقه‌ای طولانی دارد و هنوز هم ادامه دارد.',
  'cultural_note': 'انغوزه در فرهنگ‌های مختلف:\n• **هند:** "Hing" یکی از چاشنی‌های اصلی غذاست و در طب آیورودا کاربرد دارد\n• **ایران:** در طب سنتی و خوراکی‌های محلی، مخصوصاً آش‌ها\n• **روم باستان:** به عنوان چاشنی و دارو استفاده می‌شد\n• **یونان:** خواص دارویی آن شناخته شده بود\n• **پاکستان:** در غذاهای محلی و درمان‌های سنتی',
  'color': Colors.orange.shade700,
  'icon': Icons.local_florist,
  'images': [
    'assets/images/entertainments/hang_1.jpg',
    'assets/images/entertainments/hang_2.jpg',
    'assets/images/entertainments/anghuzeh_1.jpg',
  ],
},

// 26. خاک‌انداز (انتقال آتش در زمستان)
{
  'name': 'خاک‌انداز (گرفتن آتش از همسایه)',
  'type': 'بازی‌های دوران کار',
  'mechanism': 'انتقال آتش با خاکستر داغ',
  'description': 'در زمستان‌های سخت ایراج، همه خانه‌ها آتش نداشتند. کبریت هم یا نبود یا کمیاب و گران‌قیمت بود. به همین دلیل، مردم برای روشن کردن آتش خانه‌شان، از همسایگان آتش می‌گرفتند. این کار با وسیله‌ای به نام "خاک‌انداز" انجام می‌شد و خودش به یک ماجراجویی کودکانه تبدیل شده بود!',
  'method': 'بچه‌ها یا بزرگترها یک کاسه یا ظرف سفالی (خاک‌انداز) برمی‌داشتند و به خانه همسایه می‌رفتند. آنجا مقداری خاکستر داغ و زغال‌های روشن از تنور یا بخاری همسایه برمی‌داشتند و با دقت به خانه خود می‌آوردند تا آتش را روشن کنند. این کار نیاز به مهارت و دقت داشت تا آتش در راه خاموش نشود.',
  'details': '🔥 **خاک‌انداز چیست؟**\n\nخاک‌انداز ظرفی سفالی یا فلزی بود که برای انتقال آتش و خاکستر استفاده می‌شد. این ظرف معمولاً:\n• از جنس سفال بود (برای حفظ حرارت)\n• دسته‌دار بود تا حمل آن راحت باشد\n• درب داشت یا با پارچه می‌پوشاندندش\n• ته‌گرد بود تا روی زمین بماند\n\n❄️ **زمستان‌های سخت ایراج:**\n\nدر قدیم، همه خانه‌ها اجاق و آتشگاه نداشتند. بعضی خانواده‌ها که وضع مالی بهتری داشتند، اجاق یا بخاری داشتند، اما خیلی‌ها بی‌آتش می‌ماندند. با سرد شدن هوا، نیاز به آتش برای:\n• گرم کردن خانه\n• پختن نان\n• پختن غذا\n• گرم کردن آب\n• روشنایی شب\n\nضروری بود.\n\n🪔 **روش کار:**\n\n**۱. آماده‌سازی خاک‌انداز:**\nیک ظرف سفالی یا فلزی تمیز برمی‌داشتند. کف آن را کمی خاکستر یا خاک نرم می‌ریختند تا حرارت به ظرف آسیب نزند.\n\n**۲. رفتن به خانه همسایه:**\nبه خانه همسایه‌ای که آتش داشت می‌رفتند. این همسایه معمولاً از اقوام یا دوستان نزدیک بود.\n\n**۳. گرفتن آتش:**\nتکه‌های زغال روشن و خاکستر داغ را با احتیاط داخل خاک‌انداز می‌گذاشتند. اگر تنور بود، از ته تنور که حرارت بیشتری داشت برمی‌داشتند.\n\n**۴. پوشاندن آتش:**\nروی زغال‌ها را با خاکستر می‌پوشاندند تا آتش خاموش نشود، اما هوا به آن برسد. گاهی روی ظرف را با پارچه نازک می‌پوشاندند.\n\n**۵. انتقال به خانه:**\nبا دقت و سرعت مناسب، خاک‌انداز را به خانه خود می‌بردند. در راه باید:\n• از تکان دادن زیاد خودداری می‌کردند\n• مراقب باد بودند (باد آتش را خاموش می‌کرد)\n• اگر باران می‌بارید، روی آن را می‌پوشاندند\n\n**۶. روشن کردن آتش:**\nدر خانه، زغال‌های داغ را داخل اجاق یا تنور می‌گذاشتند و با هیزم و کاه، آتش را دوباره شعله‌ور می‌کردند.\n\n🧒 **نقش بچه‌ها در این ماجرا:**\n\nاین کار برای بچه‌ها مثل یک مأموریت مهم بود! آنها:\n• با افتخار خاک‌انداز را به دست می‌گرفتند\n• مسئولیت انتقال آتش را بر عهده می‌گرفتند\n• اگر آتش را سالم به خانه می‌رساندند، به آنها افتخار می‌کردند\n• گاهی چند خانه پشت سر هم می‌رفتند تا آتش بگیرند\n\n😄 **خاطره‌بازی:**\n\nیکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، من بچه بودم و همیشه وظیفه گرفتن آتش از خونه عمه‌ام را داشتم. یک روز برف می‌بارید و هوا خیلی سرد بود. خاک‌انداز را گرفتم و رفتم خونه عمه. زغال‌های داغ را برداشتم و با سرعت به سمت خونه دویدم. وسط راه پام لیز خورد و خاک‌انداز افتاد و آتش ریخت بیرون! مجبور شدم دوباره برگردم خونه عمه. کلی دعوایم کرد ولی آخرش بهم آتش داد. از آن روز به بعد خیلی مواظب بودم!"\n\n🔧 **کبریت، کالای کمیاب:**\n\nدر قدیم، کبریت به اندازه امروز در دسترس نبود. کبریت‌ها:\n• گران‌قیمت بودند\n• به سختی پیدا می‌شدند\n• بعضی‌ها اصلاً کبریت نداشتند\n• برای روشن کردن آتش، اول باید کبریت را پیدا می‌کردی!\n\n📦 **کبریت‌های قدیمی:**\n\nکبریت‌های قدیمی از جنس چوب بودند و سرِ گوگردی داشتند. این کبریت‌ها:\n• خیلی راحت خیس می‌شدند و از کار می‌افتادند\n• اگر باد می‌وزید، روشن نمی‌شدند\n• گاهی سرِ کبریت کنده می‌شد و کار نمی‌کرد\n• به همین خاطر، گرفتن آتش از همسایه مطمئن‌ترین راه بود.\n\n💡 **نکته جالب:**\n\nبعضی از خانواده‌ها که کبریت داشتند، آن را در جایی دور از دسترس بچه‌ها نگهداری می‌کردند تا هدر نرود. بچه‌ها همیشه دنبال کبریت بودند که برای بازی یا روشن کردن آتش استفاده کنند!\n\n🌟 **اهمیت این رسم:**\n\n• نشانه همبستگی اجتماعی و کمک به همسایگان بود\n• باعث می‌شد مردم در زمستان از هم جدا نباشند\n• کودکان را مسئولیت‌پذیر بار می‌آورد\n• به بچه‌ها نحوه برخورد با آتش را یاد می‌داد\n• یک خاطره مشترک و شیرین برای نسل قدیم ساخت',

  'history': 'در قدیم که وسایل گرمایشی مدرن نبود و کبریت هم کمیاب و گران بود، گرفتن آتش از همسایه یکی از کارهای روزمره در روستاهای ایران بود. این رسم در ایراج نیز رایج بود و مردم با خاک‌انداز از خانه‌ای به خانه دیگر می‌رفتند تا آتش بگیرند. با آمدن کبریت‌های ارزان و فندک‌های مدرن، این رسم کمکم از بین رفت اما خاطراتش هنوز در ذهن بزرگترها باقی مانده است.',

  'cultural_note': 'نمونه‌های مشابه در فرهنگ‌های دیگر:\n• **اروپا:** در قرون وسطی، مردم با زغال‌های داغ از همسایه آتش می‌گرفتند\n• **آفریقا:** قبایل آفریقایی با چوب‌های مخصوص آتش منتقل می‌کردند\n• **ژاپن:** در خانه‌های سنتی، آتش اجاق را همیشه روشن نگه می‌داشتند\n• **هند:** در روستاها، گرفتن آتش از همسایه رایج بود\n• **ترکیه:** رسم مشابهی با ظروف سفالی وجود داشته',

  'color': Colors.orange.shade800,
  'icon': Icons.fireplace,
  'images': [
    'assets/images/entertainments/fire_pot_1.jpg',
    'assets/images/entertainments/fire_pot_2.jpg',
  ],
},
// 27. مسابقه شاشیدن (مسافت‌سنجی پسرانه)
{
  'name': 'مسابقه شاشیدن (مسافت‌سنجی پسرانه)',
  'type': 'بازی‌های رقابتی',
  'mechanism': 'رقابت در مسافت و قدرت',
  'description': 'یکی از بازی‌های عجیب و خنده‌دار پسرهای ایراج که شاید امروز برایمان عجیب به نظر برسد، مسابقه شاشیدن بود! پسرها برای تفریح و رقابت، بالای تپه یا بلندی می‌رفتند و با هم مسابقه می‌گذاشتند ببینند چه کسی می‌تواند ادرار خود را دورتر پرتاب کند. این بازی بیشتر برای بچه‌های نوجوان و جوون‌ها بود و کلی خنده و هیجان داشت!',
  'method': 'بچه‌ها به اتفاق به بالای یک تپه یا بلندی می‌رفتند. کنار هم می‌ایستادند و با یک علامت، همزمان شروع به شاشیدن می‌کردند. همه تلاش می‌کردند با فشار بیشتر، ادرار خود را دورتر پرتاب کنند. هر کس ادرارش مسافت بیشتری را طی می‌کرد، برنده بود. گاهی از این بازی برای سنجش قدرت و توانایی هم استفاده می‌کردند!',
  'details': '💦 **یک بازی عجیب اما واقعی!**\n\nشاید باورش سخت باشد، اما مسابقه شاشیدن یکی از بازی‌های رایج پسرهای نوجوان در ایراج و بسیاری از روستاهای ایران بود. این بازی ساده اما پر از خنده و رقابت، لحظات خاطره‌انگیزی برای نسل قدیم ساخته است.\n\n🏔️ **محل برگزاری:**\n\n• بالای تپه‌های اطراف ایراج\n• پشت بام خانه‌های بلند\n• بلندی‌های طبیعی (مثل تپه‌های قلعه قدیمی)\n• هر جایی که ارتفاع داشته باشد و بچه‌ها بتوانند از بالا شاش کنند\n\n🎯 **قوانین مسابقه:**\n\n**۱. انتخاب محل:**\nبچه‌ها به اتفاق به بالای یک تپه یا بلندی می‌رفتند. بهتر بود جای خلوت باشد تا کسی نبیند!\n\n**۲. آماده‌سازی:**\nکنار هم می‌ایستادند و لباس‌هایشان را آماده می‌کردند. یک علامت برای شروع تعیین می‌کردند مثل:\n• "سه، دو، یک، حالا!"\n• یک سوت یا فریاد\n• اشاره دست\n\n**۳. اجرا:**\nبا علامت شروع، همه همزمان شروع به شاشیدن می‌کردند. هر کس با تمام فشار، تلاش می‌کرد ادرار خود را دورتر پرتاب کند.\n\n**۴. اندازه‌گیری:**\nبعد از تمام شدن، همه به پایین نگاه می‌کردند و مسافت هر کس را تخمین می‌زدند. بعضی‌ها با قدم اندازه می‌گرفتند!\n\n**۵. تعیین برنده:**\nهر کس ادرارش مسافت بیشتری را طی کرده بود، برنده مسابقه بود. برنده با افتخار و خنده، جایزه (معمولاً تشویق و تحسین دیگران) را دریافت می‌کرد.\n\n🔬 **علم پشت این بازی:**\n\nشاید باورش سخت باشد، اما این بازی یک آزمایش فیزیک ساده بود!\n\n**عوامل مؤثر بر مسافت ادرار:**\n\n**۱. فشار مثانه:**\nهر چه مثانه پرتر باشد، فشار بیشتری برای خروج وجود دارد و ادرار دورتر می‌رود.\n\n**۲. قدرت عضلات:**\nعضلات کف لگن و شکم در قدرت پرتاب نقش دارند. بچه‌های قوی‌تر فشار بیشتری می‌توانستند وارد کنند.\n\n**۳. ارتفاع:**\nهر چه بالاتر می‌ایستادند، ادرار مسافت بیشتری طی می‌کرد (قانون جاذبه و سقوط آزاد).\n\n**۴. زاویه پرتاب:**\nبهترین زاویه برای پرتاب دور، حدود ۴۵ درجه است! بچه‌های باهوش این زاویه را پیدا می‌کردند.\n\n**۵. سرعت خروج:**\nسرعت بالاتر خروج ادرار، مسافت بیشتری ایجاد می‌کرد.\n\n😂 **لحظه‌های خنده‌دار:**\n\n• بعضی‌ها آنقدر فشار می‌آوردند که می‌افتادند!\n• بعضی‌ها وسط کار می‌خندیدند و کارشان نیمه‌کاره می‌ماند\n• بعضی‌ها مسیر ادرارشان کج می‌شد و به طرف دیگر می‌رفت\n• بعضی‌ها با باد مخالف، ادرارشان به خودشان برمی‌گشت!\n• بعضی‌ها ادعا می‌کردند رکورد جهانی دارند!\n\n😄 **خاطره‌بازی:**\n\nیکی از بزرگترهای ایراج با خنده تعریف می‌کند: "یادش بخیر، ما که جوون بودیم، کلی از این مسابقه‌ها داشتیم. بالای تپه‌های پشت قلعه می‌رفتیم و مسابقه می‌دادیم. بعضی‌ها آنقدر فشار می‌آوردند که صورتشان قرمز می‌شد! اون روزها خیلی ساده بودیم و از همین چیزهای کوچک کلی می‌خندیدیم."\n\n🧒 **گروه سنی:**\n\nاین بازی بیشتر برای:\n• پسرهای نوجوان (۱۲ تا ۱۶ ساله)\n• جوون‌های جوان (۱۶ تا ۲۰ ساله)\n• گاهی بچه‌های کوچک‌تر هم برای تفریح انجام می‌دادند\n\n🕵️ **مخفی‌کاری:**\n\nچون این بازی کمی خجالت‌آور بود، بچه‌ها معمولاً:\n• به جای خلوت می‌رفتند تا کسی نبیند\n• اگر کسی از دور می‌آمد، ناگهان همه می‌ایستادند\n• به کوچکترها می‌گفتند نگویند!\n\n🌟 **اهمیت این بازی در فرهنگ محلی:**\n\n• نشانه دوران ساده و بی‌آلایش گذشته بود\n• باعث می‌شد پسرها با هم رقابت کنند و دوست شوند\n• یک خاطره مشترک و خنده‌دار برای نسل قدیم ساخت\n• جنبه علمی ساده‌ای داشت (آشنایی با فشار، مسافت و زاویه)\n• حس رقابت و قدرت‌نمایی را در پسرها پرورش می‌داد',

  'history': 'این بازی در بسیاری از روستاهای ایران در گذشته رایج بوده. بچه‌ها و نوجوانان در فضای باز و با کمبود سرگرمی‌های مدرن، از هر چیزی می‌توانستند یک بازی بسازند. با تغییر سبک زندگی، افزایش امکانات تفریحی و تغییر فرهنگ عمومی، این بازی کمکم از بین رفت و امروزه دیگر دیده نمی‌شود. اما خاطراتش هنوز در میان نسل قدیم زنده است و گاهی با خنده از آن یاد می‌کنند.',

  'cultural_note': 'در فرهنگ‌های دیگر هم بازی‌های مشابهی وجود داشته:\n• **یونان باستان:** مسابقات پرتاب نیزه و سنگ، به نوعی نشانه قدرت بود\n• **اروپا:** در قرون وسطی، مسابقات شاشیدن در میان سربازان برای سرگرمی وجود داشته\n• **روسیه:** جوک‌های قدیمی درباره مسابقه شاشیدن بین مردان وجود دارد\n• **امریکای لاتین:** گاهی در جمع‌های مردانه به شوخی چنین مسابقاتی برگزار می‌شده',

  'color': Colors.lightBlue.shade600,
  'icon': Icons.water_damage,
  'images': [],
},
// 28. قاصدک (فوت کردن تخم قاصدک)
{
  'name': 'قاصدک (فوت کردن تخم قاصدک)',
  'type': 'بازی‌های کودکانه با گیاهان',
  'mechanism': 'دمیدن و پخش شدن تخم‌ها در باد',
  'description': 'یکی از لطیف‌ترین و رویایی‌ترین بازی‌های بچه‌های ایراج، بازی با قاصدک بود. وقتی گیاه قاصدک در فصل بهار و تابستان به مرحله تخم‌دهی می‌رسید، گل آن به یک توپ پف‌آلود و کرکی تبدیل می‌شد که بچه‌ها عاشق آن بودند. آنها این گل کرکی را می‌چیدند و با یک فوت، تخم‌های آن را به باد می‌سپردند و تماشا می‌کردند که چگونه در هوا پراکنده می‌شوند و به دوردست‌ها می‌روند.',
  'method': 'بچه‌ها در بهار و تابستان به دنبال گیاه قاصدک می‌گشتند که گل آن به مرحله تخم‌دهی رسیده باشد. وقتی یک قاصدک پیدا می‌کردند، آن را با دقت از ساقه جدا می‌کردند. سپس یک نفس عمیق می‌کشیدند و با یک فوت محکم، تخم‌های کرکی قاصدک را به هوا می‌فرستادند. تماشای پرواز تخم‌های سفید و کرکی در هوا، لحظه‌ای جادویی و شادی‌بخش برای بچه‌ها بود.',
  'details': '🌼 **قاصدک چیست؟**\n\nقاصدک گیاهی خودرو در بیابان‌ها، دشت‌ها و کنار جوی‌های آب است. این گیاه در فصل بهار و تابستان گل می‌دهد و پس از آن، گل آن به یک توپ کرکی سفید تبدیل می‌شود که هر کدام از کرک‌ها، یک دانه (تخم) قاصدک را حمل می‌کنند.\n\n🌸 **چرخه زندگی قاصدک:**\n\n**۱. گل زرد:** ابتدا گیاه قاصدک گل زرد زیبایی دارد\n**۲. تبدیل به کرک:** پس از مدتی، گل زرد تبدیل به یک توپ کرکی سفید می‌شود\n**۳. تخم‌ها:** هر کرک کوچک، یک دانه قاصدک را حمل می‌کند\n**۴. پراکندگی:** با وزش باد یا فوت کردن، تخم‌ها به هوا بلند می‌شوند و در جای جدید می‌افتند\n**۵. رشد مجدد:** تخم‌ها در جای جدید رشد می‌کنند و گیاه جدیدی می‌شوند\n\n💨 **روش بازی:**\n\n**۱. پیدا کردن قاصدک:**\nدر بهار و تابستان به دنبال قاصدک‌هایی بگردید که به مرحله کرکی سفید رسیده باشند.\n\n**۲. چیدن با دقت:**\nقاصدک را با دقت از ساقه بچینید تا کرک‌ها نریزند.\n\n**۳. آماده‌سازی:**\nقاصدک را در دست بگیرید و یک نفس عمیق بکشید.\n\n**۴. فوت کردن:**\nبا یک فوت محکم و ناگهانی، تخم‌های قاصدک را به هوا بفرستید.\n\n**۵. تماشا:**\nتماشا کنید که تخم‌های سفید و کرکی چگونه در هوا می‌رقصند و به دوردست‌ها می‌روند.\n\n😍 **لحظات جادویی:**\n\n• وقتی قاصدک را فوت می‌کنید، کرک‌های سفید مانند برف یا پرهای کوچک در هوا پخش می‌شوند\n• بعضی از کرک‌ها بلند می‌روند و بعضی نزدیک می‌افتند\n• زیر نور خورشید، کرک‌های قاصدک می‌درخشند و منظره‌ای زیبا ایجاد می‌کنند\n• بچه‌ها با ذوق و شوق فراوان، چندین قاصدک پشت سر هم فوت می‌کردند\n\n🎯 **رقابت بچه‌ها:**\n\nبچه‌ها گاهی با هم مسابقه می‌گذاشتند:\n• چه کسی می‌تواند قاصدک را با یک فوت کاملاً خالی کند؟\n• چه کسی می‌تواند تخم‌های قاصدک را دورتر بفرستد؟\n• چه کسی زیباترین پراکندگی را ایجاد می‌کند؟\n\n✨ **باورهای عامیانه درباره قاصدک:**\n\n• اگر قاصدک را فوت کنی و همه تخم‌هایش بروند، آرزویت برآورده می‌شود\n• قاصدک پیغام‌رسان عشق است و تخم‌هایش حامل عشق به معشوق هستند\n• شمارش کرک‌های باقی‌مانده روی قاصدک، نشان‌دهنده تعداد سال‌های انتظار است\n• در برخی فرهنگ‌ها، قاصدک را نماد امید و آرزو می‌دانند\n\n🌿 **قاصدک در فرهنگ کودکان:**\n\nبازی با قاصدک، یکی از ساده‌ترین و در عین حال لذت‌بخش‌ترین سرگرمی‌های کودکان در طبیعت است. این بازی:\n• کودکان را با طبیعت آشنا می‌کند\n• به آنها چرخه زندگی گیاهان را نشان می‌دهد\n• لحظات شاد و آرامش‌بخشی را برایشان رقم می‌زند\n• تخیل و رویاهای کودکانه را تقویت می‌کند\n\n😄 **خاطره‌بازی:**\n\nیکی از زنان ایراج تعریف می‌کند: "یادش بخیر، بهار که می‌شد، من و دوست‌هام می‌رفتیم دشت و دنبال قاصدک می‌گشتیم. هر کس که زودتر پیدا می‌کرد، ذوق می‌کرد. می‌نشستیم تو دشت و قاصدک‌ها رو فوت می‌کردیم. کرک‌های سفید تو هوا می‌رقصیدند و ما کلی می‌خندیدیم. بعضی‌ها باور داشتند اگر قاصدک رو فوت کنی و همه کرک‌هاش بره، آرزوت برآورده می‌شه..."\n\n🧠 **نکته علمی:**\n\nقاصدک یک گیاه هوشمند است. کرک‌های تخم قاصدک به گونه‌ای طراحی شده‌اند که با کوچکترین وزش باد، تخم‌ها از گیاه جدا شده و در هوا شناور می‌شوند. این مکانیسم به قاصدک کمک می‌کند تا تخم‌های خود را در فاصله‌های دور پخش کند و نسل خود را ادامه دهد. کرک‌های قاصدک مانند چترهای کوچکی عمل می‌کنند که تخم‌ها را به پرواز درمی‌آورند.',

  'history': 'بازی با قاصدک از دیرباز در تمام نقاط ایران و جهان رایج بوده است. کودکان از هزاران سال پیش با این گیاه بازی می‌کرده‌اند و آن را نماد امید و آرزو می‌دانسته‌اند. در ایران، این بازی در روستاها و شهرها رواج داشته و نسل به نسل منتقل شده است. با وجود تغییر سبک زندگی، هنوز هم بسیاری از کودکان این بازی را دوست دارند و در فصل بهار به دنبال قاصدک می‌گردند.',

  'cultural_note': 'بازی با قاصدک در فرهنگ‌های مختلف:\n• **اروپا:** کودکان قاصدک را فوت می‌کنند و آرزو می‌کنند\n• **آمریکا:** قاصدک را نماد رویاها و آرزوها می‌دانند\n• **ژاپن:** به قاصدک "تانپوپو" می‌گویند و کودکان با آن بازی می‌کنند\n• **ترکیه:** بچه‌ها با قاصدک بازی می‌کنند و برایش شعر می‌خوانند\n• **هند:** قاصدک را نماد عشق و وفاداری می‌دانند',

  'color': Colors.yellow.shade700,
  'icon': Icons.air,
  'images': [
    'assets/images/entertainments/dandelion_1.jpg',
    'assets/images/entertainments/dandelion_2.jpg',
  ],
},

// 29. علف داغی (گیاه تاول‌زا)
{
  'name': 'علف داغی (گیاه تاول‌زا)',
  'type': 'بازی‌های کودکانه با گیاهان',
  'mechanism': 'تماس با گیاه و ایجاد تاول',
  'description': 'در دشت‌های اطراف ایراج، گیاهی به نام «علف داغی» یا «داغی» می‌رویید که اگر دست کسی به آن برخورد می‌کرد، پوست دست داغ می‌شد و تاول می‌زد. این گیاه در زبان محلی به «داغی» معروف بود و مردم معتقد بودند که اگر دست به این گیاه بزنید، انگار که دستتان را به آتش گرفته‌اید و تاول می‌زند. بچه‌ها از این گیاه می‌ترسیدند و به هم هشدار می‌دادند که به آن دست نزنند. در برخی موارد، بچه‌های شیطان برای شوخی، برگ این گیاه را به دست دوستانشان می‌مالیدند تا دستشان تاول بزند!',
  'method': 'بچه‌ها در دشت و بیابان به دنبال علف داغی می‌گشتند. این گیاه را به دیگران نشان می‌دادند و به آنها هشدار می‌دادند که دست نزنند. گاهی بچه‌های شیطان، برگ این گیاه را به دست دوستانشان می‌مالیدند تا تاول بزند. پس از ایجاد تاول، از روش‌های سنتی مانند مالیدن خاک یا گذاشتن برگ کاهو روی تاول برای بهبود آن استفاده می‌کردند.',
  'details': '''
🌿 علف داغی چیست؟

علف داغی گیاهی خودرو در بیابان‌ها و دشت‌های اطراف ایراج است که در زبان محلی به آن «داغی» می‌گویند. این گیاه دارای برگ‌های سبز و کرک‌دار است که اگر به پوست برخورد کند، باعث ایجاد حساسیت، قرمزی و تاول می‌شود.

🔥 علت نامگذاری:

به این گیاه «داغی» می‌گویند چون تماس با آن مانند تماس با آتش (داغ) است و پوست را می‌سوزاند و تاول می‌زند.

⚠️ نکات مهم درباره علف داغی:

۱. حساسیت پوستی:
برگ‌های این گیاه حاوی ماده‌ای تحریک‌کننده است که با تماس با پوست، باعث واکنش آلرژیک می‌شود.

۲. علائم تماس:
• قرمزی و التهاب پوست
• خارش شدید
• ایجاد تاول‌های ریز و آب‌دار
• سوزش و درد

۳. زمان اوج:
این گیاه در فصل بهار و اوایل تابستان که رشد کامل دارد، بیشترین تأثیر را دارد.

😄 بازی و شوخی بچه‌ها:

• بچه‌ها به یکدیگر هشدار می‌دادند: «مواظب باش به داغی دست نزنی!»
• گاهی بچه‌های شیطان، برگ داغی را به دست دوستانشان می‌مالیدند تا تاول بزند
• بعضی‌ها برای شوخی، داغی را به دیگران نشان می‌دادند و می‌گفتند: «اینو ببین، دست نزن!»
• وقتی کسی تاول می‌زد، بقیه بچه‌ها می‌خندیدند و به او می‌گفتند: «گفتم دست نزن!»

🧠 درمان‌های سنتی برای تاول داغی:

۱. مالیدن خاک:
برخی معتقد بودند که مالیدن خاک نرم روی تاول، باعث خشک شدن و بهبود آن می‌شود.

۲. برگ کاهو:
گذاشتن برگ کاهو روی تاول، باعث خنک شدن و کاهش التهاب می‌شود.

۳. آب سرد:
شستن محل با آب سرد و خنک، باعث کاهش سوزش و التهاب می‌شود.

۴. صبر و حوصله:
معمولاً تاول‌های داغی بعد از چند روز خود به خود خوب می‌شوند.

📖 خاطره‌بازی:

یکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، بچگی‌ها تو دشت کلی داغی داشتیم. بزرگترها همیشه می‌گفتند به داغی دست نزنید. یک بار که شیطنت کردم و به داغی دست زدم، دستم تاول زد و کلی اذیت شدم. مادربزرگم برگ کاهو گذاشت روی دستم و گفت: 'دیگه به داغی دست نزن، می‌سوزونه!' از آن به بعد هر وقت داغی می‌دیدم، یاد آن روز می‌افتادم."

🌾 شناخت علف داغی در طبیعت:

• برگ‌های سبز و نسبتاً پهن دارد
• روی برگ‌ها کرک‌های ریزی دارد که باعث تحریک پوست می‌شود
• معمولاً در مناطق خشک و نیمه‌خشک می‌روید
• در فصل بهار و تابستان بیشتر دیده می‌شود

⚠️ نکته ایمنی:

• اگر به این گیاه دست زدید، سریعاً دست خود را با آب و صابون بشویید
• از خاراندن تاول خودداری کنید تا عفونت نکنند
• اگر تاول‌ها شدید بودند، به پزشک مراجعه کنید

🧠 نکته علمی:

علف داغی حاوی ترکیبات شیمیایی تحریک‌کننده پوست است که باعث آزاد شدن هیستامین در پوست می‌شود و واکنش آلرژیک ایجاد می‌کند. این واکنش باعث قرمزی، خارش و تاول می‌شود. این گیاه در طب سنتی برای درمان برخی بیماری‌های پوستی نیز استفاده می‌شده است، اما باید با احتیاط مصرف شود.
''',
  'history': 'علف داغی از دیرباز در ایراج و مناطق کویری شناخته شده بوده است. مردم محلی با خواص و خطرات این گیاه آشنا بودند و به کودکان خود هشدار می‌دادند که به آن دست نزنند. این گیاه بخشی از دانش بومی مردم در شناسایی گیاهان خطرناک و مفید بوده است.',
  'cultural_note': 'گیاهان تاول‌زا در بسیاری از فرهنگ‌ها شناخته شده‌اند:\n• اروپا: گیاه "گزنه" (Nettle) که تماس با آن باعث سوزش و تاول می‌شود\n• آمریکا: گیاه "سم‌بلوط" (Poison Ivy) که باعث حساسیت شدید پوستی می‌شود\n• هند: گیاهان مختلفی که باعث تحریک پوست می‌شوند\n• آفریقا: گیاهان بومی که در طب سنتی برای درمان استفاده می‌شوند',
  'color': Colors.red.shade700,
  'icon': Icons.local_florist,
  'images': [
    'assets/images/entertainments/daghi_1.jpg',
  ],
},
// 30. خرمن‌کوبی (کار و تلاش جمعی در فصل برداشت)
{
  'name': 'خرمن‌کوبی (کار و تلاش جمعی در فصل برداشت)',
  'type': 'بازی‌های دوران کار',
  'mechanism': 'کار گروهی و جداسازی گندم از کاه',
  'description': 'یکی از سخت‌ترین و در عین حال پرخاطره‌ترین کارهای فصل تابستان در ایراج قدیم، خرمن‌کوبی بود. پس از درو کردن گندم و جو با داس و انتقال آنها با الاغ به خرمن‌گاه، نوبت به خرمن‌کوبی می‌رسید. این کار با خرمن‌کوب (که در قدیم از گاو استفاده می‌کردند) انجام می‌شد تا کاه از گندم و جو جدا شود. روز خرمن‌کوبی روزی بسیار سخت و پرغبار بود و همه جوان‌ترها از گرد و غبار کاه فراری بودند، اما خاطراتش هنوز در ذهن نسل قدیم زنده است.',
  'method': 'پس از درو کردن گندم و جو با داس، محصول را روی لیف خرما می‌گذاشتند و با الاغ به خرمن‌گاه منتقل می‌کردند. سپس با خرمن‌کوب (که در قدیم از گاو استفاده می‌کردند) گندم‌ها را می‌کوبیدند تا کاه از دانه جدا شود. کاه را داخل چادرشب می‌ریختند و به کاهدون منتقل می‌کردند. گندم و جو را با وسیله‌ای به نام «قپون» اندازه‌گیری و محاسبه می‌کردند و سپس به منزل صاحب محصول منتقل می‌شد.',
  'details': '''
🌾 **مراحل خرمن‌کوبی در ایراج قدیم:**

**۱. درو کردن با داس:**
وقتی گندم و جو می‌رسید، کشاورزان با دست و با استفاده از داس، تمام محصول را درو می‌کردند. این کار چندین روز طول می‌کشید و نیاز به نیروی کار زیادی داشت.

**۲. انتقال با الاغ:**
گندم‌های درو شده را روی لیف خرما می‌گذاشتند و با الاغ به محلی به نام «خرمن‌گاه» منتقل می‌کردند.

**۳. خرمن‌کوبی:**
محصول را در خرمن‌گاه پهن می‌کردند. سپس با خرمن‌کوب (که در قدیم از گاو برای این کار استفاده می‌کردند) گندم‌ها را می‌کوبیدند تا کاه از دانه جدا شود.

**۴. جداسازی کاه:**
کاه را داخل چادرشب می‌ریختند و به کاهدون (محل نگهداری کاه) منتقل می‌کردند.

**۵. محاسبه با قپون:**
گندم و جو را با وسیله‌ای به نام «قپون» اندازه‌گیری و محاسبه می‌کردند.

**۶. انتقال به منزل:**
گندم و جو محاسبه شده را به منزل صاحب محصول منتقل می‌کردند.

🔥 **سختی‌های خرمن‌کوبی:**

• **گرد و غبار کاه:** وقتی خرمن را می‌کوبیدند، گرد کاه در هوا پخش می‌شد و تنفس را سخت می‌کرد
• **گرمای شدید:** خرمن‌کوبی معمولاً در تابستان و در گرمای سوزان انجام می‌شد
• **سختی کار:** این کار نیاز به نیروی بدنی زیادی داشت و بسیار خسته‌کننده بود
• **زمان طولانی:** چندین روز طول می‌کشید تا همه خرمن‌ها کوبیده شوند

😄 **خاطره‌بازی:**

یکی از بزرگترهای ایراج تعریف می‌کند: "یادش بخیر، روز خرمن‌کوبی که می‌شد، همه جوان‌ترها از گرد کاه فرار می‌کردند. هر کسی یک بهانه می‌آورد که نرود! اما وقتی می‌رفتیم، با هم همکاری می‌کردیم و کار را پیش می‌بردیم. بعد از اتمام کار، کلی خسته بودیم ولی خاطرات خوبی ساخته بودیم."

📖 **قپون چیست؟**

قپون وسیله‌ای سنتی برای اندازه‌گیری غلات بود که از فلز ساخته می‌شد و حجم مشخصی از گندم یا جو را نشان می‌داد. کشاورزان با استفاده از قپون، محصول خود را محاسبه می‌کردند.

🐂 **از گاو تا تراکتور:**

در قدیم‌ترین زمان‌ها، از گاو برای خرمن‌کوبی استفاده می‌کردند. گاوها را روی خرمن می‌چرخاندند تا با سم‌های خود، گندم را از کاه جدا کنند. بعدها از خرمن‌کوب‌های مکانیکی استفاده شد و امروزه از کمباین برای برداشت و جداسازی همزمان استفاده می‌شود.
''',
  'history': 'خرمن‌کوبی یکی از قدیمی‌ترین روش‌های جداسازی دانه از کاه در کشاورزی ایران بوده است. این روش از دوران باستان تا چند دهه پیش در روستاهای ایران رواج داشت و بخش مهمی از زندگی کشاورزان را تشکیل می‌داد. با ورود ماشین‌آلات کشاورزی مدرن، این روش کمکم کنار رفت و امروزه دیگر خبری از آن روزهای پرغبار و سخت نیست.',
  'cultural_note': 'روش‌های مشابه خرمن‌کوبی در فرهنگ‌های دیگر:\n• **اروپا:** استفاده از گاو و اسب برای خرمن‌کوبی در قرون وسطی\n• **هند:** استفاده از گاو برای کوبیدن گندم در روستاها\n• **آفریقا:** روش‌های سنتی کوبیدن غلات با چوب‌های مخصوص\n• **آمریکای جنوبی:** استفاده از حیوانات برای جداسازی دانه از کاه',
  'color': Colors.orange.shade700,
  'icon': Icons.agriculture,
  'images': [
    'assets/images/entertainments/kharman_1.jpg',
    'assets/images/entertainments/kharman_2.jpg',
  ],


},

// 31. استقبال از گله (همراهی بزغاله‌ها و کره‌ها به خانه)
{
  'name': 'استقبال از گله (همراهی بزغاله‌ها و کره‌ها به خانه)',
  'type': 'بازی‌های دوران کار',
  'mechanism': 'همراهی و هدایت دام‌های تازه‌متولدشده به منزل',
  'description': 'یکی از زیباترین و مسئولیت‌پذیرترین سرگرمی‌های بچه‌های ایراج در فصل بهار، استقبال از گله در نزدیکی غروب آفتاب بود. بچه‌ها به همراه تعدادی از بزرگترها، هر روز عصر به محلی به نام «کتل گله» و ابتدای روستا می‌رفتند تا بزغاله‌ها، کره‌ها و بره‌هایی را که تازه متولد شده بودند و هنوز راه خانه خود را بلد نبودند، به منزل صاحبشان هدایت کنند. این کار اگر انجام نمی‌شد، دام‌های کوچک در شلوغی گله راه خود را گم می‌کردند و چه بسا شب را سرگردان می‌ماندند یا طعمه حیوانات درنده می‌شدند.',
  'method': 'هر روز عصر، نزدیک غروب آفتاب، بچه‌ها و بزرگترها به محل «کتل گله» در ابتدای روستا می‌رفتند. گله‌ای که از صبح زود برای چرا به بیابان رفته بود، کم‌کم برمی‌گشت. بچه‌ها با دقت به دنبال دام‌های خود می‌گشتند که معمولاً با نشانه‌هایی مثل پارچه‌های دوخته شده روی پشت یا رنگ‌های خاص روی پشم شناسایی می‌شدند. سپس بزغاله‌ها، بره‌ها و کره‌های تازه‌متولدشده را از میان گله جدا می‌کردند و با خود تا خانه همراهی می‌نمودند. اگر گله به هم می‌ریخت (اصطلاحاً «بُر» می‌کرد)، بچه‌ها و بزرگترها تا شب به دنبال دام‌های گم‌شده می‌گشتند.',
  'details': '''
🐑 **استقبال از گله؛ یک آیین روزانه در ایراج**

در فصل بهار که دام‌ها تازه زایمان کرده بودند، هر روز عصر یکی از پرماجراترین و شیرین‌ترین کارهای بچه‌های ایراج آغاز می‌شد: رفتن به استقبال گله!

---

**🌅 زمان و مکان:**

• **زمان:** هر روز عصر، نزدیک غروب آفتاب
• **مکان:** محلی به نام «کتل گله» در ابتدای روستای ایراج

بچه‌ها و تعدادی از بزرگترها، پیش از بازگشت گله به این محل می‌رفتند و منتظر می‌ماندند تا گله از بیابان برگردد.

---

**🐏 چرا این کار ضروری بود؟**

• بزغاله‌ها، بره‌ها و کره‌هایی که تازه متولد شده بودند، هنوز مسیر خانه خود را بلد نبودند
• در شلوغی گله، ممکن بود به اشتباه به خانه دیگران بروند
• اگر بچه‌ها به استقبالشان نمی‌رفتند، باید ساعت‌ها در خانه‌های مردم دنبالشان می‌گشتند
• خطر حمله حیوانات درنده در شب، تهدیدی جدی برای دام‌های سرگردان بود

---

**🎯 روش شناسایی دام‌ها:**

هر خانواده برای شناسایی دام‌های خود، روش‌های خاصی داشت:

• **پارچه روی پشت:** یک تکه پارچه رنگی به پشت دام می‌دوختند
• **رنگ کردن پشم:** قسمتی از پشم یا موی دام را با رنگ خاصی علامت‌گذاری می‌کردند
• **بریدگی گوش:** در برخی موارد، گوش دام را به شکل خاصی می‌بریدند
• **زنگوله:** به گردن بعضی از دام‌ها زنگوله می‌بستند

---

**🐾 ماجراهای استقبال از گله:**

**۱. روزهای عادی:**
بچه‌ها با دقت به دنبال دام‌های خود در میان گله می‌گشتند. هر کس دام خود را پیدا می‌کرد، با خوشحالی آن را از گله جدا می‌کرد و به سمت خانه هدایت می‌نمود.

**۲. روزهای شلوغ (عروسی و مهمانی):**
اگر در روستا عروسی یا مهمانی بود و ماشین‌ها در میان گله رفت‌آمد می‌کردند، گله می‌ترسید و به هم می‌ریخت. در این مواقع، اصطلاحاً می‌گفتند «گله بُر کرده است». یعنی گوسفندها و بزها مسیر خود را گم کرده بودند و هر کدام به سمتی می‌رفتند.

**۳. بعد از بر کردن گله:**
• بچه‌ها و بزرگترها تا شب به دنبال دام‌های گم‌شده می‌گشتند
• هر کس دام گم‌شده‌ای پیدا می‌کرد، به صاحبش خبر می‌داد
• گاهی تا پاسی از شب، صدای «بَ، بَ» گوسفندها در کوچه‌های روستا شنیده می‌شد
• صبح روز بعد، هنوز بعضی از دام‌ها پیدا نشده بودند و جستجو ادامه داشت

---

😄 **خاطره‌بازی:**

یکی از بزرگترهای ایراج تعریف می‌کند:
"یادش بخیر، ما که بچه بودیم، هر روز عصر می‌رفتیم کتل گله. ذوق داشتیم ببینیم بزغاله‌های جدید کدام‌اند. بعضی از بچه‌ها با بزغاله‌هایشان بازی می‌کردند و تا خانه همراهشان می‌شدند. یک روز که عروسی بود، ماشین‌ها گله را ترساندند و همه گوسفندها پخش شدند. تا شب دنبالشان گشتیم. یکی از گوسفندها رفته بود توی باغ همسایه و توی سبزی‌جاتش ریخته بود! کلی دعوا شد، ولی فردا دوباره همه رفته بودیم سراغ گله..."

---

🐺 **خطرات شبانه:**

• اگر دام‌ها شب را بیرون از آغل می‌ماندند، در خطر حمله گرگ‌ها و شغال‌ها بودند
• شب‌های بهار، هوای سرد هم برای بره‌های تازه‌متولدشده خطرناک بود
• به همین خاطر، پیدا کردن همه دام‌ها قبل از تاریکی کامل، حیاتی بود

---

🌟 **اهمیت این رسم:**

• آموزش مسئولیت‌پذیری به کودکان از سنین پایین
• تقویت حس همکاری و کار گروهی
• آشنایی کودکان با دام‌داری و چرخه زندگی
• ایجاد پیوند عاطفی بین کودکان و حیوانات
• حفظ نظم و امنیت گله در روستا
• انتقال دانش و تجربه از بزرگترها به کودکان

---

📖 **اصطلاحات محلی:**

• **کتل گله:** محل مشخصی در ابتدای روستا که گله از آنجا وارد می‌شد
• **بُر کردن گله:** پراکنده شدن و گم کردن مسیر توسط دام‌ها
• **بزغاله:** بز کوچک و تازه‌متولدشده
• **بره:** گوسفند کوچک و تازه‌متولدشده
''',
  'history': 'استقبال از گله یکی از رسوم دیرینه در روستاهای ایران، به ویژه مناطق دام‌داری، بوده است. در ایراج نیز این رسم از نسل‌های گذشته به یادگار مانده و بخشی از فرهنگ و هویت روستا را تشکیل می‌داده است. با تغییر سبک زندگی و کاهش دام‌داری سنتی، این رسم زیبا و پرمعنا نیز کمکم در حال فراموشی است، اما خاطرات آن همچنان در دل نسل قدیم زنده است.',
  'cultural_note': 'رسم استقبال از گله در فرهنگ‌های مختلف:\n• **مغولستان:** کودکان سوار بر اسب به استقبال گله می‌روند\n• **آفریقا:** قبیله ماسای، کودکان به همراه بزرگترها گله را هدایت می‌کنند\n• **هند:** در روستاهای پنجاب، کودکان به استقبال گاوها می‌روند\n• **ترکیه:** در مناطق عشایری، کودکان نقش مهمی در هدایت گله دارند\n• **اروپا:** در آلپ، کودکان به همراه چوپان‌ها گله را به آغل هدایت می‌کنند',
  'color': Colors.green.shade800,
  'icon': Icons.pets,
  'images': [
    'assets/images/entertainments/flock_welcome_1.jpg',
    'assets/images/entertainments/flock_welcome_2.jpg',
    'assets/images/entertainments/flock_welcome_3.jpg',
    'assets/images/entertainments/flock_welcome_4.jpg',
  ],
},
];