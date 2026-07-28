import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KidsStoriesPage extends StatefulWidget {
  const KidsStoriesPage({super.key});

  @override
  State<KidsStoriesPage> createState() => _KidsStoriesPageState();
}

class _KidsStoriesPageState extends State<KidsStoriesPage> {
  // متن جستجو
  String _searchText = "";
  
  // نوع دسته‌بندی انتخاب شده
  String _selectedCategory = "همه";

  // لیست دسته‌بندی‌ها
  final List<String> _categories = [
  "همه",
  "قصه‌های حیوانات",
  "قصه‌های پندآموز",
  "فرهنگ و دانش بومی سنتی مردم",
  "قصه‌های تخیلی",
  "شعرهای کودکانه",
  "لالایی‌ها",
  "قصه‌های شب",
  "داستان‌های دفاع مقدس",
  "داستان‌های کوتاه و تأمل‌برانگیز",
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
  List<Map<String, dynamic>> _filterStories() {
    List<Map<String, dynamic>> categoryFiltered = _selectedCategory == "همه"
        ? kidsStories
        : kidsStories.where((item) {
            return item['type'] == _selectedCategory;
          }).toList();

    if (_searchText.isEmpty) return categoryFiltered;

    final normalizedQuery = _normalizeText(_searchText);

    return categoryFiltered.where((item) {
      return _normalizeText(item['name']).contains(normalizedQuery) ||
          _normalizeText(item['description']).contains(normalizedQuery) ||
          _normalizeText(item['story']).contains(normalizedQuery) ||
          _normalizeText(item['moral'] ?? "").contains(normalizedQuery) ||
          (item['type'] as String).contains(normalizedQuery);
    }).toList();
  }

  // رنگ پس‌زمینه بر اساس نوع قصه
  Color _getCategoryColor(String type) {
    switch (type) {
      case "قصه‌های حیوانات":
        return Colors.orange.shade50;
      case "قصه‌های پندآموز":
        return Colors.green.shade50;
      case "فرهنگ و دانش بومی سنتی مردم":
        return Colors.amber.shade50;
      case "قصه‌های تخیلی":
        return Colors.purple.shade50;
      case "شعرهای کودکانه":
        return Colors.pink.shade50;
      case "لالایی‌ها":
        return Colors.blue.shade50;
      case "قصه‌های شب":
        return Colors.indigo.shade50;
      case "داستان‌های دفاع مقدس":
        return Colors.red.shade50;
      case "داستان‌های کوتاه و تأمل‌برانگیز":
       return Colors.deepPurple.shade50;
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

  // تابع کپی کردن متن داستان
  void _copyStoryToClipboard(String storyText, String storyName) {
    Clipboard.setData(ClipboardData(text: storyText)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '📋 داستان "$storyName" در حافظه کپی شد!',
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontFamily: 'Vazirmatn'),
          ),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '❌ خطا در کپی کردن داستان!',
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontFamily: 'Vazirmatn'),
          ),
          backgroundColor: Colors.red.shade700,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    });
  }

  // نشانگر نوع قصه
  Widget _buildTypeChip(String type) {
    Color chipColor;
    switch (type) {
      case "قصه‌های حیوانات":
        chipColor = Colors.orange;
        break;
      case "قصه‌های پندآموز":
        chipColor = Colors.green;
        break;
      case "فرهنگ و دانش بومی سنتی مردم":
        chipColor = Colors.amber;
        break;
      case "قصه‌های تخیلی":
        chipColor = Colors.purple;
        break;
      case "شعرهای کودکانه":
        chipColor = Colors.pink;
        break;
      case "لالایی‌ها":
        chipColor = Colors.blue;
        break;
      case "قصه‌های شب":
        chipColor = Colors.indigo;
        break;
      case "داستان‌های دفاع مقدس":
        chipColor = Colors.red;
        break;
      case "داستان‌های کوتاه و تأمل‌برانگیز":
      chipColor = Colors.deepPurple;
       break;
      default:
        chipColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor.withOpacity(0.5)),
      ),
      child: Text(
        type,
        style: TextStyle(
          fontSize: 12,
          color: _darken(chipColor, 0.7),
          fontFamily: 'Vazirmatn',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filterStories();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'قصه‌ها و شعرهای کودکانه',
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade300,
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
                hintText: 'جستجو در قصه‌ها...',
                hintStyle: const TextStyle(fontFamily: 'Vazirmatn'),
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
                        fontFamily: 'Vazirmatn',
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
                    selectedColor: Colors.pink.shade400,
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
                    fontFamily: 'Vazirmatn',
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),

          // لیست قصه‌ها با ExpansionTile
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final Color headerColor = _getCategoryColor(item['type'] as String);

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
                          item['icon'] as IconData,
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
                                fontFamily: 'Vazirmatn',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 6),
                            _buildTypeChip(item['type'] as String),
                          ],
                        ),
                        children: [
                          _buildStoryContent(item, context),
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

  // محتوای داخلی ExpansionTile برای قصه‌ها
  Widget _buildStoryContent(Map<String, dynamic> item, BuildContext context) {
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
          // داستان
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // هدر با عنوان و دکمه کپی
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.menu_book, color: Colors.brown.shade600, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '📖 داستان',
                          style: TextStyle(
                            fontFamily: 'Vazirmatn',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade700,
                          ),
                        ),
                      ],
                    ),
                    // دکمه کپی
                    Tooltip(
                      message: 'کپی داستان',
                      child: InkWell(
                        onTap: () {
                          _copyStoryToClipboard(
                            item['story'] as String,
                            item['name'] as String,
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blue.shade200,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.copy,
                                size: 16,
                                color: Colors.blue.shade700,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'کپی',
                                style: TextStyle(
                                  fontFamily: 'Vazirmatn',
                                  fontSize: 12,
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(height: 2, width: 50, color: Colors.brown.shade200),
                const SizedBox(height: 12),
                Text(
                  item['story'] as String,
                  style: const TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 15,
                    height: 1.8,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          // بخش پند اخلاقی (اگر وجود داشته باشد)
          if (item.containsKey('moral') && (item['moral'] as String).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber.shade800),
                            const SizedBox(width: 8),
                            Text(
                              '💡 پند اخلاقی',
                              style: TextStyle(
                                fontFamily: 'Vazirmatn',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                        // دکمه کپی برای پند اخلاقی
                        Tooltip(
                          message: 'کپی پند اخلاقی',
                          child: InkWell(
                            onTap: () {
                              _copyStoryToClipboard(
                                item['moral'] as String,
                                'پند اخلاقی ${item['name']}',
                              );
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.amber.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.copy,
                                    size: 14,
                                    color: Colors.amber.shade800,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'کپی',
                                    style: TextStyle(
                                      fontFamily: 'Vazirmatn',
                                      fontSize: 11,
                                      color: Colors.amber.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['moral'] as String,
                      style: const TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 14,
                        height: 1.6,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.justify,
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


// -------------------- دیتای کامل قصه‌های کودکانه --------------------
final List<Map<String, dynamic>> kidsStories = [
  // 1. کاکل زری، دندون مروارید
  {
    'name': 'کاکل زری، دندون مروارید',
    'type': 'فرهنگ و دانش بومی سنتی مردم',  // دسته جدید
    'description': 'داستان سه دختر و زن بابا و ماجراهایی که برایشان پیش می‌آید',
    'story': 'در زمانهای قدیم سه دختر بودند که زن پدر داشتند. یک روز زن بابا به آنها گفت "می‌خوابیم حلوا درست کنیم هر که بیشتر کار کنه ته دیگ حلوا را به اون می‌دیم". هرکدام از دخترها کاری کردند، آخر که حلوا پخته شد توی یک سینی بزرگ ریختند ولی ته دیگ را زن بابا خورد و به دخترها نداد. دخترها وقتی که زن بابا از خانه رفت بیرون گفتند باید تلافی دربیاریم، همه حلواها را خوردند و وقتی پدرشان از صحرا برگشت زنش گفت: امروز حلوا پختیم بیارم یه کم هم تو بخور. وقتی سینی حلوا را آورد مرد دید خالی است. زن گفت این کار دختراست و اینجا یا جای منه یا جای دخترها. مرد گفت الان دخترها را می‌برم بیابان ولشان می‌کنم. دخترها را برد بیابان و به آنها گفت: من می‌رم دستشویی و زود برمی‌گردم. دخترها منتظر پدر ماندند ولی پدرشان نیامد، وقتی رفتند اطراف را گشتند دیدند پدر نیست و آنها هم راه خانه را بلد نبودند زیر یک درخت نشستند تا اینکه شب شد. داشتند با هم صحبت می‌کردند. دختر بزرگ گفت: اگر من را پسر پادشاه بگیره لباس همه قشون پادشاه را می‌دوزم. دختر دوم گفت: اگر من را پسر پادشاه بگیره برای همه سپاه پادشاه نان می‌پزم. دختر کوچک گفت: اگر من را پسر پادشاه بگیره، یه دختر دندون مرواری با یک پسر کاکل زری براش به دنیا می‌آرم...\n\n... سه تا از پسرهای پادشاه که به شکار رفته بودند صدایشان را شنیدند و آنها را با خود به شهر بردند و شهر را آینه‌بندان کردند و هر کدام با یکی از دخترها عروسی کردند. دختر بزرگی یک لباس دوخت پر از سوزن کرد هر کدام از سربازان می‌پوشیدند سوراخ سوراخ می‌شدند و سریع لباس را در می‌آوردند. پسر پادشاه این دختر را طلاق داد.\n\nدختر دوم که قول داده بود نان بپزد خمیر را شور کرده بود سربازان پادشاه هر لقمه نان را که خوردند شور بود و از دهنشان بیرون انداختند. پسر پادشاه دختر دوم را هم طلاق داد و ماند دختر کوچک. دختر کوچک زایید و یک دختر دندون مرواری با یک پسر کاکل زری به دنیا آورد. خواهرهایش که خیلی حسود بودند زود بچه‌ها را برداشتند و بردند و به جای آنها دو تا توله سگ گذاشتند. پسر پادشاه که از شکار برگشت بهش گفتند که زنت زاییده و دو تا توله سگ به دنیا آورده. ناراحت شد و گفت: زنی که توله سگ بیاره باید ببرندش جلوی دروازه شهر به گچ بگیرند. زن هرچه التماس کرد که این حرفها دروغه و من بچه دندون مرواری و کاکل زری آوردم شوهرش قبول نکرد...\n\nخواهرهای زن بچه‌ها را بردند توی یکی از خرابه‌های کنار شهر گذاشتند. از قضا یک گوسفند بود که مال یک پیرزن بود هر روز می‌رفت توی خرابه و به بچه‌ها شیر می‌داد و آنها بزرگ می‌شدند. پیرزن دید که هر روز که بزش می‌آید شیر ندارد. رفت به چوپان گله گفت که شیر بز من را تو می‌دوشی. هرچی چوپان گفت من نمی‌دوشم پیرزن قبول نکرد. چوپان گفت خودت همراه گله بیا ببین که بزت کجا می‌ره. پیرزن با گله رفت، دید که بزش رفت توی خرابه و دو تا بچه شیرش را خوردند. پیرزن بچه‌ها را به خونه آورد. هر وقت که بی‌پول می‌شد یک نیشگون به دختر می‌گرفت گریه می‌کرد و دختر که دندان‌هایش مروارید بود اشک‌هایش هم مروارید می‌شد آنها را جمع می‌کرد می‌برد می‌فروخت و موهای پسر را هم می‌چید و می‌فروخت تا اینکه بچه‌ها بزرگ شدند و هر روز می‌رفتند دم دروازه با بچه‌های دیگر بازی می‌کردند و به زن پسر پادشاه که تو گچ بود سنگ می‌زدند و این بچه‌ها نمی‌دانستند که این زن، مادرشان است. یک روز پسر پادشاه از زنش پرسید اینقدر بچه‌ها به تو سنگ می‌زنند دردت هم میاد؟ گفت: نه، فقط یک دختر و پسر هستند که وقتی سنگ می‌زنند دردم میاد!\n\nبچه‌ها بزرگ و بزرگتر شدند و برای خودشان قصری ساختند. خاله‌هاشون فهمیدند که این‌ها همان بچه‌ها هستند با خود گفتند هرجوری شده باید آنها را از بین ببریم. گفتند می‌ریم بهشون می‌گیم که خونه شما خیلی قشنگه فقط یه اسب چهل کُرّه می‌خواهد. وقتی اونها می‌رن اسب را بگیرن اسب اونها را لگد می‌زنه و می‌میرن. خاله‌ها رفتند به پسر کاکل زری گفتند: خونه شما اسب چهل کره می‌خواد. پسره آمد به خواهرش گفت: این زن گفته خونه شما اسب چهل کره می‌خواد. خواهرش گفت یه کم شکر بردار برو لب چشمه، وقتی اسب اومد آب بخوره یک مشت شکر بریز توی آب. اسب می‌گه چه آب شیرینی! تو هم بهش می‌گی بیا پالانت کنم، میاد. باز یک مشت دیگه شکر می‌ریزی تو آب می‌گه چه آب شیرینی، می‌گی: بیا زینت کنم و سوارت بشم و این کار را می‌کنی. وقتی سوارش شدی یک نعره می‌زنه چهل کره از زیر بوته‌ها بیرون میان. کاکل زری این کارها را کرد و اسب چهل کره را به خانه آورد.\n\nخاله‌ها دیدند که بچه‌ها باز هم سالم هستند. گفتند: خونه شما انار چهل غنچه می‌خواد. هرکس که به دنبال انار چهل غنچه می‌رفت دیو او را می‌کشت چون زیر درخت انار چهل غنچه دیو خوابیده بود. پسر کاکل زری اومد ماجرا را به خواهرش گفت. خواهرش گفت: می‌ری سوار اسب می‌شی به باد می‌گی "سالم راه انار چهل غنچه از کدوم وره" نشونت می‌ده، می‌رسی به در می‌گی "راه انار چهل غنچه از کدوم وره" به کلیدون می‌رسی می‌گی "راه انار چهل غنچه از کدوم وره" همه نشونت می‌دن، می‌ری انار را می‌چینی و میایی. کاکل زری سوار اسب شد و رفت و از همه نشانی‌ها را پرسید تا اینکه رسید به کلیدون سلام کرد و در باز شد. رفت توی باغ دید زیر درخت انار، دیو خوابیده. یواش یواش رفت انار را چید و سوار بر اسب شد. یک دفعه دیو از خواب بیدار شد گفت: کلیدون، در را قفل کن نذار بره. کلیدون گفت: بره مال خودشه. دیو گفت: در، بسته شو نذار بره، گفت: بره مال خودشه. دیو گفت: باد بگیرش. گفت: بره مال خودشه. اومد رسید به خونه، به خاله‌ها گفت: انار چهل غنچه آوردم.\n\nخاله‌ها دیدند هیچ بلایی نمی‌توانند سر این بچه بیارند، گفتند: خونه شما "ماه دخترون" می‌خواد. هر کس می‌رفت ماه دخترون را بیاره سنگ سیاه می‌شد. کاکل زری اومد به خواهرش گفت: این زنه می‌گه خونه شما ماه دخترون می‌خواد. دندون مرواری گفت: می‌ری سوار بر اسب می‌شی پای کوه ماه دخترون می‌گی: ماه دخترون پای اسبم سیاه شد، ماه دخترون اسبم سیاه شد، ماه دخترون خودم و اسبم سیاه شدیم، اون موقع ماه دخترون میاد بیرون. کاکل زری اومد پای کوه دید اونجا پر از سنگ سیاهه، فهمید اینها آدم‌هایی بودن که اومدن ماه دخترون را ببینن که سنگ سیاه شدن. کاکل زری کارهایی را که خواهرش گفت کرد تا اینکه دید ماه دخترون از وسط کوه بیرون اومد. کاکل زری او را سوار بر اسب کرد و به خانه اومد.\n\nخاله‌ها دیدند بازهم این بچه‌ها سالم هستند. اومدند به پسر پادشاه (که همان پدر بچه‌ها بود) گفتند: یه دختر و پسر هستند که خیلی ثروتمندند و توی خانه‌شان اسب چهل کره دارن، انار چهل غنچه دارن، ماه دخترون دارن.... اگر اینها را نکشی پادشاه می‌شن. پسر پادشاه گفت امشب آنها را دعوت می‌کنم و در غذایشان زهر می‌ریزم. رفتند آنها را دعوت کردند. دندون مرواری به کاکل زری گفت: امشب وقتی رفتی مهمانی یک کلاه سرت بذار که آنها ندونن موهای تو زری است و یک چوب با یک کاسه بر می‌داری وقتی سفره پهن شد می‌گن: بسم‌الله، تو می‌گی: چوب و کاسه و بسم‌الله. دست به غذا نمی‌زنی چون زهر توش کردن. باز می‌گن بسم‌الله، و تو حرف قبلی را می‌زنی. رفتن مهمانی، سفره پهن شد. پسر شاه گفت: بسم‌الله، کاکل زری گفت: چوب و کاسه و بسم‌الله. پسر شاه ناراحت شد، گفت: پسره نمی‌فهمم چوب و کاسه هم مگه شام می‌خورن؟ کاکل زری گفت: مگه نمی‌فهمی مگه آدم هم توله سگ به دنیا میاره؟ بعد کلاهش را برداشت. پسر پادشاه دید که کاکلش زری است! دندون مرواری هم خندید، پسر پادشاه دید که دندانش مروارید است و فهمید که خواهرهای زنش دروغ گفتند... دستور داد آنها را به دم اسب بادپا ببندند و توی صحرا روی زمین بکشند تا تکه تکه شوند. بعد مادرشان را هم از توی گچ درآوردند و به قصر آوردند و با هم زندگی کردند.',
    'moral': 'حسادت کار دست آدم می‌دهد و در نهایت حقیقت آشکار می‌شود',
    'color': Colors.amber,
    'icon': Icons.auto_stories,
    'image': '',
  },

  // 2. نمکو
  {
    'name': 'نمکو',
    'type': 'فرهنگ و دانش بومی سنتی مردم',  // دسته جدید
    'description': 'داستان دختری که با هوشمندی از چنگ دیو فرار کرد',
    'story': 'یک مرد و زن بودند که هفت تا دختر داشتند و خانه‌شان هشت در داشت، هر شب نوبت یکی از دخترها بود که درها را ببندد و اگر یکی از درها را نمی‌بست دیو به خانه آنها می‌آمد و آنها را می‌برد. یک شب که نوبت نمکو بود مادرش گفت: برو همه درها را ببند، نمکو همه درها را بست اما یک در را یادش رفت ببندد. شب داشتند چرخ می‌ریسیدند که دیدند دیو آمد توی خانه‌شان. دیو گفت: بریسید و بریسید ماه دودان / بیارید یک چایی بهر مهمان. مادر و خواهرهای نمکو گفتند: هفت در را بستی نمکو یک در را نبستی نمکو کور شو برو چایی بهش بده. نمکو گریه‌کنان رفت و دیو را چایی داد. دوباره دیو گفت: بریسید و بریسید ماه دودان / بیارید یک شامی بهر مهمان. خواهرهایش گفتند: هفت در را بستی نمکو یک در را نبستی نمکو کور شو برو شامش بده. نمکو رفت دیو را شام داد. بعد دیو همدم خواست. خواهرهایش گفتند: هفت در را بستی نمکو یک در را نبستی نمکو کور شو برو همدمش باش. نمکو هم رفت و تو اتاق دیو خوابید. نصف شب دیو نمکو را برداشت و توی توبره گذاشت و پشت گرفت و رفت.\n\nنمکو در راه فکری به سرش زد به دیو گفت: دستشویی دارم، دیو نمکو را از توبره بیرون آورد، نمکو هم وقتی دیو حواسش نبود توبره را پر از سنگ کرد و خودش فرار کرد. دیو توبره را برداشت همینطور که می‌رفت گفت: نمکو اینقدر خودت را سنگین نکن. ولی صدایی نیامد توی توبره را نگاه کرد دید پر از سنگ است. برگشت و رفت و نمکو را پیدا کرد. او را در توبره گذاشت و راه افتاد. دوباره نمکو گفت: دستشویی دارم. دیو توبره را زمین گذاشت و نمکو را بیرون آورد. نمکو این بار توبره را پر از خار کرد و خودش فرار کرد. دوباره دیو به راه افتاد و دید که توبره سیخ می‌زند. گفت نمکو اینقدر سیخ نزن. دید صدایی نیامد نگاه کرد دید توبره پر از خار است. برگشت و نمکو را پیدا کرد و توی توبره گذاشت تا اینکه رسید به خانه‌اش. به نمکو گفت: من می‌رم شکار اگر اومدم و دیدم که آب حوض لجن بسته تو را به چنگه دار می‌زنم. نمکو ترسید و دید چندتا دختر دیگر را هم به چنگه دار زده. دیو رفت بیرون. نمکو رفت دستاشو بشوره تا دست توی حوض برد دید آب حوض لجن بسته. با خودش گفت حالا چه کار کنم الان دیو میاد و مرا هم دار می‌زنه. یه فکری کرد و رفت مقداری نمک و سوزن و کبریت و پر مرغ برداشت و دخترهایی را هم که آویزان بودند آزاد کرد و خودش هم فرار کرد. همینطور که فرار می‌کرد دیو را دید که دنبالش می‌دود با خود گفت الان مرا می‌گیرد کبریت را روشن کرد و انداخت جلو پای دیو، پای دیو می‌سوخت ولی دنبال نمکو می‌دوید. دوباره نمکو نگاه کرد دید دیو دارد به او می‌رسد سوزن را انداخت زیر پای دیو و سوزن توی پای دیو رفت بازهم دنبال نمکو می‌دوید و بعد نمکو نمک‌ها را ریخت و پای سوخته و زخمی دیو پر از نمک و دردش بیشتر شد ولی نمکو دید باز هم دیو دارد دنبالش می‌آید. این بار پر را انداخت، نمکو بال در آورد و پرواز کرد و رفت خانه‌شان دید پدر و مادر و خواهرهایش از غصه نمکو کور شده‌اند. نمکو پرش را به چشم مادر و پدر و خواهرهایش کشید چشمشون روشن شد و دیو هم که پاهایش سوخته بود مرد و همه از دست دیو راحت شدند.',
    'moral': 'هوش و ذکاوت می‌تواند آدمی را از خطرات نجات دهد',
    'color': Colors.amber,
    'icon': Icons.auto_stories,
    'image': '',
  },

  // 3. روباه پوستین‌دوز
  {
    'name': 'روباه پوستین‌دوز',
    'type': 'قصه‌های حیوانات',
    'description': 'داستان روباه مکار و مزرعه‌دار ساده‌لوح',
    'story': 'یکی بود یکی نبود زیر گنبد کبود، غیر از خدا هیچکس نبود. یه روباهی بود که هر شب می‌رفت به یه مزرعه و از مرغ و خروس‌های صاحب مزرعه یکی می‌دزدید می‌خورد تا اینکه یه شب صاحب مزرعه روباه را به دام انداخت و قصد جانش را کرد. روباه که به حیله‌گری معروف هست به مزرعه‌دار گفت: منا نکش شغل من پوستین‌دوزی هست به جای این که مرغهات را خوردم برات پوستین می‌دوزم و برای اینکه مطمئن بشی که من نمی‌خوام فرار کنم منا با طناب بفرست تو چاه و شما پوست برای من بنداز داخل چاه تا من برات پوستین بدوزم. صاحب مزرعه قبول کرد و روباه رفت ته چاه و صاحب مزرعه هم یکی از گوسفندانش را کشت و پوست و مقداری گوشت فرستاد ته چاه برای روباه. فردا از روباه پرسید چطوره حال پوستین؟ روباه گفت: یقه مونده و آستین. روباه گفت: یه پوست دیگه بنداز تو چاه. بیچاره مزرعه‌دار رفت و یکی دیگه از گوسفندانش را کشت و به همراه پوست مقداری گوشت هم برای روباه فرستاد تو چاه. روز بعد مزرعه‌دار پرسید آقا روباه چطوره حال پوستین؟ روباه باز گفت: یقه مونده و آستین. روباه گفت: یه پوست دیگه که بندازی دیگه تموم میشه. بیچاره مزرعه‌دار آخرین گوسفندش را کشت و با مقداری گوشت داد ته چاه. روباه مکار که تو این چند روز همه گوشت‌ها و پوست‌ها را خورده بود گفت چکار کنم که بتونم فرار کنم اگر نه کشته میشم. به مزرعه‌دار گفت: دوتا طناب بفرست تو چاه یکی برای خودم یکی هم برای پوستین. روباه اومد یه سنگ بزرگ بست به یه طناب و خودش را هم به یه طناب بست. گفت اول منا بکش بالا بعد پوستین را که با هم پوستین را بکشیم بالا. یه خورده که کشیدند روباه گفت: من خسته شدم شما خودت بکش ولی مواظب باش طناب را ول نکنی که پوستین پاره میشه. همینطور که داشت طناب را می‌کشید بالا یک دفعه روباه پا به فرار گذاشت و وقتی بیچاره مزرعه‌دار طناب را کشید بالا دید یه سنگ بزرگ به طناب بسته شده. بیچاره دو دستی زد تو سر خودش که چه جوری فریب روباه را خورده هم مرغ و خروس‌هایش را از دست داده و هم گوسفندانش را. قصه ما به سر رسید، کلاغه به خونه‌ش نرسید.',
    'moral': 'حیله‌گری و فریبکاری ممکن است موقتاً نتیجه بدهد اما در نهایت آدمی را به دردسر می‌اندازد',
    'color': Colors.orange,
    'icon': Icons.pets,
    'image': '',
  },

  // 4. عاله نخود (نصف نخود)
  {
    'name': 'عاله نخود (نصف نخود)',
    'type': 'قصه‌های تخیلی',
    'description': 'داستان پسر کوچولویی که برای گرفتن طلب پدرش به سفر رفت',
    'story': 'یکی بود یکی نبود، زیر گنبد کبود، جز خدای مهربون اونجا دیگه هیچکی نبود. روزی روزگاری یه خانواده سه نفره پدر و مادر و یه پسر توی یه روستای دور افتاده زندگی می‌کردند. پسر خانواده از بس که کوچک بود و حتی از یه نخود هم کوچکتر بود اسمش را گذاشته بودند عاله نخود یعنی نصف یه نخود. یه روز عاله نخود متوجه میشه که چند سال پیش باباش برای پادشاه کار کرده ولی پادشاه پول اون را نداده. عاله نخود به پدر و مادرش گفت من می‌خوام برم پیش پادشاه و طلب تو را از اون بگیرم. حالا طلبش چقدر بوده؟ صنار و سی شاهی برای اون زمان پول زیادی بوده. خلاصه عاله نخود به مادرش می‌گه یه خورده نان تو سفره بذار و به کمر من ببند تا راهی سفر بشم و برم قصر پادشاه و پول را بگیرم. عاله نخود راه می‌افته به سمت شهر همینطور که راه می‌رفته، پیش خودش زمزمه می‌کرده: عاله نخود می‌ره به شهر، طلب کنه پول پدر. وسط راه به یه گرگ برخورد می‌کنه گرگه می‌گه عاله نخود کجا می‌ری؟ می‌گه عاله نخود می‌ره به شهر، طلب کنه پول پدر. گرگه می‌گه برای اینکه تنها نباشی منم باهات می‌ام. یه خورده که راه می‌رن گرگه خسته میشه عاله نخود می‌گه بیا برو توی جیب من بخواب و به راهش ادامه می‌ده. تا اینکه می‌رسه به یه روباه، روباه می‌پرسه عاله نخود کجا می‌ری؟ جواب می‌ده عاله نخود می‌ره به شهر، طلب کنه پول پدر. روباه می‌گه برای اینکه تنها نباشی منم می‌ام. یه خورده که راه می‌رن روباه می‌گه من خسته شدم عاله نخود می‌گه بیا برو توی اون جیب من بخواب. خلاصه به راهش ادامه می‌ده تا می‌رسه به یه برکه آب تو بیابون، برکه می‌گه عاله نخود کجا می‌ری؟ می‌گه عاله نخود می‌ره به شهر، طلب کنه پول پدر. برکه می‌گه منم اینجا تنهام با خودت ببر. عاله نخود تمام آب برکه را تو شکمش جا می‌ده و می‌ره به سمت قصر پادشاه. دم دروازه شهر که می‌رسه دروازه‌بان جلوش را می‌گیره می‌گه هی کجا می‌خواهی بری؟ می‌گه عاله نخود اومد به شهر، طلب کنه پول پدر. جریان را تعریف می‌کنه از طلب پدرش از پادشاه. خبر به پادشاه می‌دن و موضوع را تعریف می‌کنن شاه می‌گه بگیرید بندازیدش تو کومه مرغ و خروس‌ها تا بخورنش. وقتی می‌ندازنش لونه مرغ‌ها، یه دفعه روباه را از جیبش در میاره و تمام مرغ و خروس‌ها را می‌خوره و باز میاد بیرون و می‌خونه عاله نخود اومد به شهر، طلب کنه پول پدر. باز خبر می‌دن به شاه که عاله نخود جان سالم در برده و تموم مرغ و خروس‌ها از بین رفتن. این بار گفت ببرید بندازید تو طویله اسب‌ها تا زیر دست و پا له بشه. بردنش پیش اسب‌ها که یک دفعه عاله نخود از جیبش گرگ را آورد بیرون و تمام اسب‌ها را تکه و پاره کرد و خودش را نجات داد. باز دیدن عاله نخود داره تو قصر راه می‌ره و شعر می‌خونه. پادشاه این دفعه گفت ببرید بندازیدش تو تنور آتش تا بسوزه و از دستش راحت بشیم. عاله نخود را گرفتن و بردن انداختن تو تنور که یک دفعه آب‌های برکه تو شکمش را خالی کرد و آتش خاموش شد و از آنجا اومد بیرون. خبر به پادشاه دادن که عاله نخود باز اومده بیرون. این بار دستور داد ببریدش تو خزانه مگه یه عاله نخود چقدر می‌تونه پول برداره تا از دستش راحت بشیم. بردنش تو خزانه و در را بستن. عاله نخود هم تمام طلا و جواهرات داخل خزانه را تو شکمش جا داد و از روزنه فرار کرد. صبح رفتن سراغ خزانه دیدن تمام خزانه خالی شده و خبری از عاله نخود نیست. شاه دستور داد هزار تا اسب‌سوار تو بیابون بتازونند تا اینکه عاله نخود زیر دست و پا له بشه. عاله نخود تا گرد و غبار سواران پادشاه را دید رفت و پشت یه پشکل پناه گرفت و جان سالم به در برد. تا اینکه شب رسید به خونه. پدر و مادرش دیدن پسرشون عاله نخود صحیح و سالم برگشته گفتن پول پس کو؟ گفت منا با طناب از روزنه اتاق سرازیر کنید و با چوب بزنید بر بدنم تا هرچی خوردم را بیرون بیارم. خلاصه اتاق پر از طلا و جواهرات و پول شد و سال‌های سال عاله نخود و پدر و مادرش زندگی خوب و راحتی داشتند و به وجود همچین پسر زرنگی افتخار می‌کردند. قصه ما به سر رسید کلاغه به خونه‌ش نرسید. بالا رفتم دوغ بود پایین اومدم دوغ بود قصه ما دروغ بود.\n\nکلمه عاله جایی در فرهنگ و لغت نیومده که معنی نصف بدهد ولی در گویش عامیانه به نصف یا برشی از چیزی گفته میشه مثلا یه عاله سیب یا یه عاله هندونه و غیره.',
    'moral': 'هوش و شجاعت می‌تواند مشکلات بزرگ را حل کند و کوچکی جثه دلیل بر ناتوانی نیست',
    'color': Colors.purple,
    'icon': Icons.child_care,
    'image': '',
  },

  
// داستان پیرمرد خارکن - اضافه شده به لیست kidsStories
{
  'name': 'پیرمرد خارکن',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان پیرمرد مهربانی که مار را از سرما نجات داد اما مار به او بدی کرد',
  'story': 'روزی و روزگاری بود\nهر کسی نونی می‌خواست\nهمش پی یه کاری بود\n\nقهرمان قصه ما پیرمرد خارکنی بود که هر روز برای امرار معاش به صحرا می‌رفت و مقداری خار جمع آوری می‌کرد و برای فروش به شهر می‌آورد. تا اینکه یک روز سرد زمستانی وقتی به صحرا می‌رفت چشمش به یک مار خیلی بزرگ افتاد که از سرما عنقریب بود جانش را از دست بدهد.\n\nپیرمرد دلش به حال مار سوخت و گفت: اگر می‌خواهی گرم شوی بیا و برو داخل این خورجین تا منم خار جمع کنم. مار خزید داخل خورجین ولی وقتی گرم شد یک فکر شوم به سرش زد. هنگامی که خارکن آمد، مار گفت: می‌دانی که من چند روزه چیزی نخورده‌ام و گرسنه‌ام و حالا می‌خواهم تو و خرت را نیش بزنم و بعد بخورم.\n\nخارکن گفت: من تو را از سرما نجات دادم این است مزد من؟\nمار گفت: از قدیم گفتند «سزای نیکی بدی‌ است».\n\nخارکن گفت: زن و بچه من منتظرم هستند، اجازه بده من به خانه بروم و به آنها خبر دهم و برگردم، شاید تا آن موقع نظر تو هم برگشته باشد و مرا نیش نزنی.\n\nمار گفت: به شرطی که خرت را نزد من بگذاری و پیاده به نزد خانواده‌ات بروی و وقت برگشتن کسی را با خودت نیاوری.\n\nخارکن قبول کرد. موقع رفتن به مار گفت: پس برو داخل خورجین که از سرما در امان باشی. مار وقتی داخل خورجین رفت، پیرمرد در خورجین را محکم دوخت و گفت: من زود برمی‌گردم.\n\nخارکن کمی که دور شد یک خرمنی از آتش فراهم کرد و به نزد مار آمد. گفت: من به قول خودم وفا کردم ولی بدان ای مار که تو بد عهدی کردی.\n\nمار گفت: رسم روزگار همین است.\n\nپیرمرد خورجین را بر دوش گرفت و در میان خرمنی از آتش انداخت و گفت: این هم سزای کسی که نمک خورد و نمکدان را شکست.\n\nهمین‌طور که مار در میان آتش داشت می‌سوخت با آه و ناله شعری را زمزمه می‌کرد:\n«نمک خوردم نمکدان را شکستم\nکنون در خرمنی آتش نشستم\nببخشا مرد خارکن مار بدبین\nبرون آور مرا از بند خورجین»\n\nولی دیگر کار از کار گذشته بود و مار بدجنس در میان آتش‌ها جزغاله می‌شد.\n\nقصه ما چه با نمک\nسراسرش دوز و کلک',
  'moral': 'نیکی به ناسپاسان نتیجه بدی خواهد داشت. همان‌طور که ضرب‌المثل می‌گوید: «نمک خورد و نمکدان شکست»',
  'color': Colors.green,
  'icon': Icons.nature_people,
  'image': '',
},


  // 4. کوه هزار و دو درّه
  {
    'name': 'کوه هزار و دو درّه',
    'type': 'قصه‌های تخیلی',
    'description': 'داستان افرادی که برای شمارش دره ها  می رفتند',
    'story': 'روزی و روزگاری بود\nنقل می کنند در صحرایی بی آب و علف،و دور\n آبادی کوهی بود که دره های بسیار داشت\nولی کسی از تعداد دره های اون کوه خبری نداشت\nو هر کسی که برای شمردن دره ها میرفت\nاز صبح تا شب حرکت می کرد و دره ها  را می شمرد\nتا اینکه شب می شد و هنوز دره های بسیاری باقیمانده بود\n،میخوابید که فردا صبح بقیه دره ها را بشمارد\nولی از بس که خسته بود به خواب عمیق فرو میرفت\nو شب یک غول خیلی بزرگ و\nبدجنس به سراغش می آمد و آنقدر \nکف پاهای او را لیس میزد که از حال میرفت\nو می مرد چندین نفر رفتند ولی موفق نشدند\nخبر به پادشاه رسید و جریان را برایش تعریف کردند،\nشاه گفت هرکسی از پس این کار بر بیاید \nجایزه بزرگی به او می دهم از قضا روزی\n دو نفر به نزد شاه رفتند و این کار را قبول کردند\nرفتند و تا شب دره ها را شمردند موقع خواب گفتن\nچکار کنیم که از دست غول در امان باشیم یکی از انها گفت\nموقع خواب پاهای همدیگر را داخل پاچه شلوار  همدیگر کنیم\nکه اصلا پایی نباشه که غول لیس بزنه\nخلاصه این ترفند را زدند و خوابیدند مثل یه آدمی\nکه دوتا سر داشته باشه نیمه های شب \nغول اومد و هرچی دور و بر اینها راه رفت پایی ندید ،پیش خودش گفت \nرفتم به کوه هزار و  دو درّه      آدم ندیدم دو سره\nاینها وقتی این گفته را از غول شنیدند فهمیدند \n که این کوه هزار و دره داره و صبح دیگه بقیه دره ها را نشمردند\nو سریع به نزد پادشاه اومدن و قضیه را برا شاه تعریف کردند\nپادشاه به و هوش و ذکاوت این دو نفر مرحبا گفت و\nکیسه ای از زر به آنها داد وچون آدمهای زرنگ و\nفهیمی بودند در دربار به کار گماشت\nقصه ما به سر رسید    صبح شد و خورشیدم دمید\n',
    'moral': 'هوش و شجاعت می‌تواند مشکلات بزرگ را حل کند ',
    'color': Colors.purple,
    'icon': Icons.child_care,
    'image': '',
  },


// 5. لالایی شبانه
 {
  'name': 'لالایی گل پونه',
  'type': 'لالایی‌ها',
  'description': 'لالایی بلند و آرامش‌بخش برای خواب کودک با حال‌وهوای مادرانه و گل پونه',
  'story': '''لالا لالا گل پونه
بخواب ای ناز دردونه

لالا لالا نازنینم
چراغ روشنِ زمینم

لالا لالا گلِ خونه
دلِ مادر برات می‌خونه

لالا لالا ای ستاره
بخواب وقتِ بهاره

لالا لالا نازِ مادر
بخواب ای کودکِ دلبر

لالا لالا زیرِ مهتاب
چشاتُ ببند برو در خواب

لالا لالا گل پونه
بخواب ای ماهِ تو خونه

نسیم آروم می‌پیچه
شب از راهِ دور می‌رسه

ستاره توی آسمون
می‌خنده آروم و مهربون

بخواب ای غنچه‌ی زیبا
الهی دور شی از غم‌ها

بخواب ای نورِ توی شب
که خوابت بشه شیرین و لب‌لب

لالا لالا مادر اینجاست
دلش همیشه با تو تنهاست

اگر ابری بشه فردا
الهی خنده باشه با ما

اگر بارون بیاد آروم
بخوابی توی یک رویای معصوم

کنار گهواره‌ی چوبی
بخواب ای کودکِ خوبی

فرشته دور تو بگرده
خدا پشت و پناهت کرده

لالا لالا گل پونه
دلم بی تو نمی‌مونه

لالا لالا نازدونه
بخواب ای مِهرِ شبخونه

الهی قد بکشی فردا
بشی چون سروِ سبز و زیبا

الهی بخت تو روشن
دلت پاک و لبت خندان

الهی غصه کم باشه
دلت از شادی پُر باشه

بخواب ای کوچولوی نازم
که من با عشق می‌سازم

شبِ آرومِ گهواره
پر از لطفِ خداواره

لالا لالا وقتِ خوابه
چشای نازت پُر از خوابه

لالا لالا گل پونه
بخواب ای یارِ تک‌دونه

بذار ماه از پشتِ شیشه
برات قصه همیشه بگه

بذار بادِ شبونه آروم
بخونه از دلِ هامون

بخواب ای نازنینِ من
تویی شیرین‌ترینِ من

تو خوابِ دشت و بارون ببین
پرنده و نیستان ببین

تو خوابِ باغِ شب‌بوها
تو خوابِ چشمه و جوها

تو خوابِ گل، تو خوابِ نور
تو خوابِ راه‌های دور

لالا لالا گل پونه
بخواب ای ماهِ دردونه

لالا لالا تا سحرگاه
الهی باشه دلت آگاه

به عشق و مهر و زیبایی
به لطفِ پاکِ دریایی

بخواب ای جانِ مادر جان
الهی خنده‌هات فراوان

لالا لالا نازنینم
تمامِ عشقِ روی زمینم''',
  'moral': 'محبت مادرانه، آرامش، امید و پناه بردن به مهر خدا',
  'color': Colors.blue,
  'icon': Icons.night_shelter,
  'image': '',
},

{
  'name': 'چای خاکستری',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'خاطره‌ای از روزهای جنگ تحمیلی و تلاش برای درست کردن چای در سنگر',
  'story': '''هشت نفر، هشت روز توی سنگر چهار نفره روی یک تپه می‌نشستی و گردنت رو خم می‌کردی، دراز می‌کشیدی.
باید با پاهات مثلث درست کنی.
حتی من که قدم به یکصد و شصت هم نمی‌رسید، یک مثلث درست می‌کردم با قاعده بزرگ، شاید حدود یک متر روی زمین.
بعضی‌ها که ماشاءالله فقط در جهت ارتفاع رشد کرده بودند، مثلث می‌شن با قاعده بیست سانتی‌متر.
حساب که دستتان اومد، عرض یک متر و نیم و طول کمتر از دو متر و نیم، یه گور دسته جمعی!

شبانه، از غروب که روشنایی هوا شام را می‌خوردیم، دو نفر آماده و مجهز برای اولین پست نگهبانی بیرون سنگر می‌ماندند.
روزها نگهبانی نداشتیم، شب‌ها همیشه دو نفر در حال پست دادن بودند.
هر شب به ترتیب برنامه پست دادن از دم در سنگر می‌خوابیدیم.
شب آخر من و سلیمان نوبت دوم بودیم، باید دم در می‌خوابیدیم بعد دو نفر بعدی و هر کسی هم که پستش تمام می‌شد می‌آمد جای نفرات قبلی می‌خوابید.

هر کسی که پست می‌داد باید کورمال کورمال روی دست و پای بقیه برود ته سنگر بخوابد تا نفرات بعدی که برای نگهبانی می‌روند دست و پایش را لگد نکنند و بیدارشان نسازند.
دو نفر آخر هم که پست می‌دادند دیگر نمی‌خوابیدند، بچه‌ها را برای نماز صبح بیدار می‌کردند.
نماز را هم بیرون سنگر می‌خواندیم، فقط ظهرها به علت گرمی هوا نماز ظهر و عصر را در سنگر می‌خواندیم نشسته و شکسته.

سنگ‌ها بسیار داغ بودند.
هرچند منطقه کوهستانی بود ولی چله تابستان همانجا هم به نسبت گرم بود.
هر روز صبح، ظهر و غروب چای درست می‌کردیم با خرج خمپاره و آرپی‌جی هم زیاد بود، هم دود نداشت هم و هم کتری سریع جوش می‌آمد.

روز هشتم بود، یک ساعت مانده به غروب.
هوس چای آتیشی کردیم.
با هیزم مقداری شاخ و برگ خشک جمع کردیم و کتری پر از آب را روی اجاق سنگی گذاشت و شاخ و برگ‌ها رو چپاندیم توی اجاق زیر کتری.
کبریت را کشیدیم، از بس شاخ و برگ‌ها زیاد بود، آتش خفه می‌سوخت و دود زیادی می‌کرد تا بیاید آتش بگیرد.

زودتر دشمن گروی ما را گرفت و شروع کرد به ریختن آتش بر سر ما.
اولین گلوله که پشت سر ما خورد همه مثل فنر پریدیم تو سنگر.
دشمن ول کن نبود.
حدود یک ربعی با خمپاره تپه رو گلوله باران کرد.
حتی یک گلوله پشت سنگر خورد، نزدیک بود سنگر رو خراب کنه.

من گفتم بریم بیرون، اگه یه گلوله رو سنگر بخوره همه از بین می‌ریم ولی بیرون سنگر کمتر آسیب می‌بینیم چون پشت تخت سنگر با فاصله زیادی مخفی می‌شیم.
مسئول سنگر اجازه نداد و گفت: «نه باید داخل سنگر بمانیم.»

آتش‌بازی‌ها که تمام شد، دیگه هوا هم داشت تاریک می‌شد.
یکی یکی آرام آرام از سنگر بیرون خزیدیم.
شیشه چای شکسته بود و چای‌ها ریخته بود روی آتش و آب کتری هم ریخته بود روش.
یک چای خاکستری دبش درست شده بود.
حیف که نمی‌شد خورد!''',
  'moral': 'در سخت‌ترین شرایط، لحظات ساده زندگی مثل یک فنجان چای می‌توانند خاطره‌انگیزترین باشند',
  'color': Colors.red,
  'icon': Icons.sports_kabaddi,
  'image': '',
},


{
  'name': 'پنکه سقفی',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'خاطره‌ای از روزهای جنگ و تأثیر آن بر زندگی یک خانواده روستایی',
  'story': ''' خانمش خیلی ترسیده بود وقتی دیده بود شوهرش محمد بیرون از پشه بند روی موزاییک‌های حیاط سینه خیز می‌رود و هر از گاهی دستانش را روی سرش می‌گذارد.

هوای گرم کویر شب‌های تابستان مردم را می‌کشاند به حیاط و پشت بام خانه‌ها و اگر کولر روبه‌راهی باشد محبوس می‌کند توی خانه.

حالا مرد خانه خودش آمده و روی رختخوابش بیرون پشه‌بند خوابیده بود و چشمانش را به آسمان دوخته و هیچ نمی‌گفت اما وقتی سینه خیز می‌رفت مرتب می‌گفت:

«مواظب باشید بخوابید رو زمین، همینطور بخوابید، جم نخورید.»

خانم خیلی ترسیده بود. به آرامی کنار پسر دو ماهه‌اش خوابید و زیپ پشه‌بند را کشید.

طی یک سالی که از عروسی‌شان می‌گذشت ندیده بود شوهرش اینطور شود. جرئت نکرد چیزی به او بگوید. پیش خودش فکر کرد باید فردا با او صحبت کنم یا نه؟

موضوع را با پدرش در میان بگذارم؟ چطور است به پدرم بگویم؟ نه با او هم نمی‌شود. با مادرم بگویم بهتر است. نکند همسرم بیماری خاصی دارد.

آدم‌هایی که سر دارند را دیده‌اند می‌افتند و غش می‌کنند دست و پا می‌زنند اما به این طرف و آن طرف نمی‌روند.

خوب شد همسایه‌های دو طرفمان روی پشت بام نبودند که صدای محمد را بشنوند و...

حالا دو هفته از آن شب گذشته. خواهر بزرگم با شوهرش تهران آمدند به ده. هنوز جریان را به مادرم نگفتم. راستش را بخواهید می‌ترسم نمی‌دانم واکنش او چگونه خواهد بود.

پیش خودش فکر کرد بهتر است به خواهر بگویم با او خیلی راحت‌ترم.

عصر عصر بود که زنگ در خانه به صدا درآمد. خانم در را باز کرد برادرش بود. علیرضا گفت:

«مامان گفته شب بیایید بالا دور هم باشیم. ما که صبح آنجا بودیم. باشه حالا برای شام بیایید. مامان گفته حتما بیایید. باشه می‌آییم.»

روستای ما دو بافت کاملاً مجزا دارد. بافت قدیمی و سنتی که در دامنه تپه‌ای و کنار چشمه‌های آب واقع شده و تا کوه فاصله چندانی ندارد. بافت جدید استاد با فاصله کمی روی زمین صاف و هموار بنا شده و چون بافت سنتی مشرف به بافت جدید است به آنجا اصطلاحاً بالا می‌گویند.

غروب نشه رفتیم تا کمکی هم کرده باشیم. خواهرم هر سال تابستان چند روزی با همسرش می‌آید ده و میهمان ماست یعنی اقامتگاهشان خانه پدرم است و گاهی هم خانه ما می‌آیند.

بعد از صرف شام پدر و مادرم خوابیدند. خانه پدرم چندین اتاق دارد هم سطح حیاط و یک اتاق دارد بالای پشت بام به نام بالاخانه. این بالاخانه را بیشتر خانه‌های سنتی دارند که در فصل تابستان می‌شود اتاق نشیمن و زمستان‌ها یا جای یا خالی است یا انبار بعضی مواد غذایی.

بیشتر بالاخانه‌ها دو در دارد یکی دو پنجره تا از هر طرف باد بوزد هوای بالاخانه را خنک کند.

بعد از ساعت گل گفتن و گل شنفتن بلند شدیم برویم خانه خودمان که خواهرم اصرار کرد همین جا بخوابید این همه اتاق خالی. اصلاً ما می‌رویم بالاخونه و مردها بروند پشت بام.

شوهر خواهرم گفت: «نه ما می‌ریم تو بالاخونه شما بچه‌ها بالای پشت بام بخوابید چون من و محمد آقا هنوز می‌خواهیم صحبت کنیم. شاید مزاحم همسایه‌ها بشیم شب صدا آن هم بالای پشت بام خیلی راه می‌رود آن هم توی ده که یکی دو ساعت بعد از غروب همه جا را سکوت فرا می‌گیرد.»

آنها رفتند توی بالاخانه و گرم صحبت شدند و ما بچه‌ها پشت بام تو پشه‌بند خوابیدیم.

نیمه‌های شب یک مرتبه با سر و صدای شوهرم بیدار شدیم. دیدیم محمد مانند دو هفته قبل باز سر و صدا راه انداخته. نور تیر چراغ برق کوچه داخل بالاخانه روشن کرده بود.

محمد در حال سینه خیز رفتن بود و مرتب داد می‌زد:

«بخوابید رو زمین. عراقی‌ها حمله کردند. مواظب هلیکوپترها باشید. کسی حرکت نکنه. هلیکوپترهای عراقی دارن نزدیک می‌شن.»

آقا عیسی شوهرم را محکم گرفته بود اما همچنان دست و پا می‌زد و داد و فریاد می‌کرد.

ما دو خواهر بچه‌ها را رها کرده و در آستانه در بالاخانه ایستاده بودیم. هنوز یکی دو ساعتی بیشتر از تعریف کردن جریان دو هفته پیش برای خواهرم نگذشته بود که باز ناگهان آقا عیسی همان طور که شوهرم را بغل کرده بود داد زد:

«اون پنکه سقفی لعنتی رو خاموش کنید! خاموش کنید پنکه سقفی لعنتی!»''',
  'moral': 'جنگ زخم‌های عمیقی بر روح و روان آدم‌ها می‌گذارد که حتی سال‌ها پس از پایان آن، در لحظات عادی زندگی خود را نشان می‌دهند',
  'color': Colors.red,
  'icon': Icons.bedtime,
  'image': '',
},


{
  'name': 'پا عوض',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'خاطره‌ای از نرمش‌های صبحگاهی در دوران جنگ و مردی که با لبخند همه را به حرکت وادار می‌کرد',
  'story': '''پا عوض!

حسنک کجایی؟ حسنک کجایی؟ دیروقت بود، دیروقت بود!
خورشید در پشت کوه‌های مغرب، خورشید در پشت کوه‌های مغرب غروب می‌کرد، غروب می‌کرد!
اما از حسنک، اما از حسنک خبری نبود، خبری نبود!
عجب گندم‌های زرد قشنگی! عجب گندم‌های زرد قشنگی!
چه کسی این‌ها را کاشته است؟ چه کسی این‌ها رو کاشته است؟
دهقان! دهقان! همان دهقانی که دوش ماست! همان دهقانی که دوش ماست!
بسم‌الله، بسم‌الله، بسم‌الله، بسم‌الله!
اذا جا نصرالله، اذا جا نصرالله!

آقای خورشیدی می‌گفت این‌ها تنها بخش کوچکی از چیزهایی بود که در مراسم دو صبحگاهی توسط یکی از بچه‌ها که بیرون صف و برابر بچه‌ها می‌دوید گفته می‌شد و دیگران تکرار می‌کردند.

آقای الماسی دانشجوی رشته فیزیک از همه واردتر بود. او علاوه بر درس حسن کجایی و دوستان ما، درس‌های تصمیم کبری، مهمانان سرزده، کوکب خانم و گاو عموحسین، چندین درس دیگر از کلاس‌های دوم و سوم ابتدایی را حفظ بود.
چند تا شعر هم همین طور مثل: «میهن خویش را کنیم آباد»، «من یار مهربانم»، «ای مادر عزیز که جانم فدای تو» و غیره.

برادر فرمانده گردان که ظاهراً معاون گردان هم بود، در مدتی که در مقر حضور داشت مسئول نرمش صبحگاه هم بود.
بدنی بسیار ورزیده داشت، حدوداً چهل ساله می‌نمود. فکر کنم رزمی کار بود یا حداقل بعضی دوره‌های آن را دیده بود.

حدود یک ماهی که بود یک مرتبه غیبش زد. هیچ کس نمی‌دانست کجا رفته، هیچ کس هم نمی‌گفت کجا رفته و معمولاً هیچ کس هم نمی‌پرسید کجا رفته. فقط همه می‌دانستند مرخصی نرفته.

حالا مقرهای دیگر می‌رفت، خط مقدم می‌رفت، مواضع پدافندی سرکشی می‌کرد یا بچه‌های اطلاعات عملیات می‌رفت. این‌ها را دیگر کسی نمی‌دانست.

گفتند که معمولاً کسی هم نمی‌پرسید چون می‌دانستند جواب درستی نخواهند گرفت. اگر احیانا کسی هم می‌پرسید جواب درستی نمی‌گرفت، مثل همه جواب‌ها دو کلمه بیشتر نمی‌شنید.

گفتن نگید...

آقای خورشیدی از پشت میزش بلند شد و کشوی بالای فایل را بیرون کشید و پاکت بزرگ کهنه و رنگ و رو رفته‌ای را از داخل یک نایلون بیرون آورد.
داخل پاکت چند ورق کاغذ تا خورده بود.
به آرامی یکی از آنها را باز کرد و دست انداخت و گفت:
«این همین چیزهایی است که برایت تعریف کردم. بقیه‌اش را خودت بخوان.»

خیلی بد خط نوشته شده بود، بعضی کلمات هم رنگ باخته بودند. ترسیدم نتوانم درست بخوانم. گفتم:
«بفرمایید خودتان بخوانید، من دوست دارم گوش بدهم.»

من دوست دارم گوش بدهم، حس و حال بهتری دارد.
پرسیدم: «و راستی آن روزها چند ساله بودید؟»
«هجده نوزده ساله.»

کاغذ را که از دستم گرفت، دست‌هایم را در چانه زده و سراپا گوش شدم و او اینگونه خواند:

«هر روز که دعای صبحگاهی تمام می‌شود، زمان نرمش صبحگاهی است که حداقل نیم ساعت طول می‌کشه.
این برادر فرمانده بعضی روزها از سر انگشتان پا شروع می‌کند، می‌رود تا سر و گردن و حتی حرکات نرمش برای گوش، چشم، ابرو و بینی هم دارد.
و روزهای دیگر از بالا به پایین می‌آید.
تنها نقطه مشترک هر روزه این است که در نرمش قسمت پاها، حرکت هر حرکتی را ده بار با پای چپ انجام می‌دهد و ما هم هماهنگ با او انجام می‌دهیم.
بعد می‌گوید "پا عوض" و همان حرکت را با پای راست انجام می‌دهیم.
و این "پا عوض" را روزی چندین بار می‌گوید چون چندین حرکت نرمشی برای انگشتان پا، مچ، زانو و غیره دارد.
همه اسمش را گذاشته‌اند "پا عوض".
همه حرکات را با لبخند انجام می‌دهد. همه دوستش دارند.»

تمام شد. پرسیدم: «کجا؟»
«این خاطره جالب بود. جز آن قسمت شعارها که اول گفتی، بقیه‌اش خیلی معمولی بود.»

آقای خورشیدی لبخند تلخی زد و گفت:
«آره، بقیه‌اش را ننوشتم چون مربوط به چند ماه بعد می‌شود. زمانی که من برگه پایانی‌ام را گرفته بودم و برگشته بودم اصفهان.
روزی اتفاقی روی سی و سه پل یکی از بچه‌های گردان را که خیلی شوخ و حاضر جواب بود دیدم.
ما بین صحبت‌هایمان پرسیدم: "راستی از پا عوض چه خبر؟"
گفت: "هیچی، فقط پاهاش عوض شده!"»''',
  'moral': 'در سخت‌ترین شرایط، لبخند و شوخ‌طبعی می‌تواند روحیه جمعی را حفظ کند و خاطرات شیرینی بسازد که سال‌ها بعد هم لبخند به لب می‌آورد',
  'color': Colors.red,
  'icon': Icons.directions_run,
  'image': '',
},
{
  'name': 'مطلق',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی کوتاه درباره تلاش برای عبور از سخت‌ترین بندهای زندگی و مفهومی که هرگز نوشته نشد',
  'story': '''بند شانزدهم از همه بندها سخت‌تر بود.
دیگر توانی برایم باقی نمانده بود، مخم داشت سوت می‌کشید.
احوال بغل دستی‌ام از من هم بهتر نبود.
حتی خانم میری هم نتوانست به ما کمکی بکند.
شاید بیست دقیقه بیشتر طول کشید تا ما دو نفر از بند شانزدهم خلاص شدیم.

بندهای یک تا پانزده نسبتاً خوب بود.
گاهی من بغل دستی‌ام را یاری می‌دادم، گاه او مرا یاری می‌داد.
اما امان از این بند شانزدهم، خصوصاً آخر بند!
اوایل بند مانند بندهای قبلی بود، اما آخرش دمار من یکی را درآورد.
هضمش برایم مشکل بود، حتماً چیزی کم داشت یا چیز اضافه.
نمی‌دانم.

کسی هم که در انتهای سالن ایستاده بود، دقیقاً آخر بند شانزدهم بود.
گاهی با حرکات او ما آخر بند را می‌دیدیم و آن حال بد به ما دست می‌داد.
دیگر به بندهای بعدی فکر نمی‌کردم.
نمی‌دانم چرا بندهای بعدی شماره نداشت.
با اینکه هنوز حدود ده بند دیگر مانده بود.
و هرگز نفهمیدیم که بندهای نوزده به بعد چیست.

ناگهان سرم را به سمت راست چرخاندم و به بغل دستی‌ام گفتم:
«مطلق!»
از جا پرید و گفت: «چی گفتم؟»
«مطلق! مطلق دسته تا کمرنگ است، گویا اصلاً نوشته نشده است.»
«شانزده! پرهیز از شخصیت‌های مطلق!»
«امان از این ماژیک‌های بی‌رمق و بی‌حال! امان!»''',
  'moral': 'گاهی سخت‌ترین موانع زندگی آن‌هایی هستند که ظاهراً ساده به نظر می‌رسند، و مفهومی که باید درک شود، شاید هیچ‌وقت به درستی نوشته نشده باشد',
  'color': Colors.deepPurple,
  'icon': Icons.edit_note,
  'image': '',
},



{
  'name': 'سیلی بیهوش',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی تأثیرگذار درباره لحظه‌ای که مرز میان زندگی و مرگ با یک سیلی شکسته شد',
  'story': '''روی تخت بیمارستان افتاده بودم و عملیات احیای قلبی به سرعت روی من انجام می‌شد.
اکسیژن را وصل کرده و به من شوک می‌دادند.
بعد از چندین مرتبه شوک، خط ممتد نشان می‌داد که هیچ راه بازگشتی نیست.

دوستَم التماس می‌کرد: «یک بار دیگر شوک بدهید!»
اما آنها گفتند: «فایده‌ای نداره!»

اینقدر دوستم التماس کرد و زار زد که دلم به حالش سوخت.
دلم به حال خودم هم سوخت.
چقدر دوستم التماس می‌کنید ولی کسی گوشش بدهکار نیست؟
دوستَم باز گفت: «فقط یه بار دیگه! من که چیز زیادی ازتون نمی‌خوام. خواهش می‌کنم!»

آقایی که دستگاه شوک را در دست‌هایش گرفته بود با عصبانیت، در حالی که آنها را بر سینه برهنه من می‌فشرد، گفت:
«بیا این هم یه بار دیگه!»

شوک را که به من داد، ناگهان نیم‌خیز شدم و سیلی محکمی به گوشش نواختم.
بیچاره از ترس نمی‌دانست چه کند. گویا خودش دچار شوک شده بود.

گفتم: «اینقدر دوست من التماس می‌کنه که یه شوک دیگه بدهید، اینقدر ناز می‌کنید!»
بدبخت بیچاره! موتور مال او بود، راننده هم خودش بوده.
ماشینی هم که به ما زد خدا خیرش بده، زود ما رو رسوند بیمارستان.
اورژانس هم نصف‌شبی خلوت بود.

«زیادیت می‌کرد؟ یه شوک دیگه به من بدهی!»

دوستَم سر از پا نمی‌شناخت.
نشسته بود، گاهی سر به سجده می‌گذاشت، گاهی دستانش را به سمت آسمان بلند می‌کرد و خدا را شکر می‌کرد و گریه می‌کرد.
بلند می‌شد جای سیلی مرا روی صورت مرد می‌بوسید، دستانش را می‌بوسید.
آخر هم افتاد روی پاهای آن مرد و کفش‌هایش را بوسید.
گاهی معذرت‌خواهی می‌کرد، گاهی تشکر می‌کرد.

پزشک کشیک مرا آرام خواباند و دستور داد حرکت نکنم.
و از بهورزها خواست سریعاً اقدامات امدادی و درمانی بعدی را انجام دهند.

سرم را که چرخاندم، دوستم روی تخت کناری داشت از همان آقای شوک‌دهنده سیلی می‌خورد.
ولی صد تا هم که بزند، آن سیلی آبدار من نمی‌شود!''',
  'moral': 'گاهی یک اقدام ناامیدانه و یک التماس ساده می‌تواند مرز میان مرگ و زندگی را جابه‌جا کند و عشق و وفاداری در سخت‌ترین لحظات خود را نشان می‌دهد',
  'color': Colors.deepPurple,
  'icon': Icons.emergency,
  'image': '',
},
{
  'name': 'کلاس مجازی انشا',
  'type': 'قصه‌های تخیلی',
  'description': 'ماجرای کلاس مجازی و شازده کوچولو که از کتاب بیرون پرید!',
  'story': '''همین که ارتباطم با کلاس نهم قطع کردم، گوشی همراهم زد زیر خنده. گفتم: "مرض چه مرگته، چرا می‌خندی؟"
قیافه حق به جانبی به خود گرفت و گفت: "حالا اینا می‌تونن داستان تخیلی بنویسن؟"
گفتم: "چرا که نه!"
گفت: "چشمم آب نمی‌خوره. الان مطمئنم متین داره یه چیزی می‌خوره، فاطمه هم دراز کشیده، فکر کنه ای بابا این چه موضوعیه دیگه، غزاله هم تو آشپزخونه داره برای خودش چایی می‌ریزه."
گفتم: "باشه، اونا دارن تخیل می‌کنند."

یک مرتبه شازده کوچولو از تو کتاب فارسی پرید بیرون و گفت: "چرا گفتی من واقعی نیستم؟ می‌خوای ببینی چه خبره؟"
که یک مرتبه روباه هم از توی کتاب بیرون پرید و گفت: "هی آقا، اگر واقعی نیست، پس چرا من اهلی شدم؟" و دستش را انداخت گردن شازده کوچولو.
یک مرتبه دستش را کنار کشید و گفت: "شازده، چرا خیسی؟ مگه تو هم عرق می‌کنی؟"
شازده گفت: "عرق دیگه چیه؟ من برای اینکه سیستم خوب کار کنه، مرتب روغن کاری می‌شم."
روباه انگشت چربش را زد روی گوشی همراه من که داد گوشی دراومد: "هی چیکار داری می‌کنی؟"
روباه گفت: "می‌خوام روغن کاریت کنم!"
گوشی گفت: "دیوونه، من که روغن کاری نمی‌خوام، کثیفم کردی!"''',
  'moral': 'تخیل می‌تواند مرزهای واقعیت را درنوردد و شخصیت‌های داستانی را زنده کند',
  'color': Colors.purple,
  'icon': Icons.book,
  'image': '',
},

// داستان تخیلی جدید - اژدهای مهربان
{
  'name': 'اژدهای مهربان',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان اژدهایی که به جای ترساندن، به مردم کمک می‌کرد',
  'story': '''در روستای کوچکی کنار کوهستان، مردم همیشه از اژدهایی که در غار بزرگ زندگی می‌کرد می‌ترسیدند. اما هیچ‌کس تا به حال اژدها را ندیده بود، فقط داستان‌هایی از ترس و وحشت شنیده بودند.

یک روز، پسر کوچکی به اسم علی برای پیدا کردن گوسفند گمشده‌اش به کوهستان رفت. او در میان مه غلیظ، راه را گم کرد و به غار بزرگ رسید. در آنجا، به جای اژدهای وحشتناک، یک اژدهای بزرگ و مهربان را دید که داشت برای پرنده‌های کوچک لانه می‌ساخت.

اژدها گفت: "نترس کوچولو! من سال‌هاست اینجام ولی هیچ‌وقت به کسی آسیبی نرساندم. مردم فقط از روی ترس، داستان‌هایی درباره من ساخته‌اند."

علی با اژدها دوست شد و فهمید که اژدها هر شب برای بچه‌های روستا هدیه‌های کوچکی می‌گذارد. او تصمیم گرفت حقیقت را به مردم بگوید.

روز بعد، علی همه مردم را به کوهستان برد و اژدهای مهربان را به آنها نشان داد. مردم که ترسشان ریخته بود، از اژدها عذرخواهی کردند و او را به روستا دعوت کردند. از آن روز، اژدهای مهربان محافظ روستا شد و همه دوستش داشتند.''',
  'moral': 'نباید به داستان‌های ترسناک بدون دیدن حقیقت اعتقاد کرد؛ گاهی ترس‌ها فقط در ذهن ما وجود دارند',
  'color': Colors.purple,
  'icon': Icons.pets,
  'image': '',
},

// داستان تخیلی جدید - باغچه آرزوها
{
  'name': 'باغچه آرزوها',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان باغچه‌ای که هر آرزویی در آن به حقیقت می‌پیوست',
  'story': '''سارا یک باغچه کوچک در حیاط خانه‌اش داشت که گل‌های رنگارنگی در آن می‌رویید. یک روز، وقتی داشت گل‌ها را آب می‌داد، یک گل طلایی دید که قبلاً ندیده بود.

گل طلایی به سارا گفت: "من یک گل آرزو هستم! هر آرزویی که در کنار من بکنی، به حقیقت می‌پیوندد. اما یادت باشد، فقط می‌توانی یک آرزو کنی!"

سارا که از این موضوع خیلی خوشحال شده بود، می‌خواست آرزوی بزرگ و مهمی بکند. اما فکر کرد: "بهترین آرزویی که می‌توانم بکنم چیست؟"

او به همه آرزوها فکر کرد: ثروت، قدرت، سفر به جاهای دور. اما بعد به یاد همسایه پیرش افتاد که تنها زندگی می‌کرد و به دوست نیاز داشت. به یاد دوستش که بیمار بود و به مدرسه نمی‌توانست بیاید. به یاد پرنده‌های بی‌لانه که توی حیاط پناه گرفته بودند.

سارا تصمیم گرفت آرزویش را بکند: "من آرزو می‌کنم که همه آدم‌ها و حیوانات شاد و سالم باشند و هیچ‌کس تنها نباشد!"

گل طلایی درخشید و ناپدید شد. از آن روز به بعد، اتفاق‌های خوبی در محله افتاد. همسایه پیر دوست‌های جدیدی پیدا کرد، دوست سارا خوب شد و پرنده‌ها هم لانه‌های جدید ساختند.

سارا فهمید که بهترین آرزو، آرزویی است که به دیگران هم کمک کند.''',
  'moral': 'آرزوی واقعی وقتی ارزش دارد که به دیگران هم فکر کنیم؛ بزرگترین خوشحالی در شادی دیگران است',
  'color': Colors.purple,
  'icon': Icons.grass,
  'image': '',
},

// داستان کودکانه جدید - خرسی که بوی بد می‌داد
{
  'name': 'خرسی که بوی بد می‌داد',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان خرسی که هیچ‌کس با او بازی نمی‌کرد چون بوی بدی داشت',
  'story': '''خرس کوچولویی به اسم بومبوم توی جنگل زندگی می‌کرد. بومبوم عاشق بازی بود، اما هیچ‌کس با او بازی نمی‌کرد. چون بومبوم دوست نداشت حمام برود و بوی بدی می‌داد.

همه حیوانات وقتی بومبوم را می‌دیدند، فرار می‌کردند. سنجاب‌ها می‌گفتند: "بوی بد! بوی بد!" و خرگوش‌ها بینی‌شان را می‌گرفتند. بومبوم خیلی ناراحت بود.

یک روز، بومبوم کنار رودخانه نشسته بود و گریه می‌کرد که یک ماهی کوچولو از آب بیرون پرید و گفت: "چرا گریه می‌کنی خرس کوچولو؟"

بومبوم ماجرا را برای ماهی تعریف کرد. ماهی گفت: "من هر روز حمام می‌کنم و همین باعث میشه همه دوستم داشته باشن. تو هم بیا توی آب و حمام کن!"

بومبوم اول نمی‌خواست، اما وقتی دید هیچ‌کس با او بازی نمی‌کند، قبول کرد و رفت توی آب. حسابی خودش را شست و تمیز شد.

وقتی از آب بیرون آمد، بوی خوش گل‌های جنگلی می‌داد. حیوانات که بوی خوش را حس کردند، دور بومبوم جمع شدند. سنجاب گفت: "چه بوی خوبی! تو همان خرس کوچولوی بدبویی بودی؟"

بومبوم با خوشحالی گفت: "بله! حالا می‌خواهید با من بازی کنید؟"

همه حیوانات قبول کردند و از آن روز به بعد، بومبوم هر روز حمام می‌کرد تا همیشه خوشبو باشد و همه با او بازی کنند.''',
  'moral': 'تمیز بودن و رعایت بهداشت باعث می‌شود دیگران ما را بیشتر دوست داشته باشند',
  'color': Colors.orange,
  'icon': Icons.pets,
  'image': '',
},

// داستان کودکانه جدید - خرگوش و لاک‌پشت دانا
{
  'name': 'خرگوش و لاک‌پشت دانا',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان خرگوشی که از لاک‌پشت دانا پرسید راز شادی چیست',
  'story': '''خرگوش کوچولوی تندرو همیشه عجله داشت. می‌دوید، می‌پرید و هیچ‌وقت آرام نمی‌گرفت. یک روز از جلوی خانه لاک‌پشت پیر و دانا رد می‌شد که دید لاک‌پشت دارد به آرامی زیر نور آفتاب قدم می‌زند و لبخند می‌زند.

خرگوش از لاک‌پشت پرسید: "آقای لاک‌پشت! چرا اینقدر آرام راه می‌روید و لبخند می‌زنید؟ راز شادی شما چیست؟"

لاک‌پشت با لبخند گفت: "بیا کنار من بنشین تا بهت بگم."

خرگوش که همیشه عجله داشت، گفت: "نه وقت ندارم! سریع بگو!"

لاک‌پشت گفت: "خب، من هر روز صبح از خواب بیدار می‌شوم و به گل‌های باغچه سلام می‌کنم. به پرنده‌ها گوش می‌دهم که آواز می‌خوانند. طعم شبنم صبحگاهی را می‌چشم. به جای عجله، از هر لحظه لذت می‌برم."

خرگوش با تعجب گفت: "یعنی فقط همین؟"

لاک‌پشت گفت: "آره! وقتی آرام می‌گیری، می‌توانی زیبایی‌های اطرافت را ببینی. زندگی یک مسابقه نیست که همیشه بدوی، زندگی یک باغ است که باید از گل‌هایش لذت ببری."

خرگوش فکر کرد و برای اولین بار نشست و به آسمان نگاه کرد. ابرهای سفید را دید که به آرامی حرکت می‌کردند و پرنده‌ها که آواز می‌خواندند. او لبخند زد و گفت: "راست می‌گویی! من تا حالا این همه قشنگ‌ها را ندیده بودم."

از آن روز، خرگوش هر روز کمی می‌ایستاد و از زیبایی‌های اطرافش لذت می‌برد و دیگر همیشه عجله نداشت.''',
  'moral': 'آرامش و توجه به لحظه‌های کوچک زندگی، کلید خوشبختی واقعی است',
  'color': Colors.green,
  'icon': Icons.nature,
  'image': '',
},

// ==================================================
// دسته 1: قصه‌های حیوانات (3 داستان جدید)
// ==================================================

// 1. گنجشک و مورچه
{
  'name': 'گنجشک و مورچه',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان گنجشکی که به مورچه کمک کرد و روزی مورچه جبران کرد',
  'story': '''یک روز گرم تابستانی، گنجشک کوچکی در حال پرواز بود که دید مورچه‌ای در حال تلاش برای حمل یک دانه گندم بزرگ است. مورچه حسابی خسته شده بود و نمی‌توانست دانه را به لانه‌اش برساند.

گنجشک که دلش به حال مورچه سوخته بود، پایین آمد و گفت: "مورچه جان! می‌خواهی کمکت کنم؟"

مورچه که از این پیشنهاد خوشحال شده بود، گفت: "بله! خیلی ممنون می‌شوم!"

گنجشک دانه را با نوکش گرفت و تا نزدیکی لانه مورچه برد. مورچه از او تشکر کرد و گفت: "اگر روزی به کمکت نیاز داشتی، من حاضرم جبران کنم!"

گنجشک خندید و گفت: "تو که یک مورچه کوچک هستی، چطور می‌توانی به من کمک کنی؟" و پرواز کرد.

چند روز بعد، گنجشک در حال آب خوردن از کنار یک رودخانه بود که پای‌اش لغزید و توی آب افتاد. آب تند بود و گنجشک نمی‌توانست بیرون بیاید. هرچه تقلا می‌کرد، بدتر در آب فرو می‌رفت.

مورچه که آن نزدیکی بود، صدای فریاد گنجشک را شنید. سریعاً به سمت رودخانه دوید و دید گنجشک در حال غرق شدن است. مورچه با سرعت به سمت یک برگ بزرگ رفت و آن را به آب انداخت و فریاد زد: "گنجشک! سوار برگ شو!"

گنجشک با آخرین توانش خودش را روی برگ کشید و به ساحل رسید. وقتی جان سالم به در برد، به مورچه گفت: "راست می‌گفتی! حتی کوچک‌ترین موجودات هم می‌توانند کمک بزرگی کنند. ممنونم که نجاتم دادی!"

از آن روز، گنجشک و مورچه بهترین دوستان شدند و همیشه به هم کمک می‌کردند.''',
  'moral': 'هیچ کس را نباید دست کم گرفت؛ حتی کوچک‌ترین موجودات هم می‌توانند کمک بزرگی کنند',
  'color': Colors.orange,
  'icon': Icons.pets,
  'image': '',
},

// 2. مرغ مغرور
{
  'name': 'مرغ مغرور',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان مرغی که فکر می‌کرد از همه بهتر است و درس عبرتی گرفت',
  'story': '''در یک مزرعه بزرگ، مرغی بود که خیلی مغرور بود. او همیشه به دیگر حیوانات می‌گفت: "من زیباترین، باهوش‌ترین و بهترین هستم! تخم‌های من بزرگ‌تر و خوش‌مزه‌تر از تخم‌های دیگران است!"

هر روز صبح با غرور راه می‌رفت و جیغ می‌کشید: "قور قور قور! من از همه بهترم!"

بز، گاو، اسب و حتی سگ مزرعه از دست این مرغ خسته شده بودند. یک روز، خروس پیر مزرعه به مرغ گفت: "غرور باعث می‌شود دوستانت را از دست بدهی. باید متواضع باشی."

مرغ با غرور گفت: "من احتیاجی به نصیحت تو ندارم! من خودم همه چیز را می‌دانم!"

یک روز، مرغ در حال گردش در حیاط بود که یک روباه گرسنه از پشت بوته‌ها بیرون آمد. مرغ که غرق غرور خودش بود، روباه را ندید. روباه گفت: "مرغ خانم! چقدر زیبا و چاق و چله هستی! می‌شود با تو دوست شوم؟"

مرغ که از تعریف روباه خوشش آمده بود، گفت: "البته که می‌شود! من که همه دوستم دارند!"

روباه با حیله گفت: "بیا من را به خانه‌ات دعوت کن تا با هم غذا بخوریم!"

مرغ هم قبول کرد و روباه را به مرغدانی برد. اما به محض اینکه وارد شدند، روباه در مرغدانی را بست و گفت: "حالا نوبت شام من است!"

مرغ ترسیده بود و فریاد می‌زد: "کمک! کمک!"

خروس و سگ صدای مرغ را شنیدند و سریع به مرغدانی دویدند. سگ شروع به پارس کردن کرد و خروس هم با بال‌هایش سر و صدا کرد. روباه که ترسیده بود، از آنجا فرار کرد.

مرغ نجات پیدا کرد، اما دیگر مغرور نبود. او به خروس گفت: "حق با تو بود. غرور باعث شد نزدیک بود کشته شوم. از این به بعد متواضع خواهم بود."''',
  'moral': 'غرور باعث سقوط می‌شود، تواضع باعث نجات',
  'color': Colors.orange,
  'icon': Icons.pets,
  'image': '',
},

// 3. بزغاله و گرگ دروغگو
{
  'name': 'بزغاله و گرگ دروغگو',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان بزغاله‌ای که فریب حرف‌های شیرین گرگ را نخورد',
  'story': '''در دامنه یک کوه سبز، بزغاله کوچکی با مادرش زندگی می‌کرد. مادرش هر روز صبح به چرا می‌رفت و به بزغاله می‌گفت: "تا برنگشتم به هیچکس در را باز نکن!"

یک روز، گرگ حیله‌گر که خیلی گرسنه بود، به نزدیک خانه بزغاله آمد. گرگ با نرم‌ترین صدا گفت: "بزغاله جان! من دوست مادرت هستم. در را باز کن تا با هم بازی کنیم!"

بزغاله که مادرش به او گفته بود مواظب باشد، با دقت از پشت در گفت: "صدا و لباس مادرم را برایم بخوان!"

گرگ که نمی‌دانست مادر بزغاله چه صدایی دارد، شروع کرد به آواز خواندن: "بزغاله کوچولو، در را وا کن! مادرت برگشته، برات خوراکی آورده!"

بزغاله که صدای گرفته و خشن گرگ را شنید، گفت: "تو مادر من نیستی! مادرم صدای نرم و دلنشینی دارد!"

گرگ که نقشه‌اش لو رفته بود، خیلی عصبانی شد و با صدای زمخت خودش گفت: "اگر در را باز نکنی، می‌آیم و در را می‌شکنم!"

بزغاله ترسیده بود اما عاقلانه عمل کرد. او یک سطل آب داغ از پشت بام روی سر گرگ خالی کرد. گرگ جیغی کشید و فرار کرد. در همان لحظه، مادر بزغاله از راه رسید و داستان را شنید.

مادر به بزغاله گفت: "آفرین پسرم! با هوش و ذکاوت خودت را نجات دادی. هیچ‌وقت حرف‌های شیرین غریبه‌ها را باور نکن!"''',
  'moral': 'هیچ‌وقت حرف‌های شیرین غریبه‌ها را باور نکن و همیشه به حرف پدر و مادرت گوش بده',
  'color': Colors.orange,
  'icon': Icons.pets,
  'image': '',
},

// ==================================================
// دسته 2: قصه‌های پندآموز (3 داستان جدید)
// ==================================================

// 4. تبرک طلایی
{
  'name': 'تبرک طلایی',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان هیزم‌شکنی که تبرش را در رودخانه انداخت و فرشته به او کمک کرد',
  'story': '''روزی روزگاری، هیزم‌شکن فقیری در کنار رودخانه مشغول بریدن درخت بود که ناگهان تبرش از دستش لغزید و در رودخانه افتاد. هیزم‌شکن که تبرش تنها وسیله کارش بود، شروع به گریه کرد.

ناگهان، فرشته‌ای از آب بیرون آمد و گفت: "چرا گریه می‌کنی ای مرد؟"

هیزم‌شکن داستان را برای فرشته تعریف کرد. فرشته به آب رفت و یک تبر طلایی بیرون آورد و گفت: "آیا این تبر توست؟"

هیزم‌شکن با صداقت گفت: "نه، تبر من طلایی نبود."

فرشته دوباره به آب رفت و یک تبر نقره‌ای بیرون آورد و پرسید: "این یکی؟"

هیزم‌شکن گفت: "نه، تبر من از آهن بود."

فرشته بار سوم به آب رفت و تبر آهنی هیزم‌شکن را بیرون آورد. هیزم‌شکن با خوشحالی گفت: "بله! این همان تبر من است!"

فرشته از صداقت هیزم‌شکن خیلی خوشش آمد و هر سه تبر را به او هدیه داد. هیزم‌شکن با خوشحالی به خانه برگشت و داستان را برای همسایه‌اش تعریف کرد.

همسایه که مرد حریصی بود، روز بعد به سراغ رودخانه رفت و عمداً تبرش را در آب انداخت و شروع به گریه کرد. فرشته از آب بیرون آمد و یک تبر طلایی به او نشان داد و گفت: "آیا این تبر توست؟"

همسایه حریص گفت: "بله! همان است!"

فرشته که از دروغ او خیلی ناراحت شده بود، گفت: "دروغ گفتی!" و با تبر طلایی به سر او زد و او را تنبیه کرد و از آنجا ناپدید شد.

همسایه حریص، هم تبر خودش را از دست داد و هم تبر طلایی را.''',
  'moral': 'صداقت همیشه پاداش دارد و دروغ باعث ضرر می‌شود',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 5. درخت بخشنده
{
  'name': 'درخت بخشنده',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان درختی که همه چیز خود را به پسر کوچکی بخشید',
  'story': '''روزی روزگاری، یک درخت بزرگ و زیبا در کنار یک روستا زندگی می‌کرد. یک پسر کوچک هر روز می‌آمد و زیر سایه درخت بازی می‌کرد، از میوه‌هایش می‌خورد و با شاخه‌هایش تاب بازی می‌کرد. درخت از دیدن پسر خیلی خوشحال می‌شد.

پسر بزرگ شد و دیگر کمتر به دیدن درخت می‌آمد. یک روز که پسر به سراغ درخت آمد، درخت گفت: "بیا و با من بازی کن!"

پسر گفت: "من دیگر بزرگ شده‌ام و به پول نیاز دارم."

درخت گفت: "میوه‌های مرا بچین و بفروش."

پسر میوه‌ها را چید و فروخت و دیگر به سراغ درخت نیامد.

سال‌ها بعد، پسر که حالا مرد جوانی شده بود، باز به سراغ درخت آمد. درخت با شوق گفت: "بیا و با من بازی کن!"

مرد گفت: "من خانه می‌خواهم بسازم ولی چوب ندارم."

درخت گفت: "شاخه‌های مرا ببر و با آنها خانه بساز."

مرد شاخه‌ها را برید و رفت و درخت از تنهایی غمگین شد.

سال‌ها گذشت و مرد که حالا پیر شده بود، باز به سراغ درخت آمد. درخت گفت: "دیگر چیزی برایت ندارم، فقط یک تنه خشک مانده‌ام."

پیرمرد گفت: "دیگر به چیزی نیاز ندارم، فقط می‌خواهم یک جای آرام برای نشستن داشته باشم."

درخت گفت: "روی تنه من بنشین و استراحت کن."

پیرمرد روی تنه درخت نشست و درخت خوشحال شد که بالاخره می‌تواند به دوستش کمک کند، حتی اگر فقط یک تنه خشک باشد.''',
  'moral': 'بخشش و مهربانی بدون چشمداشت، ارزشمندترین کار دنیاست',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 6. دو برادر و گنج
{
  'name': 'دو برادر و گنج',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان دو برادر که یکی حریص و دیگری بخشنده بود',
  'story': '''دو برادر در یک مزرعه زندگی می‌کردند. یکی از آنها خیلی حریص بود و دیگری بسیار بخشنده. یک شب، پیرمرد عاقلی به نزد آنها آمد و گفت: "در مزرعه شما یک گنج بزرگ دفن شده است. اگر آن را پیدا کنید، ثروتمند خواهید شد."

برادر حریص از این خبر خیلی خوشحال شد و شب تا صبح به دنبال گنج گشت. صبح روز بعد، برادر بخشنده گفت: "من نیازی به گنج ندارم. اگر تو پیدا کنی، همه مال توست."

برادر حریص به جستجو ادامه داد و در نهایت یک گنج بزرگ پیدا کرد. اما وقتی سکه‌ها را بیرون آورد، دید همه سکه‌ها سیاه شده‌اند. با خودش گفت: "این گنج بی‌ارزش است!"

برادر بخشنده که این را دید، گفت: "بیا سکه‌ها را بشوییم." وقتی سکه‌ها را شستند، دیدند که طلای ناب هستند. برادر حریص که می‌خواست همه را برای خودش نگه دارد، گفت: "من گنج را پیدا کردم، پس همه مال من است."

برادر بخشنده گفت: "خیلی خب، هرچه می‌خواهی بردار."

برادر حریص تمام سکه‌ها را برداشت و به شهر رفت. اما در راه، سارقان به او حمله کردند و همه سکه‌ها را دزدیدند. برادر حریص خالی به مزرعه برگشت.

برادر بخشنده که هیچ‌وقت به دنبال گنج نرفته بود، با آرامش به کارش ادامه داد. چند روز بعد، وقتی داشت زمین را شخم می‌زد، یک گنج دیگر پیدا کرد. این بار، او گنج را با همسایگانش تقسیم کرد و همه از او تشکر کردند.

برادر حریص که هیچ‌چیز نداشت، از برادرش خواست که به او هم کمک کند. برادر بخشنده پذیرفت و به او گفت: "حریص بودن هیچ فایده‌ای ندارد. خوشبختی در بخشش است."''',
  'moral': 'حرص و طمع باعث از دست دادن همه چیز می‌شود، بخشش باعث برکت',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// ==================================================
// دسته 3: فرهنگ و دانش بومی سنتی مردم (3 داستان جدید)
// ==================================================

// 7. نان‌وا و خمیر جادویی
{
  'name': 'نان‌وا و خمیر جادویی',
  'type': 'فرهنگ و دانش بومی سنتی مردم',
  'description': 'داستان نان‌وایی که خمیرش برکت داشت و به فقرا نان می‌داد',
  'story': '''در یک روستای قدیمی، نان‌وایی بود که هر روز صبح زود بیدار می‌شد و نان می‌پخت. خمیر او همیشه خوب ور می‌آمد و نان‌هایش خوشمزه و پربرکت بود. مردم از دور و نزدیک برای خرید نان به نانوایی او می‌آمدند.

یک روز، مسافری که از راه دور آمده بود، به نان‌وا گفت: "راز نان‌های خوشمزه تو چیست؟ من سفر کرده‌ام و هرگز اینقدر نان خوشمزه نخورده‌ام."

نان‌وا با لبخند گفت: "راز نان من، خمیر جادویی است که مادربزرگم به من یاد داد. او گفت: 'هر وقت نان می‌پزی، یک مشت از خمیرت را به فقرا بده تا برکت در نانت بماند.'"

مسافر تعجب کرد و گفت: "پس باید خیلی نان به فقرا داده باشی!"

نان‌وا گفت: "بله، هر روز صبح یک سبد نان برای فقرای روستا می‌برم. از وقتی این کار را می‌کنم، خمیرم همیشه خوب ور می‌آید و نانم خوشمزه می‌شود."

چند روز بعد، یک مهمان ناخوانده به نانوایی آمد. او یک پادشاه بود که لباس مبدل پوشیده بود و می‌خواست ببیند مردم چطور زندگی می‌کنند. پادشاه یک نان خرید و از خوشمزگی آن شگفت‌زده شد.

پادشاه به نان‌وا گفت: "من پادشاه هستم. می‌خواهم تو را به عنوان نان‌وای مخصوص قصر انتخاب کنم."

نان‌وا گفت: "متاسفم پادشاه بزرگوار! من نمی‌توانم روستا را ترک کنم. اینجا فقیرانی هستند که هر روز به نان من نیاز دارند. اگر بروم، آنها گرسنه می‌مانند."

پادشاه از بزرگواری نان‌وا شگفت‌زده شد و دستور داد برای روستا یک نانوایی بزرگ بسازند و به نان‌وا کمک کنند تا بتواند به همه مردم نان بدهد.

از آن روز، روستا به روستای برکت معروف شد و نان‌وا تا پایان عمرش به فقرا نان می‌داد و خمیرش همیشه برکت داشت.''',
  'moral': 'بخشش و کمک به دیگران برکت زندگی را زیاد می‌کند',
  'color': Colors.amber,
  'icon': Icons.auto_stories,
  'image': '',
},

// 8. فرش باف ماهر
{
  'name': 'فرش باف ماهر',
  'type': 'فرهنگ و دانش بومی سنتی مردم',
  'description': 'داستان فرش‌بافی که با عشق و صبر، زیباترین فرش‌ها را می‌بافت',
  'story': '''در یک روستای کوهستانی، استاد فرش‌بافی زندگی می‌کرد که با عشق و صبر، زیباترین فرش‌های جهان را می‌بافت. مردم از شهرهای دور می‌آمدند تا یک تکه از هنر او را به خانه ببرند.

استاد یک شاگرد جوان داشت که عجله داشت و می‌خواست زودتر استاد شود. یک روز به استاد گفت: "استاد! چرا اینقدر آرام گره می‌زنی؟ اگر سریع‌تر کار کنی، می‌توانی فرش‌های بیشتری بفروشی."

استاد لبخندی زد و گفت: "فرش مثل یک قصه است. هر گره، یک کلمه است و هر رنگ، یک احساس. اگر عجله کنی، قصه‌ات بی‌معنا می‌شود."

شاگرد حرف استاد را گوش نکرد و شروع به بافتن فرش با سرعت کرد. یک ماه بعد، فرشش تمام شد. اما وقتی آن را به استاد نشان داد، استاد گفت: "این فرش زیبا نیست. گره‌ها شل هستند، رنگ‌ها با هم هماهنگ نیستند و طرحش نامفهوم است."

شاگرد ناراحت شد و گفت: "پس باید چکار کنم؟"

استاد گفت: "هر روز قبل از شروع کار، یک دقیقه چشم‌هایت را ببند و به طرحی که می‌خواهی ببافی فکر کن. با عشق گره بزن و هر گره را با دقت بباف. فرش، قلب تو را نشان می‌دهد."

شاگرد حرف استاد را گوش کرد و با صبر و حوصله شروع به بافتن فرش جدید کرد. سه ماه بعد، وقتی فرش تمام شد، استاد گفت: "این یک شاهکار است! گره‌ها محکم، رنگ‌ها هماهنگ و طرح زیبا است. حالا تو استاد شده‌ای."

شاگرد از حرف استاد خوشحال شد و فهمید که برای رسیدن به کمال، باید صبور بود و با عشق کار کرد.''',
  'moral': 'صبر و عشق در کار، زیباترین نتیجه را به ارمغان می‌آورد',
  'color': Colors.amber,
  'icon': Icons.auto_stories,
  'image': '',
},

// 9. سفالگر و کوزه شکسته
{
  'name': 'سفالگر و کوزه شکسته',
  'type': 'فرهنگ و دانش بومی سنتی مردم',
  'description': 'داستان سفالگری که با عشق کوزه شکسته را تعمیر کرد',
  'story': '''در یک کارگاه سفالگری قدیمی، استاد سفالگری با عشق و هنر، کوزه‌های زیبا می‌ساخت. یک روز، یکی از شاگردانش در حین کار، یک کوزه زیبا را از روی میز انداخت و آن شکست.

شاگرد که خیلی ناراحت شده بود، گفت: "استاد! من کوزه زیبای شما را شکستم! متاسفم!"

استاد با مهربانی گفت: "ناراحت نباش. هیچ چیز غیرقابل تعمیر نیست."

استاد تکه‌های کوزه را جمع کرد و با دقت شروع به چسباندن آنها کرد. نه فقط با چسب، بلکه با ترکیبی از طلا و نقره. وقتی کارش تمام شد، کوزه زیباتر از قبل شده بود. خطوط طلایی که تکه‌ها را به هم وصل می‌کردند، مثل یک نقش جدید بر روی کوزه خودنمایی می‌کردند.

شاگرد با تعجب گفت: "استاد! کوزه زیباتر از قبل شده است!"

استاد گفت: "در ژاپن به این هنر 'کینتسوگی' می‌گویند. آنها معتقدند که شکستگی‌ها بخشی از تاریخ شیء هستند و نباید آنها را پنهان کرد. با طلا و نقره، شکستگی‌ها را تزئین می‌کنند تا زیبایی جدیدی خلق شود."

شاگرد پرسید: "ما هم می‌توانیم این کار را انجام دهیم؟"

استاد گفت: "بله، این یک هنر قدیمی است که نشان می‌دهد حتی چیزهای شکسته هم می‌توانند دوباره زیبا شوند. مثل زندگی ما که با تجربه‌های تلخ و شیرین، زیباتر می‌شود."

از آن روز، شاگردان استاد یاد گرفتند که هیچ چیز را دور نیندازند و با عشق و هنر، چیزهای شکسته را دوباره زیبا کنند.''',
  'moral': 'هیچ چیز غیرقابل تعمیر نیست و شکستگی‌ها می‌توانند به زیبایی تبدیل شوند',
  'color': Colors.amber,
  'icon': Icons.auto_stories,
  'image': '',
},

// ==================================================
// دسته 4: قصه‌های تخیلی (3 داستان جدید)
// ==================================================

// 10. ابر نقره‌ای
{
  'name': 'ابر نقره‌ای',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان ابری که می‌توانست آرزوها را به آسمان ببرد',
  'story': '''در آسمان آبی، یک ابر نقره‌ای زندگی می‌کرد که می‌توانست آرزوهای مردم را بشنود و به آسمان برساند. هر کس زیر این ابر می‌ایستاد و آرزویش را زمزمه می‌کرد، آرزویش به گوش خدا می‌رسید.

یک روز، دختر کوچکی به اسم لیلا زیر ابر نقره‌ای ایستاد و گفت: "ای ابر نقره‌ای! آرزوی من این است که مادرم که بیمار است، خوب شود."

ابر آرزوی لیلا را با خود به آسمان برد. چند روز بعد، مادر لیلا خوب شد. لیلا خیلی خوشحال بود.

پسر کوچکی به اسم رضا هم زیر ابر ایستاد و گفت: "ای ابر نقره‌ای! من دوست ندارم که همسایه‌مان پیرمرد تنها باشد. آرزو می‌کنم دوست‌هایی پیدا کند."

ابر آرزوی رضا را هم به آسمان برد. یک هفته بعد، پیرمرد تنها با چند نفر از همسایه‌ها دوست شد و دیگر تنها نبود.

خبر ابر نقره‌ای به گوش پادشاه حریص رسید. او دستور داد ابر را بگیرند و به قصر بیاورند. سربازان پادشاه با تورهای بزرگ به دنبال ابر رفتند، اما ابر نقره‌ای آنقدر بلند پرواز می‌کرد که هیچ‌کس نمی‌توانست آن را بگیرد.

پادشاه عصبانی شد و گفت: "اگر ابر را نگیرید، همه شما را زندانی می‌کنم!"

اما ابر نقره‌ای فهمید که پادشاه می‌خواهد از آرزوها برای خودش استفاده کند. ابر تصمیم گرفت دیگر به حرف‌های پادشاه گوش ندهد و فقط آرزوهای خوب مردم را به آسمان ببرد.

سال‌ها گذشت و ابر نقره‌ای همچنان در آسمان می‌درخشید و آرزوهای مردم را به آسمان می‌برد. و همه می‌دانستند که هر آرزوی خوبی، به ابر نقره‌ای می‌رسد و به حقیقت می‌پیوندد.''',
  'moral': 'آرزوهای خوب همیشه به حقیقت می‌پیوندند و هیچ قدرتی نمی‌تواند جلوی آنها را بگیرد',
  'color': Colors.purple,
  'icon': Icons.cloud,
  'image': '',
},

// 11. ماهی‌های پرنده
{
  'name': 'ماهی‌های پرنده',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان ماهی‌هایی که آرزوی پرواز داشتند و به آسمان رفتند',
  'story': '''در اعماق اقیانوس، یک دسته ماهی زندگی می‌کردند که آرزوی پرواز داشتند. هر روز وقتی پرنده‌ها را بالای سرشان می‌دیدند، غبطه می‌خوردند و می‌گفتند: "کاش ما هم می‌توانستیم مثل پرنده‌ها پرواز کنیم!"

پیرترین ماهی که اسمش نِی‌مو بود، گفت: "من دریاها را گشته‌ام و داستان‌های زیادی شنیده‌ام. می‌گویند اگر یک پر جادویی از پرنده‌های دریا پیدا کنید، می‌توانید پرواز کنید."

ماهی‌ها با شوق شروع به جستجو کردند. آنها همه جا را گشتند تا اینکه یک روز، ماهی کوچکی به اسم ماهی، یک پر آبی زیبا در میان مرجان‌ها پیدا کرد.

وقتی پر را لمس کردند، ناگهان بال‌هایی زیبا در پشت آنها رشد کرد. ماهی‌ها با خوشحالی از آب بیرون پریدند و شروع به پرواز کردند. آنها بالای اقیانوس پرواز می‌کردند و از منظره لذت می‌بردند.

اما یک روز، ماهی‌ها دیدند که پرنده‌ها ناراحت هستند. از آنها پرسیدند: "چرا ناراحتید؟"

پرنده‌ها گفتند: "ما فکر می‌کردیم شما فقط ماهی هستید. حالا که شما هم می‌توانید پرواز کنید، دیگر ما خاص نیستیم."

ماهی‌ها با هم مشورت کردند و تصمیم گرفتند که پرواز را فقط در شب انجام دهند تا پرنده‌ها ناراحت نشوند. از آن روز، هر شب وقتی آسمان تاریک می‌شد، ماهی‌های پرنده از آب بیرون می‌پریدند و زیر نور مهتاب پرواز می‌کردند.

و پرنده‌ها هم به آنها احترام می‌گذاشتند و یاد گرفتند که همه موجودات می‌توانند رویاهای خود را داشته باشند.''',
  'moral': 'هر کسی می‌تواند رویای خود را داشته باشد، اما نباید دیگران را ناراحت کرد',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 12. کلاه جادویی
{
  'name': 'کلاه جادویی',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان پسری که یک کلاه جادویی پیدا کرد و هر خواسته‌اش را برآورده می‌کرد',
  'story': '''سامی، پسر کوچکی بود که یک روز در اتاق زیرشیروانی خانه مادربزرگش، یک کلاه قدیمی و خاک‌گرفته پیدا کرد. کلاه خیلی ساده بود، اما وقتی سامی آن را روی سرش گذاشت، ناگهان صدایی شنید: "سلام سامی! من کلاه جادویی هستم. هر چیزی که آرزو کنی، برایت برآورده می‌کنم!"

سامی که باور نمی‌کرد، گفت: "من یک بستنی شکلاتی بزرگ می‌خواهم!"

ناگهان یک بستنی بزرگ جلویش ظاهر شد. سامی ذوق‌زده شد و گفت: "وای! واقعاً جادویی است!"

سامی با کلاه جادویی شروع به آرزو کردن کرد. اول برای خودش آرزو کرد: یک دوچرخه قرمز، یک اسباب‌بازی بزرگ، یک کیک شکلاتی. بعد برای دوستانش آرزو کرد: برای رامین یک توپ فوتبال، برای سارا یک عروسک زیبا، برای علی یک کتاب مصور.

اما روزی که داشت برای همه آرزو می‌کرد، متوجه شد که کلاه دیگر کار نمی‌کند. با ناراحتی گفت: "چرا دیگر کار نمی‌کنی؟"

کلاه جادویی گفت: "من فقط تا زمانی کار می‌کنم که آرزوهایت خودخواهانه نباشد. وقتی برای دیگران آرزو کردی، قدرتم را از دست دادی، اما حالا که فهمیدی بهترین آرزو، آرزوی خوب برای دیگران است، دوباره کار می‌کنم!"

سامی خوشحال شد و از آن روز، با کلاه جادویی فقط برای دیگران آرزو می‌کرد. او فهمید که خوشبختی واقعی در شادی دیگران است.''',
  'moral': 'بهترین آرزوها، آرزوهایی هستند که برای دیگران می‌کنیم',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// ==================================================
// دسته 5: شعرهای کودکانه (3 شعر جدید)
// ==================================================

// 13. شعر کودکانه - بادبادک
{
  'name': 'بادبادک من',
  'type': 'شعرهای کودکانه',
  'description': 'شعری زیبا درباره بادبادک و پرواز در آسمان',
  'story': '''بادبادک من اومد تو آسمون
با یه دمِ گرم و یه نسیمِ خون

بال می‌زنه توی اون آبی
مثل یه پرنده‌ی زیبا و نابی

ریسمونش توی دست منه
هر جا که بره، دلم پیششه

با ابرها می‌ره به مسافرت
می‌بینه شهرها رو از بالا سر

گاهی می‌گم بیا پایین نازنین
نذار که گم بشی توی اون آسمونِ بیکرون

اما بادبادک می‌گه نه
من می‌خوام تا ابرها برم، ببینم چه خبره

بچه‌ها بیایید همه با هم
بیایید بادبادک ببریم به آسمونِ بی‌غم

تا با هم پرواز کنیم و شاد بشیم
از این روزای قشنگ، بی‌نهایت بهره ببریم''',
  'moral': 'پرواز و شادی کودکانه، زیباترین لحظات زندگی را می‌سازد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// 14. شعر کودکانه - باران و گلدون
{
  'name': 'باران و گلدون',
  'type': 'شعرهای کودکانه',
  'description': 'شعر باران و گلدون برای کودکان',
  'story': '''بارون اومد نم نمک
رو گل‌ها ریخت کم کمک

گلدون خندید با ذوق و شوق
بارون داد بهش عشق و روق

برگ‌ها سبز و شاداب شدن
غنچه‌ها وا شدن، آباد شدن

من نشستم کنار پنجره
نگاه به بارون، به شوقِ کودکی

بارون می‌گه: بچه‌ها بیایید
با من بازی کنید و بخندید

چتری بیارید و تو حیاط
با من برقصید، با من بخندید

بارون که تموم شد، رنگین‌کمان اومد
یه قوسِ زیبا، از شرق تا غرب

گفت: بچه‌ها، بارون رفت
اما یادش همیشه با ماست، همیشه در دلمون هست''',
  'moral': 'باران نشانه برکت و شادی است و همیشه بعد از آن، زیبایی می‌آید',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// 15. شعر کودکانه - پروانه‌ها
{
  'name': 'پروانه‌های رنگی',
  'type': 'شعرهای کودکانه',
  'description': 'شعری درباره پروانه‌های رنگارنگ و زیبایی طبیعت',
  'story': '''پروانه‌ها اومدن تو باغچه
با رنگ‌های قشنگ، با بال‌های نازک

یکی زرده مثل گل آفتابگردون
یکی آبیه مثل آسمونِ بی‌ابر

یکی صورتیه مثل شکوفه‌های بهار
یکی سبزه مثل برگای تازهٔ درختار

پروانه می‌گه: من آزادم
هر جا که دلم بخواد، پرواز می‌کنم

از گلی به گل دیگه می‌رم
شهدش رو می‌خورم و باز می‌رم

بچه‌ها بیایید با من بیایید
تو باغچه، با پروانه‌ها بازی کنید

اگه آروم باشید، کنارتون می‌شینم
روی شونه‌هاتون، بال می‌زنینم

پروانه‌ها مهمون بهاره‌ان
با اومدنشون، دلها بی‌قرارن

نگهشون داریم تا آخر بهار
با عشق و با مهربونی، بی‌هیچ غمی''',
  'moral': 'زیبایی طبیعت و پروانه‌ها، به ما یادآوری می‌کند که آزاد و شاد باشیم',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// ==================================================
// دسته 6: لالایی‌ها (3 لالایی جدید)
// ==================================================

// 16. لالایی ستاره
{
  'name': 'لالایی ستاره',
  'type': 'لالایی‌ها',
  'description': 'لالایی آرامش‌بخش با ستاره‌ها و مهتاب',
  'story': '''لالا لالا ای ستاره
بخواب آروم تو گهواره

ماه از پشت ابر اومده
برای تو قصه آورده

لالا لالا نازنینم
چراغ روشن زمینم

ستاره‌ها نگهبون تو هستن
نذارن هیچ غمی به دل بشینه

لالا لالا وقت خوابه
چشات بسته، بگو بسم‌الله

فردا دوباره می‌خندیم
با گل‌های بهاری می‌رقصیم

لالا لالا ای فرشته
خدا نگهدار تو باشه همیشه''',
  'moral': 'شب هنگام خواب، با آرامش و مهربانی به خواب بروید',
  'color': Colors.blue,
  'icon': Icons.night_shelter,
  'image': '',
},

// 17. لالایی گل سرخ
{
  'name': 'لالایی گل سرخ',
  'type': 'لالایی‌ها',
  'description': 'لالایی مادرانه با بوی گل سرخ و آواز شب',
  'story': '''لالا لالا گل سرخ
بوی عطرت می‌کنه هر برگ

خواب میاد آروم آروم
با نسیمی از شوق و مهر

لالا لالا ناز فرزند
تویی گل سرخ این باغ و گلد

نغمه‌های شب می‌خونن برات
پرنده‌ها می‌خونن به نرمی برات

لالا لالا وقت آرامش
بخواب و ببین رویای قشنگت

فردا خورشید می‌تازه
با روزی پر از شادی و تازه

لالا لالا مادر کنارت
تا صبح نگهبان تو هست''',
  'moral': 'مهر مادرانه، همیشه پناهگاه امن کودک است',
  'color': Colors.blue,
  'icon': Icons.night_shelter,
  'image': '',
},

// 18. لالایی مهتاب
{
  'name': 'لالایی مهتاب',
  'type': 'لالایی‌ها',
  'description': 'لالایی شبانه با مهتاب و رویای قشنگ',
  'story': '''لالا لالا ای مهتاب
بخواب تو باغ پر از خواب

نسیم شب می‌پیچه آروم
می‌کنه دلت رو پر از آرزوهات

لالا لالا کودک نازم
خدا پشت و پناهت باشه همیشه

تو خواب ببین عشق و مهربونی
درخت و آب و آسمونی

لالا لالا وقت رویاست
چشاتو ببند، ببین چه زیباست

فردا دوباره بیدار می‌شی
با خنده و بازی، سبز و پر از پری

لالا لالا شب شده تاریک
اما دلت پر از نور و شادی و عشق''',
  'moral': 'شب، زمان آرامش و رویاهای شیرین است',
  'color': Colors.blue,
  'icon': Icons.night_shelter,
  'image': '',
},

// ==================================================
// دسته 7: قصه‌های شب (3 داستان جدید)
// ==================================================

// 19. سایه‌های شب
{
  'name': 'سایه‌های شب',
  'type': 'قصه‌های شب',
  'description': 'داستان پسری که از سایه‌های شب می‌ترسید و با آن دوست شد',
  'story': '''آرمان، پسر کوچکی بود که شب‌ها از سایه‌های روی دیوار می‌ترسید. هر شب وقتی چراغ را خاموش می‌کرد، سایه‌های عجیبی روی دیوار می‌افتاد و او را می‌ترساند.

یک شب، مادرش کنار تختش نشست و گفت: "آرمان جان، می‌دانی سایه‌ها از کجا می‌آیند؟"

آرمان گفت: "نه مامان، من فقط می‌ترسم!"

مادرش چراغ را روشن کرد و یک عروسک را جلوی نور گرفت. سایه عروسک روی دیوار افتاد. گفت: "ببین آرمان، این سایه عروسک است. سایه‌ها فقط تصویر چیزهای واقعی هستند."

آرمان با دقت نگاه کرد و دید که راست می‌گوید. مادرش ادامه داد: "حالا بیا با سایه‌ها بازی کنیم!"

آنها با دست‌هایشان سایه‌های مختلف روی دیوار درست کردند: یک خرگوش، یک پرنده، یک سگ. آرمان خندید و گفت: "چقدر بامزه! سایه‌ها اصلاً ترسناک نیستند!"

از آن شب، آرمان دیگر از سایه‌ها نمی‌ترسید. هر شب قبل از خواب، با سایه‌ها بازی می‌کرد و برای خودش داستان‌های قشنگی می‌ساخت. او فهمید که ترس‌ها اغلب در ذهن ما هستند و با شناخت آنها، می‌توانیم بر ترس‌هایمان غلبه کنیم.''',
  'moral': 'ترس‌ها اغلب در ذهن ما هستند و با شناخت آنها می‌توانیم بر آنها غلبه کنیم',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 20. شهر زیر زمینی
{
  'name': 'شهر زیر زمینی',
  'type': 'قصه‌های شب',
  'description': 'داستان دختری که یک شهر زیرزمینی پر از نور پیدا کرد',
  'story': '''نازنین، دختر کوچکی بود که عاشق ماجراجویی بود. یک شب، وقتی داشت در حیاط بازی می‌کرد، متوجه یک سوراخ کوچک زیر درخت قدیمی شد. با کنجکاوی شروع به کندن کرد و ناگهان یک راه پله زیرزمینی پیدا کرد.

با ترس و هیجان از پله‌ها پایین رفت. به یک شهر زیرزمینی پر از نور رسید. همه چیز در آنجا می‌درخشید: سنگ‌ها، درخت‌ها، خانه‌ها. یک پیرمرد مهربان به استقبالش آمد و گفت: "به شهر نور خوش آمدی! ما هزاران سال است که اینجا زندگی می‌کنیم."

نازنین پرسید: "چرا اینجا اینقدر روشن است؟"

پیرمرد گفت: "ما از سنگ‌های درخشان برای روشنایی استفاده می‌کنیم. این سنگ‌ها نور خورشید را جذب می‌کنند و شب‌ها آن را آزاد می‌کنند."

نازنین در شهر زیرزمینی قدم زد و چیزهای قشنگی دید: درختانی که میوه‌های درخشان داشتند، پرنده‌هایی که با نور پرواز می‌کردند، کودکانی که با توپ‌های نورانی بازی می‌کردند.

وقتی وقت برگشتن شد، پیرمرد یک سنگ کوچک درخشان به او هدیه داد و گفت: "این سنگ را در اتاقت بگذار تا هر شب نور و روشنایی داشته باشی."

نازنین با خوشحالی به خانه برگشت و سنگ را کنار تختش گذاشت. از آن شب، اتاقش همیشه پر از نور ملایمی بود و او هیچ‌وقت از تاریکی نمی‌ترسید.''',
  'moral': 'همیشه در تاریکی، راهی برای روشنایی وجود دارد',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 21. فانوس جادویی
{
  'name': 'فانوس جادویی',
  'type': 'قصه‌های شب',
  'description': 'داستان فانوسی که در شب راهنمای مردم بود',
  'story': '''در یک روستای کوچک، یک فانوس قدیمی وجود داشت که هر شب روشن می‌شد و راه مردم را در تاریکی روشن می‌کرد. فانوس سال‌ها بود که در وسط میدان بود و همه دوستش داشتند.

یک شب، باد شدیدی وزید و فانوس خاموش شد. مردم ناراحت شدند و نمی‌دانستند چکار کنند. همه در تاریکی راهشان را گم کرده بودند.

پسری به اسم کیان، فانوس را از روی پایه برداشت و به خانه برد. با دقت آن را تمیز کرد و روغن جدیدی در آن ریخت. وقتی دوباره فانوس را روشن کرد، نور آن از همیشه درخشان‌تر شد.

کیان فانوس را به میدان برگرداند و آن را روی پایه گذاشت. اما این بار، فانوس نه تنها راه مردم را روشن می‌کرد، بلکه چیزهای قشنگی هم نشان می‌داد: روی دیوارها، نقاشی‌های نورانی ظاهر می‌شد که قصه‌های قدیمی را نشان می‌دادند.

مردم دور فانوس جمع شدند و از تماشای نقاشی‌ها لذت می‌بردند. کیان فهمید که گاهی چیزهای قدیمی، وقتی با عشق ترمیم می‌شوند، ارزش بیشتری پیدا می‌کنند.''',
  'moral': 'چیزهای قدیمی با عشق و توجه، دوباره زنده می‌شوند و ارزش بیشتری پیدا می‌کنند',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// ==================================================
// دسته 8: داستان‌های دفاع مقدس (3 داستان جدید)
// ==================================================

// 22. نامه‌های یک سرباز
{
  'name': 'نامه‌های یک سرباز',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'داستان سربازی که هر هفته برای مادرش نامه می‌نوشت',
  'story': '''در دوران جنگ تحمیلی، سرباز جوانی به اسم حسین در جبهه حضور داشت. هر هفته برای مادرش نامه می‌نوشت و از حال و هوای جبهه برایش می‌گفت.

در اولین نامه نوشت: "مادر جان! من خوبم. اینجا هوا سرد است اما دل بچه‌ها گرم است. همه با هم مثل یک خانواده هستیم. نگران من نباش."

در نامه دوم نوشت: "مادر! امروز همسنگرم سعید برایمان نان پخت. عجب نان خوشمزه‌ای بود! یاد نان‌های تو افتادم."

در نامه سوم نوشت: "مادر! دیروز یک پرنده روی سیم‌های خاردار نشست و آواز خواند. همه بچه‌ها خندیدند و برای یک لحظه جنگ را فراموش کردند."

در نامه چهارم نوشت: "مادر! امشب باران آمد. من به باران فکر می‌کردم که در کویر ما چقدر نادر است. باران برای ما مثل یک هدیه آسمانی است."

نامه‌های حسین هر هفته می‌رسید و مادرش با اشتیاق آنها را می‌خواند و برای همسایه‌ها تعریف می‌کرد. اما یک روز، نامه‌ها قطع شد.

مادر حسین چند روزی منتظر ماند، اما خبری نشد. تا اینکه یک روز، یکی از همسنگرهای حسین به دیدنش آمد و نامه‌های حسین را به او داد. در آخرین نامه حسین نوشته بود: "مادر! اگر من نیامدم، ناراحت نباش. من به آرزوی بزرگم رسیدم و برای وطنم جنگیدم. همیشه به یادت هستم."

مادر حسین با اشک نامه را خواند و فهمید که پسرش به آرزویش رسیده است. او نامه‌های حسین را تا آخر عمر نگه داشت و هر بار که ناراحت می‌شد، آنها را می‌خواند و دلداری می‌گرفت.''',
  'moral': 'ایثار و فداکاری برای وطن، عشق و از خودگذشتگی را نشان می‌دهد و مادران همیشه الهام‌بخش فرزندان خود هستند',
  'color': Colors.red,
  'icon': Icons.mail,
  'image': '',
},

// 23. گلدان همیشه سبز
{
  'name': 'گلدان همیشه سبز',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'داستان گلدانی که در زمان جنگ، نماد امید و زندگی بود',
  'story': '''در یک سنگر کوچک در جبهه، یک گلدان کوچک با یک نهال سبز وجود داشت. این گلدان مال رضا، سرباز جوانی بود که از خانه آورده بود. او هر روز به نهال آب می‌داد و با آن حرف می‌زد.

همسنگرهایش می‌خندیدند و می‌گفتند: "رضا! اینجا جای گل و گیاه نیست، اینجا جای جنگ است!"

رضا می‌گفت: "این نهال یادآور زندگی است. اگر ما از زندگی غافل شویم، جنگ بر ما پیروز می‌شود. ما برای زندگی می‌جنگیم، نه برای مرگ."

روزها گذشت و نهال بزرگ شد. رضا یک گلدان بزرگتر برایش پیدا کرد و آن را جابه‌جا کرد. همه بچه‌های سنگر به نهال علاقه‌مند شده بودند و هر کسی که به سنگر می‌آمد، اول به نهال سر می‌زد.

یک روز که بمباران شدیدی شد، همه به سنگر پناه بردند. وقتی بمباران تمام شد، دیدند که سنگر آسیب دیده اما گلدان سالم مانده است. رضا گفت: "این گلدان نماد زندگی و امید ماست. تا وقتی که این گلدان سبز است، ما هم زنده‌ایم."

بعد از پایان جنگ، رضا گلدان را به خانه برد و در حیاط کاشت. آن نهال کوچک تبدیل به یک درخت بزرگ شد که هر سال بهار پر از گل می‌شد و یادآور روزهای سخت اما پر از امید بود.''',
  'moral': 'امید و زندگی همیشه بر تاریکی پیروز می‌شود، حتی در سخت‌ترین شرایط',
  'color': Colors.red,
  'icon': Icons.local_florist,
  'image': '',
},

// 24. شب عید در جبهه
{
  'name': 'شب عید در جبهه',
  'type': 'داستان‌های دفاع مقدس',
  'description': 'خاطره شب عیدی که بچه‌های جبهه برای هم عید گرفتند',
  'story': '''شب عید بود و بچه‌های جبهه در سنگر جمع شده بودند. هوا سرد بود اما دل‌هایشان گرم. هیچ‌کس به فکر سفره هفت‌سین نبود، اما دل‌هایشان پر از امید بود.

مجید، یکی از بچه‌ها، یک کتری چای برداشت و گفت: "بچه‌ها! بیایید به جای سفره هفت‌سین، یک کتری چای بگذاریم. این چای، نماد همدلی و همبستگی ماست."

همه با خوشحالی قبول کردند. هر کسی چیزی داشت که به سفره اضافه کند: یکی یک قوطی کنسرو، یکی یک تکه شکلات، یکی یک بسته بیسکویت. سفره عید آنها ساده اما پر از عشق بود.

نیمه‌های شب، صدای تکبیر از بلندگوهای جبهه بلند شد. همه بچه‌ها بلند شدند و دست‌هایشان را به آسمان بلند کردند و برای خانواده‌هایشان دعا کردند.

احمد که تازه به جبهه آمده بود، گریه کرد و گفت: "دلم برای مادرم تنگ شده است."

همه دورش جمع شدند و مرتضی گفت: "ما همه برادر هم هستیم. مادر من، مادر تو هم هست."

آن شب، بچه‌های جبهه عید را در کنار هم جشن گرفتند. آنها فهمیدند که عید واقعی در کنار هم بودن و عشق ورزیدن است، حتی در دورترین نقطه‌ها.''',
  'moral': 'عید واقعی در کنار هم بودن و عشق ورزیدن است، حتی در سخت‌ترین شرایط',
  'color': Colors.red,
  'icon': Icons.celebration,
  'image': '',
},

// ==================================================
// دسته 9: داستان‌های کوتاه و تأمل‌برانگیز (3 داستان جدید)
// ==================================================
// ==================================================
// دسته 9: داستان‌های کوتاه و تأمل‌برانگیز (3 داستان جدید)
// ==================================================

// 25. آخرین نگاه
{
  'name': 'آخرین نگاه',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی کوتاه درباره نگاه آخر و ارزش لحظه‌ها',
  'story': '''هر روز صبح، مرد جوانی از کنار یک گلفروشی عبور می‌کرد و به گل‌های زیبا نگاه می‌کرد اما هیچ‌وقت نمی‌ایستاد.

یک روز، وقتی داشت از کنار گلفروشی عبور می‌کرد، گلفروش صدایش کرد: "پسر جوان! چرا هیچ‌وقت نمی‌ایستی و به گل‌ها نگاه نمی‌کنی؟"

مرد گفت: "من عجله دارم. همیشه کار دارم."

گلفروش گفت: "امروز بایست و به این گل سرخ نگاه کن. شاید آخرین باری باشد که چنین گلی می‌بینی."

مرد ایستاد و به گل نگاه کرد. واقعاً گل زیبایی بود. رنگش مثل آتش می‌درخشید و بوی خوشی داشت.

مرد پرسید: "چرا گفتی شاید آخرین بار باشد؟"

گلفروش گفت: "چون هیچ‌کس نمی‌داند فردا چه می‌شود. شاید فردا این گل پژمرده شود، شاید من نباشم، شاید تو نباشی. پس هر لحظه را غنیمت بشمار."

مرد تحت تأثیر قرار گرفت و یک گل خرید و به خانه برد. از آن روز، هر روز صبح می‌ایستاد و به گل‌ها نگاه می‌کرد و قدر لحظه‌ها را می‌دانست.''',
  'moral': 'هر لحظه از زندگی ارزشمند است و نباید آنها را از دست داد',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 26. سکوت و دریا
{
  'name': 'سکوت و دریا',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی درباره سکوت و قدرت آرامش در کنار دریا',
  'story': '''مردی که همیشه در شلوغی شهر زندگی می‌کرد، تصمیم گرفت برای چند روز به کنار دریا برود. او به دنبال آرامش بود.

وقتی به دریا رسید، نشست روی یک تخته سنگ و به دریا نگاه کرد. موج‌ها می‌آمدند و می‌رفتند. پرنده‌ها روی آب می‌نشستند و پرواز می‌کردند. همه چیز در حرکت بود، اما یک سکوت عمیقی همه جا را فرا گرفته بود.

مرد ساعتی نشست و فقط نگاه کرد. هیچ‌کس نبود که با او حرف بزند. هیچ صدایی نبود جز صدای امواج.

ناگهان، یک پیرمرد از کنارش عبور کرد و گفت: "چرا فقط نشسته‌ای و نگاه می‌کنی؟"

مرد گفت: "من به دنبال آرامش هستم."

پیرمرد گفت: "پس چرا حرف می‌زنی؟ آرامش در سکوت است، نه در کلمات. اگر می‌خواهی آرامش را پیدا کنی، باید سکوت را یاد بگیری."

پیرمرد رفت و مرد تنها ماند. او بارها و بارها این حرف را تکرار کرد و سرانجام چشمانش را بست و به صدای امواج گوش داد. در آن سکوت، آرامشی را پیدا کرد که تا به حال تجربه نکرده بود.

مرد فهمید که برای پیدا کردن آرامش، گاهی باید سکوت کرد و فقط گوش داد.''',
  'moral': 'آرامش واقعی در سکوت و گوش دادن به طبیعت پیدا می‌شود',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 27. پنجره باز
{
  'name': 'پنجره باز',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی کوتاه درباره فرصت‌ها و انتخاب‌های زندگی',
  'story': '''دختر جوانی در یک اتاق کوچک زندگی می‌کرد. پنجره‌ای رو به خیابان داشت که همیشه بسته بود. او دلش می‌خواست پنجره را باز کند اما می‌ترسید.

یک روز، یک پرنده کوچک روی طاقچه پنجره نشست و به داخل نگاه کرد. دختر با پرنده حرف زد: "چرا اینقدر آزاد هستی؟"

پرنده جواب داد: "چون من از پرواز نمی‌ترسم. من پنجره‌هایم را باز می‌گذارم و به استقبال دنیا می‌روم."

دختر گفت: "اما من می‌ترسم که اگر پنجره را باز کنم، باد بیاید و وسایلم را به هم بریزد."

پرنده گفت: "اما اگر پنجره را نبندی، هرگز نسیم بهاری را حس نمی‌کنی و صدای پرنده‌ها را نمی‌شنوی."

دختر فکر کرد و در نهایت پنجره را باز کرد. نسیم خنکی وارد شد و صدای پرنده‌ها به گوش رسید. او لبخندی زد و فهمید که چقدر از این کار محروم بوده است.

از آن روز، دختر هر روز پنجره را باز می‌کرد تا نسیم تازه و زندگی جدید را به اتاقش دعوت کند.''',
  'moral': 'برای دیدن دنیای جدید و تجربه زندگی، باید از ترس‌هایمان عبور کنیم',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// ==================================================
// دسته 10: قصه‌های پندآموز (3 داستان جدید - تکمیل‌کننده)
// ==================================================

// 28. گنج واقعی
{
  'name': 'گنج واقعی',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان مردی که برای پیدا کردن گنج به سفر رفت و گنج را در خانه پیدا کرد',
  'story': '''مردی به نام کریم، همیشه آرزو داشت که یک گنج بزرگ پیدا کند. او شب و روز به فکر گنج بود تا اینکه یک روز تصمیم گرفت به سفر برود و گنج را پیدا کند.

کریم وسایلش را جمع کرد و به راه افتاد. روزها و ماه‌ها سفر کرد و کوه‌ها و دشت‌ها را گشت. هر جا که می‌رسید، می‌گفت: "گنج اینجاست!" اما هیچ‌وقت گنجی پیدا نمی‌کرد.

یک روز که خیلی خسته شده بود، کنار یک رودخانه نشست. یک پیرمرد از آنجا عبور می‌کرد و کریم را دید که ناراحت است. پرسید: "چرا اینقدر ناراحتی؟"

کریم گفت: "من ماه‌هاست که به دنبال گنج می‌گردم اما هیچ‌چیز پیدا نکردم."

پیرمرد خندید و گفت: "گنج را در چه جایی جستجو می‌کنی؟"

کریم گفت: "هر جا که فکر می‌کردم گنج هست، رفتم."

پیرمرد گفت: "گنج واقعی در خانه توست. برو و زیر درخت انار حیاط خانه‌ات را بکن."

کریم که حرف پیرمرد باورش نمی‌شد، به خانه برگشت. زیر درخت انار را کند و یک گنج بزرگ پیدا کرد. او با خودش گفت: "من ماه‌ها به دنبال چیزی گشتم که همیشه در خانه خودم بود."

کریم فهمید که گاهی آنچه به دنبالش هستیم، در نزدیکی ماست و فقط باید با دقت نگاه کنیم.''',
  'moral': 'گاهی آنچه به دنبالش هستیم، در نزدیکی ماست و باید با دقت نگاه کنیم',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 29. آرزوی درخت
{
  'name': 'آرزوی درخت',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان درختی که آرزو داشت به جای دیگری برود اما سرانجام قدر جای خود را دانست',
  'story': '''یک درخت بزرگ در کنار یک رودخانه زندگی می‌کرد. هر روز به آب‌های روان نگاه می‌کرد و آرزو داشت که مانند آب، روان و آزاد باشد. گاهی به پرنده‌ها نگاه می‌کرد و آرزو داشت که مثل آنها پرواز کند.

یک روز، درخت به پرنده‌ای که روی شاخه‌اش نشسته بود گفت: "چقدر خوشحالم که جای تو هستی! تو آزادی و هر جا که دوست داری پرواز می‌کنی. اما من اینجا گیر کرده‌ام."

پرنده گفت: "اما تو هر روز می‌توانی منظره‌های جدیدی ببینی. من همیشه باید به دنبال غذا و لانه بگردم. تو ریشه‌های محکمی داری و هیچ‌کس نمی‌تواند تو را جابه‌جا کند."

درخت فکر کرد و گفت: "شاید حق با تو باشد. من هر روز آفتاب را می‌بینم که طلوع می‌کند و غروب می‌کند. باران را حس می‌کنم که به برگ‌هایم می‌خورد. پرنده‌ها را می‌بینم که روی شاخه‌هایم لانه می‌سازند."

پرنده گفت: "هر موجودی جایگاه خاص خودش را دارد. تو به پرنده‌ها سایه می‌دهی، به زمین میوه می‌دهی، به هوا اکسیژن می‌دهی. تو یکی از مهم‌ترین موجودات طبیعتی."

درخت که حرف‌های پرنده را شنید، فهمید که هر جا که هستیم، می‌توانیم مفید باشیم و قدر جایگاه خود را بدانیم.''',
  'moral': 'همیشه قدر جایگاه و موقعیت خود را بدانیم و برای دیگران مفید باشیم',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 30. لبخند مهربان
{
  'name': 'لبخند مهربان',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان پسری که با لبخندش دل یک پیرمرد تنها را شاد کرد',
  'story': '''در یک روستای کوچک، پسر جوانی به اسم سعید زندگی می‌کرد که همیشه لبخند می‌زد. همه او را دوست داشتند و می‌گفتند: "لبخند سعید، روز را برای ما روشن می‌کند."

یک روز، سعید متوجه شد که پیرمردی به اسم حاج رضا، هیچ‌وقت لبخند نمی‌زند. حاج رضا همیشه تنها بود و با کسی حرف نمی‌زد. سعید تصمیم گرفت با او دوست شود.

سعید هر روز از جلوی خانه حاج رضا عبور می‌کرد و با لبخند به او سلام می‌کرد. حاج رضا اول توجهی نمی‌کرد، اما کمک‌کم به سلام‌های سعید جواب می‌داد.

یک روز، سعید نزد حاج رضا رفت و گفت: "آقا حاج رضا! چرا هیچ‌وقت لبخند نمی‌زنید؟"

حاج رضا گفت: "من دلیلی برای لبخند زدن ندارم. من هیچ‌کس را ندارم."

سعید گفت: "اما من اینجام! من دوست شما هستم. هر روز با شما سلام می‌کنم. می‌خواهید با من قدم بزنید؟"

حاج رضا اول قبول نکرد، اما سعید آنقدر اصرار کرد که سرانجام پذیرفت. آنها با هم قدم زدند و سعید با مهربانی با او حرف می‌زد. کمک‌کم، لبخندی روی صورت حاج رضا نشست.

از آن روز، حاج رضا هر روز با سعید قدم می‌زد و لبخند می‌زد. او فهمید که با یک لبخند ساده، می‌توان زندگی دیگران را تغییر داد.''',
  'moral': 'یک لبخند مهربان می‌تواند زندگی دیگران را تغییر دهد و دل‌ها را به هم نزدیک کند',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 25. پنجره بسته
{
  'name': 'پنجره بسته',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستانی کوتاه درباره فرصت‌هایی که از پنجره‌های بسته می‌آیند',
  'story': '''پیرمردی در یک اتاق کوچک با یک پنجره بسته زندگی می‌کرد. هر روز صبح، کنار پنجره می‌نشست و به بیرون نگاه می‌کرد.

یک روز، همسایه‌اش به او گفت: "پیرمرد! چرا پنجره را باز نمی‌کنی تا هوای تازه وارد اتاق شود؟"

پیرمرد گفت: "من نمی‌خواهم بیرون را ببینم. من از پنجره بسته راضی هستم."

اما همسایه پنجره را باز کرد. هوای تازه وارد اتاق شد و نور خورشید از آن تابید. پیرمرد احساس شادابی کرد.

همسایه گفت: "گاهی باید پنجره‌های بسته زندگی را باز کنیم تا نور و هوای تازه وارد زندگیمان شود. نباید خودمان را در یک اتاق بسته حبس کنیم."

پیرمرد از آن روز، هر روز پنجره را باز می‌کرد و از نور و هوای تازه لذت می‌برد. او فهمید که گاهی کوچک‌ترین تغییرات، بزرگترین تأثیرات را در زندگی دارند.''',
  'moral': 'برای تغییر در زندگی، گاهی باید پنجره‌های بسته را باز کنیم و از فرصت‌های جدید استقبال کنیم',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 26. سایه و نور
{
  'name': 'سایه و نور',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستان مردی که سایه‌اش را دنبال می‌کرد و نور را پیدا کرد',
  'story': '''مردی همیشه به دنبال سایه‌اش بود. هر جا که می‌رفت، به زمین نگاه می‌کرد تا سایه‌اش را ببیند. یک روز، حکیمی به او گفت: "چرا همیشه به زمین نگاه می‌کنی؟"

مرد گفت: "من سایه‌ام را دنبال می‌کنم تا مطمئن شوم که هستم!"

حکیم گفت: "اگر می‌خواهی مطمئن شوی که هستی، به نور نگاه کن، نه به سایه. سایه فقط نتیجه‌ی نور است."

مرد حرف حکیم را خوب متوجه نشد. اما حکیم ادامه داد: "سایه همیشه پشت سر ماست. اگر به دنبال سایه بگردی، هیچ‌وقت به مقصد نمی‌رسی. اما اگر به نور نگاه کنی، راه را می‌بینی و به مقصد می‌رسی."

مرد فکر کرد و به جای نگاه به سایه، شروع به نگاه به آسمان و نور خورشید کرد. کمک‌کم، راهش را پیدا کرد و دیگر گم نشد.

او به حکیم گفت: "حالا فهمیدم. من باید به آینده و روشنایی نگاه کنم، نه به گذشته و تاریکی."

حکیم لبخندی زد و گفت: "همیشه به جلو نگاه کن، به نور و روشنایی. سایه‌ها خودشان از بین می‌روند."''',
  'moral': 'همیشه به آینده و روشنایی نگاه کنیم، نه به گذشته و تاریکی',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 27. لبخند و اشک
{
  'name': 'لبخند و اشک',
  'type': 'داستان‌های کوتاه و تأمل‌برانگیز',
  'description': 'داستان زنی که با لبخند، اشک‌هایش را پنهان می‌کرد',
  'story': '''زنی در یک روستا زندگی می‌کرد که همیشه لبخند می‌زد. همه فکر می‌کردند او خوشحال‌ترین زن روستا است. اما هیچ‌کس نمی‌دانست که او در درونش غم‌های بزرگی دارد.

یک روز، دختر کوچکی به او گفت: "خانم! چرا همیشه لبخند می‌زنی؟ آیا هرگز غمگین می‌شوی؟"

زن برای لحظه‌ای مکث کرد و سپس با چشمانی پر از اشک گفت: "بله عزیزم! من هم غمگین می‌شوم، اما یاد گرفته‌ام که با لبخند، غم‌هایم را پنهان کنم."

دختر پرسید: "چرا غم‌هایت را پنهان می‌کنی؟"

زن گفت: "چون لبخند، همیشه راهی برای شاد کردن دیگران است. اگر من غمگین باشم، دیگران هم غمگین می‌شوند."

دختر گفت: "اما تو نباید غم‌هایت را پنهان کنی. می‌توانی با من حرف بزنی. من گوش می‌کنم!"

زن اشک‌هایش را پاک کرد و با همان لبخند همیشگی گفت: "تو خیلی مهربانی! بودن با تو، غم‌هایم را کمتر می‌کند."

از آن روز، دختر کوچک هر روز به دیدار زن می‌رفت و با هم حرف می‌زدند. زن کمک‌کم غم‌هایش را با دختر در میان می‌گذاشت و لبخند واقعی‌تر شد.''',
  'moral': 'مهربانی و همدردی با دیگران، حتی دردهای بزرگ را هم قابل تحمل می‌کند',
  'color': Colors.deepPurple,
  'icon': Icons.auto_stories,
  'image': '',
},

// 27. شب‌چراغ جادویی
{
  'name': 'شب‌چراغ جادویی',
  'type': 'قصه‌های شب',
  'description': 'داستان شب‌چراغی که در تاریکی راهنمای بچه‌ها بود',
  'story': '''در یک روستای کوچک، شب‌چراغی قدیمی در میدان بود که هر شب روشن می‌شد و راه مردم را در تاریکی روشن می‌کرد. بچه‌های روستا عاشق شب‌چراغ بودند و هر شب دور آن جمع می‌شدند.

یک شب، طوفان شدیدی آمد و شب‌چراغ خاموش شد. همه جا تاریک شد و بچه‌ها ترسیدند. پسر کوچکی به اسم علی، شب‌چراغ را از پایه برداشت و به خانه برد.

او شب‌چراغ را تمیز کرد و روغن جدیدی در آن ریخت. وقتی دوباره روشن شد، نور آن از همیشه درخشان‌تر بود. علی شب‌چراغ را به میدان برگرداند.

اما این بار، شب‌چراغ نه تنها راه را روشن می‌کرد، بلکه روی دیوارها نقاشی‌های نورانی ظاهر می‌شد که قصه‌های قدیمی را نشان می‌دادند.

بچه‌های روستا دور شب‌چراغ جمع شدند و از تماشای نقاشی‌ها لذت می‌بردند. علی فهمید که گاهی چیزهای قدیمی، وقتی با عشق ترمیم می‌شوند، ارزش بیشتری پیدا می‌کنند.

از آن شب، شب‌چراغ هر شب برای بچه‌ها قصه می‌گفت و آنها با خوشحالی به خانه می‌رفتند.''',
  'moral': 'چیزهای قدیمی با عشق و توجه، دوباره زنده می‌شوند و ارزش بیشتری پیدا می‌کنند',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 28. فرشته کوچک شب
{
  'name': 'فرشته کوچک شب',
  'type': 'قصه‌های شب',
  'description': 'داستان فرشته‌ای که شب‌ها به بچه‌ها آرامش می‌داد',
  'story': '''در آسمان، فرشته کوچکی بود که هر شب به زمین می‌آمد و به بچه‌ها آرامش می‌داد. او مثل یک نور کوچک، وارد اتاق بچه‌ها می‌شد و آنها را به خوابی آرام دعوت می‌کرد.

یک شب، فرشته کوچک به اتاق سارا آمد. سارا نمی‌توانست بخوابد و از تاریکی می‌ترسید. فرشته نشست کنار تخت سارا و با مهربانی گفت: "نترس سارا! من اینجا هستم. شب جای ترس نیست، شب جای آرامش است."

سارا با دیدن نور فرشته آرام شد و گفت: "چطور می‌توانم مثل تو نور داشته باشم؟"

فرشته گفت: "همیشه به چیزهای خوب فکر کن. به خانواده، به دوستان، به طبیعت زیبا. این افکار مثل نور درونت می‌درخشند."

سارا چشمانش را بست و به چیزهای خوب فکر کرد. کم‌کم خوابش برد و رویای زیبایی دید.

فرشته کوچک به اتاق‌های دیگر رفت و به همه بچه‌ها آرامش داد. تا اینکه صبح شد و فرشته به آسمان برگشت.

بچه‌های روستا هر شب منتظر فرشته کوچک بودند و با آرامش به خواب می‌رفتند.''',
  'moral': 'افکار مثبت و آرامش‌بخش، شب‌ها را برای ما دلپذیر می‌کنند',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 29. درخت چراغ‌ها
{
  'name': 'درخت چراغ‌ها',
  'type': 'قصه‌های شب',
  'description': 'داستان درختی که شب‌ها با چراغ‌هایش می‌درخشید',
  'story': '''در وسط یک جنگل، درخت بزرگی بود که شب‌ها با چراغ‌های کوچکی می‌درخشید. مردم جنگل به آن "درخت چراغ‌ها" می‌گفتند و هر شب به دیدنش می‌رفتند.

یک شب، دختر کوچکی به اسم نرگس به جنگل آمد تا درخت چراغ‌ها را ببیند. اما دید که چراغ‌های درخت خاموش هستند و درخت غمگین است.

نرگس به درخت گفت: "چرا چراغ‌هایت روشن نیست؟"

درخت با صدای آرامی گفت: "چون امسال خیلی خشکسالی بود و من آب کافی نداشتم. چراغ‌هایم برای روشن شدن به آب نیاز دارند."

نرگس دوان دوان به خانه رفت و یک کوزه آب آورد. آب را پای درخت ریخت و گفت: "ای درخت! این آب را به تو می‌دهم تا دوباره چراغ‌هایت روشن شوند!"

کم‌کم چراغ‌های درخت شروع به روشن شدن کردند. کمک‌کم درخشش بیشتری پیدا کرد و تمام جنگل را روشن کرد.

حیوانات جنگل دور درخت جمع شدند و از نرگس تشکر کردند. خرگوش گفت: "نرگس! تو با مهربانی‌ات درخت را زنده کردی!"

نرگس خوشحال شد و فهمید که با یک کار کوچک می‌توان یک درخت بزرگ را شاد کرد.''',
  'moral': 'با کارهای کوچک مهربانانه، می‌توانیم شادی بزرگی به دیگران هدیه دهیم',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 30. کلید طلایی شب
{
  'name': 'کلید طلایی شب',
  'type': 'قصه‌های شب',
  'description': 'داستان کلیدی که شب‌ها درهای بسته را باز می‌کرد',
  'story': '''پیرمردی در یک خانه قدیمی زندگی می‌کرد که یک کلید طلایی داشت. هر شب، با این کلید یک در مخفی را باز می‌کرد و وارد دنیای دیگری می‌شد.

یک شب، پسر کوچکی به اسم امیر، پیرمرد را دنبال کرد تا ببیند کجا می‌رود. پیرمرد در را باز کرد و وارد یک باغ بزرگ و نورانی شد.

امیر با تعجب پرسید: "آقا! اینجا کجاست؟"

پیرمرد گفت: "این باغ آرزوهاست. هر کس وارد این باغ شود، می‌تواند یک آرزو کند."

امیر پرسید: "آیا می‌توانم یک آرزو کنم؟"

پیرمرد گفت: "بله! هر کس یک بار می‌تواند از این باغ آرزو کند."

امیر فکر کرد و گفت: "من آرزو می‌کنم که همه مردم دنیا شاد باشند و هیچ‌کس غمگین نباشد."

پیرمرد لبخندی زد و گفت: "تو خیلی مهربانی! این بهترین آرزویی بود که تا به حال شنیده‌ام."

باغ درخشید و امیر احساس کرد که آرزویش به حقیقت پیوسته است. از آن شب، امیر هر شب به باغ آرزوها می‌رفت و به مردم کمک می‌کرد تا آرزوهای خوب داشته باشند.''',
  'moral': 'بهترین آرزوها، آرزوهایی هستند که به دیگران کمک می‌کنند',
  'color': Colors.indigo,
  'icon': Icons.nightlight_round,
  'image': '',
},

// 26. دو دوست در جنگل
{
  'name': 'دو دوست در جنگل',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان دو دوست که در جنگل با خرس روبرو شدند و یکی از آنها فرار کرد',
  'story': '''دو دوست صمیمی در یک روستا زندگی می‌کردند. یک روز، تصمیم گرفتند به جنگل بروند و گردش کنند. به هم قول دادند که در هر خطری، همدیگر را تنها نگذارند.

در میان جنگل، ناگهان یک خرس بزرگ از پشت بوته‌ها بیرون آمد و به سمت آنها حمله کرد. یکی از دوستان که از خرس خیلی ترسیده بود، سریعاً از درخت بالا رفت و دوستش را تنها گذاشت.

دوست دیگر که نمی‌توانست از درخت بالا برود، روی زمین افتاد و بی‌حرکت ماند. خرس به سمت او آمد، بویش را استشمام کرد و چون فکر کرد مرده است، از آنجا رفت.

وقتی خرس رفت، دوستی که روی درخت بود پایین آمد و به دوستش گفت: "خرس چه چیزی در گوشت گفت؟"

دوست دیگر با ناراحتی گفت: "خرس به من گفت که هیچ‌وقت به کسی که در خطر تو را تنها می‌گذارد، اعتماد نکن!"

دوست درخت‌نشین شرمنده شد و فهمید که در زمان خطر، دوست واقعی کسی است که به فکر تو باشد، نه اینکه فرار کند.

او از دوستش عذرخواهی کرد و از آن روز، دوست واقعی‌تری شد.''',
  'moral': 'دوست واقعی کسی است که در سختی‌ها به فکر تو باشد، نه اینکه فرار کند',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 27. باد و خورشید
{
  'name': 'باد و خورشید',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان باد و خورشید که مسابقه دادند تا مسافری را وادار به درآوردن کتش کنند',
  'story': '''روزی روزگاری، باد و خورشید با هم مسابقه دادند که کدامیک می‌توانند مسافری را که در جاده بود، مجبور کنند کتش را در بیاورد.

باد اول شروع کرد. با تمام قدرتش وزید و سعی کرد کت مسافر را از تنش بیرون بیاورد. اما هر چه باد بیشتر می‌وزید، مسافر بیشتر کتش را به خودش می‌پیچید و محکم‌تر می‌بست. باد خسته شد و تسلیم شد.

نوبت خورشید شد. خورشید با مهربانی شروع به تابیدن کرد و کم‌کم هوا را گرم کرد. مسافر که از گرما عرق کرده بود، کتش را درآورد و زیر درختی نشست.

خورشید گفت: "باد جان! زور و خشونت همیشه جواب نمی‌دهد. گاهی مهربانی و صبر، کارسازتر از زور است."

باد که حرف خورشید را شنید، گفت: "راست می‌گویی! من با زور نمی‌توانستم کاری کنم، اما تو با مهربانی نتیجه گرفتی."

از آن روز، باد یاد گرفت که همیشه باید با مهربانی و آرامش عمل کرد، نه با زور و خشونت.''',
  'moral': 'مهربانی و صبر همیشه کارسازتر از زور و خشونت است',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 28. شیشه‌گر و آینه
{
  'name': 'شیشه‌گر و آینه',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان شیشه‌گری که آینه‌ای ساخت و مردم را در آن دید',
  'story': '''شیشه‌گری ماهر یک آینه بزرگ ساخت. وقتی مردم به آینه نگاه می‌کردند، خودشان را می‌دیدند. اما هر کس تصویر خودش را به روشی متفاوت تفسیر می‌کرد.

مردی چاق به آینه نگاه کرد و گفت: "این آینه مرا چاق نشان می‌دهد! حتماً آینه خراب است!"

زنی با لباس کهنه به آینه نگاه کرد و گفت: "آینه مرا کهنه و زشت نشان می‌دهد! حتماً شیشه‌گر آینه را کج ساخته!"

پسر کوچکی به آینه نگاه کرد و گفت: "چه آینه قشنگی! من خودم را در آن می‌بینم!"

شیشه‌گر که حرف‌های مردم را شنید، به آنها گفت: "آینه فقط تصویر شما را نشان می‌دهد. اگر در آن چیزی می‌بینید که دوست ندارید، به جای شکایت از آینه، خودتان را تغییر دهید."

مردم از حرف شیشه‌گر شگفت‌زده شدند و فهمیدند که آینه فقط حقیقت را نشان می‌دهد. اگر در آینه چیزی را دوست ندارند، باید خودشان را تغییر دهند.

از آن روز، مردم هر روز به آینه نگاه می‌کردند و سعی می‌کردند خودشان را بهتر کنند.''',
  'moral': 'به جای شکایت از دیگران، به خودمان نگاه کنیم و خودمان را بهتر کنیم',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 29. پیرزن و چراغ جادویی
{
  'name': 'پیرزن و چراغ جادویی',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان پیرزنی که چراغ جادویی پیدا کرد اما هوشمندانه از آرزوهایش استفاده کرد',
  'story': '''پیرزن مهربانی در یک روستا زندگی می‌کرد. یک روز، در حال جمع‌آوری هیزم بود که یک چراغ قدیمی پیدا کرد. وقتی چراغ را مالید، یک جن از آن بیرون آمد و گفت: "ای پیرزن! من هر سه آرزوی تو را برآورده می‌کنم!"

پیرزن فکر کرد و گفت: "اولین آرزوی من این است که همه مردم روستا غذای کافی داشته باشند."

جن آرزوی اول را برآورده کرد و همه مردم روستا سیر شدند.

پیرزن گفت: "دومین آرزوی من این است که همه بیماران روستا خوب شوند."

جن آرزوی دوم را برآورده کرد و همه بیماران خوب شدند.

پیرزن گفت: "سومین آرزوی من این است که هیچ‌کس در روستا تنها نباشد و همه با هم مهربان باشند."

جن آرزوی سوم را برآورده کرد و روستا به مهربان‌ترین روستا تبدیل شد.

جن به پیرزن گفت: "تو خیلی مهربان هستی! بیشتر مردم آرزوهای خودخواهانه می‌کنند، اما تو به فکر دیگران بودی."

پیرزن گفت: "خوشبختی واقعی در شادی دیگران است. وقتی همه خوشحال باشند، من هم خوشحالم."

جن تحت تأثیر مهربانی پیرزن قرار گرفت و تصمیم گرفت برای همیشه در روستا بماند و به مردم کمک کند.''',
  'moral': 'خوشبختی واقعی در شادی و کمک به دیگران است، نه در ثروت و قدرت',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// 30. کوزه آب و سنگ‌ها
{
  'name': 'کوزه آب و سنگ‌ها',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان استادی که به شاگردش نشان داد چه چیزی در زندگی ارزشمند است',
  'story': '''یک استاد بزرگ، یک کوزه آب را روی میز گذاشت و به شاگردانش گفت: "این کوزه نشانه زندگی شماست."

سپس چند سنگ بزرگ در کوزه انداخت و پرسید: "آیا کوزه پر شده؟"

شاگردان گفتند: "بله، پر شده."

استاد سنگریزه‌های کوچک در کوزه ریخت و کوزه را تکان داد. سنگریزه‌ها بین سنگ‌ها جا گرفتند. پرسید: "حالا چی؟"

شاگردان گفتند: "الان پر شده."

استاد ماسه در کوزه ریخت و پرسید: "حالا؟"

شاگردان گفتند: "الان دیگر واقعاً پر شده!"

استاد یک فنجان آب در کوزه ریخت و گفت: "همیشه فکر می‌کنید وقتی سنگ‌ها را اول می‌گذارید، برای چیزهای دیگر جا نمی‌ماند. اما اگر اول سنگریزه‌ها را بگذارید، دیگر جایی برای سنگ‌ها نمی‌ماند."

استاد ادامه داد: "سنگ‌های بزرگ مهم‌ترین چیزهای زندگی هستند: خانواده، سلامتی، عشق. سنگریزه‌ها چیزهای مهم‌تر هستند: کار، خانه، دوستان. ماسه‌ها بقیه چیزها هستند. و آب، لحظات کوچک شادی است. همیشه اول سنگ‌های بزرگ را در زندگی بگذارید، چون بقیه چیزها جا می‌شوند."''',
  'moral': 'اولویت‌های زندگی را بشناسیم و همیشه مهم‌ترین‌ها را در اولویت قرار دهیم',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},
// ==================================================
// داستان‌های بلند جدید (۲۰ داستان)
// ==================================================

// داستان ۱: پسر کوچولو و درخت جادویی
{
  'name': 'پسر کوچولو و درخت جادویی',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان پسری که یک درخت جادویی پیدا کرد و با آن سفر کرد',
  'story': '''در یک روستای کوچک، پسر کوچکی به اسم کامیار زندگی می‌کرد. او عاشق طبیعت و درخت‌ها بود. هر روز می‌رفت توی جنگل و با درخت‌ها حرف می‌زد.

یک روز، کامیار در جنگل قدم می‌زد که یک درخت بزرگ و کهنسال را دید که هیچ‌وقت ندیده بود. درخت خیلی بزرگ بود و برگ‌هایش می‌درخشیدند. کامیار به سمت درخت رفت و دید که روی تنه درخت یک نوشته حک شده: "من یک درخت جادویی هستم. هر کس که با من حرف بزند، آرزویش برآورده می‌شود."

کامیار با تعجب به درخت گفت: "سلام درخت جادویی! من کامیار هستم. راست می‌گویی که آرزوها را برآورده می‌کنی؟"

درخت با صدای عمیق و آرامی گفت: "بله کامیار جان! هر آرزویی که بکنی، برآورده می‌شود. اما فقط یک آرزو می‌توانی بکنی."

کامیار فکر کرد که چه آرزویی بکند. می‌توانست آرزوی ثروت یا قدرت بکند، اما به یاد مادربزرگش افتاد که همیشه می‌گفت: "بهترین آرزو، آرزوی خوب برای دیگران است."

کامیار به درخت گفت: "من آرزو می‌کنم که همه مردم روستا شاد و خوشحال باشند و هیچ‌کس گرسنه و تنها نباشد."

درخت درخشید و گفت: "چه آرزوی قشنگی! تو پسر مهربانی هستی." ناگهان درخت شروع به درخشیدن کرد و هزاران گل و میوه از شاخه‌هایش آویزان شد.

کامیار با خوشحالی به روستا برگشت و دید که همه مردم شاد و خوشحال هستند. خانه‌ها پر از نور و شادی شده بود و هیچ‌کس گرسنه نبود.

کامیار فهمید که بهترین آرزو، آرزویی است که به دیگران هم کمک کند. از آن روز، او هر روز به دیدار درخت جادویی می‌رفت و با او حرف می‌زد و از او تشکر می‌کرد.

درخت جادویی همیشه به کامیار می‌گفت: "مهربانی تو باعث شد که روستا بهشت شود. همیشه به یاد داشته باش که با یک آرزوی خوب، می‌توانی دنیا را تغییر دهی."

و کامیار تا آخر عمر مهربان ماند و به دیگران کمک می‌کرد و همیشه دعای خیر همه مردم روستا همراه او بود.''',
  'moral': 'مهربانی و آرزوی خوب برای دیگران، بهترین کاری است که می‌توانیم انجام دهیم',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۲: گنجشک تنها و دوستای جدید
{
  'name': 'گنجشک تنها و دوستای جدید',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان گنجشکی که تنها بود و با مهربانی دوست پیدا کرد',
  'story': '''در یک باغ بزرگ و زیبا، گنجشک کوچکی به اسم چیکو زندگی می‌کرد. چیکو تنها بود و هیچ دوستی نداشت. هر روز روی شاخه درخت می‌نشست و به پرنده‌های دیگر که با هم بازی می‌کردند، نگاه می‌کرد.

دل چیکو برای دوست تنگ شده بود. یک روز تصمیم گرفت که با پرنده‌ها دوست شود. اما هر وقت به آنها نزدیک می‌شد، فرار می‌کردند. چیکو ناراحت شد و گفت: "چرا هیچ‌کس با من دوست نمی‌شود؟"

یک روز، گنجشک کوچولویی به اسم نازی به سمت چیکو آمد و گفت: "سلام! من نازی هستم. می‌خواهی با من دوست بشوی؟"

چیکو با خوشحالی گفت: "بله! خیلی دوست دارم!"

نازی گفت: "من تو را هر روز می‌دیدم که تنها نشسته‌ای. چرا نمی‌آیی و با ما بازی می‌کنی؟"

چیکو گفت: "من خجالت می‌کشم. فکر می‌کنم مرا دوست ندارید."

نازی خندید و گفت: "این فکر اشتباه است! همه پرنده‌ها تو را دوست دارند. فقط خجالتی هستی."

چیکو با نازی به سمت پرنده‌ها رفت. پرنده‌ها با خوشحالی از چیکو استقبال کردند و گفتند: "بیا چیکو! با هم بازی کنیم!"

از آن روز، چیکو دیگر تنها نبود. او با پرنده‌ها بازی می‌کرد، آواز می‌خواند و از زندگی لذت می‌برد. چیکو فهمید که نباید از مردم فرار کند و باید شجاع باشد تا دوست پیدا کند.

یک روز، طوفان شدیدی آمد و لانه چیکو خراب شد. پرنده‌ها همه به کمک او آمدند و با هم یک لانه جدید ساختند. چیکو گفت: "ممنونم دوستان! شما بهترین دوستان دنیا هستید."

پرنده‌ها گفتند: "ما همیشه در کنار هم هستیم و به هم کمک می‌کنیم. دوستی یعنی همین!"

چیکو فهمید که دوستی یعنی کمک کردن به هم و در کنار هم بودن.''',
  'moral': 'دوستی یعنی کمک کردن به هم و در کنار هم بودن',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۳: ماجرای رنگین‌کمان کوچولو
{
  'name': 'ماجرای رنگین‌کمان کوچولو',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان رنگین‌کمانی که می‌خواست به زمین بیاید و با بچه‌ها بازی کند',
  'story': '''رنگین‌کمان کوچولویی توی آسمان زندگی می‌کرد. او همیشه بچه‌ها را می‌دید که در زمین بازی می‌کنند و خوشحال هستند. دلش می‌خواست مثل آنها بازی کند و خوشحال باشد.

یک روز، رنگین‌کمان به خورشید گفت: "خورشید خانم! من می‌خواهم به زمین بروم و با بچه‌ها بازی کنم."

خورشید گفت: "اما رنگین‌کمان جان! تو فقط وقتی می‌آیی که باران ببارد. بدون باران نمی‌توانی به زمین بروی."

رنگین‌کمان ناراحت شد و گفت: "پس چه کنم؟ من خیلی دوست دارم با بچه‌ها بازی کنم."

خورشید فکری کرد و گفت: "یک راه وجود دارد. اگر باران را دعوت کنی تا با تو بیاید، می‌توانی به زمین بروی."

رنگین‌کمان با خوشحالی باران را صدا کرد: "باران جان! بیا با هم به زمین برویم و با بچه‌ها بازی کنیم!"

باران که همیشه دوست داشت بچه‌ها را خوشحال کند، قبول کرد و با رنگین‌کمان به زمین آمدند. باران نم نم بارید و رنگین‌کمان زیبا در آسمان ظاهر شد.

بچه‌ها با خوشحالی به سمت رنگین‌کمان دویدند و گفتند: "وای! چه رنگین‌کمان قشنگی! بیا با هم بازی کنیم!"

رنگین‌کمان با خوشحالی گفت: "بله! من هم آرزو داشتم با شما بازی کنم!"

بچه‌ها و رنگین‌کمان با هم بازی می‌کردند و می‌خندیدند. بچه‌ها رنگین‌کمان را بغل می‌کردند و او هم با نورهای قشنگش آنها را نوازش می‌کرد.

وقتی وقت برگشتن شد، رنگین‌کمان گفت: "من باید برگردم به آسمان، اما هر وقت باران بیاید، دوباره می‌آیم و با شما بازی می‌کنم."

بچه‌ها با ناراحتی گفتند: "خداحافظ رنگین‌کمان! دوباره بیا!"

رنگین‌کمان گفت: "حتما! قول می‌دهم هر وقت باران ببارد، بیایم و با شما بازی کنم."

از آن روز، هر وقت باران می‌بارید، بچه‌ها با خوشحالی به سمت پنجره می‌رفتند تا رنگین‌کمان را ببینند و با او بازی کنند.''',
  'moral': 'زیبایی‌های طبیعت مثل رنگین‌کمان، شادی و امید را به زندگی ما می‌آورند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۴: عمو نوروز و بچه‌های جنگل
{
  'name': 'عمو نوروز و بچه‌های جنگل',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان عمو نوروز که با مهربانی به حیوانات جنگل کمک می‌کرد',
  'story': '''در یک جنگل بزرگ و سرسبز، پیرمرد مهربانی به اسم عمو نوروز زندگی می‌کرد. او تمام حیوانات جنگل را دوست داشت و به آنها کمک می‌کرد. هر روز صبح، عمو نوروز با یک سبد میوه و غذا به جنگل می‌رفت و حیوانات را سیر می‌کرد.

حیوانات جنگل عمو نوروز را خیلی دوست داشتند. خرگوش‌ها دورش جمع می‌شدند، پرنده‌ها روی شانه‌اش می‌نشستند و آهوها به او نزدیک می‌شدند.

یک روز، عمو نوروز مریض شد و نتوانست به جنگل برود. حیوانات ناراحت شدند و نمی‌دانستند چکار کنند. خرگوش‌ها گفتند: "عمو نوروز مریض است! باید به او کمک کنیم!"

پرنده‌ها گفتند: "ما می‌رویم و برای او غذا می‌آوریم!"

آهوها گفتند: "ما می‌رویم و برای او آب شیرین از چشمه می‌آوریم!"

حیوانات با هم تصمیم گرفتند که به عمو نوروز کمک کنند. خرگوش‌ها از باغچه سبزیجات آوردند، پرنده‌ها میوه‌های تازه چیدند و آهوها آب گوارا از چشمه آوردند.

وقتی حیوانات به خانه عمو نوروز رسیدند، او را در رختخواب دیدند. عمو نوروز با خوشحالی گفت: "وای! شما آمدید به دیدار من؟"

خرگوش‌ها گفتند: "بله عمو نوروز! ما آمدیم تا به شما کمک کنیم."

عمو نوروز با اشک شوق گفت: "شما بهترین دوستان من هستید! من هیچ وقت فکر نمی‌کردم که حیوانات جنگل اینقدر مهربان باشند."

حیوانات چند روز از عمو نوروز مراقبت کردند تا اینکه خوب شد. وقتی خوب شد، عمو نوروز به جنگل برگشت و حیوانات با خوشحالی دورش جمع شدند.

عمو نوروز گفت: "من یاد گرفتم که مهربانی همیشه جواب دارد. شما به من نشان دادید که دوستی یعنی کمک کردن به هم."

حیوانات با هم گفتند: "ما همیشه در کنار هم هستیم و به هم کمک می‌کنیم."''',
  'moral': 'مهربانی و کمک به دیگران، همیشه پاداش خوبی دارد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۵: کلاه جادویی و آرزوها
{
  'name': 'کلاه جادویی و آرزوها',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان کلاهی که آرزوهای بچه‌ها را برآورده می‌کرد',
  'story': '''سامی، پسر کوچکی بود که یک روز در اتاق زیرشیروانی خانه مادربزرگش، یک کلاه قدیمی و خاک‌گرفته پیدا کرد. کلاه خیلی ساده بود، اما وقتی سامی آن را روی سرش گذاشت، ناگهان صدایی شنید: "سلام سامی! من کلاه جادویی هستم. هر چیزی که آرزو کنی، برایت برآورده می‌کنم!"

سامی که باور نمی‌کرد، گفت: "من یک بستنی شکلاتی بزرگ می‌خواهم!"

ناگهان یک بستنی بزرگ جلویش ظاهر شد. سامی ذوق‌زده شد و گفت: "وای! واقعاً جادویی است!"

سامی با کلاه جادویی شروع به آرزو کردن کرد. اول برای خودش آرزو کرد: یک دوچرخه قرمز، یک اسباب‌بازی بزرگ، یک کیک شکلاتی. بعد برای دوستانش آرزو کرد: برای رامین یک توپ فوتبال، برای سارا یک عروسک زیبا، برای علی یک کتاب مصور.

اما روزی که داشت برای همه آرزو می‌کرد، متوجه شد که کلاه دیگر کار نمی‌کند. با ناراحتی گفت: "چرا دیگر کار نمی‌کنی؟"

کلاه جادویی گفت: "من فقط تا زمانی کار می‌کنم که آرزوهایت خودخواهانه نباشد. وقتی برای دیگران آرزو کردی، قدرتم را از دست دادی، اما حالا که فهمیدی بهترین آرزو، آرزوی خوب برای دیگران است، دوباره کار می‌کنم!"

سامی خوشحال شد و از آن روز، با کلاه جادویی فقط برای دیگران آرزو می‌کرد. او فهمید که خوشبختی واقعی در شادی دیگران است.

یک روز، سامی با کلاه جادویی به مدرسه رفت و به همه بچه‌ها گفت که می‌تواند آرزوهایشان را برآورده کند. بچه‌ها با خوشحالی دورش جمع شدند و هر کسی یک آرزو کرد. سامی همه آرزوها را برآورده کرد و همه بچه‌ها خوشحال شدند.

معلم کلاس که این صحنه را دید، به سامی گفت: "تو با مهربانی‌ات قلبت را بزرگ کردی. بهترین کار این است که دیگران را خوشحال کنی."''',
  'moral': 'بهترین آرزوها، آرزوهایی هستند که برای دیگران می‌کنیم',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۶: دو دوست و مسابقه بزرگ
{
  'name': 'دو دوست و مسابقه بزرگ',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان دو دوست که با هم مسابقه دادند و درس بزرگی گرفتند',
  'story': '''در یک جنگل بزرگ، دو دوست صمیمی به اسم سنجاب و خرگوش زندگی می‌کردند. آنها هر روز با هم بازی می‌کردند و خیلی خوشحال بودند.

یک روز، سنجاب به خرگوش گفت: "بیا مسابقه بدیم ببینیم کدوممون تندتر می‌دویم!"

خرگوش که خیلی تند می‌دوید، با خوشحالی قبول کرد و گفت: "باشه! ولی یادت باشه که من از همه تندترم!"

مسابقه شروع شد. خرگوش خیلی سریع دوید و از سنجاب جلو افتاد. وسط راه، خرگوش به یک درخت رسید و دید که سنجاب خیلی عقب است. با خودش گفت: "من که برنده می‌شم! بیا یک کمی استراحت کنم."

خرگوش زیر درخت نشست و خوابش برد. سنجاب با آرامش به دویدن ادامه داد و از کنار خرگوش خوابیده گذشت. وقتی خرگوش بیدار شد، دید سنجاب به خط پایان رسیده است.

خرگوش ناراحت شد و گفت: "من باید برنده می‌شدم! تو چطور من را شکست دادی؟"

سنجاب گفت: "تو غرور داشتی و فکر می‌کردی حتماً برنده می‌شوی. غرور باعث شد که استراحت کنی و من برنده شوم."

خرگوش فهمید که نباید به خودش مغرور شود و همیشه باید تا آخر تلاش کند.

از آن روز، خرگوش دیگر مغرور نبود و همیشه تا آخر تلاش می‌کرد. او به سنجاب گفت: "تو به من درس بزرگی دادی. من دیگر هیچ‌وقت غرور ندارم و همیشه تا آخر تلاش می‌کنم."

سنجاب گفت: "دوستی یعنی به هم کمک کنیم و از اشتباهات هم درس بگیریم."

دو دوست با هم دست دادند و قول دادند که همیشه به هم کمک کنند.''',
  'moral': 'غرور باعث شکست می‌شود و باید همیشه تا آخر تلاش کرد',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۷: باغچه‌های همسایه
{
  'name': 'باغچه‌های همسایه',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان دو همسایه که با هم مسابقه دادند تا بهترین باغچه را داشته باشند',
  'story': '''در یک محله زیبا، دو همسایه به اسم آقای مهربان و آقای خودخواه زندگی می‌کردند. هر دو یک باغچه کوچک داشتند و می‌خواستند زیباترین باغچه را داشته باشند.

آقای خودخواه هر روز به باغچه‌اش آب می‌داد و از گل‌هایش مراقبت می‌کرد، اما به باغچه همسایه توجهی نمی‌کرد. آقای مهربان علاوه بر باغچه خودش، به باغچه همسایه هم رسیدگی می‌کرد و به گل‌هایش آب می‌داد.

یک روز، آقای خودخواه به آقای مهربان گفت: "چرا به باغچه من آب می‌دهی؟ این مال تو نیست!"

آقای مهربان گفت: "من دوست دارم همه باغچه‌ها زیبا باشند. وقتی باغچه تو هم قشنگ باشد، محله ما زیباتر می‌شود."

چند ماه بعد، باغچه آقای مهربان پر از گل‌های رنگارنگ شد، اما باغچه آقای خودخواه خشک و بی‌روح شد. آقای خودخواه تعجب کرد و گفت: "چطور باغچه من خشک شد، اما باغچه تو اینقدر زیبا و سرسبز است؟"

آقای مهربان گفت: "به خاطر اینکه من به باغچه تو هم آب می‌دادم. وقتی به هم کمک می‌کنیم، همه چیز بهتر می‌شود."

آقای خودخواه شرمنده شد و گفت: "من اشتباه می‌کردم. از این به بعد به تو کمک می‌کنم."

از آن روز، دو همسایه با هم به باغچه‌ها رسیدگی می‌کردند و محله‌شان به زیباترین محله تبدیل شد.''',
  'moral': 'کمک به دیگران باعث می‌شود که همه چیز بهتر و زیباتر شود',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۸: ستاره دریایی تنها
{
  'name': 'ستاره دریایی تنها',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان ستاره دریایی که از خانه دور شد و دوست جدید پیدا کرد',
  'story': '''در ته اقیانوس، یک ستاره دریایی کوچک به اسم لیلی زندگی می‌کرد. لیلی عاشق ماجراجویی بود و همیشه می‌خواست جاهای جدید ببیند.

یک روز، لیلی تصمیم گرفت که از خانه دور شود و به سفر برود. او از صخره‌ها و مرجان‌ها عبور کرد تا اینکه به یک جای جدید رسید. آنجا پر از ماهی‌های رنگارنگ و عجیب بود.

لیلی با یک ماهی کوچک به اسم دالی دوست شد. دالی به لیلی گفت: "تو از کجا آمده‌ای؟ من تو را تا حالا ندیده‌ام!"

لیلی گفت: "من از آن طرف اقیانوس آمده‌ام. من عاشق ماجراجویی هستم و می‌خواهم جاهای جدید ببینم."

دالی گفت: "چه جالب! من هم عاشق ماجراجویی هستم. بیا با هم به سفر برویم!"

لیلی و دالی با هم به سفر رفتند. آنها جاهای زیادی را دیدند: جنگل‌های مرجانی، کوه‌های زیرآبی، دره‌های عمیق. هر جا که می‌رفتند، چیزهای جدید یاد می‌گرفتند.

یک روز، طوفان شدیدی در اقیانوس آمد. لیلی و دالی در میان موج‌ها گیر کردند. آنها با هم تلاش کردند تا به ساحل برسند.

دالی به لیلی گفت: "نترس! من اینجا هستم! با هم از این طوفان جان سالم به در می‌بریم!"

لیلی با دالی کنار هم ماندند و از طوفان عبور کردند. وقتی طوفان تمام شد، لیلی گفت: "ممنونم دالی! تو بهترین دوست هستی!"

دالی گفت: "ما همیشه در کنار هم هستیم. دوستی یعنی همین!"

لیلی فهمید که بهترین سفر، سفری است که با دوست انجام شود. او تصمیم گرفت به خانه برگردد اما دالی را هم با خودش برد تا با هم زندگی کنند.''',
  'moral': 'دوستی و همراهی در سفرها و ماجراجویی‌ها، زیباترین تجربه زندگی را می‌سازد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۹: نقاش کوچک
{
  'name': 'نقاش کوچک و رنگ‌های جادویی',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان پسری که با رنگ‌های جادویی دنیا را زیبا می‌کرد',
  'story': '''پسر کوچکی به اسم سعید عاشق نقاشی بود. هر جا که می‌رفت، دفتر نقاشی و مدادهای رنگی‌اش را با خود می‌برد.

یک روز، سعید در اتاق زیرشیروانی خانه‌شان، یک جعبه رنگ قدیمی پیدا کرد. وقتی جعبه را باز کرد، دید که رنگ‌هایش می‌درخشند. یک رنگ به او گفت: "سلام سعید! ما رنگ‌های جادویی هستیم. با ما می‌توانی هر چیزی که نقاشی کنی، واقعی شود!"

سعید با تعجب گفت: "واقعاً؟ پس من می‌توانم یک خورشید نقاشی کنم که واقعی شود؟"

رنگ‌ها گفتند: "بله! فقط کافی است با عشق و مهربانی نقاشی کنی."

سعید یک خورشید بزرگ و طلایی نقاشی کرد. ناگهان، خورشید از روی کاغذ بلند شد و به آسمان رفت و شروع به درخشیدن کرد. سعید با خوشحالی گفت: "وای! واقعاً جادویی است!"

سعید با رنگ‌های جادویی شروع به نقاشی کردن کرد. او یک باغ بزرگ پر از گل‌های رنگارنگ، یک رودخانه پر از ماهی‌های قشنگ و یک کوه بلند و سبز نقاشی کرد. همه چیز واقعی شد.

مردم روستا وقتی این همه زیبایی را دیدند، با خوشحالی گفتند: "سعید! تو روستا را به بهشت تبدیل کردی!"

اما یک روز، سعید یک دیو بزرگ و ترسناک نقاشی کرد که می‌خواست همه چیز را خراب کند. دیو از نقاشی بیرون آمد و شروع به خراب کردن همه چیز کرد.

سعید ترسیده بود، اما یادش آمد که رنگ‌های جادویی با عشق و مهربانی کار می‌کنند. او یک تابلوی بزرگ از یک قلعه محکم و یک اژدهای مهربان نقاشی کرد که از قلعه محافظت می‌کرد.

اژدهای مهربان از نقاشی بیرون آمد و دیو را شکست داد. همه چیز دوباره به آرامش برگشت. سعید فهمید که با نقاشی‌های خوب و مهربان، می‌تواند دنیا را زیبا کند.''',
  'moral': 'خلاقیت و هنر می‌تواند دنیا را زیبا و پر از شادی کند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۰: خرس کوچولو و عسل
{
  'name': 'خرس کوچولو و عسل گمشده',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان خرسی که عسل‌هایش را گم کرد و با کمک دوستانش آنها را پیدا کرد',
  'story': '''بابا خرس یک کندوی عسل بزرگ داشت. هر روز از آن عسل می‌خورد و خیلی خوشحال بود. یک روز که بابا خرس به خانه برگشت، دید که کندوی عسل خالی شده است. تمام عسل‌ها ناپدید شده بودند.

بابا خرس ناراحت شد و گفت: "چه کسی عسل‌های من را دزدیده است؟"

او به جنگل رفت و از همه حیوانات پرسید: "آیا شما عسل‌های من را دیده‌اید؟"

خرگوش گفت: "نه بابا خرس! من عسل ندیده‌ام."

روباه گفت: "من هم ندیده‌ام. شاید باد آنها را برده باشد."

بابا خرس ناراحت به خانه برگشت. اما در راه، یک زنبور کوچک را دید که بالش زخمی شده بود و نمی‌توانست پرواز کند. بابا خرس زنبور را برداشت و با مهربانی بالش را بست و به کندوی خودش برد تا خوب شود.

زنبور کوچک به بابا خرس گفت: "ممنونم که نجاتم دادی! من می‌توانم به تو کمک کنم."

بابا خرس گفت: "چطور؟ من عسل‌هایم را گم کرده‌ام."

زنبور گفت: "من می‌دانم عسل‌هایت کجا هستند. یک روباه حیله‌گر آنها را دزدیده و در غار خودش پنهان کرده است."

بابا خرس با کمک زنبور به غار روباه رفت و عسل‌هایش را پس گرفت. روباه که دستش رو شده بود، شرمنده شد و عذرخواهی کرد.

بابا خرس به روباه گفت: "من تو را می‌بخشم، اما دیگر این کار را نکن. اگر عسل می‌خواهی، به من بگو تا با تو تقسیم کنم."

روباه از مهربانی بابا خرس خیلی خوشش آمد و از آن روز، آنها بهترین دوستان شدند.''',
  'moral': 'مهربانی و بخشش، بهترین راه برای حل مشکلات و دوستی است',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۱: سفر به ماه
{
  'name': 'سفر به ماه با نردبان جادویی',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان پسری که با نردبان جادویی به ماه سفر کرد و ماجراهای زیادی دید',
  'story': '''پسر کوچکی به اسم آریا همیشه به ماه نگاه می‌کرد و آرزو داشت که بتواند به آنجا برود. یک شب که داشت از پنجره به ماه نگاه می‌کرد، ناگهان یک نردبان جادویی از ماه پایین آمد و جلوی پنجره او قرار گرفت.

آریا با تعجب به نردبان نگاه کرد و گفت: "این نردبان مرا به ماه می‌برد؟"

یک صدای نرم از بالا آمد: "بله آریا! بیا بالا تا ماه را ببینی!"

آریا با خوشحالی از نردبان بالا رفت. هر چه بالاتر می‌رفت، ستاره‌ها درشت‌تر و درخشان‌تر می‌شدند. تا اینکه به ماه رسید.

در ماه، آریا یک دنیای عجیب و قشنگ دید. همه چیز نقره‌ای و درخشان بود. یک پیرمرد مهربان با ریش بلند به استقبالش آمد و گفت: "به ماه خوش آمدی آریا! من نگهبان ماه هستم."

آریا با تعجب گفت: "اینجا خیلی قشنگ است! چرا هیچ‌کس اینجا زندگی نمی‌کند؟"

پیرمرد گفت: "اینجا فقط شب‌ها روشن است. روزها همه چیز تاریک می‌شود. به همین دلیل کسی اینجا زندگی نمی‌کند."

آریا در ماه قدم زد و چیزهای قشنگی دید: کوه‌های نقره‌ای، دریاچه‌های نورانی، درخت‌های درخشان. با بچه‌های ماه که کوچک و نورانی بودند، بازی کرد و خیلی خوشحال شد.

وقتی وقت برگشتن شد، پیرمرد به آریا یک تکه سنگ ماه به عنوان یادگاری داد و گفت: "هر وقت دلت برای ماه تنگ شد، به این سنگ نگاه کن و یادش بیفت."

آریا با خوشحالی به خانه برگشت و سنگ ماه را کنار تختش گذاشت. هر شب که به ماه نگاه می‌کرد، یاد سفر قشنگش می‌افتاد و لبخند می‌زد.''',
  'moral': 'رویاها و آرزوها می‌توانند ما را به جاهای قشنگ و جدید ببرند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۲: گربه‌ای که می‌خواست آواز بخواند
{
  'name': 'گربه‌ای که می‌خواست آواز بخواند',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان گربه‌ای که عاشق آواز بود و با تمرین به آرزویش رسید',
  'story': '''گربه کوچکی به اسم مینی عاشق آواز بود. هر روز که پرنده‌ها را می‌دید که آواز می‌خوانند، دلش می‌خواست مثل آنها آواز بخواند. اما هر وقت می‌خواست آواز بخواند، صدای خرخرش همه را می‌ترساند.

یک روز، مینی پیش بلبل رفت و گفت: "آقای بلبل! می‌توانی به من آواز یاد بدهی؟"

بلبل گفت: "اما تو یک گربه هستی! گربه‌ها نمی‌توانند آواز بخوانند."

مینی ناراحت شد و گفت: "اما من خیلی دوست دارم آواز بخوانم. لطفاً به من یاد بده!"

بلبل که از اصرار مینی خوشش آمده بود، گفت: "باشه! هر روز بیا پیش من تا به تو آواز یاد بدهم."

مینی هر روز پیش بلبل می‌رفت و تمرین می‌کرد. اول خیلی سخت بود، اما مینی دست بردار نبود. روزها و ماه‌ها تمرین کرد تا اینکه یاد گرفت با صدای نرم و قشنگی آواز بخواند.

یک روز که مینی داشت توی باغچه آواز می‌خواند، همه حیوانات جمع شدند و با تعجب به او گوش دادند. خرگوش گفت: "وای! مینی چه صدای قشنگی دارد!"

سنجاب گفت: "ما هیچ وقت فکر نمی‌کردیم که یک گربه بتواند اینقدر قشنگ آواز بخواند!"

مینی با خوشحالی گفت: "من با تمرین و پشتکار توانستم آواز بخوانم. هیچ‌وقت نباید از رویاهایتان دست بکشید."

حیوانات جنگل از آن روز به بعد، هر روز می‌آمدند تا آواز قشنگ مینی را بشنوند. مینی فهمید که با تلاش و پشتکار، هر آرزویی می‌تواند به حقیقت بپیوندد.''',
  'moral': 'با تمرین و پشتکار می‌توان به هر آرزویی رسید',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۳: کفش‌های قرمز کوچولو
{
  'name': 'کفش‌های قرمز کوچولو',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان دختری که با کفش‌های قرمز خود به دیگران کمک کرد',
  'story': '''در یک روستا، دختر کوچکی به اسم ستاره زندگی می‌کرد. او یک جفت کفش قرمز زیبا داشت که خیلی دوستشان داشت. هر جا که می‌رفت، با کفش‌های قرمز بود.

یک روز، ستاره در راه مدرسه، یک پیرزن را دید که کفش‌هایش پاره شده بود و نمی‌توانست راه برود. ستاره دلش به حال پیرزن سوخت و به او گفت: "مادربزرگ! کفش‌های من را به شما می‌دهم."

پیرزن با تعجب گفت: "اما تو با چه کفشی به مدرسه می‌روی؟"

ستاره گفت: "من پابرهنه می‌روم. شما کفش‌ها را بپوشید."

ستاره کفش‌هایش را به پیرزن داد و پابرهنه به مدرسه رفت. بچه‌ها وقتی دیدند که ستاره پابرهنه است، خندیدند. اما ستاره اهمیت نداد.

یک روز، ستاره داشت از کنار یک رودخانه عبور می‌کرد که دید یک پسر کوچک در آب افتاده و دارد غرق می‌شود. ستاره سریعاً دوید و با کمک شاخه‌ای که پیدا کرد، پسر را نجات داد.

پسر نجات پیدا کرد و مادرش با خوشحالی گفت: "ممنونم ستاره! تو جان پسرم را نجات دادی. من هر چه بخواهی به تو می‌دهم."

ستاره گفت: "من هیچ چیزی نمی‌خواهم. فقط خوشحالم که توانستم کمک کنم."

خبر مهربانی ستاره به همه روستا رسید. مردم دورش جمع شدند و از او تشکر کردند. یک کفاش به ستاره گفت: "من برایت یک جفت کفش قرمز جدید و زیباتر از قبلی می‌سازم."

ستاره با خوشحالی کفش‌های جدید را پوشید و فهمید که مهربانی همیشه پاداش دارد.''',
  'moral': 'مهربانی و کمک به دیگران، همیشه پاداش خوبی دارد',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۴: اژدهای کوچک و شاهزاده
{
  'name': 'اژدهای کوچک و شاهزاده شجاع',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان اژدهایی که به جای ترساندن، به مردم کمک می‌کرد',
  'story': '''در یک سرزمین دور، یک اژدهای کوچک به اسم دراگو زندگی می‌کرد. بر خلاف بقیه اژدهاها که ترسناک و خشن بودند، دراگو مهربان و خوش‌قلب بود.

یک روز، شاهزاده جوانی به اسم آرش به جنگل آمد تا اژدها را بکشد. وقتی با دراگو روبرو شد، با تعجب دید که اژدها در حال کمک به یک پرنده زخمی است.

آرش گفت: "تو اژدهای این جنگل هستی؟ چرا به جای ترساندن مردم، به پرنده کمک می‌کنی؟"

دراگو گفت: "من هیچ‌وقت به کسی آسیبی نرسانده‌ام. من فقط می‌خواهم به دیگران کمک کنم."

آرش با خودش فکر کرد که شاید داستان‌هایی که شنیده دروغ بوده است. به دراگو گفت: "بیا با هم به شهر برویم و حقیقت را به مردم بگوییم."

دراگو با خوشحالی قبول کرد. آنها به شهر رفتند و مردم وقتی اژدهای مهربان را دیدند، با خوشحالی از او استقبال کردند.

شاهزاده آرش به مردم گفت: "این اژدها مهربان است و هیچ‌وقت به کسی آسیبی نرسانده. او فقط می‌خواهد به ما کمک کند."

مردم از دراگو عذرخواهی کردند و او را به شهر دعوت کردند. دراگو به مردم کمک می‌کرد تا خانه‌هایشان را بسازند، محصولاتشان را ببرند و از جنگل محافظت کنند.

از آن روز، دراگو محبوب همه مردم شد و شاهزاده آرش بهترین دوست او شد. دراگو فهمید که با مهربانی می‌تواند دل مردم را به دست بیاورد.''',
  'moral': 'مهربانی و خوبی همیشه بر ترس و خشونت پیروز می‌شود',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۵: باغ جادویی
{
  'name': 'باغ جادویی پر از گل‌های سخنگو',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان باغچه‌ای که گل‌هایش می‌توانستند حرف بزنند و به بچه‌ها درس بدهند',
  'story': '''در یک روستای کوچک، باغچه‌ای بود که گل‌هایش می‌توانستند حرف بزنند. بچه‌های روستا هر روز به باغچه می‌رفتند و با گل‌ها حرف می‌زدند.

یک روز، دختر کوچکی به اسم نرگس به باغچه آمد و به گل‌ها گفت: "گل‌های نازنین! من امروز در مدرسه نمره خوبی نگرفتم و ناراحت هستم."

یک گل سرخ به نرگس گفت: "ناراحت نباش نرگس! همه ما گاهی اشتباه می‌کنیم. مهم این است که از اشتباهاتمان درس بگیریم."

یک گل نرگس گفت: "من هم زمانی کوچک بودم و نمی‌دانستم چطور رشد کنم. اما با صبر و تلاش، بزرگ و زیبا شدم."

نرگس با حرف‌های گل‌ها آرام شد و تصمیم گرفت بیشتر تلاش کند.

روزهای بعد، بچه‌های دیگر هم به باغچه می‌آمدند و از گل‌ها درس‌های قشنگی یاد می‌گرفتند. گل‌ها به آنها درباره صبر، مهربانی، همدلی و عشق به طبیعت می‌گفتند.

یک روز، یک پسر بدجنس آمد و می‌خواست گل‌ها را بچیند. بچه‌ها جلوی او را گرفتند و گفتند: "این گل‌ها دوستان ما هستند! به آنها آسیب نرسان!"

پسر که از حرف بچه‌ها خجالت کشید، از کارش پشیمان شد و از گل‌ها عذرخواهی کرد.

گل‌ها به پسر گفتند: "ما تو را می‌بخشیم. هر کسی می‌تواند اشتباه کند، مهم این است که از اشتباهاتش درس بگیرد."

از آن روز، بچه‌های روستا با گل‌ها دوست بودند و از آنها درس‌های قشنگی یاد می‌گرفتند و باغچه همیشه پر از گل‌های رنگارنگ بود.''',
  'moral': 'طبیعت و گل‌ها می‌توانند به ما درس‌های بزرگی درباره زندگی بدهند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۶: روباه و زنبور
{
  'name': 'روباه و زنبور',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان روباه حیله‌گری که با یک زنبور دوست شد و درس بزرگی گرفت',
  'story': '''روباه حیله‌گری در جنگل زندگی می‌کرد که همیشه به دنبال راهی برای فریب دادن حیوانات بود. یک روز که داشت در جنگل قدم می‌زد، یک زنبور را دید که در حال جمع‌آوری شهد از گل‌ها بود.

روباه به زنبور گفت: "ای زنبور کوچک! چرا اینقدر کار می‌کنی؟ بیا با من به جای دیگری برویم که شهد بیشتری دارد."

زنبور که زیرک بود، گفت: "من اینجا خیلی شهد دارم. تو اگر راست می‌گویی، به من نشان بده که آن شهدها کجا هستند."

روباه فکر کرد که می‌تواند زنبور را گول بزند. او زنبور را به سمت یک درخت بزرگ برد که هیچ گلی نداشت. زنبور گفت: "اینجا که هیچ گلی نیست! تو داری دروغ می‌گویی!"

روباه خندید و گفت: "آره! من می‌خواستم تو را گول بزنم تا راه خانه‌ات را به من بگویی و من عسل‌هایت را بدزدم."

زنبور عصبانی شد و گفت: "تو خیلی حیله‌گری! اما من از تو باهوش‌ترم."

زنبور به سمت روباه پرواز کرد و با نیشش به بینی روباه زد. روباه از درد جیغ کشید و شروع به دویدن کرد.

روباه که از دست زنبور فرار کرده بود، به کنار رودخانه رفت تا صورتش را بشوید. آنجا یک زنبور دیگر را دید که داشت به گل‌ها شهد می‌داد.

روباه به زنبور دوم گفت: "ای زنبور مهربان! من اشتباه کردم. می‌توانی به من کمک کنی تا از زنبور قبلی عذرخواهی کنم؟"

زنبور دوم گفت: "اگر راست می‌گویی و پشیمان هستی، تو را می‌بخشم. بیا تا با هم به نزد آن زنبور برویم."

روباه با زنبور دوم به نزد زنبور اول رفت و از او عذرخواهی کرد. زنبور اول که پشیمانی روباه را دید، او را بخشید.

روباه فهمید که حیله‌گری و دروغ، هیچ‌وقت نتیجه خوبی ندارد و همیشه باید راست و درست بود.''',
  'moral': 'دروغ و حیله‌گری هیچ‌وقت نتیجه خوبی ندارد و همیشه باید راست و درست بود',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۷: کفش‌های بالدار
{
  'name': 'کفش‌های بالدار کوچولو',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان کفش‌هایی که به پسر کوچکی قدرت پرواز می‌دادند',
  'story': '''در یک شهر کوچک، پسر بچه‌ای به اسم پارسا زندگی می‌کرد. پارسا خیلی دوست داشت پرواز کند و پرنده‌ها را ببیند. هر روز به آسمان نگاه می‌کرد و آرزو داشت که مثل پرنده‌ها پرواز کند.

یک روز، پارسا در اتاق زیرشیروانی خانه‌شان، یک جفت کفش قدیمی پیدا کرد. کفش‌ها چرمی و قهوه‌ای بودند و روی آنها یک پر کوچک نقره‌ای حک شده بود. پارسا کفش‌ها را پوشید و ناگهان احساس کرد که دارد از زمین بلند می‌شود.

پارسا با خوشحالی گفت: "وای! این کفش‌ها بال دارند! من می‌توانم پرواز کنم!"

او از پنجره بیرون پرید و در آسمان شروع به پرواز کرد. باد در صورتش می‌وزید و پرنده‌ها با تعجب به او نگاه می‌کردند. پارسا با پرنده‌ها پرواز کرد و از بالای شهر، همه چیز را دید.

او قصر پادشاه را دید که طلایی می‌درخشید، باغ‌های سرسبز را دید که پر از گل بودند و رودخانه‌ای را دید که مثل یک مار نقره‌ای می‌پیچید.

یک روز که پارسا داشت پرواز می‌کرد، صدای گریه‌ای شنید. دنبال صدا رفت و دید یک پرنده کوچک در تله افتاده است. پارسا پایین آمد و پرنده را نجات داد.

پرنده به پارسا گفت: "ممنونم که نجاتم دادی! من شاهزاده پرنده‌ها هستم. اگر روزی به کمک نیاز داشتی، من را صدا کن."

پارسا با پرنده‌ها دوست شد و هر روز با آنها پرواز می‌کرد. اما یک روز، کفش‌های جادویی شروع به ناپدید شدن کردند. پارسا ناراحت شد و نمی‌دانست چکار کند.

پرنده‌ها به پارسا گفتند: "ناراحت نباش! ما هر روز می‌آییم و با تو بازی می‌کنیم. تو نیازی به کفش‌های جادویی نداری، چون ما دوستان تو هستیم."

پارسا فهمید که بهترین پرواز، پروازی است که با دوستان انجام شود.''',
  'moral': 'دوستی و همراهی، بهترین هدیه‌ای است که می‌توانیم داشته باشیم',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۸: قطار کوچولو
{
  'name': 'قطار کوچولو و سفر بزرگ',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان قطار کوچکی که با کمک دوستانش از کوه عبور کرد',
  'story': '''در یک ایستگاه قطار، یک قطار کوچولو به اسم توتو زندگی می‌کرد. توتو آرزو داشت که بتواند از کوه بزرگ عبور کند و به شهرهای دور برود. اما همه به او می‌گفتند که کوچک است و نمی‌تواند از کوه عبور کند.

یک روز، توتو تصمیم گرفت که امتحان کند. او بار خود را بست و به سمت کوه حرکت کرد. اول راه خیلی راحت بود، اما وقتی به پای کوه رسید، شیب خیلی تند شد و توتو نتوانست بالا برود.

توتو ناراحت شد و گفت: "من نمی‌توانم از این کوه عبور کنم. خیلی کوچک هستم."

ناگهان، یک لوکوموتیو بزرگ به نام بزرگ‌خان به توتو نزدیک شد و گفت: "ناراحت نباش توتو! من به تو کمک می‌کنم. بیا بارهایت را به من بده تا من آنها را از کوه ببرم."

توتو با خوشحالی گفت: "ممنونم بزرگ‌خان! تو خیلی مهربانی."

توتو بارهایش را به بزرگ‌خان داد و با خیال راحت به دنبالش رفت. بزرگ‌خان از کوه عبور کرد و توتو هم به دنبالش رفت.

وقتی از کوه گذشتند، توتو به بزرگ‌خان گفت: "من فکر می‌کردم که باید همه کارها را خودم انجام دهم. اما حالا فهمیدم که گاهی باید از دیگران کمک بگیریم."

بزرگ‌خان گفت: "دقیقاً! هیچ‌کس نمی‌تواند همه کارها را به تنهایی انجام دهد. ما باید به هم کمک کنیم."

توتو به سفر خود ادامه داد و از شهرهای مختلف عبور کرد. او با قطارهای دیگر دوست شد و به آنها کمک می‌کرد. توتو فهمید که با کمک دیگران، می‌توان به هر جایی که آرزو دارد برسد.''',
  'moral': 'کمک گرفتن از دیگران و همکاری، راه موفقیت در کارها است',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۹: درخت پول‌های طلایی
{
  'name': 'درخت پول‌های طلایی',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان درختی که به جای میوه، سکه طلا می‌داد و درس بزرگی به مردم داد',
  'story': '''در یک روستا، یک درخت عجیب رشد کرد که به جای میوه، سکه‌های طلا می‌داد. مردم روستا با خوشحالی به سمت درخت دویدند و شروع به چیدن سکه‌ها کردند. همه فکر می‌کردند که ثروتمند شده‌اند.

اما یک روز، درخت شروع به پژمرده شدن کرد. سکه‌ها کمتر و کمتر می‌شدند تا اینکه دیگر هیچ سکه‌ای روی درخت نبود. مردم ناراحت شدند و نمی‌دانستند چکار کنند.

یک پسر کوچک به اسم علی به سمت درخت رفت و با مهربانی به آن گفت: "ای درخت نازنین! چرا اینقدر پژمرده و ناراحتی؟"

درخت با صدای ضعیفی گفت: "من از اینکه مردم فقط برای سکه‌هایم می‌آمدند خسته شده‌ام. هیچ‌کس به من آب نمی‌دهد و از من مراقبت نمی‌کند."

علی فهمید که باید به درخت کمک کند. او هر روز به درخت آب می‌داد، خاکش را نرم می‌کرد و با او حرف می‌زد. کم‌کم، درخت دوباره سبز شد و جوانه‌های جدید زد.

مردم با دیدن مهربانی علی، شرمنده شدند و شروع به مراقبت از درخت کردند. آنها فهمیدند که درخت فقط یک وسیله برای پول درآوردن نیست، بلکه یک موجود زنده است که نیاز به مراقبت دارد.

چند ماه بعد، درخت دوباره میوه داد. اما این بار میوه‌هایش سکه نبودند، بلکه میوه‌های واقعی و خوشمزه بودند. درخت به مردم گفت: "من دیگر سکه نمی‌دهم، اما میوه‌های خوشمزه و مغذی به شما می‌دهم که از آنها لذت ببرید."

مردم از میوه‌ها لذت بردند و فهمیدند که ثروت واقعی، سلامتی و طبیعت است، نه پول و طلا.''',
  'moral': 'ثروت واقعی، سلامتی و طبیعت است، نه پول و طلا',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۲۰: سفر زیر آب
{
  'name': 'سفر زیر آب با ماهی‌های درخشان',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان پسری که با یک ماشین جادویی به زیر آب سفر کرد و دنیای جدیدی دید',
  'story': '''پسر کوچکی به اسم دانیال همیشه آرزو داشت که زیر آب را ببیند و با ماهی‌ها دوست شود. یک روز که داشت در ساحل دریا قدم می‌زد، یک ماشین جادویی پیدا کرد که می‌توانست زیر آب برود.

دانیال با خوشحالی سوار ماشین شد و به زیر آب رفت. آنجا دنیای عجیب و قشنگ بود. ماهی‌های رنگارنگ با او سلام می‌کردند، مرجان‌ها می‌درخشیدند و ستاره‌های دریایی با او حرف می‌زدند.

دانیال با یک ماهی کوچک به اسم نارنجی دوست شد. نارنجی به دانیال گفت: "بیا تا شهر مرجانی را به تو نشان بدهم!"

دانیال با نارنجی به شهر مرجانی رفت. آنجا قصرهای بزرگ از مرجان ساخته شده بود و ماهی‌های درخشان در آن زندگی می‌کردند. همه جا پر از نور و رنگ بود.

اما یک روز، یک اختاپوس بزرگ و ترسناک به شهر مرجانی حمله کرد و می‌خواست همه چیز را خراب کند. دانیال با شجاعت به سمت اختاپوس رفت و گفت: "چرا به این موجودات بی‌گناه آسیب می‌زنی؟"

اختاپوس گفت: "من تنها هستم و هیچ دوستی ندارم. به همین دلیل عصبانی هستم."

دانیال با مهربانی گفت: "اگر دوست داشته باشی، من با تو دوست می‌شوم. بیا با هم به ماهی‌ها کمک کنیم تا شهرشان را بسازند."

اختاپوس که از مهربانی دانیال خوشش آمده بود، قبول کرد و با ماهی‌ها دوست شد. آنها با هم شهر را ساختند و همه با خوشحالی در کنار هم زندگی کردند.

دانیال با ماشین جادویی به سطح آب برگشت و فهمید که با مهربانی می‌توان حتی دشمنان را هم به دوست تبدیل کرد.''',
  'moral': 'مهربانی و دوستی می‌تواند دشمنان را به دوست تبدیل کند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},


























// ==================================================
// دسته 5: شعرهای کودکانه (۲۰ شعر جدید)
// ==================================================

// شعر ۱: بارون میاد جرجر
{
  'name': 'بارون میاد جرجر',
  'type': 'شعرهای کودکانه',
  'description': 'شعر باران و شب‌های پر از راز و ماجرا',
  'story': '''بارون میاد جرجر
گم شده راه بندر
ساحل شب چه دوره
آبش سیاه و شوره

ای خدا کشتی بفرست
آتیش بهشتی بفرست
جاده کهکشون کو
زهره آسمون کو

چراغ زهره سرده
تو سیاهییا می گرده
ای خدا روشنش کن
فانوس راه منش کن
گم شده راه بندر
بارون میاد جرجر

بارون میاد جرجر
رو گنبد و رو منبر
لک لک پیر خسته
بالای منار نشسته

لک لک ناز قندی
یه چیزی بگم نخندی؟
تو این هوای تاریک
دالون تنگ و باریک
وقتی که می پریدی
تو زهره رو ندیدی؟

عجب بلائی بچه
از کجا میائی بچه؟
نمی بینی خوابه جوجه م
حالش خرابه جوجه م
از بس که خورده غوره
تب داره مثل کوره
تو این بارو شرشر
هوا سیاه زمین تر
زهره چکار داره؟

بارون میاد جرجر
رو پشت بوم هاجر
هاجر عروسی داره
تاج خروسی داره

هاجر نازقندی
یه چیزی بگم نخندی
وقتی حنا میذاشتی
ابروهاتو برمی داشتی
زلفاتو وا می کردی
خالتو سیاه می کردی
زهره نیومد تماشا
نکن اگه دیدی حاشا

حوصله داری بچه؟
نکنه بیکاری بچه
نمی دونی کار دارم من
دل بیقرار دارم من
الان دومادو میارن
دستمو میدن به دستش
باید درارو بستش

تو این هوای گریون
شرشر لوس بارو
که شب سحر نمیشه
زهره به در نمیشه

بارون میاد جرجر
رو خونه های بی در
چهار تا مرد بیدار
نشسته تنگ دیوار

دیوار کنده کاری
نه فرش و نه بخاری
مردا سلام علیکم
زهره خانم شده گم
نه لک لک اونو دیده
نه هاجر ورپریده
اگه دیگه برنگرده
اوهو اوهو چه درده
بارون ریشه ریشه
شب دیگه صبح نمیشه

بچه خسته مونده
چیزی به صبح نمونده
غصه نخور دیونه
کی دیده شب بمونه
زهره تابون اینجاست
تو گره مشت مرداست
وقتی که مردا پاشن
ابرا زهم می پاشن
خروس سحر می خونه
خورشید خانم می دونه
که وقت شب گذشته
موقع کار و کشته
خورشید بالا بالا
گوشش به زنگه حالا

بارون میاد جرجر
رو گنبد و رو منبر
رو پشت بوم هاجر
رو خونه های بی در
ساحل شب چه دوره
آبش سیاه و شوره
جاده کهکشون کو؟
زهره آسمون کو؟
آفتاب و روشنش کن
فانوس راه منش کن
گم شده راه بندر
بارون میاد جرجر''',
  'moral': 'در دل شب‌های تاریک، نور امید همیشه در انتظار صبح است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۲: کلاغ
{
  'name': 'کلاغ',
  'type': 'شعرهای کودکانه',
  'description': 'شعر کلاغ سیاه و بازیگوش',
  'story': '''کلاغ سیاه تو باغچه
نشسته روی شاخه
با چشمای گرد و براق
می‌بینه دنیا رو با ذوق

کلاغ می‌پره بالا
تا آسمون آبی
با بالای سیاهش
مثل یه ابر تار

کلاغ به من می‌گه
با من بیا به سفر
با هم بریم به جنگل
و شادی رو ببینیم

کلاغ کوچولو نازم
تو خیلی باهوشی
با من بیا تو باغ
با هم بازی کنیم

کلاغ سیاه می‌خونه
با صدای بلند و نرم
بچه‌ها گوش می‌دن
به آواز قشنگش

کلاغ نازم و من
با هم میریم به سفر
دنیا رو می‌گردیم
با شادی و با ذوق''',
  'moral': 'هر موجودی در طبیعت جایگاه و زیبایی خاص خود را دارد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۳: خروس نگو یه ساعت
{
  'name': 'خروس نگو یه ساعت',
  'type': 'شعرهای کودکانه',
  'description': 'شعر خروس و بیدار کردن مردم در صبح',
  'story': '''خروس نگو یه ساعت
خورشید اومد از در
بچه‌ها بیدار شدن
با خنده و با سر

خروس می‌گه قوقولی
قوقولی قوقو
بیدار شید بچه‌ها
صبح اومد از کو

خروس نازم و من
با هم میریم به باغ
با هم برقصیم و بخندیم
دنیا رو قشنگ کنیم

خروس آواز می‌خونه
با صدای پر از شوق
بچه‌ها از خواب می‌پرن
با خنده و با ذوق

خروس نگو یه ساعت
خورشید اومد بالا
بچه‌ها با خنده
می‌رن به مدرسه حالا

خروس نازم و من
با هم میریم به راه
با هم درس می‌خونیم
با شادی و آگاه''',
  'moral': 'صبح زود بیدار شدن و شروع روز با انرژی، رمز موفقیت است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۴: دس دسی باباش میاد
{
  'name': 'دس دسی باباش میاد',
  'type': 'شعرهای کودکانه',
  'description': 'شعر بازی دس دسی و انتظار برای بابا',
  'story': '''دس دسی باباش میاد
با یه کادو قشنگ
برام چی آورده؟
یه عروسک رنگ رنگ

دس دسی مامانش میاد
با یه سبد میوه
سیب و گلابی و انگور
برای بچه‌های خوشحال

دس دسی بازی قشنگ
با دستای کوچولو
بچه‌ها با هم می‌خونن
با شوق و ذوق و حال

دس دسی نازم و من
با هم میریم به باغ
با هم میوه می‌چینیم
با شادی و با ذوق

دس دسی باباش میاد
با یه لبخند ناز
بچه‌ها دورش جمعن
با شوق و با نیاز''',
  'moral': 'انتظار برای آمدن پدر و مادر، لحظاتی پر از عشق و شادی است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۵: چه دختری
{
  'name': 'چه دختری',
  'type': 'شعرهای کودکانه',
  'description': 'شعر دختر کوچک ناز و مهربان',
  'story': '''چه دختری چه دختری
ناز و کوچولو و قشنگ
با چشمای گرد و سیاش
مثل ماه شب چه قشنگ

چه دختری نازنینی
با خنده‌های رنگین
هر جا که میری نازم
دنیا برات قشنگه

چه دختری با مامانش
میره به باغچه
با هم گل آب می‌دن
با شوق و با سعه

چه دختری نازم
با من بیا به باغ
با هم برقصیم و بخندیم
دنیا رو قشنگ کنیم

چه دختری چه مهربون
با قلب پر از نور
همیشه شاد و خوشحال
مثل یک گل در باغ''',
  'moral': 'دختران کوچک با مهربانی و لبخندشان، دنیا را زیبا می‌کنند',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۶: آب
{
  'name': 'آب',
  'type': 'شعرهای کودکانه',
  'description': 'شعر آب و اهمیت آن در زندگی',
  'story': '''آب آب آب
مثل یه گوهر ناب
از چشمه میاد پایین
میشه رودخونه

آب آب آب
به گل‌ها می‌دهد جواب
با بارون میاد بالا
زمین رو تازه می‌کنه

آب آب نازم
با من بیا به باغ
با هم گل آب می‌دیم
با شوق و با ذوق

آب آب آب
همه جان‌ها به تو وابسته‌اند
با تو سبز می‌شه زمین
با تو شاد می‌شه جهان

آب آب نازم
تو بهترین هدیه‌ای
از آسمون میای
زمین رو آباد می‌کنی''',
  'moral': 'آب مایه حیات و زندگی است و باید قدر آن را بدانیم',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۷: بچه بی ادب
{
  'name': 'بچه بی ادب',
  'type': 'شعرهای کودکانه',
  'description': 'شعر آموزش ادب به کودکان',
  'story': '''بچه بی ادب نازم
ادب رو یاد بگیر
سلام کن به بزرگتر
به کوچکتر نگاه کن

بچه بی ادب نازم
ادب خوب و قشنگه
با ادب و نازه
دنیا برات رنگ رنگه

بچه بی ادب می‌گه
من ادب رو دوست دارم
با بزرگتر سلام می‌کنم
با کوچکتر مهربونم

بچه بی ادب نازم
تو خیلی خوب شدی
با ادب و با نازه
دنیا رو قشنگ کردی

بچه بی ادب حالا
همه دوستش دارن
با ادب و با نازه
همه احترامش می‌ذارن''',
  'moral': 'ادب و احترام به دیگران، نشانه شخصیت خوب است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۸: دوستی شیرین است
{
  'name': 'دوستی شیرین است',
  'type': 'شعرهای کودکانه',
  'description': 'شعر دوستی و محبت بین کودکان',
  'story': '''دوستی شیرین است
مثل عسل شیرینه
با دوست خوب و نازم
دنیا برات قشنگه

دوستی یعنی کمک
دوستی یعنی مهر
با دوست خوب و نازم
هیچ غمی نیست تو دل

دوستی نازم و من
با هم میریم به باغ
با هم بازی می‌کنیم
با شوق و با ذوق

دوستی شیرین است
با دوست خوب و ناز
همیشه در کنار هم
با عشق و با نیاز

دوستی نازم و من
با هم درس می‌خونیم
با هم بزرگ می‌شیم
با شادی و با سعه''',
  'moral': 'دوستی و محبت به دیگران، شیرین‌ترین هدیه زندگی است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۹: بهار آمد عید آمد
{
  'name': 'بهار آمد عید آمد',
  'type': 'شعرهای کودکانه',
  'description': 'شعر بهار و عید نوروز',
  'story': '''بهار آمد عید آمد
گل‌ها از خواب بیدار شدن
درختا سبز و خندان
زمین پر از گل و گلشن

بهار آمد با شادی
با عطر نرگس و یاس
بچه‌ها با خنده
دور هم جمع شدن

بهار نازم و من
با هم میریم به باغ
با هم گل می‌چینیم
با شوق و با ذوق

بهار آمد عید آمد
سال نو مبارک
با شادی و خنده
دنیا رو قشنگ کنید

بهار نازم و من
با هم میریم به سفر
دنیا رو می‌گردیم
با شادی و با سر''',
  'moral': 'بهار و عید نوروز، نماد تازگی، شادی و امید است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۰: پیشی
{
  'name': 'پیشی',
  'type': 'شعرهای کودکانه',
  'description': 'شعر گربه و بازی با کودکان',
  'story': '''پیشی پیشی نازه
با چشمای گرد و آزاده
هر جا که میره با ناز
دل ما رو می‌ربایه

پیشی با توپ بازی می‌کنه
با نخ رنگین
می‌پره و می‌چرخه
با شوق و با فن

پیشی نازم و من
با هم میریم به باغ
با هم بازی می‌کنیم
با شادی و با ذوق

پیشی پیشی می‌خونه
با صدای نرم و ناز
بچه‌ها دورش جمعن
با شوق و با نیاز

پیشی نازم و من
با هم میریم به خونه
با هم غذا می‌خوریم
با شادی و با سعه''',
  'moral': 'مهربانی با حیوانات، شادی و محبت را به زندگی می‌آورد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۱: جیک جیک جوجه‌هایم
{
  'name': 'جیک جیک جوجه‌هایم',
  'type': 'شعرهای کودکانه',
  'description': 'شعر جوجه‌های کوچک و بازیگوش',
  'story': '''جیک جیک جوجه‌هایم
توی حیاط می‌پرن
با مامان جوجه‌ها
دنبال دونه می‌گردن

جیک جیک جوجه نازم
با من بیا به باغ
با هم دونه می‌چینیم
با شوق و با ذوق

جوجه‌ها با هم می‌رقصن
با بالای کوچیکشون
با صدای جیک جیکشون
دل ما رو شاد می‌کنن

جیک جیک جوجه نازم
تو خیلی بامزه‌ای
با من همیشه باش
با شادی و با سعه

جوجه‌ها با مامانشون
زندگی قشنگی دارن
با هم غذا می‌خورن
و خاطره می‌سازن''',
  'moral': 'حیوانات کوچک نیز مانند ما به مهر و محبت نیاز دارند',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۲: بارون بارونه
{
  'name': 'بارون بارونه',
  'type': 'شعرهای کودکانه',
  'description': 'شعر باران و شادی کودکان در روز بارانی',
  'story': '''بارون بارونه بارون
روی چترای رنگارنگ
بچه‌ها می‌خندن و می‌رقصن
توی این هوای قشنگ

بارون بارونه بارون
بر گل‌ها ببار
زمین رو تازه کن
دنیا رو آباد کن

بارون بارونه نازم
با من بیا به باغ
با هم گل آب می‌دیم
با شوق و با ذوق

بارون بارونه بارون
بچه‌ها با تو شادن
با قطره‌های نازت
دلشون پر از شادیه

بارون بارونه نازم
تو بهترین همراهی
با اومدنت نازم
دنیا رو قشنگ می‌کنی''',
  'moral': 'باران نشانه برکت و شادی است و کودکان را خوشحال می‌کند',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۳: جوجه‌هامو بردن
{
  'name': 'جوجه‌هامو بردن',
  'type': 'شعرهای کودکانه',
  'description': 'شعر دلتنگی برای جوجه‌هایی که رفته‌اند',
  'story': '''جوجه‌هامو بردن
با خودشون به سفر
دلم براشون تنگه
نمی‌دونم کجان

جوجه‌هامو بردن
با خودشون به باغ
دلم براشون تنگه
نمی‌دونم چطورن

جوجه‌هامو بردن
با خودشون به جنگل
دلم براشون تنگه
نمی‌دونم برمی‌گردن؟

جوجه‌هامو بردن
با خودشون به دریا
دلم براشون تنگه
نمی‌دونم چی می‌شن؟

جوجه‌هامو بردن
با خودشون به شهر
دلم براشون تنگه
نمی‌دونم کی برمی‌گردن؟''',
  'moral': 'دلتنگی برای عزیزان، نشانه محبت و عشق است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۴: کلاس جنگل
{
  'name': 'کلاس جنگل',
  'type': 'شعرهای کودکانه',
  'description': 'شعر مدرسه در جنگل با حیوانات',
  'story': '''کلاس جنگل نازه
با معلم بلبل
بچه‌ها دورش جمعن
با شوق و با ذوق

کلاس جنگل می‌گه
با من بیایید به درس
با هم یاد می‌گیریم
با شادی و با نرس

کلاس جنگل نازم
با من بیا به باغ
با هم درس می‌خونیم
با شوق و با ذوق

کلاس جنگل با حیوانات
زندگی قشنگی داره
با هم درس می‌خونن
و خاطره می‌سازن

کلاس جنگل نازم
تو بهترین مدرسه‌ای
با حیوانات مهربون
دنیا رو قشنگ می‌کنی''',
  'moral': 'یادگیری در طبیعت و با دوستان، زیباترین شکل آموزش است',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۵: دستا بالا با خنده
{
  'name': 'دستا بالا با خنده',
  'type': 'شعرهای کودکانه',
  'description': 'شعر شادی و بازی دسته‌جمعی کودکان',
  'story': '''دستا بالا با خنده
بچه‌ها دور هم جمعن
با شادی و با خنده
دنیا رو قشنگ می‌کنن

دستا بالا با خنده
بچه‌ها با هم می‌رقصن
با شادی و با شوق
دنیا رو قشنگ می‌کنن

دستا بالا با خنده
بچه‌ها با هم می‌خونن
با شادی و با ذوق
دنیا رو قشنگ می‌کنن

دستا بالا با خنده
بچه‌ها با هم بازی می‌کنن
با شادی و با سعه
دنیا رو قشنگ می‌کنن

دستا بالا با خنده
بچه‌ها با هم بزرگ می‌شن
با شادی و با نازه
دنیا رو قشنگ می‌کنن''',
  'moral': 'بازی و شادی دسته‌جمعی، خاطرات شیرینی برای کودکان می‌سازد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۶: خروس
{
  'name': 'خروس',
  'type': 'شعرهای کودکانه',
  'description': 'شعر خروس و بیدار کردن مردم در صبح',
  'story': '''خروس خروس نازم
با تاج قرمز و نازه
هر صبح که میاد بالا
مردم رو بیدار می‌کنه

خروس می‌گه قوقولی
قوقولی قوقو
بیدار شید بچه‌ها
صبح اومد از کو

خروس نازم و من
با هم میریم به باغ
با هم برقصیم و بخندیم
دنیا رو قشنگ کنیم

خروس با آوازش
دل ما رو شاد می‌کنه
با صدای پر از شوق
زندگی رو زیبا می‌کنه

خروس نازم و من
با هم میریم به راه
با هم درس می‌خونیم
با شادی و آگاه''',
  'moral': 'خروس با آواز خود، شروع روزی تازه را به ما خبر می‌دهد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۷: گرگم و گله میبرم
{
  'name': 'گرگم و گله میبرم',
  'type': 'شعرهای کودکانه',
  'description': 'شعر بازی گرگم و گله میبرم',
  'story': '''گرگم و گله میبرم
بچه‌ها دور هم جمعن
با شادی و با خنده
بازی قشنگ می‌کنن

گرگم و گله میبرم
یکی گرگه یکی گله
بچه‌ها می‌دونن و می‌پرن
با شوق و با سعه

گرگم و گله میبرم
بازی قدیمی و نازه
بچه‌ها با هم می‌خونن
با شادی و با آوازه

گرگم و گله میبرم
بچه‌ها با هم می‌رقصن
با شادی و با شوق
دنیا رو قشنگ می‌کنن

گرگم و گله میبرم
بازی خوب و قشنگه
بچه‌ها با هم بزرگ می‌شن
با شادی و با رنگ''',
  'moral': 'بازی‌های گروهی، همکاری و شادی را به کودکان می‌آموزد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۸: خدای ما
{
  'name': 'خدای ما',
  'type': 'شعرهای کودکانه',
  'description': 'شعر خدای مهربان و زیبایی‌های آفرینش',
  'story': '''خدای ما مهربونه
همیشه با ماست
هر جا که باشیم نازم
با ماست و با ماست

خدای ما بزرگه
با قدرت بی‌نظیر
گل‌ها و درختا رو
آفریده با تدبیر

خدای ما نازم
با من بیا به باغ
با هم گل می‌بینیم
با شوق و با ذوق

خدای ما خدای خوبه
همیشه دوست داره
بچه‌های ناز و مهربون
رو خیلی دوست داره

خدای ما نازم
تو بهترین پناهی
با تو همیشه شادم
با عشق و آگاهی''',
  'moral': 'خداوند مهربان و بزرگ است و همه موجودات را دوست دارد',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۱۹: شهر
{
  'name': 'شهر',
  'type': 'شعرهای کودکانه',
  'description': 'شعر شهر زیبا و بچه‌های خوشحال',
  'story': '''شهر شهر نازم
با خونه‌های رنگارنگ
بچه‌ها با هم بازی می‌کنن
با شوق و با ذوق

شهر شهر می‌گه
با من بیا به خیابون
با هم قدم می‌زنیم
با شادی و با آهنگ

شهر شهر نازم
با من بیا به پارک
با هم بازی می‌کنیم
با شوق و با ذوق

شهر شهر با خیابون
زندگی قشنگی داره
بچه‌ها با هم بزرگ می‌شن
با شادی و با آوازه

شهر شهر نازم
تو بهترین خونه‌ای
با خیابونای قشنگت
دنیا رو زیبا می‌کنی''',
  'moral': 'شهر محل زندگی ماست و باید آن را تمیز و زیبا نگه داریم',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},

// شعر ۲۰: شعر ما بچه‌ها
{
  'name': 'شعر ما بچه‌ها',
  'type': 'شعرهای کودکانه',
  'description': 'شعر شادی و بازی بچه‌ها',
  'story': '''شعر ما بچه‌ها
با خنده و شادی
با بازی و با ذوق
دنیا رو قشنگ می‌کنیم

شعر ما بچه‌ها
با هم و در کنار هم
با دوستی و مهربونی
زندگی رو شیرین می‌کنیم

شعر ما بچه‌ها
با آواز و با نغمه
با شادی و با سعه
دنیا رو روشن می‌کنیم

شعر ما بچه‌ها
با عشق و با صفا
با هم بزرگ می‌شیم
با شادی و با آگاه

شعر ما بچه‌ها
برای همیشه موندگاره
با خنده و با شادی
دنیا رو قشنگ می‌کنه''',
  'moral': 'کودکان با شادی و بازی خود، دنیا را زیباتر می‌کنند',
  'color': Colors.pink,
  'icon': Icons.auto_stories,
  'image': '',
},


// ==================================================
// ۲۰ داستان جدید از وب‌سایت اتل متل توتوله
// ==================================================

// داستان ۱: بز زنگوله‌پا
{
  'name': 'بز زنگوله‌پا',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان بز باهوشی که با زنگوله‌اش گرگ را فریب داد',
  'story': '''در یک روستای کوچک، بز زیبایی به اسم گل‌خان زندگی می‌کرد. گل‌خان یک زنگوله طلایی به گردن داشت که با هر قدمش صدای قشنگی می‌داد. مردم روستا صدای زنگوله‌اش را دوست داشتند و می‌دانستند که گل‌خان کجاست.

یک روز، گرگ حیله‌گری به روستا آمد و تصمیم گرفت بز را بدزدد. اما می‌دانست که صدای زنگوله باعث می‌شود مردم متوجه شوند. گرگ شبانه به طویله رفت و زنگوله را از گردن بز باز کرد و آن را به دم خودش بست.

صبح که شد، مردم صدای زنگوله را از دور دست شنیدند. فکر کردند بز فرار کرده است، اما چوپان باهوش فهمید که اگر بز فرار می‌کرد، آرام فرار می‌کرد و زنگوله اینقدر صدا نمی‌داد. او به دنبال صدا رفت و گرگ را در حال فرار دید.

چوپان گرگ را تعقیب کرد و بز را نجات داد. گرگ فرار کرد و دیگر به آن روستا برنگشت. گل‌خان دوباره زنگوله‌اش را به گردن آویخت و با خوشحالی به چرا ادامه داد. مردم روستا از هوش چوپان خوشحال شدند و به او هدیه دادند.''',
  'moral': 'همیشه باید باهوش باشیم و با دقت به نشانه‌ها توجه کنیم تا از خطرات جلوگیری کنیم',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۲: شهر موش‌ها
{
  'name': 'شهر موش‌ها',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان موش‌هایی که شهری زیرزمینی ساختند و با گربه‌ها جنگیدند',
  'story': '''زیر زمین، شهر بزرگی از موش‌ها وجود داشت. موش‌ها با هم همکاری می‌کردند و زندگی خوبی داشتند. آنها انبارهای پر از دانه، خانه‌های راحت و مدرسه‌های قشنگ برای بچه‌هایشان ساخته بودند.

یک روز، گربه‌های بزرگ و خطرناکی به شهر موش‌ها حمله کردند. موش‌ها ترسیدند و نمی‌دانستند چکار کنند. پادشاه موش‌ها، موش سفید عاقلی به اسم نرگس، همه موش‌ها را جمع کرد و گفت: "ما باید از شهرمان دفاع کنیم!"

موش‌ها با هم نقشه‌ای کشیدند. آنها تونل‌های پیچ‌درپیچ ساختند که گربه‌ها در آنها گم می‌شدند. سوراخ‌های کوچکی درست کردند که فقط خودشان از آنها رد می‌شدند. و یک زنگ بزرگ نصب کردند که با صدای آن، همه موش‌ها به سنگرها می‌رفتند.

وقتی گربه‌ها دوباره حمله کردند، موش‌ها نقشه‌شان را اجرا کردند. گربه‌ها در تونل‌ها گم شدند و نتوانستند موش‌ها را پیدا کنند. موش‌ها با همکاری هم، گربه‌ها را شکست دادند و شهرشان را نجات دادند.

گربه‌ها از آن روز به بعد، دیگر به شهر موش‌ها حمله نکردند و موش‌ها با آرامش در شهر زیرزمینی خود زندگی کردند.''',
  'moral': 'همکاری و اتحاد، قدرت را بیشتر می‌کند و می‌تواند هر خطری را دفع کند',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۳: کدو قلقله‌زن
{
  'name': 'کدو قلقله‌زن',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان کدویی که حرف می‌زد و به بچه‌ها کمک می‌کرد',
  'story': '''در یک باغ بزرگ، یک کدو غول‌پیکر به اسم قلقله‌زن زندگی می‌کرد. این کدو مثل بقیه کدوها نبود؛ او می‌توانست حرف بزند و با بچه‌های روستا دوست بود.

هر روز که بچه‌ها به باغ می‌آمدند، قلقله‌زن برایشان داستان‌های قشنگ تعریف می‌کرد. او از سفرهایی که در رویاهایش می‌رفت می‌گفت، از پرنده‌هایی که بالای سرش می‌پریدند و از گل‌هایی که در شب می‌رقصیدند.

یک روز، بچه‌ها ناراحت به باغ آمدند. گفتند که مدرسه‌شان قرار است تعطیل شود چون معلم جدیدی برایشان پیدا نشده است. قلقله‌زن فکری کرد و گفت: "من می‌توانم به شما درس بدهم! من هر روز چیزهای جدیدی یاد می‌گیرم."

بچه‌ها با خوشحالی قبول کردند. قلقله‌زن هر روز به بچه‌ها درس می‌داد: درباره طبیعت، ستاره‌ها، گیاهان و حیوانات. بچه‌ها خیلی چیزها یاد گرفتند و مدرسه‌شان باز ماند.

مردم روستا از قلقله‌زن تشکر کردند و او را به عنوان معلم افتخاری روستا انتخاب کردند. قلقله‌زن تا آخر عمرش به بچه‌ها درس داد و آنها را خوشحال کرد.''',
  'moral': 'هیچ‌وقت نباید از یاد گرفتن دست بکشیم و هر کسی می‌تواند معلم خوبی باشد',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۴: سه بچه خوک
{
  'name': 'سه بچه خوک',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان سه بچه خوک که هر کدام خانه‌ای ساختند و با گرگ روبرو شدند',
  'story': '''سه بچه خوک با مادرشان در یک مزرعه زندگی می‌کردند. وقتی بزرگ شدند، مادرشان به آنها گفت: "هر کدام باید برای خودتان خانه‌ای بسازید و مستقل شوید."

بچه خوک اول تنبل بود. او یک خانه کاهی ساخت. بچه خوک دوم کمی کوشاتر بود. او یک خانه چوبی ساخت. اما بچه خوک سوم سخت‌کوش بود. او یک خانه آجری محکم ساخت.

یک روز، گرگ گرسنه به خانه اول آمد و گفت: "بچه خوک! در را باز کن!" خوک اول قبول نکرد. گرگ فوت کرد و خانه کاهی را ویران کرد. خوک اول به خانه دوم فرار کرد.

گرگ به خانه دوم آمد و گفت: "در را باز کنید!" اما آنها قبول نکردند. گرگ فوت کرد و خانه چوبی را هم ویران کرد. دو خوک به خانه سوم فرار کردند.

گرگ به خانه سوم آمد و هرچه فوت کرد، خانه آجری تکان نخورد. گرگ از دودکش بالا رفت، اما خوک‌ها یک دیگ آب جوش زیر دودکش گذاشته بودند. گرگ توی دیگ افتاد و سوخت و فرار کرد.

سه بچه خوک با خوشحالی در خانه آجری زندگی کردند و از آن روز، به اهمیت سخت‌کوشی پی بردند.''',
  'moral': 'سخت‌کوشی و برنامه‌ریزی، همیشه نتیجه بهتری از تنبلی دارد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۵: مورچه اشک‌ریزان
{
  'name': 'مورچه اشک‌ریزان',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان مورچه‌ای که از دست دادن خانواده‌اش غمگین بود و دوست جدید پیدا کرد',
  'story': '''در یک لانه بزرگ، مورچه کوچکی به اسم اشک‌ریزان زندگی می‌کرد. او همیشه غمگین بود و اشک می‌ریخت، چون خانواده‌اش را در یک سیل از دست داده بود. مورچه‌های دیگر او را مسخره می‌کردند و می‌گفتند: "تو همیشه گریه می‌کنی! دیگر بزرگ شو!"

یک روز، مورچه پیر و دانایی به اشک‌ریزان نزدیک شد و گفت: "غم و اندوه را نباید در دل نگه داشت. اشک ریختن نشانه ضعف نیست، نشانه انسانیت است. اما نباید اجازه دهی غم، زندگی‌ات را نابود کند."

اشک‌ریزان از حرف‌های مورچه پیر خوشش آمد و تصمیم گرفت زندگی جدیدی را شروع کند. او شروع به کمک به مورچه‌های دیگر کرد و با آنها دوست شد.

یک روز، باران شدیدی آمد و لانه مورچه‌ها در خطر خراب شدن بود. اشک‌ریزان با شجاعت به دیگران کمک کرد تا لانه را نجات دهند. همه از شجاعت او تعجب کردند و او را تحسین کردند.

اشک‌ریزان فهمید که حتی در سخت‌ترین شرایط هم می‌توان امیدوار بود و به دیگران کمک کرد. او دیگر اشک نمی‌ریخت و به یک مورچه شجاع و محبوب تبدیل شد.''',
  'moral': 'غم و اندوه نباید زندگی را نابود کند؛ با شجاعت و کمک به دیگران می‌توان بر سختی‌ها غلبه کرد',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۶: دزد و مرغ فلفلی
{
  'name': 'دزد و مرغ فلفلی',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان مرغی که با فلفل، دزد را فراری داد',
  'story': '''یک روز، دزدی به مرغدانی یک روستا رفت تا مرغ‌ها را بدزدد. اما در میان مرغ‌ها، یک مرغ فلفلی قرمز و کوچک بود که خیلی تندمزاج بود. مرغ فلفلی به دزد گفت: "اگر به من دست بزنی، پشیمان می‌شوی!"

دزد خندید و گفت: "تو که یک مرغ کوچک هستی، چطور می‌خواهی من را پشیمان کنی؟" و دستش را به سمت مرغ دراز کرد.

مرغ فلفلی سریعاً نوک زد و مقداری فلفل تند به چشم دزد پاشید. دزد از درد شروع به گریه کرد و چشمانش را مالید. فلفل حسابی چشمانش را سوزاند.

دزد که نتوانست چیزی ببیند، شروع به دویدن کرد و به دیوار خورد و افتاد. مرغ‌های دیگر با خوشحالی دور مرغ فلفلی جمع شدند و او را تشویق کردند.

صاحب مرغدانی که صدای سر و صدا را شنید، به مرغدانی آمد و دزد را گرفت و به پلیس تحویل داد. مرغ فلفلی قهرمان روستا شد و همه او را دوست داشتند.

مرغ فلفلی به مرغ‌های دیگر گفت: "همیشه باید از خودتان دفاع کنید و نترسید!"''',
  'moral': 'با شجاعت و زیرکی می‌توان از خود دفاع کرد و حتی بر دشمنان بزرگ‌تر پیروز شد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۷: خروس زری پیرهن پری
{
  'name': 'خروس زری پیرهن پری',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان خروس زیبایی که با آوازش مردم را بیدار می‌کرد و جشنی برایش گرفتند',
  'story': '''در یک روستا، خروس زیبایی به اسم زرین زندگی می‌کرد. زرین پرهای طلایی و یک تاج قرمز بزرگ داشت. هر صبح، زرین با آواز قشنگش همه را بیدار می‌کرد و مردم روستا روزشان را با صدای خوش او شروع می‌کردند.

مردم روستا زرین را خیلی دوست داشتند. یک روز، بچه‌های روستا تصمیم گرفتند برای زرین یک جشن بگیرند. آنها برایش یک پیرهن پری از پارچه‌های رنگارنگ دوختند و به او هدیه دادند.

زرین با خوشحالی پیرهن را پوشید و روی پشت بام رفت و آواز خواند. مردم با خوشحالی دورش جمع شدند و با او رقصیدند. آن روز، همه روستا جشن داشتند.

از آن روز، زرین هر روز با پیرهن پری‌اش آواز می‌خواند و همه را خوشحال می‌کرد. زرین فهمید که مهربانی و شادی، بهترین هدیه‌ای است که می‌توان به دیگران داد.

مردم روستا همیشه زرین را دوست داشتند و از او تشکر می‌کردند که هر روز با آوازش، روزشان را شروع می‌کرد.''',
  'moral': 'مهربانی و شادی، بهترین هدیه‌ای است که می‌توان به دیگران داد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۸: داستان انجیر زیبا
{
  'name': 'داستان انجیر زیبا',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان درخت انجیری که میوه‌هایش طلا بود و به فقرا کمک می‌کرد',
  'story': '''در یک روستا، یک درخت انجیر بزرگ و زیبا وجود داشت. این درخت هر سال انجیرهای طلایی و خوشمزه می‌داد. مردم روستا این میوه‌ها را می‌چیدند و می‌فروختند و پول خوبی به دست می‌آوردند.

اما یک سال، خشکسالی شدید آمد و درخت انجیر میوه نداد. مردم ناراحت شدند و نمی‌دانستند چکار کنند. پیرمرد دانای روستا گفت: "ما باید از درخت مراقبت کنیم تا دوباره میوه بدهد."

مردم با همکاری هم به درخت آب دادند، خاکش را نرم کردند و از آن مراقبت کردند. کمکم درخت دوباره سبز شد و انجیرهای طلایی داد.

مردم فهمیدند که باید قدر داشته‌هایشان را بدانند و از آنها مراقبت کنند. آنها قسمتی از محصول را به فقرا دادند و از آن روز، روستا همیشه پر از برکت بود.

درخت انجیر هر سال میوه‌های طلایی می‌داد و مردم با شادی آنها را می‌چیدند و از برکت خداوند سپاسگزار بودند.''',
  'moral': 'مراقبت از داشته‌ها و بخشش به دیگران، برکت زندگی را زیاد می‌کند',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۹: میز ناراحت
{
  'name': 'میز ناراحت',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان میزی که از بی‌مهرگی صاحبش ناراحت بود و روزی قدردانی شد',
  'story': '''در یک خانه، یک میز چوبی قدیمی و زیبا وجود داشت. این میز سال‌ها بود که در خانه بود و شاهد خاطرات زیادی بود. اما صاحب خانه، مرد بی‌محبتی بود که همیشه به میز لگد می‌زد و به آن بی‌احترامی می‌کرد.

میز ناراحت بود و با خودش فکر می‌کرد که چرا صاحبش اینقدر با او بد است. یک روز، میز تصمیم گرفت با صاحبش حرف بزند. وقتی مرد تنها بود، میز با صدای آرامی گفت: "چرا اینقدر با من بد هستی؟ من سال‌هاست که به تو خدمت می‌کنم."

مرد که صدای میز را شنید، تعجب کرد و گفت: "تو یک میز چوبی هستی، چطور حرف می‌زنی؟"

میز گفت: "من خیلی چیزها دیده‌ام و خاطرات زیادی در دلم دارم. تو باید به من احترام بگذاری."

مرد از حرف‌های میز خجالت کشید و از او عذرخواهی کرد. از آن روز، مرد به میز احترام می‌گذاشت و از آن مراقبت می‌کرد. میز خوشحال شد و تا آخر عمر در آن خانه ماند.

مرد فهمید که باید به همه چیز احترام بگذارد، حتی به اشیای بی‌جان.''',
  'moral': 'احترام به همه چیز، حتی اشیای بی‌جان، نشانه انسانیت است',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۰: شش در رو بستی نمکی، یک در رو نبستی نمکی
{
  'name': 'شش در رو بستی نمکی، یک در رو نبستی نمکی',
  'type': 'فرهنگ و دانش بومی سنتی مردم',
  'description': 'داستان نمکی که یک در را نبست و دیو به خانه‌شان آمد',
  'story': '''یک مرد و زن بودند که هفت تا دختر داشتند. خانه‌شان هشت در داشت و هر شب نوبت یکی از دخترها بود که درها را ببندد. اگر یکی از درها را نمی‌بست، دیو به خانه آنها می‌آمد.

یک شب، نوبت نمکو بود که درها را ببندد. مادرش گفت: "برو همه درها را ببند." نمکو همه درها را بست، اما یک در را یادش رفت ببندد.

شب که شد، دیو آمد توی خانه‌شان. دیو گفت: "بریسید و بریسید ماه دودان / بیارید یک چایی بهر مهمان." خواهرهای نمکو گفتند: "نمکو کور شو برو چایی بهش بده."

نمکو گریه‌کنان به دیو چایی داد. دیو گفت: "بیارید یک شامی بهر مهمان." باز نمکو رفت و دیو را شام داد. دیو گفت: "همدم می‌خواهم." خواهرهایش گفتند: "نمکو کور شو برو همدمش باش."

نمکو با دیو خوابید و نصف شب دیو او را برداشت و برد. اما نمکو با هوش و ذکاوتش توانست سه بار از دست دیو فرار کند و در نهایت دیو را شکست داد و به خانه برگشت و خواهرهایش را نجات داد.''',
  'moral': 'هوش و ذکاوت می‌تواند آدمی را از خطرات نجات دهد و بی‌دقتی باعث دردسر می‌شود',
  'color': Colors.amber,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۱: جوجه کلاغ پارک
{
  'name': 'جوجه کلاغ پارک',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان جوجه کلاغی که از لانه افتاد و با بچه‌های پارک دوست شد',
  'story': '''یک روز بادی، یک جوجه کلاغ کوچک از لانه‌اش در پارک افتاد. جوجه کلاغ ترسیده بود و نمی‌توانست پرواز کند. بچه‌های پارک که داشتند بازی می‌کردند، جوجه کلاغ را دیدند و به کمکش آمدند.

بچه‌ها جوجه کلاغ را برداشتند و به او آب و غذا دادند. جوجه کلاغ کمک‌کم به بچه‌ها عادت کرد و با آنها دوست شد. بچه‌ها اسمش را گذاشتند "پارکی".

پارکی با بچه‌ها بازی می‌کرد، با آنها قدم می‌زد و حتی با آنها غذا می‌خورد. بچه‌ها عاشق پارکی شده بودند. اما یک روز، مادر کلاغ به دنبال جوجه‌اش به پارک آمد و با ناراحتی بالای سرش چرخید.

بچه‌ها فهمیدند که پارکی باید پیش مادرش برگردد. با اینکه ناراحت بودند، اما جوجه کلاغ را به مادرش بازگرداندند. پارکی با خوشحالی به لانه برگشت و بچه‌ها هم خوشحال بودند که توانسته بودند به او کمک کنند.

هر روز که بچه‌ها به پارک می‌آمدند، پارکی از بالا به آنها نگاه می‌کرد و با صدای بلند قارقار می‌کرد و بچه‌ها هم دست تکان می‌دادند.''',
  'moral': 'کمک به حیوانات و مهربانی با آنها، شادی و خوشحالی را به زندگی ما می‌آورد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۲: تاب تاب
{
  'name': 'تاب تاب',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان تاب جادویی که بچه‌ها را به سفرهای قشنگ می‌برد',
  'story': '''در یک پارک، یک تاب قدیمی و زیبا وجود داشت. این تاب مثل تاب‌های دیگر نبود؛ وقتی بچه‌ها روی آن می‌نشستند و تاب می‌خوردند، به جاهای قشنگ سفر می‌کردند.

یک روز، سارا و علی روی تاب نشستند و شروع به تاب خوردن کردند. ناگهان، آنها خودشان را در یک جنگل بزرگ و سرسبز دیدند. پرنده‌های رنگارنگ برایشان آواز می‌خواندند و گل‌های عجیب با آنها حرف می‌زدند.

سارا و علی در جنگل قدم زدند و با حیوانات دوست شدند. یک خرگوش مهربان آنها را به خانه‌اش دعوت کرد و با هویج و عسل از آنها پذیرایی کرد.

وقتی وقت برگشتن شد، دوباره روی تاب نشستند و تاب خوردند تا به پارک برگشتند. آنها ماجرای قشنگشان را برای دوستانشان تعریف کردند و دوستانشان هم دوست داشتند به آن سفر بروند.

از آن روز، تاب جادویی هر روز بچه‌ها را به سفرهای جدید می‌برد: به کوهستان‌های برفی، به دریاهای آبی، به شهرهای رنگارنگ. و بچه‌ها هر روز ماجراهای جدیدی تجربه می‌کردند.''',
  'moral': 'تخیل و ماجراجویی، دنیای کودکان را پر از شادی و هیجان می‌کند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۳: گنجشک‌های خونه
{
  'name': 'گنجشک‌های خونه',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان گنجشک‌هایی که در خانه یک پیرزن لانه ساختند و با او دوست شدند',
  'story': '''یک پیرزن مهربان در یک خانه قدیمی زندگی می‌کرد. یک روز، یک جفت گنجشک آمدند و زیر سقف خانه‌اش لانه ساختند. پیرزن صدای جیک‌جیک آنها را دوست داشت و هر روز برایشان خرده نان می‌ریخت.

گنجشک‌ها کمک‌کم به پیرزن عادت کردند و از او نمی‌ترسیدند. آنها هر روز صبح با آوازشان پیرزن را بیدار می‌کردند و عصرها با او خداحافظی می‌کردند.

یک روز، پیرزن مریض شد و نتوانست برای گنجشک‌ها غذا بگذارد. گنجشک‌ها نگران شدند و به دنبال غذا گشتند. آنها دیدند که پیرزن در رختخواب افتاده و نمی‌تواند بلند شود.

گنجشک‌ها به همسایه‌ها خبر دادند و آنها به کمک پیرزن آمدند. پیرزن خوب شد و از گنجشک‌ها تشکر کرد. او گفت: "شما بهترین دوستان من هستید!"

گنجشک‌ها تا آخر عمر با پیرزن زندگی کردند و او را خوشحال نگه داشتند. پیرزن همیشه می‌گفت که گنجشک‌ها بهترین هدیه زندگی‌اش بودند.''',
  'moral': 'مهربانی با حیوانات، محبت آنها را به همراه دارد و همیشه پاداش خوبی دارد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۴: قصه یولک طلا و نفس کشیدن قورقوری
{
  'name': 'یولک طلا و نفس کشیدن قورقوری',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان یولک طلایی که با نفس‌های جادویی خود به مردم کمک می‌کرد',
  'story': '''در یک روستا، یک یولک (مرغابی) طلایی به اسم زرین زندگی می‌کرد. زرین یک نفس جادویی داشت که می‌توانست هر چیزی را شفا دهد. وقتی بیماران روستا به سراغش می‌آمدند، زرین روی آنها نفس می‌کشید و آنها خوب می‌شدند.

اما زرین یک راز داشت: هر بار که نفس می‌کشید، صدای قورقوری می‌کرد که همه را می‌خنداند. مردم اول به این صدا می‌خندیدند، اما بعد می‌فهمیدند که شفا گرفته‌اند.

یک روز، پسر کوچکی به اسم رامین بیمار شد و به سراغ زرین آمد. زرین روی او نفس کشید و رامین خوب شد. اما رامین از صدای قورقوری خندید و به زرین گفت: "صدای تو خیلی بامزه است!"

زرین گفت: "این صدای شفا است. با هر قورقوری، یک بیماری از بین می‌رود." رامین از زرین تشکر کرد و به خانه رفت.

خبر شفاهای زرین به گوش پادشاه رسید. پادشاه که بیمار بود، زرین را به قصر دعوت کرد. زرین روی پادشاه نفس کشید و او خوب شد. پادشاه از زرین تشکر کرد و به او یک هدیه طلایی داد.

زرین تا آخر عمر به مردم کمک می‌کرد و همه او را دوست داشتند و از نفس‌های جادویی و صدای قورقوری‌اش لذت می‌بردند.''',
  'moral': 'هر کسی یک استعداد ویژه دارد و باید از آن برای کمک به دیگران استفاده کند',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۵: چشم ورقلمبیده؛ سگ تنها
{
  'name': 'چشم ورقلمبیده؛ سگ تنها',
  'type': 'قصه‌های حیوانات',
  'description': 'داستان سگی که یک چشمش را از دست داده بود و با شجاعت دوست پیدا کرد',
  'story': '''در یک شهر، یک سگ تنها به اسم ورقلمبیده زندگی می‌کرد. او یک چشمش را در یک تصادف از دست داده بود و به همین دلیل همه از او می‌ترسیدند و فرار می‌کردند. ورقلمبیده خیلی تنها بود و هیچ دوستی نداشت.

یک روز، پسر کوچکی به اسم امیر، ورقلمبیده را در خیابان دید. امیر از سگ نترسید و به او نزدیک شد. ورقلمبیده با ناراحتی به امیر نگاه کرد و امیر گفت: "چرا اینقدر ناراحتی؟"

ورقلمبیده گفت: "همه از من می‌ترسند چون یک چشمم را از دست داده‌ام." امیر با مهربانی گفت: "من از تو نمی‌ترسم. تو فقط یک سگ مهربان هستی که به دوست نیاز دارد."

امیر و ورقلمبیده با هم دوست شدند. آنها هر روز با هم بازی می‌کردند و قدم می‌زدند. ورقلمبیده خیلی خوشحال بود که بالاخره یک دوست پیدا کرده است.

یک روز، یک دزد به خانه امیر آمد و می‌خواست وسایل را بدزدد. ورقلمبیده با شجاعت به سمت دزد حمله کرد و او را فراری داد. امیر و خانواده‌اش از ورقلمبیده تشکر کردند و او را به خانه‌شان آوردند.

ورقلمبیده فهمید که با شجاعت و مهربانی می‌توان بر هر مشکلی غلبه کرد و دوست‌های خوبی پیدا کرد.''',
  'moral': 'ظاهر فریبنده است و نباید کسی را به خاطر ظاهر یا نقص جسمی‌اش قضاوت کرد',
  'color': Colors.orange,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۶: یخی که عاشق خورشید شد
{
  'name': 'یخی که عاشق خورشید شد',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان یک تکه یخ که عاشق خورشید شد و برایش آب شد',
  'story': '''در یک زمستان سرد، یک تکه یخ کوچک به اسم برفی در کنار یک رودخانه زندگی می‌کرد. برفی هر روز خورشید را می‌دید که در آسمان می‌درخشد و به او لبخند می‌زند. برفی عاشق خورشید شده بود.

برفی با خودش فکر می‌کرد: "کاش می‌توانستم به خورشید نزدیک‌تر شوم و با او حرف بزنم." اما هر بار که خورشید بیشتر می‌تابید، برفی کمی آب می‌شد و کوچک‌تر می‌شد.

یک روز، برفی تصمیم گرفت که به خورشید نزدیک‌تر شود. او با شوق به آسمان نگاه کرد و با صدای بلند گفت: "خورشید خانم! من تو را دوست دارم!"

خورشید با مهربانی گفت: "من هم تو را دوست دارم برفی! اما تو با عشق من آب می‌شوی."

برفی گفت: "من حاضرم برای عشق تو آب شوم. بودن در کنار تو برای من ارزشمندتر از ماندن به شکل یخ است."

خورشید بیشتر تابید و برفی شروع به آب شدن کرد. اما وقتی کاملاً آب شد، به یک قطره آب تبدیل شد که به رودخانه پیوست و به سمت دریا رفت. برفی در سفر به دریا، جاهای قشنگ زیادی دید و خوشحال بود که عشقش را نشان داده است.

برفی فهمید که عشق یعنی فداکاری و گاهی باید برای کسی که دوستش داری، از داشته‌هایت بگذری.''',
  'moral': 'عشق یعنی فداکاری و گاهی باید برای کسی که دوستش داریم، از داشته‌هایمان بگذریم',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۷: بابا برفی
{
  'name': 'بابا برفی',
  'type': 'قصه‌های تخیلی',
  'description': 'داستان آدم برفی که زنده شد و با بچه‌ها دوست شد',
  'story': '''در یک روز برفی، بچه‌های یک روستا یک آدم برفی بزرگ ساختند. آنها به او کلاه و شال گردن و یک بینی هویجی دادند و اسمش را گذاشتند "بابا برفی".

شب که شد، بچه‌ها به خانه رفتند. اما بابا برفی ناگهان زنده شد! او از جایش بلند شد و شروع به قدم زدن در روستا کرد. بابا برفی از دیدن دنیای جدید خیلی خوشحال بود.

صبح که بچه‌ها به حیاط آمدند، دیدند که بابا برفی جایش نیست. آنها به دنبالش گشتند و او را در پارک پیدا کردند که داشت با پرنده‌ها بازی می‌کرد.

بچه‌ها با تعجب به بابا برفی نگاه کردند و گفتند: "تو زنده شدی؟!" بابا برفی با لبخند گفت: "بله! شما با عشقتان به من جان دادید."

بابا برفی با بچه‌ها بازی می‌کرد، برایشان داستان می‌گفت و آنها را خوشحال می‌کرد. اما با گرم شدن هوا، بابا برفی شروع به آب شدن کرد.

بچه‌ها ناراحت شدند و گفتند: "نرو بابا برفی! ما تو را دوست داریم!" بابا برفی گفت: "من باید بروم، اما زمستان سال بعد دوباره برمی‌گردم."

بچه‌ها با ناراحتی با بابا برفی خداحافظی کردند و قول دادند که سال بعد دوباره او را بسازند.''',
  'moral': 'محبت و عشق می‌تواند حتی به اشیای بی‌جان هم جان بدهد و خاطرات شیرینی بسازد',
  'color': Colors.purple,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۸: مردی که لب نداشت
{
  'name': 'مردی که لب نداشت',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان مردی که با لبخند و مهربانی، قلب‌ها را فتح کرد',
  'story': '''در یک شهر، مردی زندگی می‌کرد که لب نداشت. او نمی‌توانست حرف بزند و همه از او دوری می‌کردند. مرد تنها و غمگین بود و هیچ دوستی نداشت.

یک روز، دختر کوچکی به اسم نازنین به او نزدیک شد و با مهربانی به او لبخند زد. مرد تعجب کرد، چون هیچ‌کس تا حالا به او لبخند نزده بود. نازنین گفت: "چرا اینقدر تنها هستی؟"

مرد با اشاره به لب‌هایش نشان داد که نمی‌تواند حرف بزند. نازنین گفت: "مهم نیست! من با تو دوست می‌شوم. تو می‌توانی با چشم‌هایت حرف بزنی."

نازنین هر روز به دیدار مرد می‌آمد و با او حرف می‌زد. مرد با اشاره و حرکت چشم‌هایش با او ارتباط برقرار می‌کرد. کمکم، مردم دیگر از مرد نمی‌ترسیدند و با او دوست می‌شدند.

یک روز، مرد تصمیم گرفت به مردم نشان دهد که چقدر مهربان است. او با نقاشی‌های قشنگش، دیوارهای شهر را تزئین کرد. مردم از هنر او شگفت‌زده شدند و او را تحسین کردند.

مرد فهمید که برای مهربانی نیازی به حرف زدن نیست و با عشق و هنر می‌توان قلب‌ها را فتح کرد.''',
  'moral': 'مهربانی و عشق نیازی به کلمات ندارد و با عمل می‌توان قلب‌ها را فتح کرد',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۱۹: گل اومد بهار اومد
{
  'name': 'گل اومد بهار اومد',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان بهار و گل‌هایی که با آمدنشان شادی آوردند',
  'story': '''زمستان تمام شده بود و بهار داشت از راه می‌رسید. در یک باغ بزرگ، گل‌ها在地下 خوابیده بودند و منتظر آمدن بهار بودند.

یک روز، خورشید گرمتر تابید و برف‌ها آب شدند. نسیم ملایمی وزید و به گل‌ها گفت: "بیدار شوید! بهار آمده است!"

گل‌ها یکی یکی از خواب بیدار شدند و سر از خاک بیرون آوردند. اول لاله‌ها، بعد نرگس‌ها، بعد گل‌های یاس و سرخ. باغ پر از رنگ و بو شد.

بچه‌ها با خوشحالی به باغ آمدند و گل‌ها را تماشا کردند. یک دختر کوچک به اسم سارا گفت: "بهار چه قشنگ است! گل‌ها چقدر زیبا هستند!"

یک گل سرخ به سارا گفت: "ما آمدیم تا شادی را به شما هدیه دهیم. با آمدن ما، روزها بلندتر و گرم‌تر می‌شوند و زندگی دوباره جریان می‌گیرد."

سارا فهمید که بهار، فصل تازگی و شادی است و باید از آن لذت برد. بچه‌ها با هم در باغ بازی می‌کردند و از زیبایی گل‌ها لذت می‌بردند.

بهار با گل‌هایش، امید و شادی را به همه هدیه داد و مردم با خوشحالی از آن استقبال کردند.''',
  'moral': 'بهار نماد تازگی، امید و شادی است و باید از زیبایی‌های آن لذت برد',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},

// داستان ۲۰: پیر مرد و چغندر
{
  'name': 'پیرمرد و چغندر',
  'type': 'قصه‌های پندآموز',
  'description': 'داستان پیرمردی که یک چغندر غول‌پیکر کاشت و با کمک همه آن را درآورد',
  'story': '''پیرمرد مهربانی در یک باغ کوچک زندگی می‌کرد. یک روز، یک دانه چغندر کاشت و از آن مراقبت کرد. چغندر روز به روز بزرگ‌تر شد تا اینکه به اندازه یک کدو تنبل بزرگ شد!

پیرمرد می‌خواست چغندر را از زمین دربیاورد، اما هرچه کشید، نتوانست. به سراغ همسرش رفت و گفت: "بیا کمکم کن تا چغندر را دربیاوریم."

زن و مرد با هم کشیدند، اما چغندر تکان نخورد. نوه‌شان را صدا کردند. نوه آمد و کمک کرد، اما باز هم نشد. سگ را صدا کردند، گربه را صدا کردند، حتی موش را صدا کردند!

همه با هم کشیدند و کشیدند تا اینکه چغندر از زمین کنده شد و همه روی هم افتادند و خندیدند.

پیرمرد گفت: "اگر همه کمک نمی‌کردند، من نمی‌توانستم این چغندر غول‌پیکر را از زمین دربیاورم. همکاری یعنی قدرت!"

همگی چغندر را به خانه بردند و با هم یک آش خوشمزه درست کردند و از آن لذت بردند. پیرمرد فهمید که کار گروهی و همکاری، کارهای بزرگ را ممکن می‌کند.''',
  'moral': 'همکاری و کمک کردن به یکدیگر، کارهای بزرگ را ممکن می‌کند و همه از نتیجه آن بهره‌مند می‌شوند',
  'color': Colors.green,
  'icon': Icons.auto_stories,
  'image': '',
},
];