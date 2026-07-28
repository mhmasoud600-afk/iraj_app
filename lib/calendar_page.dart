import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'date_utils.dart';
import '../settings/app_settings.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with SettingsAwareWidget {
  int year = 1404;
  int month = 1;

  @override
  Widget build(BuildContext context) {
    final days = generateMonthCalendar(year, month);

    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "${Jalali(year, month).formatter.mN} $year",
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: settings.appBarColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          Text(
            "$year / ${jalaliToGregorianYear(year)} / ${jalaliToHijriYear(year)}",
            style: TextStyle(
              fontSize: settings.mainFontSize * 0.9,
              fontWeight: FontWeight.bold,
              fontFamily: settings.mainFontFamily,
              color: settings.mainTextColor,
            ),
          ),

          const SizedBox(height: 10),

          // روزهای هفته
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeekDayText("ش"),
              _buildWeekDayText("ی"),
              _buildWeekDayText("د"),
              _buildWeekDayText("س"),
              _buildWeekDayText("چ"),
              _buildWeekDayText("پ"),
              _buildWeekDayText("ج"),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              itemCount: days.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final day = days[index];

                if (day["shamsi"] == "") {
                  return Container();
                }

                // بررسی روزهای تعطیل یا خاص
                final isHoliday = day["name"]?.contains("جمعه") == true ||
                    day["name"]?.contains("عید") == true ||
                    day["name"]?.contains("تاسوعا") == true ||
                    day["name"]?.contains("عاشورا") == true ||
                    day["name"]?.contains("اربعین") == true ||
                    day["name"]?.contains("رحلت") == true ||
                    day["name"]?.contains("شهادت") == true ||
                    day["name"]?.contains("ولادت") == true ||
                    day["name"]?.contains("مبعث") == true;

                final isToday = day["shamsi"] == Jalali.now().day.toString() &&
                    month == Jalali.now().month &&
                    year == Jalali.now().year;

                return Container(
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isToday ? settings.primaryColor : Colors.teal,
                      width: isToday ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    color: isToday
                        ? settings.primaryColor.withOpacity(0.15)
                        : isHoliday
                            ? Colors.red.withOpacity(0.1)
                            : settings.isDarkMode
                                ? Colors.grey[850]
                                : Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day["shamsi"]!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: settings.mainFontSize * 0.75,
                          color: isToday
                              ? settings.primaryColor
                              : isHoliday
                                  ? Colors.red
                                  : settings.mainTextColor,
                          fontFamily: settings.mainFontFamily,
                        ),
                      ),
                      Text(
                        day["miladi"]!,
                        style: TextStyle(
                          fontSize: settings.mainFontSize * 0.5,
                          color: settings.mainTextColor.withOpacity(0.6),
                          fontFamily: settings.mainFontFamily,
                        ),
                      ),
                      Text(
                        day["qamari"]!,
                        style: TextStyle(
                          fontSize: settings.mainFontSize * 0.5,
                          color: settings.mainTextColor.withOpacity(0.6),
                          fontFamily: settings.mainFontFamily,
                        ),
                      ),
                      Text(
                        day["name"]!,
                        style: TextStyle(
                          fontSize: settings.mainFontSize * 0.55,
                          color: isHoliday ? Colors.red : settings.primaryColor,
                          fontFamily: settings.mainFontFamily,
                          fontWeight: isHoliday ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // دکمه‌های جابه‌جایی ماه
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
              border: Border(
                top: BorderSide(
                  color: settings.primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: settings.primaryColor,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      if (month == 12) {
                        month = 1;
                        year++;
                      } else {
                        month++;
                      }
                    });
                  },
                  tooltip: 'ماه بعد',
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: settings.primaryColor,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      if (month == 1) {
                        month = 12;
                        year--;
                      } else {
                        month--;
                      }
                    });
                  },
                  tooltip: 'ماه قبل',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDayText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: settings.mainFontSize * 0.85,
        fontWeight: FontWeight.bold,
        fontFamily: settings.mainFontFamily,
        color: settings.primaryColor,
      ),
    );
  }
}