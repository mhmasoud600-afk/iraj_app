import 'package:flutter/material.dart';
import '../settings/app_settings.dart';

class ZarbolMasalPage extends StatelessWidget with SettingsAwareWidget {
  const ZarbolMasalPage({super.key});

  // لیست ضرب‌المثل‌ها و کنایه‌های محلی
  final List<Map<String, dynamic>> items = const [
    {
      "title": "آب از آب تکان نمی‌خورد",
      "meaning": "موقعیتی که هیچ اتفاقی نمی‌افتد و همه چیز آرام است.",
      "example": "اونقدر اوضاع آروم بود که انگار آب از آب تکان نمی‌خورد."
    },
    {
      "title": "از تو حرکت از خدا برکت",
      "meaning": "برای موفقیت باید تلاش کرد و توکل به خدا داشت.",
      "example": "هر کاری می‌خوای انجام بدی، از تو حرکت از خدا برکت."
    },
    {
      "title": "آفتاب لب بام است",
      "meaning": "کار به آخرین لحظات رسیده و زمان زیادی باقی نمانده است.",
      "example": "آفتاب لب بامه، باید زودتر تصمیم بگیری."
    },
    {
      "title": "با یک گل بهار نمی‌شود",
      "meaning": "با یک کار کوچک نمی‌توان به موفقیت بزرگ رسید.",
      "example": "با یک گل که بهار نمی‌شه، باید بیشتر تلاش کنی."
    },
    {
      "title": "پشت کوه است",
      "meaning": "چیزی که دور از دسترس است و به سختی می‌توان به آن رسید.",
      "example": "اونقدر کارها عقب افتاده که انگار پشت کوه است."
    },
    {
      "title": "تو دهن مورچه نرفته",
      "meaning": "چیزی که بسیار کوچک و ناچیز است.",
      "example": "اونقدر خسیسه که حتی تو دهن مورچه هم نمی‌ره."
    },
    {
      "title": "خاله خرسه",
      "meaning": "کسی که ادعای کارهای بزرگ دارد اما کاری از دستش بر نمی‌آید.",
      "example": "خاله خرسه همیشه حرف می‌زنه ولی عملی نداره."
    },
    {
      "title": "خرما را نخورده، نخلش را حساب کرده",
      "meaning": "کسی که قبل از انجام کار، به نتیجه‌های دور و دراز فکر می‌کند.",
      "example": "هنوز کار شروع نشده، خرما رو نخورده نخلش رو حساب کرده."
    },
    {
      "title": "خروسی که خروس می‌خواند، دانه هم پیدا می‌کند",
      "meaning": "هر کسی که تلاش کند و پیگیر باشد، بالاخره به نتیجه می‌رسد.",
      "example": "خروسی که خروس می‌خونه، دانه هم پیدا می‌کنه."
    },
    {
      "title": "دست از طلب ندارم تا کام مرا برآورند",
      "meaning": "انسان نباید از تلاش برای رسیدن به هدف دست بردارد.",
      "example": "من دست از طلب ندارم تا کام مرا برآورند."
    },
    {
      "title": "دل به دریا زدن",
      "meaning": "کار خطرناکی انجام دادن و ریسک کردن.",
      "example": "آخرش دل به دریا زد و این کار رو انجام داد."
    },
    {
      "title": "روی پلک هاش خوابش میاد",
      "meaning": "کسی که خیلی خسته است و خوابش می‌آید.",
      "example": "اونقدر خسته بود که روی پلک هاش خوابش میومد."
    },
    {
      "title": "سایه هر درختی رو که نشستی، باید میوه‌اش رو هم بخوری",
      "meaning": "هر جا که منفعتی می‌بری، باید مسئولیت‌های آن را هم بپذیری.",
      "example": "سایه هر درختی رو که نشستی، باید میوه‌اش رو هم بخوری."
    },
    {
      "title": "سرش تو لاک خودشه",
      "meaning": "کسی که منزوی شده و با کسی حرف نمی‌زند.",
      "example": "این روزها سرش تو لاک خودشه و با کسی حرف نمی‌زنه."
    },
    {
      "title": "سیبی که گاز زده باشی، کسی نمی‌خرد",
      "meaning": "چیزی که یکبار استفاده شده باشد، دیگر ارزش ندارد.",
      "example": "سیبی که گاز زده باشی، کسی نمی‌خره."
    },
    {
      "title": "شتر دیدی، ندیدی",
      "meaning": "چیزهایی را که نباید می‌دیدیم، نباید به آنها توجه کنیم.",
      "example": "شتر دیدی، ندیدی، بهتره از این موضوع رد بشیم."
    },
    {
      "title": "صد تا یک غاز",
      "meaning": "چیزی که به نظر زیاد می‌آید اما در واقع ارزش چندانی ندارد.",
      "example": "این همه حرف می‌زنه ولی صد تا یک غاز ارزش نداره."
    },
    {
      "title": "طاقت آوردن دو تا عید خونه‌مون رو نداره",
      "meaning": "کسی که بسیار کم‌طاقت است.",
      "example": "اونقدر کم‌طاقته که طاقت آوردن دو تا عید خونه‌مون رو نداره."
    },
    {
      "title": "عمرش به دنیا نیامده",
      "meaning": "کسی که خیلی جوان است یا تجربه کمی دارد.",
      "example": "عمرش به دنیا نیومده، هنوز چیز زیادی نمی‌دونه."
    },
    {
      "title": "قناری بودن در قفس طلایی",
      "meaning": "در رفاه بودن اما آزادی نداشتن.",
      "example": "اون مثل قناری تو قفس طلایی زندانی شده."
    },
    {
      "title": "کاسه‌ای که از آش داغ‌تر نیست",
      "meaning": "کسی که ادعای بیشتری از توانایی خود دارد.",
      "example": "کاسه‌ای که از آش داغ‌تر نیست، چرا این همه ادعا می‌کنه؟"
    },
    {
      "title": "کوه به کوه نمی‌رسد، آدم به آدم می‌رسد",
      "meaning": "انسان‌ها همیشه در زندگی به هم می‌رسند و باید با هم مهربان باشند.",
      "example": "کوه به کوه نمی‌رسه، آدم به آدم می‌رسه."
    },
    {
      "title": "گدا را اگر پادشاه کنند، رگ خوابش نمی‌رود",
      "meaning": "عادت‌های قدیمی به سختی تغییر می‌کنند.",
      "example": "گدا رو اگر پادشاه کنن، رگ خوابش نمی‌ره."
    },
    {
      "title": "ماست را کیسه می‌کنند؟",
      "meaning": "چیزی که غیرممکن است یا شدنی نیست.",
      "example": "ماست رو کیسه می‌کنن؟ این کار شدنی نیست."
    },
    {
      "title": "مثل گربه که ناخنش را تیز می‌کند",
      "meaning": "آماده شدن برای کاری که در پیش است.",
      "example": "اون مثل گربه ناخن‌هاش رو تیز می‌کنه برای جلسه فردا."
    },
    {
      "title": "نه می‌خوره نه می‌ذاره بخورن",
      "meaning": "کسی که خودش از چیزی استفاده نمی‌کند، اما مانع استفاده دیگران هم می‌شود.",
      "example": "اون یه آدم حسوده، نه می‌خوره نه می‌ذاره بخورن."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "ضرب‌المثل‌ها و کنایه‌ها",
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildItemCard(item, index);
        },
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: settings.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: settings.buttonFontSize,
                fontWeight: FontWeight.bold,
                color: settings.primaryColor,
                fontFamily: settings.mainFontFamily,
              ),
            ),
          ),
        ),
        title: Text(
          item["title"],
          style: TextStyle(
            fontSize: settings.mainFontSize,
            fontWeight: FontWeight.bold,
            fontFamily: settings.mainFontFamily,
            color: settings.mainTextColor,
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: settings.primaryColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'معنی:',
                  style: TextStyle(
                    fontSize: settings.mainFontSize - 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: settings.mainFontFamily,
                    color: settings.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item["meaning"],
                  style: TextStyle(
                    fontSize: settings.mainFontSize - 2,
                    fontFamily: settings.mainFontFamily,
                    color: settings.mainTextColor,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 12),
                Text(
                  'مثال:',
                  style: TextStyle(
                    fontSize: settings.mainFontSize - 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: settings.mainFontFamily,
                    color: settings.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: settings.isDarkMode ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item["example"],
                    style: TextStyle(
                      fontSize: settings.mainFontSize - 2,
                      fontFamily: settings.mainFontFamily,
                      color: settings.mainTextColor.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}