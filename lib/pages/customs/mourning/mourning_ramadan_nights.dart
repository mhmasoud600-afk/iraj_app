
import 'package:flutter/material.dart';

class MourningRamadanNightsPage extends StatelessWidget {
const MourningRamadanNightsPage({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text(
'ماه مبارک رمضان',
style: TextStyle(fontFamily: 'Vazirmatn'),
),
),
body: Directionality(
textDirection: TextDirection.rtl,
child: Padding(
padding: const EdgeInsets.all(16),
child: ListView(
children: [
const Text(
'مراسمات شب احیای ماه رمضان',
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
color: Colors.teal,
fontFamily: 'Vazirmatn',
),
),
const SizedBox(height: 16),
const Text(
'مراسم ویژه شب‌های احیای ماه مبارک رمضان (شب‌های ۱۹، ۲۱ و ۲۳) شامل برنامه‌های معنوی زیر است:',
style: TextStyle(
fontSize: 16,
height: 1.7,
fontFamily: 'Vazirmatn',
),
textAlign: TextAlign.justify,
),
const SizedBox(height: 16),
const Padding(
padding: EdgeInsets.symmetric(horizontal: 8),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildBulletPoint('خواندن دعای جوشن کبیر: دعای مفصلی شامل ۱۰۰۱ اسم الهی'),
_buildBulletPoint('خواندن نمازهای قضای واجب: به جای‌گزاری نمازهای فوت شده'),
_buildBulletPoint('مراسم قرآن به سر گرفتن: گرفتن قرآن بر سر برای تبرک'),
_buildBulletPoint('شب‌زنده‌داری و عبادت تا سحر'),
_buildBulletPoint('قرائت قرآن و ادعیه مأثوره'),
_buildBulletPoint('استغفار و طلب آمرزش گناهان'),
_buildBulletPoint('خواندن دعای ابوحمزه ثمالی یا جوشن کبیر تا پاسی از شب و قبل از سحرگاه'),
],
),
),
const SizedBox(height: 16),
const Text(
'این مراسم در مساجد و حسینیه‌ها با حضور پرشور مردم برگزار می‌شود. اهالی روستا از غروب تا سحرگاه در مسجد حضور یافته و به عبادت و دعا مشغول می‌شوند. زنان و مردان در بخش‌های جداگانه اما همزمان در این مراسم شرکت می‌کنند.',
style: TextStyle(
fontSize: 16,
height: 1.7,
fontFamily: 'Vazirmatn',
),
textAlign: TextAlign.justify,
),
const SizedBox(height: 24),
// اطلاعات اضافی
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
'• از ساعت ۲۳ تا ۱ بامداد: دعای جوشن کبیر\n'
'• از ساعت ۱ تا ۲ بامداد: نمازهای قضا\n'
'• از ساعت ۲ تا ۲:۳۰: قرآن به سر کردن\n',



style: TextStyle(
fontSize: 16,
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
}

class _buildBulletPoint extends StatelessWidget {
final String text;

const _buildBulletPoint(this.text);

@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.symmetric(vertical: 4),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Padding(
padding: EdgeInsets.only(top: 6, left: 8),
child: Icon(
Icons.circle,
size: 8,
color: Colors.teal,
),
),
const SizedBox(width: 8),
Expanded(
child: Text(
text,
style: const TextStyle(
fontSize: 16,
height: 1.6,
fontFamily: 'Vazirmatn',
),
textAlign: TextAlign.justify,
),
),
],
),
);
}
}