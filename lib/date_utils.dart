import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:hijri/hijri_calendar.dart';

final List<String> waterNames = [
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
  "نوردیننون"
];

List<Map<String, String>> generateMonthCalendar(int year, int month) {
  final firstDay = Jalali(year, month, 1);
  final weekDay = firstDay.weekDay % 7;

  final daysInMonth = firstDay.monthLength;

  List<Map<String, String>> result = [];

  for (int i = 0; i < weekDay; i++) {
    result.add({"shamsi": "", "miladi": "", "qamari": "", "name": ""});
  }

  for (int d = 1; d <= daysInMonth; d++) {
    final j = Jalali(year, month, d);
    final g = j.toDateTime();
    final h = HijriCalendar.fromDate(g);

    result.add({
      "shamsi": "$d ${j.formatter.mN}",
      "miladi": DateFormat("d MMM yyyy").format(g),
      "qamari": "${h.hDay} ${h.longMonthName}",
      "name": waterNames[(d - 1) % waterNames.length],
    });
  }

  return result;
}

int jalaliToGregorianYear(int jy) {
  return Jalali(jy, 1, 1).toDateTime().year;
}

int jalaliToHijriYear(int jy) {
  final g = Jalali(jy, 1, 1).toDateTime();
  return HijriCalendar.fromDate(g).hYear;
}