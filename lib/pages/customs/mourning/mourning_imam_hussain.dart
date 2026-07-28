import 'package:flutter/material.dart';

class MourningImamHussainPage extends StatelessWidget {
  const MourningImamHussainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'عزاداری امام‌حسین (ع)',
            style: TextStyle(fontFamily: 'Vazirmatn'),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: const [
              Tab(text: 'دهه اول محرم'),
              Tab(text: 'محرم و صفر'),
              Tab(text: 'اربعین'),
              Tab(text: 'مراسم 28 صفر'),
            ],
            labelStyle: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            // دهه اول محرم - متن جدید و کامل ایراج
            _IrajMuharramContent(),

            // محرم و صفر (به‌روز شده)
            _TabContent(
              title: 'محرم و صفر',
              description:
                  'حسینیه و مسجد امام حسین (ع) تا آخر محرم و صفر هر شب برنامه نوحه‌خوانی، روضه و سخنرانی دارند.\n\n'
                  'شب‌های محرم و صفر در روستای ما به عزاداری و عبادت اختصاص دارد. مراسم اصلی شامل:\n\n'
                  '• شب‌زنده‌داری و عبادت در مسجد\n'
                  '• مداحی و نوحه‌خوانی شبانه\n'
                  '• قرائت زیارت عاشورا و ادعیه مخصوص\n'
                  '• سخنرانی‌های مذهبی درباره اهل بیت (ع)\n'
                  '• تعزیه‌خوانی در شب تاسوعا و عاشورا\n'
                  '• پخش چای و خرما در بین عزاداران\n\n'
                  'زنان و مردان به صورت جداگانه در مراسم شرکت کرده و فضای معنوی خاصی در روستا حاکم می‌شود.',
            ),
            _TabContent(
              title: 'اربعین',
              description:
                  'مراسم اربعین حسینی در روستای ما با آیین‌های ویژه‌ای برگزار می‌شود:\n\n'
                  '• پیاده‌روی نمادین از روستا تا مسجد اصلی\n'
                  '• زیارت اربعین به صورت دسته‌جمعی\n'
                  '• پخت نذری زنجبیل و چای\n'
                  '• تشکیل دسته‌های عزاداری با پرچم‌های سیاه\n'
                  '• سخنرانی درباره فلسفه قیام عاشورا\n'
                  '• قرائت دعای عهد و نیایش\n\n'
                  'در این روز، اهالی که به کربلا مشرف شده‌اند، خاطرات خود را نقل کرده و فضای معنوی خاصی ایجاد می‌کنند.',
            ),
            _TabContent(
              title: 'مراسم 28 صفر',
              description:
                  'مراسم ۲۸ صفر به مناسبت شهادت پیامبر اسلام(ص) و امام حسن مجتبی(ع) در روستای ما برگزار می‌شود:\n\n'
                  '• برگزاری مراسم عزاداری در مسجد\n'
                  '• سخنرانی درباره سیره نبوی و کرامات امام حسن(ع)\n'
                  '• مداحی و نوحه‌خوانی ویژه\n'
                  '• پخش نذری و غذای گرم\n'
                  '• قرائت قرآن و فاتحه برای ارواح مطهر\n'
                  '• بیان فضایل و مناقب پیامبر و اهل بیت\n\n'
                  'این مراسم نشانگر ارادت عمیق اهالی روستا به خاندان پیامبر اسلام (ص) است.',
            ),
          ],
        ),
      ),
    );
  }
}

// ویجت جدید و کامل برای دهه اول محرم (متن ارسالی شما با دسته‌بندی)
class _IrajMuharramContent extends StatelessWidget {
  const _IrajMuharramContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان اصلی
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'دهه اول محرم در ایراج',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // آماده‌سازی قبل از محرم
              _buildSectionTitle('آماده‌سازی قبل از محرم'),
              const Text(
                'یک روز مانده به محرم در ایراج شور و حال عجیبی برپاست. به همت بچه‌های روستا، حسینیه و مسجد امام حسین (ع) با پارچه و پرچم‌های مخصوص این ماه سیاه‌پوش می‌شود و خانم‌ها حسینیه و مسجد را تمیز می‌کنند.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // مراسم شب‌های محرم
              _buildSectionTitle('مراسم شب‌های محرم'),
              const Text(
                'از شب اول محرم در حسینیه و مسجد امام حسین مراسم عزاداری همراه با زیارت عاشورا، نوحه و مرثیه‌ای از محتشم تا شب عاشورا برگزار می‌شود. بعد از خواندن قرآن، برای شروع نوحه‌خوانی مرثیه‌ای که در ایراج به «محتشم» معروف است خوانده می‌شود که در آخر این مرثیه با آوردن اسم امام زمان (عج) همه از جا برمی‌خیزند و برای سینه‌زنی آماده می‌شوند.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // ========== کادر اول: شعر آغازین (از سبب تعجیل) ==========
              _buildFirstPoemCard(context),
              const SizedBox(height: 20),

              // نخل و علم‌های ایراج
              _buildSectionTitle('نخل و علم‌های ایراج'),
              const Text(
                'از قدیم‌الایام حسینیه ایراج دارای یک نخل (نقل) است، مشابه آنچه در یزد و تفت هست اما کوچک‌تر. همچنین دارای ۳ علم متفاوت که با پارچه‌های زیبا پوشانده شده و نزد اهالی تقدس ویژه‌ای دارند. سابقاً یک نخل چوبی بسیار سنگین داشتند که چند سالی است به نخل فلزی سبک‌تر تبدیل شده است.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // مراسم علم‌گردانی
              _buildSectionTitle('مراسم علم‌گردانی'),
              const Text(
                'شب ششم محرم علم‌ها را از اتاق بیرون آورده و با ورود به حسینیه می‌خوانند: "این علم از کیست که بی‌صاحب است / صاحب او کشته و یا غایب است". ساعتی علم‌ها را در مجلس عزاداری می‌چرخانند. هر علم توسط یک نفر و آن هم فرد خاصی که از گذشته‌های دور جدشان علم‌دار بوده حمل می‌شود.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // مراسم پَرسه (سنت قدیمی)
              _buildSectionTitle('مراسم پَرسه (سنت قدیمی)'),
              const Text(
                'تا چند سال پیش در روز تاسوعا مراسم "پرسه" برگزار می‌شد که متأسفانه با تصمیم برخی افراد این سنت از بین رفت. این مراسم از حسینیه شروع می‌شد و مردم همراه با علم‌دارها و مرحوم ابوالحسن اکبر بر در خانه‌ها می‌رفتند. ایشان با حافظه خوبی که داشت برای تمامی درگذشتگان و اموات آن خانواده آمرزش طلب می‌کرد و مردم آمین می‌گفتند. صاحبخانه نیز از مردم پذیرایی می‌کرد.\n\n'
                'دو نفر هم پشت سر مردم به در خانه‌ها می‌آمدند و گندم برای حلیم و نان برای غذای ظهر عاشورا جمع‌آوری می‌کردند و یک نفر هم پول برای روضه‌خوان‌های دهه محرم جمع می‌کرد.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // رفت و آمد دسته‌ها بین روستاها
              _buildSectionTitle('ارتباط با روستای اردیب'),
              const Text(
                'در بیشتر سال‌ها در روز تاسوعا یا مردم ایراج مهمان مردم اردیب هستند یا مردم خوب روستای اردیب مهمان ایراجی‌ها. خوشبختانه این سنت نیکو همچنان ادامه دارد.\n\n'
                'وقتی دسته عزاداری به روستای دیگر می‌رسد، آنها با خم کردن پرچم به مهمان سلام می‌دهند و با خواندن اشعاری از قبیل:\n'
                '"اندر این ماوای ما خوش آمدید خوش آمدید / ایهاالاقوام ما خوش آمدید خوش آمدید"\n'
                'به استقبال دسته عزاداری می‌روند و به احترام مهمان در دو طرف می‌ایستند تا دسته عزاداری مهمان از وسط رد شود و در جلو قرار بگیرد. همچنین میکروفون را در اختیار مهمان قرار می‌دهند.\n\n'
                'وقتی مهمان می‌خواهد روستا را ترک کند با اشعار مذهبی بدرقه می‌شوند:\n'
                '"سینه زنان شه دین خوش آمدید خوش آمدید"\n'
                'در مقابل مهمان اینگونه جواب می‌دهد:\n'
                '"ما دعا کردیم و رفتیم زین عزا / اجر هر یک با شهید کربلا"',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // شب عاشورا و مراسم صبح روسیاه
              _buildSectionTitle('شب عاشورا و مراسم صبح روسیاه'),
              const Text(
                'شب عاشورا تا قبل از اذان صبح مراسم نوحه و روضه‌خوانی برپاست و با خواندن "صبح روسیاه" این مراسم به پایان می‌رسد.\n\n'
                'موقع خواندن صبح روسیاه، طبق سنت‌های قدیم چهار نفر زیر نخل را گرفته و دور حسینیه می‌چرخانند و مداحان صبح روسیاه را می‌خوانند و مردم هم پشت سر نخل گریه می‌کنند.\n\n'
                'به گونه‌ای که شنیده‌ام این نخل نمادی از تابوت امام حسین (ع) است. دقیقاً همین مراسم با همین کیفیت و نخل و علم‌های جداگانه در مسجد امام حسین (ع) نیز برگزار می‌شود.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              // ========== کادر دوم: شعر امشبی را شه دین (منتقل شده به بخش شب عاشورا) ==========
              _buildSecondPoemCard(context),
              const SizedBox(height: 16),

              // تزیین نخل
              _buildSectionTitle('تزیین نخل در شب عاشورا'),
              const Text(
                'به نخل توسط شخصی در شب عاشورا لباسی سیاه پوشانده می‌شود. بر روی لباس نخل عکس‌هایی از دستان قطع شده ابوالفضل (ع) و اشعار مذهبی حک شده است.\n\n'
                'بعد از پوشاندن لباس:\n'
                '• دو آینه به دو طرف نخل آویزان می‌شود\n'
                '• بر روی نخل دو کارد بزرگ نصب می‌شود\n'
                '• بر سر هر کارد یک انار گذاشته می‌شود\n'
                '• در زیر نخل دو عدد زنگ قدیمی (شبیه زنگ کلیسا اما کوچک‌تر) می‌بندند\n\n'
                'می‌گویند این زنگ‌ها یادآور زنگ‌های شترهای کاروان اسیران می‌باشد.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // ========== کادر سوم: شعر باز این چه شورش است (در بخش صبح روسیاه) ==========
              _buildThirdPoemCard(context),
              const SizedBox(height: 20),

              // مراسم روز عاشورا
              _buildSectionTitle('مراسم روز عاشورا'),
              const Text(
                'صبح عاشورا مردم در حسینیه جمع می‌شوند و نخل را که از شب قبل آماده شده توسط چهار نفر به حرکت درمی‌آورند. یک نفر هم در زیر نخل برای به صدا درآوردن زنگ‌ها قرار می‌گیرد. جای این چهار نفر به نوبت عوض می‌شود.\n\n'
                'نخل را برداشته و مردم پشت سر نخل به سمت شهرک راه می‌افتند. وقتی به نزدیکی‌های مسجد امام حسین می‌رسند، می‌ایستند و نخل و علم‌های مسجد را هم برمی‌دارند و به سمت جاده زیردشت حرکت می‌کنند. اینگونه می‌شود: دو نخل و ۶ علم همراه با پرچم‌ها و علم حضرت فاطمه (س) که سرتاسر سیاه‌پوش است.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              const Text(
                'مراسم به این شکل است که از حسینیه شروع می‌شود، تمام روستا را دور زده و از راه زیردشت ایراج دوباره به حسینیه بازمی‌گردند. بین راه نوحه، مصیبت و روضه می‌خوانند.\n\n'
                'قبل از رسیدن دوباره به حسینیه، در مسیر امام‌زاده‌ای به نام "زیارت پایین" وجود دارد که هر سال عزاداران آنجا می‌ایستند و همسایه‌های امام‌زاده از مردم پذیرایی می‌کنند. قبلاً مرحوم حاج سید کاظم و حاج محمد حسن موبد روضه می‌خواندند و در حال حاضر حاج جعفر اکبر روضه خود را می‌خواند.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),

              const Text(
                'دوباره به سمت حسینیه راه می‌افتند و پس از رسیدن به حسینیه، عزاداری تا نزدیکی‌های ظهر ادامه دارد. برای نماز ظهر و ناهار، بعضی افراد همراه با نخل و علم‌های مسجد به سمت مسجد امام حسین می‌روند و برخی در حسینیه می‌مانند (بستگی به سلیقه اشخاص دارد).\n\n'
                'با خواندن نماز و خوردن ناهار، مراسم روز عاشورا به پایان می‌رسد. بعد از ظهر عاشورا تمام مردم روستا بر سر مزار شهیدان و اموات خود می‌روند.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // شام غریبان
              _buildSectionTitle('شام غریبان'),
              const Text(
                'شب یازدهم محرم که به شام غریبان معروف است، اول شام غریبان برگزار می‌شود و سپس مراسمی به نام "دم گرفتن" اجرا می‌گردد و بدین ترتیب دهه اول محرم به پایان می‌رسد.',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),

              // حسینیه ایراجی‌های مقیم تهران
              _buildSectionTitle('حسینیه ایراجی‌های مقیم تهران'),
              const Text(
                'همین مراسم به همان سبکی که در ایراج انجام می‌شود، در مسجد چهارده معصوم (واقع در منطقه خلیج فارس تهران) نیز برگزار می‌گردد. روز تاسوعا هیئت به خیابان‌ها و درب منازل افرادی که نذری دارند یا قربانی برای نهار عاشورا دارند می‌روند و روز عاشورا در خیابان اصلی خلیج تا نزدیکی بیمارستان فیاض‌بخش می‌روند و برمی‌گردند.\n\n'
                'خیلی از ایراجی‌ها نمی‌توانند برای مراسم تاسوعا و عاشورا به ایراج بروند، ولی وقتی وارد این حسینیه می‌شوند، همان فضا و حال‌وهوای زادگاهشان برایشان زنده می‌شود.\n\n'
                'در آخر تشکر می‌کنیم از ایراجی‌هایی که این حسینیه را سرپا نگه داشته‌اند، به ویژه از آقایان دانا و مسعود و زاهد و...',
                style: TextStyle(fontSize: 16, height: 1.8, fontFamily: 'Vazirmatn'),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              // کادر زمان‌بندی
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'زمان‌بندی مراسم:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• صبح‌ها: ۸ تا ۱۰ - سخنرانی\n'
                      '• ظهر: ۱۲ تا ۱۳:۳۰ - مراسم سینه‌زنی\n'
                      '• عصر: ۱۷ تا ۱۹ - تعزیه‌خوانی\n'
                      '• شب: ۲۰ تا ۲۲ - روضه‌خوانی',
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Vazirmatn',
          color: Colors.teal,
        ),
      ),
    );
  }

  // ========== کادر اول: شعر آغازین (از سبب تعجیل) ==========
  Widget _buildFirstPoemCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: Colors.purple.shade100,
            child: Icon(Icons.star, color: Colors.purple.shade700),
          ),
          title: Text(
            'شعر آغازین',
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.purple.shade700,
            ),
          ),
          subtitle: Text(
            'از برای سبب تعجیل ظهور...',
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'از برای سبب تعجیل ظهور موفور السرور امام ثانی عشر آمین\n'
                'و به آن فرمان فرمای قضا و قدر آمین\n'
                'و به آن شعشعه افروز شمس و قمر\n'
                'و به آن نایب حضرت خیر البشر آمین\n'
                'به معراج خورشید "قل لا اسئلکم علیه اجرا الا الموده فی القربی" آمین\n'
                'به خورشید تابنده اوج شرف آمین\n'
                'به ماه درخشنده بی خسف آمین\n'
                'گل بوستان رسول امین آمین\n'
                'کرم پیشه معجز نما رکن دین آمین\n'
                'آنکه چون تیغ بر کشد ز غلاف آمین\n'
                'لرزه افتد به هفت قله قاف آمین\n'
                'نایب مرتضی علی باشد آمین\n'
                'نونهال ریاض عبد مناف آمین\n'
                'آنکه چون برگ از شجر ریزد آمین\n'
                'دم تیغش عدو به روز مصاف آمین\n'
                'یعنی به نام پادشاه محتشم حشم، مشتری شیم، کیوان علم، قمر اقتدار آمین\n'
                'صاحب السیف و ذوالفقار آمین\n'
                'یعنی به نام امام عصر و عج الله ظهوره',
                style: TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 15,
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== کادر دوم: شعر امشبی را شه دین (در بخش شب عاشورا) ==========
  Widget _buildSecondPoemCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: Colors.indigo.shade100,
            child: Icon(Icons.nightlight, color: Colors.indigo.shade700),
          ),
          title: Text(
            'شب عاشورا',
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.indigo.shade700,
            ),
          ),
          subtitle: Text(
            'امشبی را شه دین در حرمش مهمان است...',
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text(
                'امشبی را شه دین در حرمش مهمان است\n'
                'ظهر فردا بدنش زیر سم اسبان است\n'
                'مکن ای صبح طلوع، مکن ای صبح طلوع\n'
                'ای صبح روسیاه به چه رو می‌شوی سپید\n'
                'فردا حسین تشنه جگر می‌شود شهید',
                style: TextStyle(
                  fontFamily: 'Vazirmatn',
                  fontSize: 15,
                  height: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== کادر سوم: شعر باز این چه شورش است (در بخش صبح روسیاه) ==========
  Widget _buildThirdPoemCard(BuildContext context) {
    List<String> poemLines = [
'بعد از هر بیتی که خوانده می شود\n بیت زیر توسط عزاداران خوانده می شود\n '
'ای صبح روسیاه به چه رو میشوی سپید',
      'فردا حسین تشنه جگر می شود شهید',  

      'باز این چه شورش است که در خلق عالم است',
      'باز این چه نوحه و چه عزا و چه ماتم است',
      
      'باز این چه رستخیز عظیم است کز زمین',
      'بی‌ نفخ صور خاسته تا عرش اعظم است',
     
      'این صبح تیره باز دمید از کجا کزو',
      'کار جهان و خلق جهان جمله در هم است',

      'گویا طلوع می‌کند از مغرب آفتاب',
      'کآشوب در تمامی ذرات عالم است',

      'گر خوانمش قیامت دنیا بعید نیست',
      'این رستخیز عام که نامش محرم است',

      'در بارگاه قدس که جای ملال نیست',
      'سرهای قدسیان همه بر زانوی غم است',

      'جن و ملک بر آدمیان نوحه می‌کنند',
      'گویا عزای اشرف اولاد آدم است',

   'خورشید آسمان و زمین، نور مشرقین',
      'پروردهٔ کنار رسول خدا حسین',

      'کشتی‌شکست‌خوردهٔ طوفان کربلا',
      'در خاک و خون تپیدهٔ میدان کربلا',

      'از آب هم مضایقه کردند کوفیان',
      'خوش داشتند حرمت مهمان کربلا',

      'بودند دیو و دد همه سیراب و می‌مکید',
      'خاتم، ز قحط آبْ سلیمان کربلا',

      'آه از دمی که لشکر اعدا نکرده شرم',
      'کردند رو به خیمهٔ سلطان کربلا',

      'کاش آن زمان ز آه جهان‌سوز اهل بیت',
      'یک شعله، برقِ خرمنِ گردونِ دون شدی',

      'کاش آن زمان که این حرکت کرد آسمان',
      'سیماب‌وارْ گویِ زمین، بی‌سکون شدی',

      'کاش آن زمان که کشتی آل نبی شکست',
      'عالم، تمامْ غرقهٔ دریای خون شدی',

      'نوبت به اولیا چو رسید، آسمان تپید',
      'زان ضربتی که بر سر شیر خدا زدند',

      'آن در که جبرئیلِ امین بود خادمش',
      'اهل ستم، به پهلوی خیرالنسا زدند',

      'پس آتشی ز اخگرِ الماس‌ریزه‌ها',
      'افروختند و در حسن مجتبی زدند',

      'وانگه سرادقی که ملک محرمش نبود',
      'کندند از مدینه و در کربلا زدند',

      'پس ضربتی کزان جگر مصطفی درید',
      'بر حلق تشنهٔ خَلَفِ مرتضی زدند',

      'اهل حرم دریده گریبان، گشوده مو',
      'فریاد بر درِ حرم کبریا زدند',

      'چون خون ز حلق تشنهٔ او بر زمین رسید',
      'جوش از زمین به ذروهٔ عرش بَرین رسید',

      'نزدیک شد که خانهٔ ایمان شود خراب',
      'از بس شکست‌ها که به ارکان دین رسید',

      'نخلِ بلندِ او، چو خسان بر زمین زدند',
      'طوفان به آسمان ز غبار زمین رسید',

      'باد، آن غبار چون به مزار نبی رساند',
      'گرد از مدینه بر فلک هفتمین رسید',

      'ترسم جزای قاتل او چون رقم زنند',
      'یکباره بر جریدهٔ رحمت قلم زنند',

      'ترسم کزین گناه، شفیعانِ روز حشر',
      'دارند شرم کز گنه خلق دم زنند',

      'دستِ عتابِ حق، به در آید ز آستین',
      'چون اهل بیت، دست در اهل ستم زنند',

      'آه از دمی که با کفن خون‌چکان ز خاک',
      'آل علی چو شعلهٔ آتش علم زنند',

      'پس بر سنان کنند سری را که جبرئیل',
      'شوید غبارِ گیسویش از آب سلسبیل',

      'روزی که شد به نیزه سر آن بزرگوار',
      'خورشیدْ سربرهنه برآمد ز کوهسار',

      'موجی به جنبش آمد و برخاست کوهْ کوه',
      'ابری به بارش آمد و بگریست زار زار',

      'گفتی تمامْ زلزله شد خاکِ مطمئن',
      'گفتی فتاد از حرکت چرخِ بی‌قرار',

      'هم بانگ نوحه غلغله در شش جهت فکند',
      'هم گریه بر ملایک هفت آسمان فتاد',

      'هرجا که بود آهویی، از دشت پا کشید',
      'هرجا که بود طایری، از آشیان فتاد',

      'شد وحشتی که شور قیامت ز یاد رفت',
      'چون چشم اهل بیت بر آن کشتگان فتاد',

      'ناگاه چشم دختر زهرا در آن میان',
      'بر پیکر شریف امام زمان فتاد',

      'بی‌اختیار، نعرهٔ «هذا حسینِ» او',
      'سر زد؛ چنانکه آتش از او در جهان فتاد',

      'پس با زبان پر گله، آن بضعهٔ بتول',
      'رو در مدینه کرد که یا ایهاالرسول',

      'این کشتهٔ فتاده به هامون حسین توست',
      'وین صید دست و پا زده در خون حسین توست',

      'این نخلِ تر، کز آتش جان‌سوز تشنگی',
      'دود از زمین رسانده به گردون حسین توست',

      'این ماهیِ فتاده به دریای خون که هست',
      'زخم از ستاره بر تنش افزون، حسین توست',

      'این غرقهٔ محیطِ شهادت که روی دشت',
      'از موجِ خون او، شده گلگون؛ حسین توست',

      'این خشک‌لب‌فتادهٔ دور از لبِ فرات',
      'کز خون او زمین شده جیحون حسین توست',

      'این شاه کم‌سپاه که با خیلِ اشک و آه',
      'خرگاه زین جهان زده بیرون حسین توست',

      'این قالبِ تپان که چنین مانده بر زمین',
      'شاهِ شهیدِ ناشده‌مدفون، حسین توست',

      'چون رویْ در بقیع، به زهرا خطاب کرد',
      'وحشِ زمین و مرغِ هوا را کباب کرد',

      'کای مونس شکسته‌دلان، حال ما ببین',
      'ما را غریب و بی‌کس و بی‌آشنا ببین',

      'اولاد خویش را که شفیعان محشرند',
      'در ورطهٔ عقوبت اهل جفا ببین',

      'در خُلد، بر حجابِ دو کونْ آستین‌ فشان',
      'واندر جهان مصیبت ما بر ملا ببین',

      'خاموش محتشم که دل سنگ آب شد',
      'بنیاد صبر و خانهٔ طاقت خراب شد',

      'خاموش محتشم که از این حرف سوزناک',
      'مرغ هوا و ماهی دریا کباب شد',

      'خاموش محتشم که از این شعر خون‌چکان',
      'در دیده، اشک مستمعان، خونِ ناب شد',

      'خاموش محتشم که از این نظمِ گریه‌خیز',
      'روی زمینْ به اشک، جگرگون، کباب شد',

      'خاموش محتشم که فلک بسکه خون گریست',
      'دریا، هزار مرتبه، گلگون‌حباب شد',

      'خاموش محتشم که به سوز تو آفتاب',
      'از آه سرد ماتمیان، ماهتاب شد',

      'خاموش محتشم که ز ذکر غم حسین',
      'جبریل را ز روی پیمبر حجاب شد',

      'ای صبح روسیاه به چه رو میشوی سپید',
      'فردا حسین تشنه جگر می شود شهید',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: Colors.red.shade100,
            child: Icon(Icons.sunny, color: Colors.red.shade700),
          ),
          title: Text(
            'صبح روسیاه',
            style: TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.red.shade700,
            ),
          ),
          subtitle: Text(
            'باز این چه شورش است که در خلق عالم است...',
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: poemLines.map((line) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      line,
                      style: const TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 14,
                        height: 1.8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// کلاس کمکی برای سایر تب‌ها
class _TabContent extends StatelessWidget {
  final String title;
  final String description;

  const _TabContent({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.grey.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  fontFamily: 'Vazirmatn',
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),

              // اطلاعات تکمیلی
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'زمان‌بندی مراسم:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getTimingInfo(title),
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimingInfo(String tabTitle) {
    switch (tabTitle) {
      case 'دهه اول محرم':
        return '• صبح‌ها: ۸ تا ۱۰ - سخنرانی\n'
            '• ظهر: ۱۲ تا ۱۳:۳۰ - مراسم سینه‌زنی\n'
            '• عصر: ۱۷ تا ۱۹ - تعزیه‌خوانی\n'
            '• شب: ۲۰ تا ۲۲ - روضه‌خوانی';
      case 'محرم و صفر':
        return '• شب‌ها: ۲۱ تا ۲۴ - مراسم شبانه\n'
            '• تعزیه: شب تاسوعا و عاشورا\n'
            '• سخنرانی: قبل از مداحی\n'
            '• پذیرایی: بعد از مراسم';
      case 'اربعین':
        return '• صبح: ۷ تا ۹ - تجمع و حرکت\n'
            '• روز: ۹ تا ۱۲ - پیاده‌روی\n'
            '• ظهر: ۱۲ تا ۱۴ - زیارت و مراسم\n'
            '• عصر: ۱۴ تا ۱۶ - پذیرایی';
      case 'مراسم 28 صفر':
        return '• صبح: ۹ تا ۱۱ - قرائت قرآن\n'
            '• ظهر: ۱۲ تا ۱۳:۳۰ - سخنرانی\n'
            '• عصر: ۱۵ تا ۱۷ - عزاداری\n'
            '• شب: ۱۸ تا ۲۰ - پذیرایی';
      default:
        return 'مراسم طبق برنامه اعلام شده برگزار می‌شود';
    }
  }
}