
import 'package:flutter/material.dart';

class MourningDeceasedPage extends StatelessWidget {
const MourningDeceasedPage({Key? key}) : super(key: key);

final List<Map<String, String>> mourningStages = const [
{
'title': 'غسل و کفن',
'description': 'پاک‌سازی بدن متوفی و پوشاندن کفن سفید بر طبق احکام شرعی.',
},
{
'title': 'تشییع و تدفین',
'description': 'برگزاری مراسم تشییع جنازه با حضور اقوام و دوستان و دفن در قبرستان.',
},
{
'title': 'تلقین',
'description': 'خواندن آیات قرآن و ادعیه خاص برای هدایت روح متوفی پس از دفن.',
},
{
'title': 'پرسه دادن',
'description': 'گردهمایی عزاداران در خانه متوفی برای تسلیت و فاتحه‌خوانی.',
},
{
'title': 'قرآن خواندن در منزل متوفی',
'description': 'خواندن قرآن به صورت دسته‌جمعی در خانه متوفی برای آمرزش روح.',
},
{
'title': 'مراسم سوم',
'description': 'گردهمایی در روز سوم فوت با خواندن فاتحه و پذیرایی.',
},
{
'title': 'مراسم هفتم',
'description': 'برگزاری مراسم در روز هفتم با قرائت قرآن و اطعام.',
},
{
'title': 'مراسم چهلم',
'description': 'مراسم بزرگ در روز چهلم با سخنرانی مذهبی و نذری.',
},
{
'title': 'مراسم سالگرد',
'description': 'برگزاری مراسم سالانه در سالگرد فوت با یادبود و خیرات.',
},
{
'title': 'مراسم‌های یادبود',
'description': 'برگزاری مراسم در مناسبت‌های مختلف مانند اعیاد و ماه رمضان.',
},
{
'title': 'عصر پنج‌شنبه‌ها در قبرستان',
'description': 'زیارت قبرستان و فاتحه‌خوانی برای اموات در عصرهای پنج‌شنبه.',
},
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'درگذشت اموات',
style: TextStyle(fontFamily: 'Vazirmatn'),
),
),
body: Directionality(
textDirection: TextDirection.rtl,
child: Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topRight,
end: Alignment.bottomLeft,
colors: [
Colors.grey.shade50,
Colors.grey.shade100,
],
),
),
child: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'آداب و رسوم مرتبط با درگذشت اموات در روستا',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.teal,
fontFamily: 'Vazirmatn',
),
),
const SizedBox(height: 8),
const Text(
'در روستای ما، مراسم درگذشت بر اساس سنت‌های دیرینه و آموزه‌های مذهبی برگزار می‌شود. اهالی با همبستگی و همدلی، خانواده داغدار را همراهی کرده و مراحل مختلف عزاداری را به طور کامل انجام می‌دهند.',
style: TextStyle(
fontSize: 16,
height: 1.7,
fontFamily: 'Vazirmatn',
),
textAlign: TextAlign.justify,
),
const SizedBox(height: 24),

// عنوان مراحل
const Text(
'مراحل مراسم درگذشت:',
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.teal,
fontFamily: 'Vazirmatn',
),
),
const SizedBox(height: 16),

// لیست مراحل
...mourningStages.asMap().entries.map((entry) {


final index = entry.key;
final stage = entry.value;
return Padding(
padding: const EdgeInsets.only(bottom: 16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Container(
width: 30,
height: 30,
decoration: BoxDecoration(
color: Colors.teal,
borderRadius: BorderRadius.circular(15),
),
alignment: Alignment.center,
child: Text(
'${index + 1}',
style: const TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontFamily: 'Vazirmatn',
),
),
),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
stage['title']!,
style: const TextStyle(
fontSize: 17,
fontWeight: FontWeight.bold,
color: Colors.black87,
fontFamily: 'Vazirmatn',
),
),
const SizedBox(height: 6),
Text(
stage['description']!,
style: const TextStyle(
fontSize: 15,
height: 1.6,
color: Colors.black54,
fontFamily: 'Vazirmatn',
),
textAlign: TextAlign.justify,
),
],
),
),
],
),
if (index < mourningStages.length - 1)
Container(
margin: const EdgeInsets.only(top: 12, right: 15),
height: 1,
color: Colors.grey.shade300,
),
],
),
);
}).toList(),

const SizedBox(height: 24),

// بخش اطلاعات تکمیلی
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.teal.shade50,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.teal.shade100),
),
child: const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'نکات مهم:',


style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.teal,
fontFamily: 'Vazirmatn',
),
),
SizedBox(height: 8),
Text(
'• خانواده متوفی معمولاً تا سه روز از پذیرایی خودداری می‌کنند\n'
'• همسایگان و اقوام در تهیه غذا و پذیرایی کمک می‌کنند\n'
'• مراسم شب هفتم و چهلم در مسجد یا حسینیه برگزار می‌شود\n'
'• خیرات و صدقه برای متوفی تا یکسال ادامه دارد\n'
'• عزاداری در مناسبت‌های مذهبی نیز تکرار می‌شود',
style: TextStyle(
fontSize: 15,
height: 1.8,
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
),
);
}
}