import 'package:flutter/material.dart';

class MourningFatimiyyaPage extends StatelessWidget {
  const MourningFatimiyyaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'دهه فاطمیه',
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
                  'برگزاری مراسم دهه فاطمیه',
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
                  'مراسم عزاداری دهه فاطمیه به مناسبت شهادت حضرت فاطمه زهرا(س) در مسجد امام حسین (ع) و حسینیه برگزار می‌شود. این مراسم شامل:\n\n'
                      '• سخنرانی درباره فضایل و سیره حضرت زهرا(س)\n'
                      '• نوحه‌خوانی و مداحی ویژه فاطمیه\n'
                      '• روضه‌خوانی و مرثیه‌سرایی\n'
                      '• اطعام و نذری‌پزی\n'
                      '• برگزاری مجالس زنانه و مردانه\n\n'
                      'این مراسم در دو دهه (بسته به تقویم) برگزار شده و مورد استقبال ویژه مردم قرار می‌گیرد.',
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