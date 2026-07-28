import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';  // ← تغییر به shamsi_date

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Map current = {};
  List daily = [];

  bool loading = true;
  bool isRefreshing = false;

  // مختصات دقیق روستای ایراج (اصلاح شده)
  final lat = 33.4600;
  final lon = 54.8700;

  // کلید برای ذخیره در SharedPreferences
  final String cacheKey = "weather_cache";
  final String cacheTimeKey = "weather_time";

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  // تبدیل اعداد انگلیسی به فارسی
  String toPersianNumber(String input) {
    const english = '0123456789';
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    var output = input;
    for (int i = 0; i < english.length; i++) {
      output = output.replaceAll(english[i], persian[i]);
    }
    return output;
  }

  // دریافت تاریخ شمسی با shamsi_date
  String getPersianDate() {
    final now = DateTime.now();
    final jalali = Jalali.fromDateTime(now);  // ← تغییر به Jalali
    final weekDays = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];
    final weekDay = weekDays[now.weekday % 7];
    return '$weekDay ${jalali.day} ${_getPersianMonth(jalali.month)} ${jalali.year}';
  }

  String _getPersianMonth(int month) {
    const months = [
      'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد',
      'شهریور', 'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
    ];
    return months[month - 1];
  }

  // دریافت آیکون مناسب بر اساس دما و وضعیت آب و هوا
  IconData getWeatherIcon(double temp, double windSpeed) {
    if (temp > 35) return Icons.wb_sunny;
    if (temp > 25) return Icons.wb_cloudy;
    if (temp > 15) return Icons.cloud;
    if (temp > 5) return Icons.cloudy_snowing;
    return Icons.ac_unit;
  }

  String getWeatherDescription(double temp) {
    if (temp > 35) return 'بسیار گرم';
    if (temp > 25) return 'گرم';
    if (temp > 15) return 'معتدل';
    if (temp > 5) return 'خنک';
    return 'سرد';
  }

  // بارگذاری آب و هوا از کش یا اینترنت
  Future<void> loadWeather() async {
    final prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(cacheKey);
    final cacheTime = prefs.getInt(cacheTimeKey);

    if (cache != null && cacheTime != null) {
      final diff = DateTime.now().millisecondsSinceEpoch - cacheTime;
      if (diff < 60 * 60 * 1000) { // یک ساعت
        final data = jsonDecode(cache);
        _parseWeatherData(data);
        setState(() => loading = false);
        return;
      }
    }

    await fetchWeather();
  }

  // دریافت آب و هوا از API
  Future<void> fetchWeather() async {
    setState(() {
      isRefreshing = true;
    });

    try {
      final url =
          "https://api.open-meteo.com/v1/forecast?"
          "latitude=$lat&longitude=$lon"
          "&current_weather=true"
          "&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,windspeed_10m_max,weathercode"
          "&timezone=auto"
          "&forecast_days=7";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode != 200) {
        throw Exception('خطا در دریافت داده‌ها');
      }

      final data = jsonDecode(res.body);
      
      // ذخیره در کش
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(cacheKey, jsonEncode(data));
      prefs.setInt(cacheTimeKey, DateTime.now().millisecondsSinceEpoch);

      _parseWeatherData(data);
      
      setState(() {
        loading = false;
        isRefreshing = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        isRefreshing = false;
      });
      _showErrorDialog('خطا در دریافت اطلاعات آب و هوا');
    }
  }

  // تجزیه داده‌های دریافتی
  void _parseWeatherData(Map data) {
    current = data["current_weather"];
    daily = List.generate(
      data["daily"]["time"].length,
      (i) => {
        "date": data["daily"]["time"][i],
        "max": data["daily"]["temperature_2m_max"][i],
        "min": data["daily"]["temperature_2m_min"][i],
        "rain": data["daily"]["precipitation_sum"][i],
        "wind": data["daily"]["windspeed_10m_max"][i],
        "weathercode": data["daily"]["weathercode"]?[i] ?? 0,
      },
    );
  }

  // نمایش خطا
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطا'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('باشه'),
          ),
        ],
      ),
    );
  }

  // فرمت تاریخ میلادی به فارسی با shamsi_date
  String formatDatePersian(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final jalali = Jalali.fromDateTime(date);  // ← تغییر به Jalali
      final weekDays = ['شنبه', 'یکشنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];
      final weekDay = weekDays[date.weekday % 7];
      return '$weekDay ${jalali.day} ${_getPersianMonth(jalali.month)}';
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('در حال دریافت اطلاعات آب و هوا...'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: fetchWeather,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: isRefreshing ? null : fetchWeather,
          child: isRefreshing
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Icon(Icons.refresh),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // تاریخ شمسی
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🔄 ${isRefreshing ? 'در حال بروزرسانی...' : 'بروزرسانی: ' + _getTimeString()}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    getPersianDate(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // عنوان
            const Text(
              '🌤️ وضعیت امروز - ایراج',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 10),

            // کارت اصلی آب و هوا
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // دما با آیکون بزرگ
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          getWeatherIcon(
                            current["temperature"]?.toDouble() ?? 0,
                            current["windspeed"]?.toDouble() ?? 0,
                          ),
                          size: 48,
                          color: Colors.orange.shade700,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${toPersianNumber(current["temperature"].toString())}°C',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              getWeatherDescription(current["temperature"]?.toDouble() ?? 0),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 24),

                    // جزئیات دیگر
                    _buildDetailRow(
                      Icons.air,
                      'سرعت باد',
                      '${toPersianNumber(current["windspeed"].toString())} km/h',
                    ),
                    _buildDetailRow(
                      Icons.compass_calibration,
                      'جهت باد',
                      '${toPersianNumber(current["winddirection"].toString())}°',
                    ),
                    _buildDetailRow(
                      Icons.schedule,
                      'زمان بروزرسانی',
                      current["time"] ?? '--',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // پیش‌بینی
            const Text(
              '📅 پیش‌بینی ۵ روز آینده',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 10),

            ...daily.take(5).map((d) {
              final tempMax = d["max"]?.toDouble() ?? 0;
              final tempMin = d["min"]?.toDouble() ?? 0;
              final rain = d["rain"]?.toDouble() ?? 0;
              final wind = d["wind"]?.toDouble() ?? 0;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    getWeatherIcon((tempMax + tempMin) / 2, wind),
                    color: Colors.orange.shade700,
                  ),
                  title: Text(
                    formatDatePersian(d["date"]),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'بارش: ${toPersianNumber(rain.toStringAsFixed(1))} mm | '
                    'باد: ${toPersianNumber(wind.toStringAsFixed(1))} km/h',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Text(
                      '${toPersianNumber(tempMax.toStringAsFixed(1))}° / '
                      '${toPersianNumber(tempMin.toStringAsFixed(1))}°',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // ویجت کمکی برای نمایش جزئیات
  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 20, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // دریافت زمان بروزرسانی
  String _getTimeString() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}