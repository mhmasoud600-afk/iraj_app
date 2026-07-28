
import 'package:flutter/material.dart';

class WeddingsPage extends StatefulWidget {
  const WeddingsPage({Key? key}) : super(key: key);

  @override
  State<WeddingsPage> createState() => _WeddingsPageState();
}

class _WeddingsPageState extends State<WeddingsPage> {
  String searchText = "";
  Map<String, bool> _expandedStates = {};

  // تابع برای تغییر حالت باز/بسته
  void _toggleExpansion(String key) {
    setState(() {
      _expandedStates[key] = !(_expandedStates[key] ?? false);
    });
  }

  // نرمال‌سازی برای جستجو
  String normalize(String text) {
    return text
        .replaceAll("ي", "ی")
        .replaceAll("ك", "ک")
        .replaceAll("\u200c", " ")
        .replaceAll(RegExp(r"\s+"), " ")
        .trim()
        .toLowerCase();
  }

  // تابع highlightText را نیز باید برای پشتیبانی از textDirection به روز کنید:
  InlineSpan highlightText(String text, String query) {
    if (query.isEmpty) return TextSpan(text: text);

    final normalizedText = normalize(text);
    final normalizedQuery = normalize(query);

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = normalizedText.indexOf(normalizedQuery, start);
      if (index < 0) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      spans.add(TextSpan(text: text.substring(start, index)));

      spans.add(
        TextSpan(
          text: text.substring(index, index + query.length),
          style: const TextStyle(
            backgroundColor: Color(0xFFB3E5FC),
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      start = index + query.length;
    }

    return TextSpan(
      children: spans,
      style: const TextStyle(
        fontFamily: 'Vazirmatn',
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  // ویجت کادر شعر
  Widget _buildPoemBox(String poem) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          poem,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Vazirmatn',
            fontSize: 16,
            color: Colors.brown,
            fontWeight: FontWeight.w500,
            height: 1.8,
          ),
        ),
      ),
    );
  }

  // لیست‌سازی کامل عروسی
  final List<Map<String, String>> weddingSections = [
    {
      "title": "خواستگاری",
      "text": """

برای خواستگاری افراد خاصی را به عنوان قاصد به منزل عروس می‌فرستادند
معمولا قاصد از جمله اشخاصی انتخاب می شد که در روستا از مقبولیت زیادی برخوردار
و شناخته شده باشد مثل مرحوم قاضی، دلیل انتخاب این افراد هم این بود که خانواده عروس
به احترام ایشان جواب مثبت بدهد و اصطلاحا خانواده داماد بتواند بله رو از خانواده عروس بگیرد
که خانواده عروس یا قبول می‌کردند یا رد می‌کردند و می‌گفتند که وعده به یکی دیگه دادیم.

مهریه یا صداق:
معمولا بزرگان روستا مثلا حاج سید مرتضی و... قباله صداق را می‌نوشتند
که از زمین کشاورزی یا آب تا منزل مسکونی و... را شامل می شد.
"""
    },
    {
      "title": "دوره رفتن",
      "text": """

برای عروسی معمولا دوره می‌رفتند یعنی یک نفر آقا و خانم از طرف عروس
و یک نفر آقا و خانم از طرف داماد به در تمام خانه‌های روستا می‌رفتند
و مردم را برای حنابندان شب دعوت می‌کردند که اسم عروس و داماد و محل حنابندان را می‌گفتند
ولی از طرف عروس کسی حرف نمی‌زد یعنی اون مرد و زنی که از طرف عروس رفته بودند حرف نمی‌زدند
مثلا کم‌رو هستند و از طرف داماد دعوت انجام می‌شد.
زنی که از طرف عروس برای دوره می‌رفت لباسی که شب حنابندان عروس می‌خواست بپوشد را می‌پوشید
و با آن دوره می‌رفت.


نکته: بیشتر عروسی‌ها در عید نوروز برگزار می‌شده است.
"""
    },
    {
      "title": "حنابندان",
      "text": """
ظهر روز حنابندان خانواده‌ی عروس افراد نزدیک خودش و خانواده‌ی داماد افراد نزدیک خودشان
برای ناهار دعوت می‌کردند.

آماده کردن حنا:
افراد کاربلد و ماهری که تخصص در حنا درست کردن داشتند را دعوت می‌کردند

تا در خانه داماد حنا را خمیر کنند. در طول زمان حنا خمیر کردن حرف نمی‌زدند
چون معتقد بودند حنا خراب می‌شود و اصطلاحا گوله می‌شود.
بعد مدت زمانی باید صبر می‌کردند تا حنا برسد
(مرحوم صفر نجفی یکی از افرادی که مهارت خاصی در حنا درست کردن داشت).
حنا را داخل بشقاب می‌گذاشتند و روی آن پنج تا هفت تا نقل می‌گذاشتند
و یک دسته گل از گل باقلا کنار آن برای تزیین می‌گذاشتند
و کنار آن لیوان آب می‌گذاشتند.

بعد از ظهر روز حنابندان دوباره دوره می‌رفتند و مردم را برای شام دعوت می‌کردند.
زمان مراسم هم از وقتی بود که گله گوسفندان روستا از بیابان می‌آمد و اصطلاحا جا می‌رفت.
مراسم که شروع می‌شد اول شام می‌دادند که معمولاً آبگوشت یا برنج و قیمه بود.
طایفه عروس خانه عروس و طایفه داماد خانه داماد که خرج شام با داماد بود.
حنابندان داماد خانه خودشون بوده و حنابندان عروس هم خانه خودشون بوده.
در مراسم حنابندان عروس، وسایلی که داماد برایش خریده بود را نمایش می‌دادند.

با داریه و تنبک، حنا که در طبق گذاشته بودند (سینی که بالای سر می‌گرفتند)
از خانه داماد به خانه عروس می‌رفتند.

در منزل عروس، مردان بیرون از خانه یا در حیاط و زنان در اتاق شعر معروفی می‌خواندند

شعر:
از کوچه در آمدی و سیبم دادی      
آی عروس حنا می‌بنده
هم‌رنگ خودت سرخ و سفیدم داد   
آی عروس حنا می‌بنده
سیبی که تو دادی هنوزش دارم       
آی عروس حنا می‌بنده
در نقره گرفتم و عزیزش دارم        
آی عروس حنا می‌بنده
آی عروس حنا می‌بنده          
بر دست و پا می‌بنده
حنای اصل کرمونه               
عاشق‌نما می‌بنده
آن یار من است که می‌رود سر بالا    
آی عروس حنا می‌بنده
دستمال به دستش و می‌زنه گرما   
آی عروس حنا می‌بنده
دستمالم بدهید تا عرقش پاک کنم    
آی عروس حنا می‌بنده
گرما نزنه شاخه گل رعنا را        
آی عروس حنا می‌بنده
آی عروس حنا می‌بنده             
بر دست و پا می‌بنده
حنای اصل کرمونه               
عاشق‌نما می‌بنده
امروز و دو روز و بیست و پنج روز و سه روز
آی عروس حنا می‌بنده
باریک شدم چو سوزن مخمل‌دوز          
آی عروس حنا می‌بنده
بر یار بگو روغن سیمرغ فرست       
آی عروس حنا می‌بنده
تا چرب کنم جراحت دل امروز           
آی عروس حنا می‌بنده
آی عروس حنا می‌بنده 
بر دست و پا می‌بنده
حنای اصل کرمونه  
عاشق‌نما می‌بنده
امشب شب ماه نبود و ماه پیدا شد      
آی عروس حنا می‌بنده
در کوچهٔ ما کلاه سیاه پیدا شد    
آی عروس حنا می‌بنده
قربون خدا برم که زیر کلاه       
آی عروس حنا می‌بنده
شب نا شده بود و قرص ماه پیدا شد  
آی عروس حنا می‌بنده
آی عروس حنا می‌بنده              
بر دست و پا می‌بنده

بعد به خانه داماد می‌رفتند و خانم‌ها هم می‌آمدند و لباس داماد رو عوض می‌کردند.
اول سرتراشی تو خرمن‌ها انجام می‌دادند که بلندترین و قشنگ‌ترین خرمن را انتخاب
می‌کردند و شعر زیر را می‌خواندند

شعر:
آی آی سر می‌تراشیم
به دور سر می‌تراشیم
...

ریش‌های داماد رو هم می‌زدند و بعد در خانه داماد لباس‌های او را عوض می‌کردند

نکته: قبل از حنابندان باید پدر عروس اجازه بدهد. اگر قید حیات نبود بزرگتر عروس باید اجازه بدهد.

همچنین باید برای حنا بستن اجازه ارباب را می‌گرفتند و تا آنها نمی‌آمدند حنا را نمی‌بستند.
یعنی حتما باید خانم‌ها و هم آقایان ارباب آنجا حضور می‌داشتند
و باید دو نفر از طرف عروس و داماد ارباب و خانواده‌شان را دعوت می‌کردند و می‌آوردند.
البته در عروسی دیگر ارباب و خانواده‌شان معمولا حضور نداشتند و فقط در حنابندان حضور داشتند.
"""
    },
    {
      "title": "عروسی",
      "text": """
روز عروسی:
دوباره همان چند نفر برای نهار روز عروسی از طرف عروس و داماد، دنبال مردم می‌رفتند
(دوره می‌رفتند) ولی باز هم از طرف داماد حرف می‌زدند و تعارف می‌کردند و اصطلاحاً
می‌گفتند که خانه فلانی عروسی خانم‌هاست و خانه فلانی عروسی آقایون و برای ناهار
همه را دعوت می‌کردند.

بعد از نهار طبق، لباس‌های عروس رو با داریه و تنبک تا خانه عروس می‌بردند و بعد
لباس‌های عروس رو عوض می‌کردن و شعر زیر را می‌خواندند

شعر:
یار مبارک بادا انشالله مبارک بادا
در کوچه‌ی تنگ تنگ‌بنگانم چه کنم
عاشق به میان در گمانم چه کنم
آهو بره‌ی سفید و فلفل نمکی
من دل به تو دادم و تو دل به شکی
من دل به تو دادم که یارم باشی
شب در بغل و روز در کنارم باشی


بعد از آن داماد جلو و عروس پشت سر به خانه عروس می‌رفتند که دو نفر عروس رو نگه
می‌داشتند و با هم حرکت می‌کردند. بعد از اون روی سر عروس و داماد نقل می‌ریختند،
سکه می‌ریختند و قوری هم از پشت بام خانه می‌انداختند و می‌شکستند.

دوباره عصر دنبال مردم می‌رفتند (دوره می‌رفتند) و برای شام عروسی دعوت می‌کردند.

آرایش عروس:
تا اینجا هنوز عروس را آرایش یا اصطلاحاً اصلاح نکرده‌اند. که عروس روز عروسی
اصلاح عروس یا آرایش عروس شروع می‌شده است. دم غروب عروس را خال و وسمه می‌کردند،
پولک در پیشانی و گونه‌اش می‌زدند، دواگلی می‌زدند، سرخاب و سفیدآب و سرمه می‌زدند.
گل و بند هم آویزون می‌کردند. بعد عروس را چتر و زلف می‌کردند. مقداری از مو بالای
پیشانی را تا بالای ابرو کوتاه می‌کردند و دو طرف را هم تا راست لب‌ها کوتاه
می‌کردند و بعد بیرون از روسری (چارقد) می‌گذاشتند و سوزن می‌زدند. زیر چونه‌ی عروس
هم به‌جای گره چارقد از دانه‌های تسبیح رنگارنگ استفاده می‌کردند و آویزان می‌کردند.

دست عروس هم باید چیزی شبیه النگو که گلدسو می‌گفتند باشد که هر چیزی با ارزشی داشت
استفاده می‌کرد. دانه‌های کهربا یا مهره‌های درشت و گران که دور دست عروس بود که
معمولاً هفت تا هشت گلدسو دست عروس بوده است. ولی هر چه وضعیت مالی خانواده عروس
بهتر بوده است تعداد و کیفیت این گلدسوها بهتر بوده است. تمام عروس‌ها چادر هم
سرشان بوده است.

نزدیک غروب (دم غروب) عروس آماده شده بوده. کسی که عروس را آرایش یا بند و برمه
کرده است را مشاطه می‌گفتند. مشاطه باید چراغ دست بگیرد و به خانه داماد برود و
داماد به همراه مشاطه به خانه عروس می‌آمده است تا عروس را که در یک اتاق خصوصی
اصلاح شده بود ببیند. داماد باید قبل از اینکه عروس را ببیند رونما بدهد چون آن
وقت چادر روی سر عروس بوده و روبند هم داشته. وقتی رونمای عروس (هدیه) را می‌داده
روبند را برمی‌داشته است و یک نظر می‌دیده و فعلاً خداحافظی می‌کرده است و داماد
به همراه مشاطه به خانه خودشان می‌رفته است و عروس هم خانه خودشون می‌مانده است.
مردم هم در همین حین در حال شام خوردن بودند.

بعد از شام، بزن‌بکوب تا آخر شب ادامه داشته است.

الله گفتن:
در بین رقصی که خانم‌ها و آقایون اجرا می‌کردند برخی از افراد به آنها اصطلاحاً
«الله» می‌گفتند. «الله» شعرهای انتقادی یا تحسین‌برانگیز بوده است.

چند نمونه از الله‌های گفته شده

شعر:
ما کلانتر زاده‌ایم دختر به رعیت داده‌ایم
نه به مال و نه به ثروت ما به قسمت داده‌ایم

شعر:
قدت از دور می‌بینم بسم نیست
به جایی رفته‌ای که دسترسم نیست
به جایی رفته‌ای که گل بچینی
که هرچه گل بچینی من بسم نیست

شعر:
درخت آلبالو می‌شوم
من کنیز شهربانو می‌شوم
من در آن وقتی که از حموم درآید
جلویش آب و جارو می‌شوم

شعر:
من شبیه چهارشنبه بود و چهارده ماه
نیت کردم که بنشینم سر راه
نیت کن و نشین بر سر راه
که یارت می‌رسه امروز و فردا

شعر:
قد سروت الهی خم نگردد
دل شادت به دور غم نگردد
به حق آیه و سی جزء قرآن
که سایت از سر ما کم نگردد

شعر:
سر بون آمدم ای سرو نازم
تو را بر من ندادند من چه سازم
نو را بر من ندادند خویش و قومون
شب و روز بر روغن خود می‌گدازم


نکته رفتاری:
در کل مراسم عروسی یک آیینه دست عروس می‌دادند و باید به آیینه نگاه می‌کرده است.
اگر سرش را بالا می‌آورده یا حتی زیرچشمی نگاه می‌کرده می‌گفتند عجب عروس‌پررویی است.
و حتی نباید می‌خندیده چون می‌گفتند خیلی خوشحال است.
مادر عروس هم نباید لباس عوض می‌کرده است.

مراسم کپل‌کپل:
یکی از کارهایی که در عروسی انجام می‌دادند کپل‌کپل بود.
یک نفر کمربند دست می‌گرفت و شعر زیر را می‌خواند و بقیه باید هر کاری که او انجام می‌داد
عیناً انجام می‌دادند وگرنه با کمربند تنبیه می‌شدند.
اغلب کارها ادا بازی بود

شعر:
کپل کپل
سرکپلی
یه شاگرد می‌خام
که همچی همچی همچی همچی همچی بکنه

زن‌ها فقط با لگن می‌زدند و داریه و تنبک مخصوص مراسم مردها بود.

لباس پوشیدن زنانه:
برخی از مردها لباس زنانه می‌پوشیدند و رویشان را می‌پوشاندند
و داخل مجلس عروسی قسمت زن‌ها می‌رفتند و می‌رقصیدند
و اصطلاحاً مراسم را گرم می‌کردند.

مراسم حمومی:
یک نفر در وسط عروسی شعر زیر را می‌خواند و بقیه همراهی می‌کردند

شعر:
حمومی آی حمومی لنگ حمومم را بردند
لنگ حمومم جهنم کاسه آبم را بردند و ...

تمام اشیای داخل حمام را به ترتیب می‌خواند و می‌رقصید.

مراسم زنبوری:
یک نفر وسط جمع شعر زیر را می‌خواند و کم‌کم لباس‌های خود را در می‌آورد

شعر:
زنبورم گزید
و بقیه جواب می‌دادند کجات گزید
و آن شخص جای خاصی را نشان می‌داد و همینطور ادامه می‌داد
تا جایی که می‌توانست لباس خود را درآورد.


در آخر شب:
از خانه داماد، با داماد که جلو حرکت می‌کرد می‌رقصیدند و به خانه عروس می‌رفتند.
خانه عروس، پدر عروس یا محرم ایشان دست عروس را داخل دست داماد می‌گذاشت.
داخل قسمت خانم‌ها محرم‌ها و پدر عروس نیز می‌رفتند.
داماد حتما باید چادر روی عروس می‌انداخت.
عروس چادر به سر می‌کرد، روبنده هم می‌انداختند و یک روسری هم روی سرش می‌گذاشتند.

و با شعر زیر عروس را تا خانه داماد یا محل حجله همراهی می‌کردند

شعر:
گل عروس چادر به سر کن حالا وقت رفتنه
گل بیا و ناز نکن بلبل بیا و ناز نکن
گل بیا و ناز نکن شب را به ما دراز نکن
گل در اومد از خونه بلبل در اومد از خونه

شعر:
امشب چه شبیست شب مراد است امشب
این خانه پر از شمع و چراغ است امشب
این خانه پر از شمع و چراغ است امشب
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
کوچه تنگه بله عروس قشنگه بله
کوچه تنگه بله عروس قشنگه بله
دست به زلفاش نزنید مرواری بنده بله
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
این حیاط و اون حیاط میریزن نقل و نبات…
این حیاط و اون حیاط میریزن نقل و نبات…
به سرعروس ودوماد میریزن نقل ونبات
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
کوچه تنگه بله عروس قشنگه بله
کوچه تنگه بله عروس قشنگه بله
دست به زلفاش نزنید مرواری بنده بله
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
عروسی شاهانه ایشالا مبارکش باد
جشن بزرگانه ایشالا مبارکش باد
گل به گلستانه ایشالا مبارکش باد
نوبت مستانه ایشالا مبارکش باد
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
مبارک و مبارک ایشالا مبارکش باد
عروسی شاهانه ایشالا مبارکش باد
جشن بزرگانه ایشالا مبارکش باد
گل به گلستانه ایشالا مبارکش باد
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا
بادا بادا مبارک بادا ایشالا مبارک بادا

شعر:
صد بار گفتم همچی مکن ننه خان آقا
زلفای سیا  قیچی مکن ننه خان آقا
 صد بار گفتم پلو مخور ننه خان آقا
ور دور کوه ها تو مخور ننه خان آقا
 صد بار گفتم یاغی مرو ننه خان آقا
رفیق الداغی مرو ننه خان آقا
 حالا که دور دورونه ننه خان آقا
اسب سیات تو جولونه ننه خان تقا
ای جولونا همیشه نیس ننه خان آقا
اسب سیات تو بیشه نیس ننه خان آقا
 وصف شما تو ایرونه ننه خان آقا
عکس شما تو تهرونه ننه خان آقا
 کو جرق و جرق شمشیرت ننه خان آقا
کو درق و درق هف تیرت ننه خان آقا
 کو اجاقت  کو اتاقت ننه خان آقا
کو برارای قولچماقت ننه خان آقا
 او تخمرغای لای نونت ننه خان قا
آخر نرف نوش جونت ننه خان آقا
 قد بلندت شوه رفت ننه خان آقا
زن قشنگت بیوه رف ننه خان آقا
 الای بمیره قاتلت ننه خان آقا
خنک رود دل مادرت ننه خان آقا

جلوی پای عروس، گوسفندی را قربانی می‌کردند.
پدر داماد یا بزرگتر داماد باید به عروس پاانداز می‌دادند
که معمولاً سفر زیارتی یا وعده گوسفند یا زمین یا آب بوده است.
مردم هم زمان ذبح گوسفند «حرومش کرد حرومش کرد» را می‌خواندند.


و سپس از زیر قرآن رد می‌کردند و وارد خانه می‌شدند.
در آن زمان دیگر فقط خانواده نزدیک می‌ماندند
و یک نفر سوره الرحمن را می‌خواند و تا هفت آیه سرهای عروس و داماد را به هم می‌زدند.

نکته پایانی:
چون معمولاً صندلی نداشتند، رختخواب‌ها را به نحوی روی هم می‌گذاشتند
که حالت تخت بشود و عروس و داماد روی آن می‌نشستند.
لحاف عروسی هم طوری درست می‌کردند که هر چهار طرفش معمولاً هفت تا دونه بادوم
داخل خود لحاف می‌دوختند که وقتی تکان می‌خورده سر و صدای جالبی می‌داده.
"""
    },
    {
      "title": "پاتختی",
      "text": """
روز پاتختی:
صبح عروسی، عروس و داماد با هم برای دست بوستی به خانه پدر و مادرشان می‌رفتند
و پدر عروس به دخترش رونما (هدیه) می‌داد که معمولاً گوسفند یا چیز دیگری بوده است.

خانواده عروس با همان گوسفندی که شب قبل جلوی عروس کشته بودند نهار درست می‌کردند
و دوباره دنبال مردم می‌رفتند و برای نهار مردم را دعوت می‌کردند.
مادر عروس حق داشته است در مراسم پاتختی برقصد.

بعد از نهار، با داریه و تنبک، صندوق عروس
(منظور جهاز عروس است چون قبلاً کل جهاز عروس در یک صندوقچه جای می‌گرفته است)
یا می‌توانسته چیزهای دیگر هم باشد که اگر بوده داخل طبق می‌گذاشتند
و روی سر می‌گرفتند و تا خانه داماد می‌بردند.
"""
    },
    {
      "title": "هفته داری",
      "text": """
هفته‌داری:
در هفتمین روز عروسی، مادر عروس برخی از اقوام را دعوت می‌کرده است
و شام آماده می‌کرده‌اند و تا پاسی از شب، بزن و بکوب و رقص بوده است.

"""
    },
  ];


// لیست تولد فرزند
  final List<Map<String, String>> birthSections = [
    {
      "title": "مقدمه و اهمیت تولد نوزاد",
      "text": """
تولد نوزاد در روستای ایراج همیشه با شادی و شور همراه بوده است.
در گذشته که زایشگاه در خور وجود نداشت، بیشتر نوزادان در خود روستا به دنیا می‌آمدند.
با وجود امکانات امروزی، به دلیل کم‌توجهی به روستاها، تعداد تولدها کاهش یافته است.

در این میان یاد و نام دو ماما و قابلهٔ دلسوز ایراج همیشه زنده است
«خانم جانی یزدانی» و «فاطمه سلطان یزدانی»
که سال‌ها با زحمت فراوان، ده‌ها نوزاد را به دنیا آوردند و برای مادران و خانواده‌ها پناه و امید بودند.
"""
    },
    {
      "title": "نقش ماما و آماده‌سازی برای زایمان",
      "text": """
وقتی درد زایمان شروع می‌شد، به دنبال ماما می‌رفتند تا به مادر کمک کند.
یک نفر نیز کنار ماما می‌ماند و وسایل و پارچه‌های تمیز را آماده می‌کرد.
پس از تولد، نوزاد را با آب ولرم می‌شستند، لباس تنش می‌کردند و طبق سنت قدیمی او را قنداق یا «پیچو» می‌کردند تا پاهایش کج نشود.
"""
    },
    {
      "title": "آیین‌های پس از تولد",
      "text": """
نوزاد را روی غربال می‌خواباندند تا عمرش دراز شود؛ چون غربال سوراخ‌های بی‌شمار دارد.
تا سه روز اول، نوزاد شیر مادر نمی‌خورد و به جای آن مخلوطی از نبات پودر شده و روغن محلی که از پارچه مرمر عبور داده می‌شد، به مقدار بسیار کم به او می‌دادند.
غذای مادر نیز «گداخته» (تخم‌مرغ و روغن محلی) و غذاهای مقوی مانند جگر بود.
"""
    },
    {
      "title": "دعوت اقوام و مراسم دونو ‌خوری",
      "text": """
چند ساعت پس از تولد، یکی از زنان فامیل به خانه‌های همسایه‌ها و بستگان می‌رفت و آن‌ها را دعوت می‌کرد.
اگر کسی در راه می‌پرسید کجا می‌روید، می‌گفتند: «دونوخوری».
«دونو» خوراکی محبوبی بود که با گندم، کنجد، شاه‌دانه و... درست می‌شد.
مهمانان با چای و شیرینی دونو پذیرایی می‌شدند و معمولاً با خود تخم‌مرغ، شکر، نبات یا پول هدیه می‌آوردند.
"""
    },
    {
      "title": "مراقبت‌های سه‌روزه مادر و نوزاد",
      "text": """
ماما تا سه روز از مادر و نوزاد مراقبت می‌کرد.
در این مدت مادر استراحت می‌کرد و زنان فامیل برای کمک به کارهای خانه می‌آمدند.
"""
    },



    {
      "title": "مراسم نام‌گذاری",
      "text": """انتخاب نام توسط بزرگان:
در فرهنگ ایراج، حق نام‌گذاری بیشتر با پدربزرگ‌ها و بزرگان فامیل بود. آنها پس از مشورت با یکدیگر، نام مناسبی برای نوزاد برمی‌گزیدند. معمولاً نام‌هایی از میان اسامی مذهبی، نام پدربزرگ‌ها و مادربزرگ‌ها، یا نام‌های محلی و سنتی انتخاب می‌شد.

آیین نام‌گذاری:
در روز نام‌گذاری، فامیل و آشنایان دعوت می‌شدند و غذایی تهیه می‌گردید. پس از صرف غذا، یکی از افراد مؤمن خانواده در گوش نوزاد اذان می‌گفت و نام انتخاب‌شده را در گوش او زمزمه می‌کرد. سپس با خواندن دعا و تبرک، مراسم به پایان می‌رسید.


"""
    },
 {
      "title": "ولیمه روز دهم (نخود آب) و حمام",
      "text": """
در روز دهم پس از تولد نوزاد، خانواده‌ی مادر یک آیین ویژه به نام «ولیمه» برگزار می‌کردند.

نخود آب، غذای مخصوص ولیمه:
در این روز غذای سنتی خاصی به نام «نخود آب» تهیه می‌شد. برای درست کردن نخود آب، نخود را می‌کوبیدند و با پیاز و هرنگ (احتمالاً نوعی ادویه یا گیاه محلی) می‌پختند. هدف از این ولیمه، دعوت از زنان فامیل و آشنایان برای دیدار مادر و نوزاد و شریک شدن در شادی خانواده بود.

رسم بر این بود که به مادر تازه زایمان کرده بگویند: «انشالله زایمان کنی بیایی نخود آب تا بخوری» که نشان‌دهنده‌ی نگاه جمعی و حمایتگر جامعه نسبت به مادران بود.

هدایای مهمانان (چشم‌وشنی):
در این روز، مهمانان هر کس به اندازه‌ی توان خود هدیه‌ای برای مادر و نوزاد می‌آوردند. هدایا معمولاً ساده و بر اساس امکانات موجود بود:
• چند عدد تخم‌مرغ
• مقداری نبات یا قند (اگر در خانه موجود بود)
• یا خوراکی‌های سنتی مانند «دونو» که از گندم و خرما تهیه می‌شد.

حمام روز دهم:
در همین روز (دهم پس از زایمان)، هم مادر و هم نوزاد را به حمام می‌بردند. این حمام جنبه‌ی آیینی و بهداشتی داشت و به نوعی پایان دوره‌ی نقاهت مادر و ورود نوزاد به چرخه‌ی اجتماعی محسوب می‌شد. همزمانی این رسم با مراسم ولیمه (نخود آب)، نشان‌دهنده‌ی اهمیت پاکیزگی و سلامت مادر و کودک در فرهنگ سنتی ایراج است.

این مراسم ساده اما پرمعنا، نشان‌دهنده‌ی همبستگی اجتماعی و اهمیت حمایت از مادران در فرهنگ سنتی ایراج بود.
"""
    },

    {
      "title": "رسوم ویژه برای مشکلات نوزاد",
      "text": """
اگر نوزاد نمی‌توانست شیر بخورد، می‌گفتند باید «کومش را ببندند».
ماما یا زن باتجربه انگشت خود را در دهان نوزاد می‌کرد و گلوی چسبیده او را باز می‌کرد تا بتواند شیر بخورد.
"""
    },
    {
      "title": "آیین غرق گل‌کردن نوزاد",
      "text": """
اگر فصل گل محمدی بود، نوزاد را زیر گل می‌گذاشتند تا بعدها به بوی گل حساس نشود.
وقتی نوزاد خواب می‌رفت، اطرافش را پر از گل می‌کردند.
اگر فصل گل نبود، تا زمان گل‌دادن صبر می‌کردند و سپس این کار را انجام می‌دادند.
"""
    },
    {
      "title": "آیین دندان‌درآوردن",
      "text": """
وقتی نوزاد دندان در می‌آورد، برایش «آش دندرو» یا همان «دندونک» می‌پختند.
این آش بین همسایه‌ها و فامیل تقسیم می‌شد و نشانه شادی و سلامت کودک بود.
"""
    },
  ];

  // لیست عید نوروز
  final List<Map<String, String>> nowruzSections = [
    {
      "title": "خانه‌تکانی",
      "text": """
چند روز مانده به نوروز، خانه‌تکانی آغاز می‌شد.
فرش‌ها شسته می‌شد، دیوارها گردگیری می‌شد و همه چیز نو می‌شد.
اعتقاد داشتند که با تمیز کردن خانه، غم و ناراحتی سال قبل نیز پاک می‌شود.
نوروز فصل رویش گیاهان و آغاز بهار طبیعت در روستای ایراج نیز همانند سایر نقاط کشور زیبایی خاصی دارد.

در گذشته روز صبح عید نوروز، قبل از دید و بازدیدها، بزرگ خانه (پدر و مادر) با مراجعه به دشت دسته‌ای از گیاهان جو و باقلا را به خانه می‌آوردند (این گیاهان زودتر از سایر گیاهان رشد می‌کند) و جلوی درب منازل یک خوشه «جو» یا «باقلا» آویزان می‌کردند که نماد آغاز بهار طبیعت است.

این رسم در حال حاضر خیلی کم‌رنگ شده و کمتر شاهد نصب گیاه در جلوی منازل در روز عید هستیم
"""
    },


{
      "title": "پخت نان و شیرینی",
      "text": """
در روستا زنان نان‌های محلی مانند فتیر، کماچ و نان روغنی می‌پختند.
بوی نان تازه نشانه نزدیک شدن نوروز بود.
برخی خانواده‌ها شیرینی‌های سنتی نیز آماده می‌کردند.
"""
    },
    {
      "title": "سفره هفت سین",
      "text": """
سفره عید را در خانه با قرآن مجید و آئینه، شیرینیجات یزدی، پشمک و باقلوا و محصولات طبیعی که حاصل زحمات خود اهالی روستا بود مثل سمنو و انار، بادام کوهی، گندمک، سنجد، برگه زردآلو، نخود، بنه کوهی، تخم مرغ رنگی (کاملاً طبیعی) چیده می‌شد.

در قدیم رسم بود که به یک انار هفت بار سوره یاسین می‌خواندند و آن را سر سفره می‌گذاشتند و هر کسی که برای دیدن می‌آمد چند دانه از آن انار را به تبرک به او می‌دادند.
"""
    },
    {
      "title": "دید و بازدید",
      "text": """
اهل خانه قبل از دید و بازدید در ابتدای صبح به زیارت اهل قبور می‌رفتند و برای خیرات درگذشتگان هم یک سری شیرینی و نان کماچ و محصولات طبیعی خود را مثل نان شلشلی، مغز بادام و ... را پخش می‌کردند.

دید و بازدیدها بعد از زیارت اهل قبور شروع می‌شد و در ابتدا به دیدن بزرگترهای فامیل می‌رفتند و این رسم در حال حاضر هم وجود دارد و اهالی که از شهرهای مختلف در ایام عید به روستا تشریف فرما می‌شوند نیز این رسم را برپا می‌دارند.
"""
    },
    {
      "title": "سیزده‌به‌در",
      "text": """
در روز سیزدهم، مردم به دشت و طبیعت می‌رفتند.
سبزه را به آب می‌سپردند تا بدی‌ها و غم‌ها از زندگی دور شود.
این روز با شادی، بازی و دورهمی همراه بود.
"""
    },
  ];

  // تابع _buildSectionBox را کاملاً با این کد جایگزین کنید:
  Widget _buildSectionBox(String title, String content, String query) {
    // پردازش محتوا
    final contentParts = _processWeddingContent(content);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // نمایش بخش‌های مختلف
            for (var part in contentParts)
              _buildContentPart(part, query),
          ],
        ),
      ),
    );
  }

  // تابع _buildContentPart را با این نسخه جایگزین کنید:
  Widget _buildContentPart(Map<String, dynamic> part, String query) {
    final type = part['type'] as String;
    final content = part['content'] as String? ?? '';

    switch (type) {
      case 'subtitle':
        // زیرعنوان: متن از راست، : از چپ با رنگ قرمز پررنگ
        return Container(
          margin: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // علامت : در سمت چپ
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  ":",
                  style: const TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F), // قرمز پررنگ
                  ),
                ),
              ),
              // متن عنوان در سمت راست
              Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F), // قرمز پررنگ
                  ),
                ),
              ),
            ],
          ),
        );
      
      case 'text':


// متن عادی
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text.rich(
            highlightText(content, query),
            textAlign: TextAlign.justify,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 16,
              color: Colors.black87,
              height: 1.7,
            ),
          ),
        );
      
      case 'poem':
        // شعر - وسط چین با کادر جداگانه
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.yellow.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.shade400, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 16,
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                  height: 1.9,
                ),
              ),
            ),
          ),
        );
      
      case 'note':
        // نکته - با کادر جداگانه
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange.shade400, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // عنوان "نکته" از سمت راست
                Text(
                  "نکته",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F), // قرمز پررنگ
                  ),
                ),
                const SizedBox(height: 8),
                // متن نکته
                Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontFamily: 'Vazirmatn',
                    fontSize: 16,
                    color: Colors.brown,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      
      default:
        return const SizedBox.shrink();
    }
  }

  // تابع _processWeddingContent را با این نسخه جایگزین کنید:
  List<Map<String, dynamic>> _processWeddingContent(String text) {
    final List<Map<String, dynamic>> parts = [];
    final lines = text.split('\n');
    String currentText = '';
    
    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();
      
      if (line.isEmpty) {
        if (currentText.isNotEmpty) {
          currentText += '\n';
        }
        continue;
      }


// تشخیص عنوان (خطی که با ":" تمام می‌شود و با "شعر:" یا "نکته:" شروع نمی‌شود)
      if (line.endsWith(':') && 
          !line.toLowerCase().startsWith('شعر') && 
          !line.toLowerCase().startsWith('نکته')) {
        // ذخیره متن قبلی اگر وجود دارد
        if (currentText.isNotEmpty) {
          parts.add({
            'type': 'text',
            'content': currentText.trim(),
          });
          currentText = '';
        }
        
        // اضافه کردن عنوان (بدون : در انتها)
        final titleText = line.substring(0, line.length - 1).trim();
        parts.add({
          'type': 'subtitle',
          'content': titleText,
        });
        continue;
      }
      
      // تشخیص شعر (شعر:)
      if (line.toLowerCase().startsWith('شعر:')) {
        // ذخیره متن قبلی
        if (currentText.isNotEmpty) {
          parts.add({
            'type': 'text',
            'content': currentText.trim(),
          });
          currentText = '';
        }
        
        String poem = '';
        // جمع‌آوری همه خطوط شعر (حذف کلمه "شعر:")
        String firstPoemLine = line.substring(4).trim(); // حذف "شعر:"
        if (firstPoemLine.isNotEmpty) {
          poem = firstPoemLine;
        }
        
        // ادامه جمع‌آوری خطوط شعر
        for (int j = i + 1; j < lines.length; j++) {
          String nextLine = lines[j].trim();
          if (nextLine.isEmpty || 
              (nextLine.endsWith(':') && !nextLine.toLowerCase().startsWith('شعر') && !nextLine.toLowerCase().startsWith('نکته')) || 
              nextLine.toLowerCase().startsWith('شعر:') || 
              nextLine.toLowerCase().startsWith('نکته:')) {
            i = j - 1;
            break;
          }
          poem += '\n$nextLine';
          
          // اگر آخرین خط است
          if (j == lines.length - 1) {
            i = j;
          }
        }
        
        if (poem.isNotEmpty) {
          parts.add({
            'type': 'poem',
            'content': poem.trim(),
          });
        }
        continue;
      }
      
      // تشخیص نکته
      if (line.toLowerCase().startsWith('نکته:')) {
        // ذخیره متن قبلی
        if (currentText.isNotEmpty) {
          parts.add({
            'type': 'text',
            'content': currentText.trim(),
          });
          currentText = '';
        }
        
        String note = line.substring(5).trim(); // فقط حذف ":" از "نکته:"
        
        // ادامه جمع‌آوری خطوط نکته
        for (int j = i + 1; j < lines.length; j++) {
          String nextLine = lines[j].trim();
          if (nextLine.isEmpty || 
              (nextLine.endsWith(':') && !nextLine.toLowerCase().startsWith('شعر') && !nextLine.toLowerCase().startsWith('نکته')) || 
              nextLine.toLowerCase().startsWith('شعر:') || 
              nextLine.toLowerCase().startsWith('نکته:')) {
            i = j - 1;
            break;
          }
          note += '\n$nextLine';
          
          // اگر آخرین خط است
          if (j == lines.length - 1) {
            i = j;
          }
        }
        
        if (note.isNotEmpty) {
          parts.add({
            'type': 'note',
            'content': note.trim(),
          });
        }
        continue;
      }
      
      // متن عادی
      currentText += '$line\n';
    }
    
    // ذخیره متن باقی‌مانده
    if (currentText.isNotEmpty) {
      parts.add({
        'type': 'text',
        'content': currentText.trim(),
      });
    }
    
    return parts;
  }

  // ویجت تب عروسی با ExpansionTile
  Widget _buildWeddingTab() {
    final filtered = weddingSections.where((item) {
      return normalize(item['title']!).contains(normalize(searchText)) ||
          normalize(item['text']!).contains(normalize(searchText));
    }).toList();

    return _buildExpansionList(
      items: filtered,
      titleColorEven: const Color(0xFF1565C0),
      titleColorOdd: const Color(0xFF42A5F5),
    );
  }


// ویجت تب تولد با ExpansionTile
  Widget _buildBirthTab() {
    final filtered = birthSections.where((item) {
      return normalize(item['title']!).contains(normalize(searchText)) ||
          normalize(item['text']!).contains(normalize(searchText));
    }).toList();

    return _buildExpansionList(
      items: filtered,
      titleColorEven: const Color(0xFF2E7D32),
      titleColorOdd: const Color(0xFF4CAF50),
    );
  }

  // ویجت تب نوروز با ExpansionTile
  Widget _buildNowruzTab() {
    final filtered = nowruzSections.where((item) {
      return normalize(item['title']!).contains(normalize(searchText)) ||
          normalize(item['text']!).contains(normalize(searchText));
    }).toList();

    return _buildExpansionList(
      items: filtered,
      titleColorEven: const Color(0xFFF57C00),
      titleColorOdd: const Color(0xFFFF9800),
    );
  }

  // در قسمت _buildExpansionList تغییرات زیر را اعمال کنید:
  Widget _buildExpansionList({
    required List<Map<String, String>> items,
    required Color titleColorEven,
    required Color titleColorOdd,
  }) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final itemKey = "${item["title"]}_$index";
        final isExpanded = _expandedStates[itemKey] ?? false;
        final titleColor = index % 2 == 0 ? titleColorEven : titleColorOdd;
        final iconColor = index % 2 == 0 ? Colors.red : Colors.pink;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ExpansionTile(
              key: Key(itemKey),
              // آیکون در سمت راست (تغییر اینجا)
              leading: Icon(
                Icons.celebration,
                color: iconColor,
              ),
              // فلش در سمت چپ (تغییر اینجا)
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey.shade700,
              ),
              // کنترل کننده فلش
              controlAffinity: ListTileControlAffinity.trailing,
              initiallyExpanded: isExpanded,
              onExpansionChanged: (expanded) {
                setState(() {
                  _expandedStates[itemKey] = expanded;
                });
              },
              title: Text(
                item["title"]!,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                  fontFamily: "Vazirmatn",
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildSectionBox(item["title"]!, item["text"]!, searchText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


@override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "آیین‌ها و رسوم",
              style: TextStyle(
                fontFamily: 'Vazirmatn',
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: "عروسی"),
                Tab(text: "تولد فرزند"),
                Tab(text: "نوروز"),
              ],
            ),
          ),
          body: Column(
            children: [
              // نوار جستجو
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  onChanged: (value) {
                    setState(() => searchText = value);
                  },
                  decoration: InputDecoration(
                    hintText: "جستجو در عنوان و متن...",
                    hintStyle: const TextStyle(fontFamily: 'Vazirmatn'),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildWeddingTab(),
                    _buildBirthTab(),
                    _buildNowruzTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}