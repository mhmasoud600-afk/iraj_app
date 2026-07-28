

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class WaterCalendarPage extends StatefulWidget {
const WaterCalendarPage({super.key});

@override
State<WaterCalendarPage> createState() => _WaterCalendarPageState();
}

class _WaterCalendarPageState extends State<WaterCalendarPage> {
Jalali currentJalali = Jalali.now();
Jalali selectedJalali = Jalali.now();

// 🔵 لنگر واقعی روستا: ۲ دی ۱۴۰۴ = مدقاسمون
final Jalali anchorJalali = Jalali(1404, 10, 2);
final int anchorWaterIndex = 6; // اندیس مدقاسمون

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
"نوردینون",
];

final Map<String, Color> waterColors = {
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
"نوردینون": Colors.blueGrey,
};

// 🔵 محاسبهٔ دقیق نام آب بر اساس اختلاف روز شمسی
String getWaterName(Jalali j) {
final int diffDays = j.distanceFrom(anchorJalali);
final int index = ((anchorWaterIndex + diffDays) % waterNames.length + waterNames.length) % waterNames.length;
return waterNames[index];
}

@override
Widget build(BuildContext context) {
final int daysInMonth = currentJalali.monthLength;
final int startWeekday = currentJalali.copy(day: 1).weekDay - 1;
final int totalCells = ((daysInMonth + startWeekday) / 7).ceil() * 7;

return Scaffold(
appBar: AppBar(title: const Text("تقویم گردش آب")),
body: Column(
children: [
const SizedBox(height: 10),

// 🔵 هدایت ماه‌ها
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
IconButton(
icon: const Icon(Icons.arrow_right),
onPressed: () {
setState(() {
currentJalali = currentJalali.addMonths(-1);
});
},
),
Column(
children: [
Text(
"${currentJalali.formatter.mN} ${currentJalali.year}",
style: const TextStyle(fontSize: 22, fontFamily: "Vazir"),
),
const SizedBox(height: 4),
Text(
"${selectedJalali.day} ${selectedJalali.formatter.mN} ${selectedJalali.year}",
style: const TextStyle(fontSize: 12, fontFamily: "Vazir"),
),
],
),
IconButton(
icon: const Icon(Icons.arrow_left),
onPressed: () {
setState(() {
currentJalali = currentJalali.addMonths(1);
});
},
),
],
),

const SizedBox(height: 10),

const WaterInfoBox(),

const SizedBox(height: 10),

// 🔵 روزهای هفته
Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: const [
Text("شنبه"),
Text("یکشنبه"),
Text("دوشنبه"),
Text("سه‌شنبه"),
Text("چهارشنبه"),
Text("پنج‌شنبه"),
Text("جمعه", style: TextStyle(color: Colors.red)),
],
),

const SizedBox(height: 10),


// 🔵 جدول روزها
Expanded(
child: GridView.builder(
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

final bool isSelected =
jDate.year == selectedJalali.year &&
jDate.month == selectedJalali.month &&
jDate.day == selectedJalali.day;

final Color colorForWater = waterColors[waterName] ?? Colors.teal;

return GestureDetector(
onTap: () {
setState(() {
selectedJalali = jDate;
});

final String sStr = "${jDate.day} ${jDate.formatter.mN} ${jDate.year}";

showDialog(
context: context,
builder: (_) {
return AlertDialog(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
title: const Text("جزئیات روز", style: TextStyle(fontFamily: "Vazir")),
content: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text("تاریخ شمسی: $sStr", style: const TextStyle(fontFamily: "Vazir")),
const SizedBox(height: 8),
Text(
"نام آب: $waterName",
style: const TextStyle(
fontFamily: "Vazir",
fontWeight: FontWeight.bold,
fontSize: 20,
color: Colors.teal,
),
),
],
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
},
child: Container(
margin: const EdgeInsets.all(4),
padding: const EdgeInsets.all(4),
decoration: BoxDecoration(
color: isSelected ? colorForWater : Colors.white,
borderRadius: BorderRadius.circular(10),
border: Border.all(color: colorForWater.withOpacity(0.7)),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text(
"$dayNumber",
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
);
}
}




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
"گردش آب ۱۶ روز است و هر روز ۲۴ ساعت که هر ۱۲ دقیقه را یک «فنجون» می‌گویند. کل میزان آب ایراج در گردش ۱۶ روزه ۱۹۲0 فنجون است. "
"مثلاً شخصی که ۵ فنجون آب دارد، ۶۰ دقیقه باید آب را ببندد و زمین‌های خود را آبیاری کند. ساعت بستن آب به صورت گردشی بین افرادی که در آن ۲۴ ساعت مالک آب هستند تغییر می‌کند.\n\n"
"هر ۲۴ ساعت آب که به یکی از اسامی زیر نامگذاری شده است، از ۶ صبح تا ۶ صبح روز بعد می‌باشد:\n"
"مسجد، حاج ممدون، حاج میرزائون، بندگون، جلالن، آروون، مدقاسمون، حسنیون، روحیون، قاسمون، حنسنون، جلالون، خجه، علی شوون، خجه ممدون، نوردینون";

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
textAlign: TextAlign.justify,
style: const TextStyle(
fontSize: 13,
height: 1.6,
fontFamily: "Vazir",
),
),
secondChild: Text(
fullText,
textAlign: TextAlign.justify,
style: const TextStyle(
fontSize: 13,
height: 1.6,
fontFamily: "Vazir",
),
),
crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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