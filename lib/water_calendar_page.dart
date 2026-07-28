// lib/water_calendar_page.dart
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../mixins/searchable_mixin.dart'; // اضافه شد

class WaterInfoBox extends StatefulWidget {
  const WaterInfoBox({super.key});

  @override
  State<WaterInfoBox> createState() => _WaterInfoBoxState();
}

class _WaterInfoBoxState extends State<WaterInfoBox> {
  bool expanded = false;

  final String fullText =
      "آب ایراج از چشمه‌های روستا سرچشمه می‌شود و در گردش ۱۶ روز بین مردم تقسیم شده است و برای کشاورزی استفاده می‌شود. "
      "آب در جوی‌های سیمانی جریان دارد و هر شخص طبق نوبت خود به محلی که «فنجوون دونو» نام دارد مراجعه و پس از تنظیم ساعت خود براساس میزان آبی که دارد «وار» یا «گورگاه» خود را تغییر می‌دهد و پس از ایشان نوبت نفر بعدی است که آب را ببندد و زمین‌های خود را آبیاری کند.\n\n"
      "گردش آب ۱۶ روز است و هر روز ۲۴ ساعت که هر ۱۲ دقیقه را یک «فنجون» می‌گویند. کل میزان آب ایراج در گردش ۱۶ روزه ۱۹۲۰ فنجون است. "
      "مثلاً شخصی که ۵ فنجون آب دارد، ۶۰ دقیقه باید آب را ببندد و زمین‌های خود را آبیاری کند. ساعت بستن آب به صورت گردشی بین افرادی که در آن ۲۴ ساعت مالک آب هستند تغییر می‌کند.\n\n"
      "هر ۲۴ ساعت آب که به یکی از اسامی زیر نامگذاری شده است، از ۶ صبح تا ۶ صبح روز بعد می‌باشد:\n"
      "مسجد، حاج ممدون، حاج میرزائون، بندگون، جلالن، آروون، مدقاسمون، حسنیون، روحیون، قاسمون، حنسنون، جلالون، خجه، علی شوون، خجه ممدون، نوردیننون\n"
      "در قدیم که هنوز ساعت نبود روزها یک سنگ در جایی قرار داده بودند که نشانه هایی کنار آن داشت\n"
      "این سنگ به سنگ نیمروز معروف بود که از روی نشانه ها و سایه آن متوجه تغییر زمان می شدند\n"
      "و نسبت به بستن آب اقدام می کردند در شب چون آفتاب نبود یک دیگ پر از آب بود\n"
      "و یک تاس که سوراخ کوچک و زائده ای داشت که هر ۶ دقیقه، آن تاس پر از آب می شد\n"
      "و به ته دیگ می رفت و به ازای هر بار که این اتفاق می افتاد یک سنگ کنار می گذاشتند \n"
      "و مثلا کسی که ۵ فنجان آب داشت یعنی به ساعت الان یکساعت باید آبیاری می کرد \n"
      "که ۱۰ تاس می شد و ده سنگ کنار گذاشته می شد و نفر بعدی که باید آب را می بست و یک نفر نماینده کسی که الان آبیاری می کرد سر دیگ حضور داشتند ";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              fullText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 13,
                height: 1.6,
                fontFamily: "Vazir",
              ),
            ),
            secondChild: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: SingleChildScrollView(
                child: Text(
                  fullText,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.6,
                    fontFamily: "Vazir",
                  ),
                ),
              ),
            ),
            crossFadeState:
                expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Text(
              expanded ? "بستن توضیحات ▲" : "اطلاعات بیشتر ▼",
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Vazir",
                color: Colors.teal.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WaterCalendarPage extends StatefulWidget {
  const WaterCalendarPage({super.key});

  @override
  State<WaterCalendarPage> createState() => _WaterCalendarPageState();
}

class _WaterCalendarPageState extends State<WaterCalendarPage> 
    with AutomaticKeepAliveClientMixin, SearchableMixin {
  
  @override
  bool get wantKeepAlive => true;

  // ============================================================
  // پیاده‌سازی متدهای SearchableMixin
  // ============================================================
  @override
  String get pageTitle => 'تقویم گردش آب';
  
  @override
  String get pageSubtitle => 'تقویم و زمان‌بندی گردش آب در قنات‌ها';
  
  @override
  String get pageCategory => 'طبیعت';
  
  @override
  IconData get pageIcon => Icons.calendar_today;
  
  @override
  Widget get pageWidget => const WaterCalendarPage();

  @override
  String getSearchText() {
    // ============================================================
    // جمع‌آوری تمام متن‌های قابل جستجو
    // ============================================================
    StringBuffer fullText = StringBuffer();
    fullText.writeln('تقویم گردش آب روستای ایراج:');
    fullText.writeln();
    
    fullText.writeln('نام‌های روزهای گردش آب (۱۶ روزه):');
    for (var name in waterNames) {
      fullText.writeln('• $name');
    }
    fullText.writeln();
    
    fullText.writeln('توضیحات کامل گردش آب:');
    fullText.writeln(_infoText);
    fullText.writeln();
    
    fullText.writeln('اطلاعات کامل آب ایراج:');
    fullText.writeln('''
آب ایراج از چشمه‌های روستا سرچشمه می‌شود و در گردش ۱۶ روز بین مردم تقسیم شده است.
گردش آب ۱۶ روز است و هر روز ۲۴ ساعت که هر ۱۲ دقیقه را یک «فنجون» می‌گویند.
کل میزان آب ایراج در گردش ۱۶ روزه ۱۹۲۰ فنجون است.
هر ۲۴ ساعت آب به یکی از اسامی زیر نامگذاری شده است:
مسجد، حاج ممدون، حاج میرزائون، بندگون، جلالن، آروون، مدقاسمون، حسنیون، روحیون، قاسمون، حنسنون، جلالون، خجه، علی شوون، خجه ممدون، نوردیننون
''');
    
    fullText.writeln('سنگ نیمروز و روش‌های قدیمی اندازه‌گیری زمان:');
    fullText.writeln('''
در قدیم که هنوز ساعت نبود، سنگ نیمروز برای تشخیص زمان استفاده می‌شد.
در شب از دیگ آب و تاس برای اندازه‌گیری زمان استفاده می‌کردند.
هر ۶ دقیقه یک بار تاس پر از آب می‌شد و به ته دیگ می‌رفت.
به ازای هر بار یک سنگ کنار می‌گذاشتند.
''');
    
    return fullText.toString();
  }

  @override
  void initState() {
    super.initState();
    _initializeDates();
    _loadSavedSlots();
    registerForSearch();
  }

  @override
  void dispose() {
    unregisterFromSearch();
    super.dispose();
  }

  late Jalali currentJalali;
  late Jalali selectedJalali;

  final Jalali anchorJalali = Jalali(1404, 10, 2);
  final int anchorWaterIndex = 6;

  final List<String> waterNames = const [
    "مسجد",
    "حاج ممدون",
    "حاج میرزائون",
    "بندگون",
    "جلالن",
    "آروون",
    "مدقاسمون",
    "حسنیون",
    "روحیون",
    "قاسمون",
    "حنسنون",
    "جلالون",
    "خجه",
    "علی شوون",
    "خجه ممدون",
    "نوردیننون",
  ];

  final List<String> weekDays = const [
    "شنبه",
    "یکشنبه",
    "دوشنبه",
    "سه‌شنبه",
    "چهارشنبه",
    "پنجشنبه",
    "جمعه",
  ];

  final Map<String, Color> waterColors = const {
    "مسجد": Colors.blue,
    "حاج ممدون": Colors.green,
    "حاج میرزائون": Colors.orange,
    "بندگون": Colors.purple,
    "جلالن": Colors.red,
    "آروون": Colors.teal,
    "مدقاسمون": Colors.indigo,
    "حسنیون": Colors.brown,
    "روحیون": Colors.cyan,
    "قاسمون": Colors.deepOrange,
    "حنسنون": Colors.lightGreen,
    "جلالون": Colors.pink,
    "خجه": Colors.amber,
    "علی شوون": Colors.deepPurple,
    "خجه ممدون": Colors.lime,
    "نوردیننون": Colors.blueGrey,
  };

  final List<String> timeSlots = const [
    "ساعت ۶ صبح تا ۱۲ ظهر",
    "ساعت ۱۲ ظهر تا ۶ عصر",
    "ساعت ۶ عصر تا ۱۲ شب",
    "ساعت ۱۲ شب تا ۶ صبح",
  ];

  final List<Color> slotColors = const [
    Colors.lightBlue,
    Colors.orange,
    Colors.purple,
    Colors.green,
  ];

  Map<String, int> savedSlots = {};
  bool loading = true;

  final String _infoText = 
      "برای استفاده کامل از تقویم گردش آب ، بر روی تاریخ مورد نظر خود که بنام آب کشاورزی خودتان است بزنید. "
      "پنجره ای باز می شود که در آن چهار کادر رنگ مشخص شده است که 4 بازه 6 ساعته می باشد. "
      "توضیح اینکه در گردش آب ایراج علاوه بر گردش 16 روزه گردش 6 ساعته نیز وجود دارد. "
      "یعنی اگر شخصی امروز در بازه 6 صبح تا 12 ظهر آبیاری کند در گردش 16 روزه بعد باید 6 بعد از ظهر تا 12 شب آبیاری کند و گردش 16 روزه بعدی 12 ظهر تا 6 عصر و گردش بعدی 16 روزه باید 12 شب تا 6 صبح روز بعد آبیاری کند. "
      "حال در برنامه وقتی زمان آبیاری فعلی را مشخص کنید اتوماتیک تا 50 سال آینده گردش درست آب شما با رنگ آن مشخص می شود.";

  void _initializeDates() {
    try {
      currentJalali = Jalali.now();
      selectedJalali = Jalali.now();
    } catch (e) {
      currentJalali = Jalali(1404, 10, 1);
      selectedJalali = Jalali(1404, 10, 1);
    }
  }

  Future<void> _loadSavedSlots() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final Map<String, int> map = {};
      
      for (var k in keys) {
        try {
          final v = prefs.getInt(k);
          if (v != null) map[k] = v;
        } catch (e) {
          continue;
        }
      }
      
      if (mounted) {
        setState(() {
          savedSlots = map;
          loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> _clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      if (mounted) {
        setState(() {
          savedSlots = {};
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('کش برنامه با موفقیت پاک شد', textDirection: TextDirection.rtl),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطا در پاک کردن کش: $e', textDirection: TextDirection.rtl),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveSlot(Jalali jDate, int slot) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String key = "${jDate.year}-${jDate.month.toString().padLeft(2, '0')}-${jDate.day.toString().padLeft(2, '0')}";
      await prefs.setInt(key, slot);
      
      if (mounted) {
        setState(() {
          savedSlots[key] = slot;
        });
      }
    } catch (e) {
      print('خطا در ذخیره‌سازی: $e');
    }
  }

  String getWaterName(Jalali j) {
    try {
      final int diffDays = j.distanceFrom(anchorJalali);
      final int index = ((anchorWaterIndex + diffDays) % waterNames.length + waterNames.length) % waterNames.length;
      return waterNames[index];
    } catch (e) {
      return "نامشخص";
    }
  }

  String _toPersianNumber(int number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    String output = number.toString();
    for (int i = 0; i < english.length; i++) {
      output = output.replaceAll(english[i], farsi[i]);
    }
    return output;
  }

  String getWeekdayName(Jalali date) {
    try {
      return weekDays[date.weekDay - 1];
    } catch (e) {
      return "";
    }
  }

  int? getSlotForDate(Jalali date) {
    if (savedSlots.isEmpty) return null;

    try {
      final String waterToday = getWaterName(date);
      
      final List<List<int>> transitionMatrix = [
        [0, 2, 1, 3],
        [1, 3, 0, 2],
        [2, 1, 3, 0],
        [3, 0, 2, 1],
      ];

      for (var entry in savedSlots.entries) {
        final key = entry.key;
        final baseSlot = entry.value;

        final parts = key.split('-');
        if (parts.length != 3) continue;
        
        final y = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        final d = int.tryParse(parts[2]);
        if (y == null || m == null || d == null) continue;

        Jalali baseDate;
        try {
          baseDate = Jalali(y, m, d);
        } catch (_) {
          continue;
        }

        if (getWaterName(baseDate) != waterToday) continue;

        try {
          int diff = date.distanceFrom(baseDate);
          if (diff < 0) continue;
          if (diff % 16 != 0) continue;

          final int n = diff ~/ 16;
          final int cycleIndex = n % 4;
          return transitionMatrix[baseSlot][cycleIndex];
        } catch (_) {
          continue;
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  void _goToNextMonth() {
    setState(() {
      int newYear = currentJalali.year;
      int newMonth = currentJalali.month + 1;
      
      if (newMonth > 12) {
        newYear++;
        newMonth = 1;
      }
      
      currentJalali = Jalali(newYear, newMonth, 1);
      
      try {
        Jalali(newYear, newMonth, selectedJalali.day);
        selectedJalali = Jalali(newYear, newMonth, selectedJalali.day);
      } catch (e) {
        selectedJalali = Jalali(newYear, newMonth, 1);
      }
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      int newYear = currentJalali.year;
      int newMonth = currentJalali.month - 1;
      
      if (newMonth < 1) {
        newYear--;
        newMonth = 12;
      }
      
      currentJalali = Jalali(newYear, newMonth, 1);
      
      try {
        Jalali(newYear, newMonth, selectedJalali.day);
        selectedJalali = Jalali(newYear, newMonth, selectedJalali.day);
      } catch (e) {
        selectedJalali = Jalali(newYear, newMonth, 1);
      }
    });
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal.shade700),
              const SizedBox(width: 8),
              const Text(
                'راهنمای تقویم گردش آب',
                style: TextStyle(fontFamily: "Vazir", fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Text(
                _infoText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Vazir",
                  height: 1.8,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'متوجه شدم',
                style: TextStyle(fontFamily: "Vazir", fontSize: 14),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (loading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                "در حال بارگذاری تقویم آب...",
                style: TextStyle(fontFamily: "Vazir"),
              ),
            ],
          ),
        ),
      );
    }

    try {
      final int daysInMonth = currentJalali.monthLength;
      final int startWeekday = currentJalali.copy(day: 1).weekDay - 1;
      final int totalCells = ((daysInMonth + startWeekday) / 7).ceil() * 7;

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "تقویم آب ایراج",
            style: TextStyle(fontSize: 16, fontFamily: "Vazir"),
          ),
          actions: [
            // دکمه راهنما
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade300.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _showInfoDialog,
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'راهنما',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // دکمه پاک کردن
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.red.shade600,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.shade300.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text(
                          'تأیید پاک کردن',
                          style: TextStyle(fontFamily: "Vazir", fontSize: 16),
                        ),
                        content: const Text(
                          'آیا مطمئن هستید که می‌خواهید تمام داده‌های ذخیره‌شده تقویم را پاک کنید؟',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontFamily: "Vazir", fontSize: 14),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'انصراف',
                              style: TextStyle(fontFamily: "Vazir", fontSize: 14),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _clearAllCache();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text(
                              'پاک کردن',
                              style: TextStyle(fontFamily: "Vazir", fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'پاک کردن',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              if (details.primaryVelocity! > 0) {
                _goToPreviousMonth();
              } else if (details.primaryVelocity! < 0) {
                _goToNextMonth();
              }
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _goToNextMonth,
                  ),
                  Column(
                    children: [
                      Text(
                        "${currentJalali.formatter.mN} ${_toPersianNumber(currentJalali.year)}",
                        style: const TextStyle(fontSize: 22, fontFamily: "Vazir"),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          _toPersianNumber(selectedJalali.day),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Vazir",
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _goToPreviousMonth,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const WaterInfoBox(),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          weekDays[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontFamily: "Vazir",
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: GridView.builder(
                  key: ValueKey('${currentJalali.year}-${currentJalali.month}'),
                  itemCount: totalCells,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    if (index < startWeekday || index >= daysInMonth + startWeekday) {
                      return const SizedBox.shrink();
                    }

                    final int dayNumber = index - startWeekday + 1;
                    final Jalali jDate = currentJalali.copy(day: dayNumber);
                    final String waterName = getWaterName(jDate);
                    final String weekdayName = getWeekdayName(jDate);

                    final bool isSelected = jDate.year == selectedJalali.year &&
                        jDate.month == selectedJalali.month &&
                        jDate.day == selectedJalali.day;

                    final int? slotIndex = getSlotForDate(jDate);
                    final Color? slotColor = slotIndex != null ? slotColors[slotIndex] : null;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedJalali = jDate;
                        });
                        _showDateDialog(jDate, waterName, weekdayName, slotIndex);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: slotColor ?? (isSelected ? (waterColors[waterName] ?? Colors.white) : Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: (waterColors[waterName] ?? Colors.teal).withOpacity(0.7),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _toPersianNumber(dayNumber),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Vazir",
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                waterName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Vazir",
                                  color: isSelected ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'خطا در نمایش تقویم: $e',
                style: const TextStyle(fontFamily: "Vazir", color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _initializeDates();
                  });
                },
                child: const Text(
                  "تلاش مجدد",
                  style: TextStyle(fontFamily: "Vazir"),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _showDateDialog(Jalali jDate, String waterName, String weekdayName, int? slotIndex) {
    final String sStr = "${_toPersianNumber(jDate.day)} ${jDate.formatter.mN} ${_toPersianNumber(jDate.year)} - $weekdayName";
    final String? todaySlotText = slotIndex != null ? timeSlots[slotIndex] : null;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text("جزئیات روز", style: TextStyle(fontFamily: "Vazir")),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("تاریخ: $sStr", textDirection: TextDirection.rtl, style: const TextStyle(fontFamily: "Vazir")),
                const SizedBox(height: 8),
                Text("نام آب: $waterName", textDirection: TextDirection.rtl,
                  style: const TextStyle(fontFamily: "Vazir", fontWeight: FontWeight.bold, fontSize: 20, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                if (todaySlotText != null) ...[
                  const Text("امروز باید در بازهٔ زیر آبیاری کنید:", textDirection: TextDirection.rtl, style: TextStyle(fontFamily: "Vazir", fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(todaySlotText, textDirection: TextDirection.rtl,
                    style: const TextStyle(fontFamily: "Vazir", fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 16),
                ],
                const Text("انتخاب بازه آبیاری (برای ثبت امروز):", textDirection: TextDirection.rtl, style: TextStyle(fontFamily: "Vazir", fontSize: 14)),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(4, (i) {
                    return GestureDetector(
                      onDoubleTap: () async {
                        await _saveSlot(jDate, i);
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: slotColors[i].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: slotColors[i], width: 2),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(timeSlots[i], textDirection: TextDirection.rtl, textAlign: TextAlign.right,
                                style: const TextStyle(fontFamily: "Vazir", fontSize: 13),
                              ),
                            ),
                            const Text("برای ثبت دوبار لمس کنید", style: TextStyle(fontFamily: "Vazir", fontSize: 11, color: Colors.black54)),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("بستن", style: TextStyle(fontFamily: "Vazir")),
            ),
          ],
        );
      },
    );
  }
}