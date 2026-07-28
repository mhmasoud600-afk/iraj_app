import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Proverb {
  final String text;
  final String latin;
  final String desc;

  Proverb({required this.text, required this.latin, required this.desc});

  factory Proverb.fromMap(Map<String, String> map) {
    return Proverb(
      text: map["text"] ?? "",
      latin: map["latin"] ?? "",
      desc: map["desc"] ?? "",
    );
  }
}

// دیتای اصلی ضرب‌المثل‌ها
final List<Map<String, String>> rawData = const [
  {"text": "اومدی آتش ببری", "latin": "", "desc": "کسی که با عجله آمده و می خواهد زود برود"},
  {"text": "لاکپشت رفت واز بیاره گندم درو شده بود", "latin": "", "desc": "کنایه از اینکه کسی برای کاری دیر اقدام می‌کند و وقتی می‌رسد که کار تمام شده است (در مقابل ضرب‌المثل معروف \"آب از آب تکان نمی‌خورد\")"},
  {"text": "دل بچه آب شد", "latin": "", "desc": "وقتی بچه منتظر خوردن چیزی است و نگاه می‌کند"},
  {"text": "امروز خر کی سقط می‌کنه؟", "latin": "", "desc": "وقتی کسی بر خلاف عادت کار مثبتی انجام می‌دهد"},
  {"text": "مثل گربه بی چشم و رو می‌مونه", "latin": "", "desc": "قدرنشناس است"},
  {"text": "کیسه گردوی کر", "latin": "", "desc": "کنایه از کسی که فقط ادعا دارد"},
  {"text": "کیسه گردو", "latin": "", "desc": "به بچه‌ای می‌گویند که زیاد گریه می‌کند و نق می‌زند"},
  {"text": "لنگ کسی را توی سر کسی زدن", "latin": "", "desc": "کنایه از اینکه کسی را بالاتر و بهتر از دیگری دانستن"},
  {"text": "تخم‌های خاکشیر", "latin": "", "desc": "کنایه از چیز زیاد و انبوه یا فامیل‌های زیاد"},
  {"text": "سیب منو خوردی پیله بده", "latin": "", "desc": "بازی بچه‌ها هنگام دیدن کرم سیب"},
  {"text": "کارد به شکمت بخوره", "latin": "", "desc": "خطاب به انسان یا حیوان شکمو"},
  {"text": "مگه شلغم داغ تو دهنته؟", "latin": "", "desc": "برای کسی که تند و نامفهوم صحبت می‌کند"},
  {"text": "نُو (nov) به آسمونه", "latin": "nov", "desc": "باران زیاد می‌آید"},
  {"text": "پنبه تو روت بمالند", "latin": "", "desc": "بمیری..."},
  {"text": "شاالله مرغ شی از پیشم بپری", "latin": "", "desc": "نوعی نفرین: بمیری، وربیفتی"},
  {"text": "شاالله به تخت نرسی", "latin": "", "desc": "قبل از ازدواج بمیری"},
  {"text": "تو کاله گردو جا کردن", "latin": "", "desc": "تحت فشار قرار دادن شخص"},
  {"text": "من چه هیزم تری بِهِت فروختم؟", "latin": "", "desc": "چه ظلمی به تو کردم؟"},
  {"text": "هیچ کس نگفت خرت به چند", "latin": "", "desc": "به من هیچ اهمیتی ندادند"},
  {"text": "قیقو کردن", "latin": "", "desc": "کار بزرگ انجام دادن"},
  {"text": "مایه انگل", "latin": "", "desc": "باعث دردسر"},
  {"text": "لباسهاما بگردونم", "latin": "", "desc": "لباس‌هایم را عوض کنم"},
  {"text": "یه شَبَنده روز فامیلیم", "latin": "", "desc": "نسبتی با هم داریم"},
  {"text": "علف در آغال بو میده", "latin": "", "desc": "قدر داشته‌های خود را ندانستن"},
  {"text": "نشاشیدی شَبت درازه", "latin": "", "desc": "زیاد خوشبین نباش، تا پایان راه زیاد مانده"},
  {"text": "آدم دستپاچه چهل جا می‌شاشه", "latin": "", "desc": "کنایه از دستپاچگی"},
  {"text": "به دعای گربه بارون نمیاد", "latin": "", "desc": "کنایه از بی‌اثر بودن دعا"},
  {"text": "سگ زرد برادر شغاله", "latin": "", "desc": "کنایه از شباهت در بدی"},
  {"text": "نخوردیم نون گندم دیدیم دست مردم", "latin": "", "desc": "کنایه از تجربهٔ غیرمستقیم"},
  {"text": "اگه عروسی نرفتیم لب بون عروسی رفتیم", "latin": "", "desc": "کنایه از حضور غیرمستقیم"},
  {"text": "بعد هفتاد برفی افتاد", "latin": "", "desc": "بعد از مدتها اتفاقی افتاد"},
  {"text": "اومدی لحاف رومون بندازی", "latin": "", "desc": "کنایه از دیر آمدن به شب‌نشینی"},
  {"text": "دست و پا به هم می‌ماله", "latin": "", "desc": "کنایه از معطل کردن"},
  {"text": "جیغ زرد و سرخ نکش", "latin": "", "desc": "به بچه‌ای که جیغ بلند می‌کشد"},
  {"text": "از هر چی بدم میاد خدا تو کاسه‌ام میذاره", "latin": "", "desc": "کنایه از بدشانسی"},
  {"text": "نه خود خورم نه کس دهم گنده کنم به سگ دهم", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "خدا خرا شناخت شاخش نداد", "latin": "", "desc": "کنایه از حکمت خدا"},
  {"text": "گر هوسه ما را بسه", "latin": "", "desc": "کنایه از قناعت"},
  {"text": "شاالله از سر ناخون پات دربیاد", "latin": "", "desc": "نوعی نفرین"},
  {"text": "روزم به چه مونا که شبم پنبه زنونه", "latin": "", "desc": "کنایه از ناتوانی در شرایط سخت"},
  {"text": "به پیغوم خر هم آب نمی‌خوره", "latin": "", "desc": "کنایه از بی‌اثر بودن حرف"},
  {"text": "اگه از دیوار صدا در آومد، از این هم صدا در اومد", "latin": "", "desc": "کنایه از تعجب"},
  {"text": "آخر پیری معرکه‌گیری", "latin": "", "desc": "کنایه از رفتار نامناسب در سن بالا"},
  {"text": "از ریش می‌کنه به سبیل می‌چسبونه", "latin": "", "desc": "کنایه از سرهم‌بندی"},
  {"text": "هر چی بیشتر می‌گم تو کمتر می‌شنوی", "latin": "", "desc": "کنایه از بی‌توجهی"},
  {"text": "گوشِت چار چار می‌شنوه", "latin": "", "desc": "کنایه از اینکه اشتباه می‌شنوی"},
  {"text": "ماه ور رویت ندیدم که...", "latin": "", "desc": "کنایه از بی‌ارزشی"},
  {"text": "اون روز که روزونت بود", "latin": "", "desc": "روزهای شکوفایی گذشته"},
  {"text": "خر شل معطل چش", "latin": "", "desc": "کنایه از بهانه‌جویی"},
  {"text": "تُوَه به دیگ گفت تَهِت سیاه", "latin": "", "desc": "کنایه از عیب‌جویی"},
  {"text": "صافی به اُفتابه گفت ای دو سوراخه", "latin": "", "desc": "کنایه از عیب‌جویی"},
  {"text": "به شتر گفتن چرا پاهت کجه", "latin": "", "desc": "کنایه از عیب‌جویی"},
  {"text": "گُه به گُهدون می‌برن، زیره به کرمون", "latin": "", "desc": "کنایه از کار بیهوده"},
  {"text": "شغال از گُمب باغ در میره", "latin": "", "desc": "کنایه از دیر شدن کار"},
  {"text": "به گربه گفتن شاشت دواس", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "هَلَندَر اومد و مهمون ما شد", "latin": "", "desc": "کنایه از مهمان ناخوانده"},
  {"text": "یکی بود دو تا شد", "latin": "", "desc": "کنایه از ناشکری"},
  {"text": "یه لا نمی‌رسه دو لا می‌کنه", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "هر جا عیدتا کردی حالا برو نوروزتا هم بکن", "latin": "", "desc": "کنایه از ادامه دادن خوشی"},
  {"text": "سنگت مُهر شد", "latin": "", "desc": "کنایه از تمام شدن سهمیه"},
  {"text": "خر پیر اوسار رنگین", "latin": "", "desc": "کنایه از فکر جوانی در پیری"},
  {"text": "کار بد صاحب نداره", "latin": "", "desc": "هیچ‌کس مسئولیت کار بد را نمی‌پذیرد"},
  {"text": "بازی شیردوشو در آوردن", "latin": "", "desc": "کنایه از اینکه کسی مسئولیت کار بد را نمی‌پذیرد"},
  {"text": "سگ را تَرِش کن نجستَرش کن", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "درخت آلو را نمی‌شه به شمشاد پیوند زد", "latin": "", "desc": "کنایه از کار نشدنی"},
  {"text": "انگار پاش تو حناهه", "latin": "", "desc": "کنایه از آهسته راه رفتن"},
  {"text": "اگر از آسمون گندم بباره", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "تنبل نرو به سایه، سایه خودش می‌آیه", "latin": "", "desc": "کنایه از تنبلی"},
  {"text": "اگر خواهی که بینی لذت خواب", "latin": "", "desc": "کنایه از آسایش"},
  {"text": "زن کارَکی، مرد کارَکی", "latin": "", "desc": "کنایه از کارهای کوچک"},
  {"text": "طما (طمع) را نباید چندان کنند", "latin": "", "desc": "کنایه از زیاده‌روی در طمع"},
  {"text": "رو نا رو نداره", "latin": "", "desc": "کنایه از بی‌شرمی"},
  {"text": "تو دعوا نقل و بادوم تو جیف هم نمیکنن", "latin": "", "desc": "کنایه از اینکه در دعوا چیزی تقسیم نمی‌شود"},
  {"text": "خری که با سر تو طویله نره با دم میبرنش", "latin": "", "desc": "کنایه از اینکه اگر کسی کاری را نکند، به زور مجبورش می‌کنند"},
  {"text": "عروس خیلی قشنگ بود گالو هم در کرد", "latin": "", "desc": "کنایه از اینکه زیبایی با عیب همراه شد(گالو همان زگیل است)"},
  {"text": "زبونتا بِجو", "latin": "", "desc": "کنایه از پرحرفی"},
  {"text": "دست کم در سفره‌ها و دست پر در کارها", "latin": "", "desc": "کنایه از کم‌کاری در خوردن و پرکاری در کار"},
  {"text": "جو پا گدار فایده نداره", "latin": "", "desc": "کنایه از بی‌فایده بودن"},
  {"text": "مگه دارم یاسین به گوش خر می‌خونم؟", "latin": "", "desc": "کنایه از بی‌اثر بودن نصیحت"},
  {"text": "خر خرابی کرده، گوش گاو را می‌برن", "latin": "", "desc": "کنایه از اینکه مجازات را به دیگری می‌دهند"},
  {"text": "اسم روغن اومد درد زاییدنش گرفت", "latin": "", "desc": "کنایه از اینکه یاد چیزی باعث دردسر شد"},
  {"text": "نون جو خوردم و زردآلو و ماست", "latin": "", "desc": "کنایه از شکایت بی‌جا، ملک الموت میگه این هم تقصیر ماست"},
  {"text": "بدبختی که باز آید، گوز وقت نماز آید", "latin": "", "desc": "کنایه از بدشانسی"},
  {"text": "به چس غریبا بنده", "latin": "", "desc": "خیلی سست و بی‌اراده"},
  {"text": "خوش به حال خودم که خر ندارم", "latin": "", "desc": "کنایه از بی‌دغدغه بودن"},
  {"text": "مرغی که انجیر می‌خوره، سر نیشکش کجه", "latin": "", "desc": "کنایه از اینکه هر کاری اثر خودش را دارد"},
  {"text": "بزی که ناز می‌کنه، آب ته جابیه گیرش میاد", "latin": "", "desc": "کنایه از اینکه ناز کردن نتیجه ندارد"},
  {"text": "یه بز کم، یه هی کم", "latin": "", "desc": "کنایه از کمبود"},
  {"text": "کسی که دست خودش زخمه، برا زخم دیگران جُل نمی‌سوزونه", "latin": "", "desc": "کنایه از اینکه کسی به مشکل دیگران توجه نمی‌کند"},
  {"text": "زکات تخم مرغ یک پنبه دانه", "latin": "", "desc": "کنایه از بخشش کوچک"},
  {"text": "از بس خوش بر و رو هست، لب خزینه هم می‌شینه", "latin": "", "desc": "کنایه از زیبایی"},
  {"text": "کمر مویی را دو تا نمی‌کنه", "latin": "", "desc": "کنایه از اینکه هیچ کاری نمی‌کند"},
  {"text": "گیر از دست و پای کسی در رفتن", "latin": "", "desc": "کنایه از شوکه شدن، بر اثر شنیدن خبر بد، ناگهان سست شدن (... تا شنیدم گیر از دست و پام در رفت)"},
  {"text": "از دستت دونو رو توه شدم", "latin": "", "desc": "کنایه از اینکه عاجز شدم. مثل دونه گندم روی توه داغ دارم بالا و پایین میپرم!!"},
  {"text": "خودتا نومایون کردی", "latin": "", "desc": "کنایه از خود را نشان دادن – خود را در معرض دید قرار دادن"},
  {"text": "اونم برای چراش", "latin": "", "desc": "کنایه از اینکه این مورد هم برای دوری از چشم نظرش"},
  {"text": "پایی به خاک‌نمیکشه", "latin": "", "desc": "کنایه از کسی است که در آستانه مرگ است"},
  {"text": "مثل گاب میمونه", "latin": "", "desc": "برای کسی که کارهای نفهمی انجام می‌دهد بکار می‌برند"},
  {"text": "تو دونی خدا", "latin": "", "desc": "کنایه از تعجب از رفتار شخص"},
  {"text": "یک جای بزار دست نشون باشه", "latin": "", "desc": "کنایه از چیزی را در جایی که در دسترس باشد قرار دادن"},
  {"text": "هم آدم نمیگیره", "latin": "", "desc": "کنایه از تحویل نگرفتن"},
  {"text": "سر سیخ کردن", "latin": "", "desc": "کنایه از تحریک کردن کسی برای کاری"},
  {"text": "این‌ پلته را از گوشت دربیار", "latin": "", "desc": "به کسی می‌گویند که حاضر به گوش دادن نیست و اصرار به انجام کار خود دارد"},
  {"text": "گربه صاحب خمیر مایه است", "latin": "", "desc": "به کسی می‌گویند که فعلا صاحب کار و اختیار دار شده است"},
  {"text": "رنگم ببین حالم نپرس", "latin": "", "desc": "کنایه از اینکه وقتی به رنگ چهره‌ام نگاه کنی حال دلم را متوجه می‌شوی"},
  {"text": "مزه کاه میده", "latin": "", "desc": "کنایه از بی‌مزه بودن چیزی"},
  {"text": "این چایی مثل رنگ‌ و‌روی مرده میمونه", "latin": "", "desc": "کنایه از بی‌رنگ و رو بودن چای"},
  {"text": "این چایی مثل شاش خر میمونه", "latin": "", "desc": "کنایه از بی‌رنگ و رو بودن چای"},
  {"text": "صد بته تلخه را آبش می‌دم چون یک شاخه گندم اون‌ وسط دارم", "latin": "", "desc": "کنایه از اینکه بخاطر یک نفر که اهمیت دارد مجبورم به بقیه هم توجه کنم"},
  {"text": "بوی ساهار میده", "latin": "", "desc": "زمانی بکار می‌برند که غذا یا هرچیزی بویی شبیه به ماهی دارد"},
  {"text": "از سرما سیاه نشی", "latin": "", "desc": "به کسی می‌گویند که بیش از حد خودش را با لباس پوشیده است"},
  {"text": "قیچی به هم زدن", "latin": "", "desc": "نشانه از دعوا می‌دانستند"},
  {"text": "دور یکی چرخیدن", "latin": "", "desc": "نشانه‌ای از اتفاق بد برای شخص می‌دانستند"},
  {"text": "کفشا اگر برعکس می‌افتاده", "latin": "", "desc": "می‌گفتند اتفاق بد می‌افتد یا یک نفر از بین می‌رود"},
  {"text": "کفشا اگر روبروی هم می‌افتاده", "latin": "", "desc": "کنایه از یک نفر دوست داشتنی می‌آید برای احوالپرسی"},
  {"text": "قلپاش باد داره", "latin": "", "desc": "کنایه از پز دادن"},
  {"text": "کاه از خودت بود کاهدون از خودت نبود", "latin": "", "desc": "به کسی می‌گویند که در خوردن زیاده‌روی می‌کند"},
  {"text": "همچی از آدمیزاد بهتره", "latin": "", "desc": "کنایه از فانی بودن آدمیزاد - کاه رو دیوار می‌مونه آدمیزاد می‌میره"},
  {"text": "کولی را گفتند خوشومد تبرشا ورداست پیش آمد", "latin": "", "desc": "کنایه از رو دادن به کسی و سوء استفاده کردن"},
  {"text": "کرمت خوابید", "latin": "", "desc": "به کسی می‌گویند که اذیت می‌کند"},
  {"text": "کرمت بیفته", "latin": "", "desc": "کنایه از بی‌خیال شدن"},
  {"text": "عروس مردنی گردن مادر شوهر", "latin": "", "desc": "کنایه از عروسی که همیشه مریض است"},
  {"text": "اوسار روی پشتش افتاده", "latin": "", "desc": "به کسی می‌گویند که بدون اجازه کاری می‌کند"},
  {"text": "پوزشا نشسته", "latin": "", "desc": "کنایه از اینکه صورتش را نشسته است"},
  {"text": "صورتشا سگ بخوره سیر میشه", "latin": "", "desc": "به بچه‌ای که صورتش خیلی کثیف است"},
  {"text": "به شتر گفتند که چرا شاشت پسه گفته ای بابا جون چچیم مثل همه کسه", "latin": "", "desc": "کنایه از متفاوت بودن"},
  {"text": "اگر جارو صدا کرد دختر هم صدا می‌دهد", "latin": "", "desc": "کنایه از حجب و حیا"},
  {"text": "اگر خاک از دیوار ته بریزه صدا از این هم درمیاد", "latin": "", "desc": "کنایه از بی‌سر و صدا بودن"},
  {"text": "بعد هرگز", "latin": "", "desc": "زمانی بکار می‌برند که شخص بعد از مدت طولانی آمده باشد"},
  {"text": "پروا تا ندارم", "latin": "", "desc": "کنایه از بی‌حوصلگی"},
  {"text": "در را چهارتا انداختی", "latin": "", "desc": "کنایه از اینکه در را بیش از اندازه باز گذاشتی"},
  {"text": "یتیم غریده", "latin": "", "desc": "به شخص مظلوم می‌گویند"},
  {"text": "یه پا بزن", "latin": "", "desc": "کنایه از اینکه کمی صبر کن و بعد برو"},
  {"text": "رو دلم می دُوَّه", "latin": "", "desc": "کنایه از اینکه حالت تهوع می گیریم (صبح که با شکم ناشتا چایی بخوری حالت تهوع می گیری میگویند نه نمی خوام رو دلم می دُوَّه)"},
  {"text": "بِزّی شدم", "latin": "", "desc": "کنایه از اینکه بدم اومد"},
  {"text": "تو این هُر وبُر چاقو بیار چُر ببر", "latin": "", "desc": "یعنی تو این شلوغی وقت گیر آوردی ( چرببر یعنی ختنه کردن )"},
  {"text": "تیر دلت کن", "latin": "", "desc": "یعنی کوفتت کن"},
  {"text": "شالله به داغ دلم بری", "latin": "", "desc": "کنایه از اینکه بمیری"},
  {"text": "شالله جونمرگ شی", "latin": "", "desc": "کنایه از اینکه جوان مرگ بشوی"},
  {"text": "مرغ هرجا تمیزه میشاشه", "latin": "", "desc": "کنایه از اینکه همه جا را کثیف می کنی"},
  {"text": "کاسه همسایه دوتا راه داره", "latin": "", "desc": "کنایه از جبران زحمات"},
  {"text": "تیر به چشم شیطون زده", "latin": "", "desc": "کنایه از اینکه کار شاقی کرده"},
  {"text": "با چیز کسی نکن جحونی، پست می‌گیرند خجل می‌میونی", "latin": "", "desc": "کنایه از اینکه با مال و وسایل مردم باید مدارا کرد و درست و با ملایمت برخورد کرد. اگر با وسایل دیگران بدرفتاری و شوخی کنی (جحونی)، روزی که مجبور شوی آن چیزرا پس بدهی(پست می‌گیرند)، خجالت می‌کشی و شرمنده می‌شوی (خجل می‌میونی). یعنی با مال مردم مهربان باش تا اگر روزی از تو خواستند پس بگیرند شرمنده نشوی."},
  {"text": "مار از پونه بدش میاد", "latin": "", "desc": "کنایه از اینکه کسی از دیگری بدش می‌آید و هر جا برود، طرف مقابل را می‌بیند و مجبور می‌شود فرار کند (مار=شخص بدبین، پونه=شخص مورد تنفر)"},
  {"text": "نامرد کسیه که مار را می‌کشد ولی زیرش نمی‌کند", "latin": "", "desc": "کنایه از اینکه انسان نامرد کسی است که کار نیمه‌تمام انجام می‌دهد و کار را به سرانجام نمی‌رساند (زیر خاک کردن مار نشانه تمام‌کننده کار است)"},
  {"text": "گفتند کوری بهتر یا کری، گفت صحرا کتری خونه قوری", "latin": "", "desc": "کنایه از اینکه هر کسی به فکر منافع خودش است و برای خودش بهترین را انتخاب می‌کند. یعنی اگر از کسی بپرسی کوری بهتر است یا کری، آن کس که در خانه است قوری را انتخاب می کند و آن کسی که در صحراست کتری را انتخاب می کند  چون برایش راحت تر است !"},
  {"text": "خر مردم را یک وری باید سوار شد هر جا گفتند بجیم‌پایین", "latin": "", "desc": "کنایه از اینکه آدم باید با مردم مدارا کند و با شرایط و خواسته‌های آنها کنار بیاید، حتی اگر منطقی نباشد. یعنی مثل سوار شدن بر خر مردم که باید مطابق میل آنها رفتار کرد."},
  {"text": "دود پیش آدم پولدار میره", "latin": "", "desc": "کنایه از اینکه منفعت و سود همیشه به سمت افراد ثروتمند و قدرتمند می‌رود. در هر معامله یا کاری، نفع اصلی به کسانی می‌رسد که از قبل پول و قدرت دارند، مثل دود که همیشه به سمت بالا می‌رود."},
  {"text": "پیر مثل کل ذرت است و جوان مثل کنده بادام", "latin": "", "desc": "کنایه از اینکه افراد پیر مانند کل ذرت، پخته، شیرین و پربرکت هستند و هر چه از آنها برداشت کنی باز هم برکت دارند. اما افراد جوان مانند کنده بادام، سخت، نرمش‌ناپذیر و بی‌ثمر هستند و باید صبر کرد تا مانند درخت بادام، بارور و پربار شوند."},
  {"text": "آب دونتون اینقدره نون دونتون چقدره", "latin": "", "desc": "کنایه از افرادی که در خوردن زیاده‌روی می‌کنند و حرص و ولع زیادی برای خوردن دارند. یعنی تو که آب را به این اندازه می‌خوری، پس نان را چقدر می‌خواهی بخوری؟ این ضرب‌المثل به کسانی گفته می‌شود که در غذا خوردن زیاده‌روی می‌کنند و هیچ حد و مرزی برای خوردن ندارند."},
];

class ProverbsListPage extends StatefulWidget {
  const ProverbsListPage({Key? key}) : super(key: key);

  @override
  State<ProverbsListPage> createState() => _ProverbsListPageState();
}

class _ProverbsListPageState extends State<ProverbsListPage> {
  late List<Proverb> allProverbs;
  List<Proverb> filteredProverbs = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  // ==================== تابع حذف اعراب ====================
  String _removeDiacritics(String text) {
    const diacritics = {
      'َ': '',
      'ِ': '',
      'ُ': '',
      'ً': '',
      'ٍ': '',
      'ٌ': '',
      'ّ': '',
      'ْ': '',
      'ٓ': '',
      'ٰ': '',
      'ٔ': '',
      'ٕ': '',
    };
    String result = text;
    diacritics.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  // ==================== تابع بررسی وجود زیررشته بدون اعراب ====================
  bool _containsWithoutDiacritics(String text, String query) {
    return _removeDiacritics(text).contains(_removeDiacritics(query));
  }

  @override
  void initState() {
    super.initState();
    allProverbs = rawData.map((map) => Proverb.fromMap(map)).toList();
    allProverbs.sort((a, b) => a.text.compareTo(b.text));
    filteredProverbs = List.from(allProverbs);
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      searchQuery = searchController.text.trim();
      if (searchQuery.isEmpty) {
        filteredProverbs = List.from(allProverbs);
      } else {
        filteredProverbs = allProverbs.where((proverb) {
          return _containsWithoutDiacritics(proverb.text, searchQuery) ||
              _containsWithoutDiacritics(proverb.desc, searchQuery);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ضرب‌المثل‌ها و کنایه‌ها"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "جستجوی ضرب‌المثل یا مفهوم...",
                hintTextDirection: TextDirection.rtl,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: filteredProverbs.isEmpty
          ? const Center(
              child: Text("نتیجه‌ای یافت نشد"),
            )
          : ListView.builder(
              itemCount: filteredProverbs.length,
              itemBuilder: (context, index) {
                final proverb = filteredProverbs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    text: _buildHighlightedText(proverb),
                  ),
                );
              },
            ),
    );
  }

  TextSpan _buildHighlightedText(Proverb proverb) {
    List<InlineSpan> children = [];

    // ===== ضرب‌المثل با رنگ قرمز (با هایلایت زرد در صورت جستجو) =====
    if (searchQuery.isNotEmpty && _containsWithoutDiacritics(proverb.text, searchQuery)) {
      final query = searchQuery;
      final textStr = proverb.text;
      final textWithoutDiacritics = _removeDiacritics(textStr);
      final queryWithoutDiacritics = _removeDiacritics(query);

      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < textWithoutDiacritics.length) {
        int index = textWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
        if (index == -1) break;
        indices.add(index);
        startIndex = index + queryWithoutDiacritics.length;
      }

      int lastIndex = 0;
      for (int idx in indices) {
        if (idx > lastIndex) {
          children.add(
            TextSpan(
              text: textStr.substring(lastIndex, idx),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          );
        }
        children.add(
          TextSpan(
            text: textStr.substring(idx, idx + query.length),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
              backgroundColor: Colors.yellow,
            ),
          ),
        );
        lastIndex = idx + query.length;
      }
      if (lastIndex < textStr.length) {
        children.add(
          TextSpan(
            text: textStr.substring(lastIndex),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        );
      }
    } else {
      children.add(
        TextSpan(
          text: "${proverb.text} ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 16,
          ),
        ),
      );
    }

    // ===== لاتین داخل پرانتز با رنگ آبی =====
    if (proverb.latin.isNotEmpty) {
      children.add(
        TextSpan(
          text: " (${proverb.latin})",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
      );
    }

    children.add(const TextSpan(text: ": "));

    // ===== توضیحات (با هایلایت زرد در صورت جستجو) =====
    if (searchQuery.isNotEmpty && _containsWithoutDiacritics(proverb.desc, searchQuery)) {
      final query = searchQuery;
      final descStr = proverb.desc;
      final descWithoutDiacritics = _removeDiacritics(descStr);
      final queryWithoutDiacritics = _removeDiacritics(query);

      List<int> indices = [];
      int startIndex = 0;
      while (startIndex < descWithoutDiacritics.length) {
        int index = descWithoutDiacritics.indexOf(queryWithoutDiacritics, startIndex);
        if (index == -1) break;
        indices.add(index);
        startIndex = index + queryWithoutDiacritics.length;
      }

      int lastIndex = 0;
      for (int idx in indices) {
        if (idx > lastIndex) {
          children.add(
            TextSpan(
              text: descStr.substring(lastIndex, idx),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          );
        }
        children.add(
          TextSpan(
            text: descStr.substring(idx, idx + query.length),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              backgroundColor: Colors.yellow,
            ),
          ),
        );
        lastIndex = idx + query.length;
      }
      if (lastIndex < descStr.length) {
        children.add(
          TextSpan(
            text: descStr.substring(lastIndex),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        );
      }
    } else {
      children.add(
        TextSpan(
          text: proverb.desc,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      );
    }

    return TextSpan(children: children);
  }
}