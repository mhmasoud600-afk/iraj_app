import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  State<PrayerTimesPage> createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final int cityId = 3427;
  final int timeOffset = 1;

  final List<String> offsetTimes = [
    "اذان صبح",
    "اذان ظهر",
    "غروب آفتاب",
    "اذان مغرب",
    "نیمه شب",
  ];

  Map<String, String> times = {};
  bool loading = true;
  bool isRefreshing = false;
  String errorMessage = '';
  int zikrCounter = 0;

  // کلیدهای کش
  final String cacheKey = "prayer_times_cache";
  final String cacheDateKey = "prayer_times_date";

  // آیکون‌های زیبا برای هر زمان
  final Map<String, IconData> timeIcons = {
    "اذان صبح": Icons.wb_twilight,
    "طلوع آفتاب": Icons.wb_sunny,
    "اذان ظهر": Icons.sunny,
    "غروب آفتاب": Icons.nights_stay,
    "اذان مغرب": Icons.nightlight_round,
    "نیمه شب": Icons.nightlight,
  };

  // رنگ‌های جذاب برای هر زمان
  final Map<String, Color> timeColors = {
    "اذان صبح": const Color(0xFF6C5CE7),
    "طلوع آفتاب": const Color(0xFFFDCB6E),
    "اذان ظهر": const Color(0xFFE17055),
    "غروب آفتاب": const Color(0xFF6C5CE7),
    "اذان مغرب": const Color(0xFF2D3436),
    "نیمه شب": const Color(0xFF0984E3),
  };

  @override
  void initState() {
    super.initState();
    _loadFromCache();
  }

  // بارگذاری از کش
  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(cacheKey);
    final cachedDate = prefs.getString(cacheDateKey);

    final today = _getTodayKey();

    // اگر کش موجود باشد و مربوط به امروز باشد
    if (cachedData != null && cachedDate == today) {
      final data = jsonDecode(cachedData) as Map<String, dynamic>;
      setState(() {
        times = Map<String, String>.from(data);
        loading = false;
      });
      return;
    }

    // در غیر این صورت از اینترنت دریافت کن
    await fetchTimes();
  }

  // دریافت کلید تاریخ برای کش
  String _getTodayKey() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  // ذخیره در کش
  Future<void> _saveToCache(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cacheKey, jsonEncode(data));
    await prefs.setString(cacheDateKey, _getTodayKey());
  }

  Future<void> fetchTimes() async {
    setState(() {
      isRefreshing = true;
      errorMessage = '';
    });

    try {
      final url = "http://prayer.aviny.com/api/prayertimes/$cityId";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data["Imsaak"] != null) {
          Map<String, String> t = {
            "اذان صبح": data["Imsaak"] ?? "",
            "طلوع آفتاب": data["Sunrise"] ?? "",
            "اذان ظهر": data["Noon"] ?? "",
            "غروب آفتاب": data["Sunset"] ?? "",
            "اذان مغرب": data["Maghreb"] ?? "",
            "نیمه شب": data["Midnight"] ?? "",
          };

          final result = applyOffset(t, timeOffset);
          
          // ذخیره در کش
          await _saveToCache(result);

          setState(() {
            times = result;
            loading = false;
            isRefreshing = false;
          });
        } else {
          setState(() {
            loading = false;
            isRefreshing = false;
            errorMessage = 'داده‌ای دریافت نشد';
          });
        }
      } else {
        setState(() {
          loading = false;
          isRefreshing = false;
          errorMessage = 'خطا در دریافت داده‌ها';
        });
      }
    } catch (e) {
      // اگر اینترنت نبود و کش وجود داشت، از کش استفاده کن
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(cacheKey);
      
      if (cachedData != null) {
        final data = jsonDecode(cachedData) as Map<String, dynamic>;
        setState(() {
          times = Map<String, String>.from(data);
          loading = false;
          isRefreshing = false;
          errorMessage = 'اتصال اینترنت برقرار نیست - نمایش داده‌های ذخیره شده';
        });
      } else {
        setState(() {
          loading = false;
          isRefreshing = false;
          errorMessage = 'خطا در اتصال به سرور';
        });
      }
    }
  }

  Map<String, String> applyOffset(Map<String, String> input, int offsetMinutes) {
    Map<String, String> result = {};

    input.forEach((key, value) {
      if (value.isEmpty) {
        result[key] = "";
        return;
      }

      final parts = value.split(":");
      if (parts.length < 2) {
        result[key] = value;
        return;
      }

      int h = int.parse(parts[0]);
      int m = int.parse(parts[1]);

      if (offsetTimes.contains(key)) {
        m += offsetMinutes;
        if (m >= 60) {
          h++;
          m -= 60;
        }
        if (h >= 24) {
          h -= 24;
        }
      }

      result[key] = "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}";
    });

    return result;
  }

  String toPersianNumber(String input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    for (int i = 0; i < en.length; i++) {
      input = input.replaceAll(en[i], fa[i]);
    }
    return input;
  }

  // اصلاح نمایش تاریخ به فرمت "یکشنبه 31 خرداد 1405"
  String getPersianDateDisplay() {
    final now = DateTime.now();
    final j = Gregorian(now.year, now.month, now.day).toJalali();
    
    const months = [
      "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور",
      "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند"
    ];

    final weekday = getWeekdayName();
    final day = toPersianNumber(j.day.toString());
    final month = months[j.month - 1];
    final year = toPersianNumber(j.year.toString());

    // ترتیب صحیح: روز هفته، روز، ماه، سال
    return "$weekday $day $month $year";
  }

  String getWeekdayName() {
    switch (DateTime.now().weekday) {
      case 6: return "شنبه";
      case 7: return "یکشنبه";
      case 1: return "دوشنبه";
      case 2: return "سه‌شنبه";
      case 3: return "چهارشنبه";
      case 4: return "پنجشنبه";
      case 5: return "جمعه";
      default: return "";
    }
  }

  Map<String, String> getZikr() {
    switch (DateTime.now().weekday) {
      case 1: return {"text": "یا قاضی الحاجات (۱۰۰ مرتبه)", "meaning": "ای برآورنده حاجت‌ها"};
      case 2: return {"text": "یا ارحم الراحمین (۱۰۰ مرتبه)", "meaning": "ای مهربان‌ترین مهربانان"};
      case 3: return {"text": "یا حی یا قیوم (۱۰۰ مرتبه)", "meaning": "ای زنده و ای پایدار"};
      case 4: return {"text": "لا إِلهَ إِلَّا اللَّهُ المَلِک الحقّ المُبین (۱۰۰ مرتبه)", "meaning": "معبودی جز خدا نیست سلطان حق و آشکار"};
      case 5: return {"text": "الّلهُمَّ صَلِّ عَلَی مُحَمَّدٍ وَآلِ مُحَمَّدٍ و عجل فرجهم (۱۰۰ مرتبه)", "meaning": "خدایا درود فرست بر محمد و خاندان او و در فرج ایشان تعجیل بفرما"};
      case 6: return {"text": "یا رب العالمین (۱۰۰ مرتبه)", "meaning": "ای پروردگار جهانیان"};
      case 7: return {"text": "یا ذَالجَلالِ وَ اْلاِکْرام (۱۰۰ مرتبه)", "meaning": "ای صاحب جلالت و کرامت"};
      default: return {"text": "", "meaning": ""};
    }
  }

  Widget zikrCard() {
    final zikrData = getZikr();
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.15),
            const Color(0xFFA29BFE).withOpacity(0.15),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF6C5CE7).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mosque,
                color: const Color(0xFF6C5CE7),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "ذکر روز ${getWeekdayName()}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6C5CE7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            zikrData["text"]!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            zikrData["meaning"]!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  toPersianNumber(zikrCounter.toString()),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6C5CE7),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => setState(() => zikrCounter++),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => zikrCounter = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "ریست",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
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

  Widget timeCard(String title, String time, int index) {
    final icon = timeIcons[title] ?? Icons.access_time;
    final color = timeColors[title] ?? Colors.blue;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Text(
            toPersianNumber(time),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اوقات شرعی روستای ایراج",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actions: [
          // دکمه بروزرسانی
          IconButton(
            icon: isRefreshing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey,
                    ),
                  )
                : const Icon(Icons.refresh, color: Colors.grey),
            onPressed: isRefreshing ? null : fetchTimes,
            tooltip: 'بروزرسانی',
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xFF6C5CE7),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'دریافت اوقات شرعی...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red.shade300,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchTimes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C5CE7),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('تلاش مجدد'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // هدر تاریخ - فرمت "یکشنبه 31 خرداد 1405"
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF6C5CE7),
                              const Color(0xFFA29BFE),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C5CE7).withOpacity(0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              getPersianDateDisplay(),
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // کارت ذکر
                      zikrCard(),

                      const SizedBox(height: 16),

                      // لیست اوقات
                      ...times.entries.map((entry) {
                        final index = times.keys.toList().indexOf(entry.key);
                        return timeCard(entry.key, entry.value, index);
                      }).toList(),

                      const SizedBox(height: 12),

                      // فوتر
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'دقت محاسبات ۳± دقیقه',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.cloud_done,
                              size: 14,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'ذخیره شده در کش',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}