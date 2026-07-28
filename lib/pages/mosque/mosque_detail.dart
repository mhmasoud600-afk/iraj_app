
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MosqueDetail extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;
  final double fontSize;
  final String fontFamily;
  final Color textColor;
  final Color backgroundColor;
  final bool isMosque;
  
  const MosqueDetail({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.description,
    required this.fontSize,
    required this.fontFamily,
    required this.textColor,
    required this.backgroundColor,
    required this.isMosque,
  }) : super(key: key);

  @override
  State<MosqueDetail> createState() => _MosqueDetailState();
}

class _MosqueDetailState extends State<MosqueDetail> {
  bool isDescriptionExpanded = false;
  bool isPoemExpanded = false;

  final String hajIsaDescription = """
بسم الله الرحمن الرحیم
شرح حال عارف بزرگ حاج عیسی بیابانکی
اینجانب رسول دانا از زمان کودکی که در ایام عاشورا
که علمها را بعد از ظهر عاشورا در منازل می بردند و فاتحه برای در گذشتگان می خواندند شاهد بودم که پس از پَرسه زدن در منازل همه سر قبرستان می رفتند و مرحوم ابوالحسن اکبر پس از فاتحه خوانی در قبرستان به مردم می فرمود بیایید برویم سر قبر حاج عیسی که آن زمان واقع شده بود در ضلع جنوبی قبرستان گبرا همه باتفاق می آمدیم کنار قبر مرحوم حاج عیسی  و پس از قرائت فاتحه از هر علمداری یک قرص نان می گرفت و قطعه قطعه می کرد و در یک سینی روی قبر قرار می داد و بعد از دعا کنار قبرایشان قطعات نان را بین حاضرین بعنوان تبرک تقسیم می کرد
بنده در کودکی بارها از مرحوم ابوی شنیده بودم که مرحوم حاج عیسی جد اعلای ماست و انطوری که پدر نقل می کرد پدرِ پدرم مرحوم مرادعلی بوده و پدر ایشان غلامعلی و پدر غلامعلی سلطانعلی بوده و پدر سلطانعلی هم مرحوم حاج عیسی بوده است که محل زندگی و کسب کارشان در مزرعه ی پا پرده بوده است و هر روز مقید بوده نمازهای پنجگانه را در مسجد جامع اقامه کند ولذا از همان پا پرده اسبی برای ایشان آماده می شده و ایشان سوار بر اسب بسرعت می آمده نزدیک ایراج در جایی که معروف است به چیل اسبی پیاده می شده و اسب غایب می شده بعد از نماز ایشان می رفتند همان مکان دوباره اسب حاضر می شده و ایشان را به پا پرده می برده بنده سال ۵۲ که به تهران امدم با همین مختصر اطلاعات بودم لکن در سالهای پس از پیروزی انقلاب تحقیقات بیشتری از قدیمیها کردم راجع به ایشان از مرحومه کربلایی ذلیخا موبدمادربزرگم از مرحوم قاضی از مرحوم محمد یگانه پدر شهید علی یگانه از مرحوم عباسعلی اقبال از مرحومه گلستان و از مرحوم غلامرضا دانا عموی پدرم از مرحوم حاج محمد حسن موبد دایی بزرگوار همه تقریباً یک قول بودند در انچه مرحوم ابوی گفته بود مضافاً اینکه می گفتند کفش جلوی پایشان جفت می شده و مرد عارف و با تقوایی بوده که مورد احترام نه تنها ایراج بلکه منطقه بوده است
در سالهای شصت وسه یا شصت وچهار دقیق بخاطر ندارم که در این دوسه سال کدام سال بود در ایام نوروز که همه ی فامیل جمع بودند در ایراج تصمیم گرفتیم یک روز باتفاق روز جمعه قبر را باز کنیم و اگر جسدی یا استخوانی هست ببریم در گلزار شهدا دفن کنیم از این کاری که قراربود انجام بشود بنده خیلی نگران بودم نسبت به درستی آن لذا شب جمعه با توسلی که به اهلبیت موقع خوابیدن پیدا کردم از خداوند خواستم حقیقت برایم روشن شود که انجام اینکار درست است یانه بعد از اینکه خوابیدم در عالم رؤیا دیدم که همان موضع قبر چمنزاری است و وقتی روی قبررا باز کردیم مشاهده کردم آقایی بسیار نورانی با صورت کشیده و چشمانی ازرق و موهای بلند خرمایی و ابروانی کشید ه و پیوسته در حالیکه دستاری به پیشانی بسته داشت از میان قبر بلند شد و نشست من کنار ایشان بودم پس از احوالپرسی گفتم شما زنده اید گفت بله و نگاهی به دور و بر کرد و دوباره در قبر آرام گرفت من از خواب بیدار شدم دیدم نیم ساعت مانده به اذان صبح بعد از اقامه نماز و دعا و قرآن و صرف صبحانه آمدم سر قبر مرحوم حاج عیسی و برادرم حاج محمد و خواهر زاده ها و عمه زاده ها همه آمدند سنگها را بر داشتیم خاکها را کنار زدیم حدود یک متر که پایین رفتیم رسیدیم به سه لخته سنگ نسبتا بزرگ که روی قبر راپوشانده بود اطمینان حاصل شد که قبر وجود دارد لذا خواستند سنگها را بردارند بنده مانع شدم و چون در عالم رؤیا ثابت شد که ایشان از عرفا و بزرگان هستند خوابم را تعریف کردم و گفتم جایز نیست قبر باز شود هرچند ناراحت شدند ولی قبر را پر کردیم و با بلوک و آجرا مقداری از سطح زمین بالا آوردیم


بارها بنده برای اینکه نزولات آسمانی ببارد آب روی قبر ریختم و همان شب یا فردای آن قدری باران می آمد
امروزه قبر این مرد بزرگ در ضلع غربی شهرک جنوب
قبر خانه ی عالم می باشد که سنگ روی قبر را هم پدر خانم حجه الاسلام صدیقی که مدتی در ایراج امام جماعت بودند با توجه به حاجتی که داشتند و از ایشان خواسته بودند از خدا بخواهد حاجت روا شود و نتیجه گرفته بود و مشکلشان حل شده بود تصمیم به نوشتن سنگ قبر می گیرند و با هزینه خودشان روی قبر نصب می کنند
لازم به یا اوری است در مورد وفات ایشان بنده در عالم رؤیا قطعه سنگی صافی باندازه ی یک دست دیدم که حک شده بود ۱۱۵۰هجری ولی در برداشتن خاک قبر چیزی ندیدیم 
روحش شاد و یادش گرامی باد ـ رسول دانا
""";

  final String hajIsaPoem = """
ای ولیِّ خدا ،حاج عیسی
افتخاری به ما حاج عیسی
از تو گویند حرفها مردم
بوده ای بی ریا حاج عیسی
شرح حالت شنیدم از چندی
احترامت بجا حاج عیسی
کسب و کار تو بوده پا پرده
هم به صبح و مسا حاج عیسی
بوده ای مخلص و خدا محور
اهل راز و دعا حاج عیسی
دو سه فرسخ ره تا پا پرده
بوده است گوئیا حاج عیسی
آمد و رفت کارِ هر روزت
هم به صبح و مسا حاج عیسی
تا نمازت به  مسجدِ جامع
بنمایی ادا حاج عیسی
می شده بهر تو مهیا اسب
از همان ابتدا حاج عیسی
می شده ابتدایِ دِه غایب
کس نداند چرا حاج عیسی
بوده ای صاحب کراماتی
بوده مشکل گشا حاج عیسی
دوسه قرن است جای تو خالیست
بین اهل ولا حاج عیسی
دور قبرت بُوَد ز قبرستان
از چه باشد جدا حاج عیسی
علتش را کسی نمی داند
اصلا این ماجرا حاج عیسی
داخل شهرک است امروزه
شده از نو بنا حاج عیسی
هست در جنبِ خانه ی عالم
دارد انجا صفا حاج عیسی
مورد احترام هستی تو
پیرو مرتضی حاج آقا
بر مزارت حضور می یابد
غیر و هم آشنا حاج عیسی
رحمت حق به روح پاکت باد
مرد بی ادعا حاج عیسی
شرحِ حالِ تو می کند « دانا»
که بر اویی نیا حاج عیسی
""";

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isMosque ? Colors.blue : Colors.green;
    final isHajIsa = widget.name.contains("حاج عیسی");
    final isSahabeh = widget.name.contains("زیارتگاه صحابه");

    return Scaffold(
      backgroundColor: isSahabeh ? Colors.green.shade50 : widget.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontSize: widget.fontSize + 2,
            fontFamily: widget.fontFamily,
            color: widget.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isSahabeh ? Colors.green : themeColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // تصویر
            GestureDetector(
              onTap: () {
                _showFullImageDialog(context);
              },
              child: Container(
                width: double.infinity,
                height: 250,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                  color: isSahabeh ? Colors.green.withOpacity(0.1) : themeColor.withOpacity(0.1),
                ),
                child: widget.imagePath.isNotEmpty 
                      
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholderIcon();
                          },
                        ),
                      )
                    : _buildPlaceholderIcon(),


),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // توضیحات اصلی
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: isSahabeh ? Colors.green.withOpacity(0.3) : themeColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: _buildDescriptionText(widget.description, isMainDesc: true),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // فقط برای حاج عیسی: قسمت شرح حال
                  if (isHajIsa) ...[
                    _buildExpandableSection(
                      title: "شرح حال حاج عیسی بیابانکی",
                      content: hajIsaDescription,
                      isExpanded: isDescriptionExpanded,
                      onToggle: () {
                        setState(() {
                          isDescriptionExpanded = !isDescriptionExpanded;
                        });
                      },
                      color: Colors.orange,
                      icon: Icons.description,
                      isPoem: false,
                      previewLines: 3, // نمایش 3 خط اول
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // قسمت شعر
                    _buildExpandableSection(
                      title: "شعر از حاج رسول دانا",
                      content: hajIsaPoem,
                      isExpanded: isPoemExpanded,
                      onToggle: () {
                        setState(() {
                          isPoemExpanded = !isPoemExpanded;
                        });
                      },
                      color: Colors.purple,
                      icon: Icons.auto_stories,
                      isPoem: true,
                      previewLines: 4, // نمایش 4 بیت (8 خط)
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                  
                  // برای زیارتگاه صحابه: کادر اضافی زیر عکس
                  if (isSahabeh) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.green, size: 24),


const SizedBox(width: 8),
                              Text(
                                "اطلاعات بیشتر",
                                style: TextStyle(
                                  fontSize: widget.fontSize + 2,
                                  fontFamily: widget.fontFamily,
                                  color: widget.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildDescriptionText(
                            "این زیارتگاه به نام صحابه نامگذاری شده است، لیکن اطلاعات دقیقی از شخص مدفون در دست نیست. احتمال می‌رود که ایشان یکی از صحابه امام رضا (ع) باشند که بعد از هجرت ایشان به طوس، در این محل فوت یا کشته شده باشند. مردم روستا برای زیارت بر سر قبر ایشان حاضر می‌شوند.",
                            isMainDesc: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تابع برای ساخت بخش‌های تاشو
  Widget _buildExpandableSection({
    required String title,
    required String content,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Color color,
    required IconData icon,
    required bool isPoem,
    int previewLines = 3,
  }) {
    // جدا کردن خطوط برای پیش‌نمایش
    List<String> lines = content.trim().split('\n').where((line) => line.trim().isNotEmpty).toList();
    String previewContent = lines.take(previewLines * (isPoem ? 2 : 1)).join('\n');
    if (lines.length > previewLines * (isPoem ? 2 : 1)) {
      previewContent += '\n...';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // هدر بخش
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  // آیکون سمت راست
                  Icon(icon, color: color, size: 24),
                  
                  const SizedBox(width: 8),
                  
                  // عنوان در وسط
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: widget.fontSize + 1,
                        fontFamily: widget.fontFamily,
                        color: widget.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // فلش جمع‌شونده سمت چپ
                  InkWell(
                    onTap: onToggle,
                    child: Container(
                      padding: const EdgeInsets.all(4),


child: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: color,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // محتوا
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: color.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // آیکون کپی کوچک
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.copy, color: color, size: 20),
                    onPressed: () {
                      _copyToClipboard(content, title);
                    },
                    tooltip: "کپی متن",
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // نمایش متن با راست‌چین بودن
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: isPoem 
                      ? _buildPoemText(isExpanded ? content : previewContent, color)
                      : _buildDescriptionText(isExpanded ? content : previewContent, isMainDesc: false),
                ),
                
                const SizedBox(height: 8),
                
                // دکمه بیشتر/کمتر در پایین متن
                if (!isExpanded && lines.length > previewLines * (isPoem ? 2 : 1))
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: onToggle,
                      child: Text(
                        "مشاهده کامل",
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          fontFamily: widget.fontFamily,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                
                if (isExpanded)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: onToggle,
                      child: Text(
                        "بستن",
                        style: TextStyle(
                          fontSize: widget.fontSize,
                          fontFamily: widget.fontFamily,
                          color: color,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تابع برای نمایش متن شعر با راست‌چین و چپ‌چین متناوب
  Widget _buildPoemText(String poem, Color color) {
    List<String> lines = poem.trim().split('\n').where((line) => line.trim().isNotEmpty).toList();
    
    return Column(
      children: lines.asMap().entries.map((entry) {
        int index = entry.key;
        String line = entry.value.trim();
        
        if (line.isEmpty) return const SizedBox(height: 8);
        
        // خط‌های فرد (0,2,4,...): راست‌چین، خط‌های زوج (1,3,5,...): چپ‌چین
        // برای نمایش مثل نمونه:
        // .الا یا اینها الساقی
        //                    ادرکاسا و‌ناولها
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),


child: Row(
            children: [
              if (index % 2 == 1) const Spacer(), // برای خط‌های زوج (چپ‌چین)
              Expanded(
                flex: index % 2 == 1 ? 0 : 1,
                child: Text(
                  line,
                  textAlign: index % 2 == 0 ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontSize: widget.fontSize + 2,
                    fontFamily: widget.fontFamily,
                    color: widget.textColor,
                    height: 1.6,
                    backgroundColor: index % 2 == 0 
                        ? color.withOpacity(0.05) 
                        : Colors.transparent,
                  ),
                ),
              ),
              if (index % 2 == 0) const Spacer(), // برای خط‌های فرد (راست‌چین)
            ],
          ),
        );
      }).toList(),
    );
  }

  // تابع برای نمایش متن توصیفات با راست‌چین
  Widget _buildDescriptionText(String description, {bool isMainDesc = false}) {
    List<String> paragraphs = description.split('\n\n').where((p) => p.trim().isNotEmpty).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.asMap().entries.map((entry) {
        int index = entry.key;
        String paragraph = entry.value.trim();
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            paragraph,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: isMainDesc ? widget.fontSize + 2 : widget.fontSize + 3,
              fontFamily: widget.fontFamily,
              color: widget.textColor.withOpacity(index % 2 == 0 ? 0.9 : 0.7),
              height: 1.8,
              backgroundColor: index % 2 == 0 
                  ? Colors.transparent 
                  : (isMainDesc ? null : Colors.grey.shade50),
            ),
          ),
        );
      }).toList(),
    );
  }

  // تابع برای کپی به کلیپ‌بورد
  void _copyToClipboard(String text, String sectionName) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '"$sectionName" در کلیپ‌بورد کپی شد',
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
            ),
            textAlign: TextAlign.right,
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  Widget _buildPlaceholderIcon() {
    final isSahabeh = widget.name.contains("زیارتگاه صحابه");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSahabeh ? Icons.account_balance : (widget.isMosque ? Icons.mosque : Icons.account_balance),
            size: 80,
            color: isSahabeh ? Colors.green : (widget.isMosque ? Colors.blue : Colors.green),
          ),
          const SizedBox(height: 10),
          Text(
            isSahabeh ? "زیارتگاه صحابه" : (widget.isMosque ? "مسجد" : "زیارتگاه"),
            style: TextStyle(
              fontSize: widget.fontSize,
              fontFamily: widget.fontFamily,
              color: isSahabeh ? Colors.green : (widget.isMosque ? Colors.blue : Colors.green),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showFullImageDialog(BuildContext context) {
    final isSahabeh = widget.name.contains("زیارتگاه صحابه");
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(


children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: widget.imagePath.startsWith("assets/images/mosque/") &&
                        widget.imagePath != "assets/images/mosque/.jpg"
                    ? DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.contain,
                      )
                    : null,
                color: isSahabeh 
                    ? Colors.green.shade100 
                    : (widget.isMosque ? Colors.blue.shade100 : Colors.green.shade100),
              ),
              child: widget.imagePath.isEmpty ||
                      widget.imagePath == "assets/images/mosque/.jpg" ||
                      !widget.imagePath.startsWith("assets/images/mosque/")
                  ? Center(
                      child: Icon(
                        isSahabeh ? Icons.account_balance : (widget.isMosque ? Icons.mosque : Icons.account_balance),
                        size: 150,
                        color: isSahabeh ? Colors.green : (widget.isMosque ? Colors.blue : Colors.green),
                      ),
                    )
                  : null,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}