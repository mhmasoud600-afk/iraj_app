import 'package:flutter/material.dart';

class MourningOtherImamsPage extends StatelessWidget {
  const MourningOtherImamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'عزاداری سایر ائمه اطهار',
          style: TextStyle(fontFamily: 'Vazirmatn'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'برگزاری مراسم زنده نگه‌داشتن یاد ائمه اطهار',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'مراسم عزاداری برای سایر ائمه اطهار(ع) به منظور زنده نگه‌داشتن یاد و سیره آن بزرگواران برگزار می‌شود. این مراسم شامل:\n\n'
                      '• خواندن نوحه و مرثیه برای هر امام در سالروز شهادت\n'
                      '• روضه‌خوانی و سخنرانی درباره فضایل ائمه\n'
                      '• برگزاری جلسات ذکر مصیبت در مساجد و حسینیه‌ها\n'
                      '• اطعام و نذری به نام هر امام\n'
                      '• برگزاری مراسم ویژه برای امام رضا(ع)، امام جعفر صادق(ع) و دیگر ائمه\n\n'
                      'این مراسم‌ها موجب پیوند نسل‌ها با معارف اهل بیت(ع) و ترویج فرهنگ عاشورایی می‌شود.',
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    fontFamily: 'Vazirmatn',
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