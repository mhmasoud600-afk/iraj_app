// lib/martyrs_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MartyrsPage extends StatefulWidget {
  const MartyrsPage({Key? key}) : super(key: key);

  @override
  State<MartyrsPage> createState() => _MartyrsPageState();
}

class _MartyrsPageState extends State<MartyrsPage> {
  List<dynamic> martyrs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/data/martyrs.json');
      setState(() => martyrs = json.decode(jsonStr));
    } catch (e) {
      debugPrint("خطا در بارگذاری فایل شهداء: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (martyrs.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "شهدای روستا",
          style: TextStyle(
            fontFamily: 'Vazirmatn',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: martyrs.length,
          itemBuilder: (context, index) {
            final m = martyrs[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(m['image']),
                ),
                title: Text(
                  m['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
                subtitle: Text(
                  "تولد: ${m['birthDate']}  •  شهادت: ${m['deathDate']}\nمحل شهادت: ${m['deathPlace']}",
                  style: const TextStyle(fontFamily: 'Vazirmatn'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MartyrDetailPage(martyr: Map<String, dynamic>.from(m)),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// کلاس MartyrDetailPage (بدون تغییر - همان کد قبلی)
// ============================================================
class MartyrDetailPage extends StatefulWidget {
  final Map<String, dynamic> martyr;
  const MartyrDetailPage({Key? key, required this.martyr}) : super(key: key);

  @override
  State<MartyrDetailPage> createState() => _MartyrDetailPageState();
}

class _MartyrDetailPageState extends State<MartyrDetailPage> {
  bool showWill = false;
  bool showBio = false;
  bool showPoem = false;

  String _getFirstLine(String? text) {
    if (text == null || text.isEmpty) return '';
    List<String> lines = text.split('\n');
    return lines.isNotEmpty ? lines[0] : text;
  }

  @override
  Widget build(BuildContext context) {
    final martyr = widget.martyr;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            martyr['name'] ?? 'شهید',
            style: const TextStyle(
              fontFamily: 'Vazirmatn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: 200,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    martyr['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              _buildInfoRow("نام:", martyr['name']),
              _buildInfoRow("تاریخ تولد:", martyr['birthDate']),
              _buildInfoRow("محل تولد:", martyr['birthPlace']),
              _buildInfoRow("تاریخ شهادت:", martyr['deathDate']),
              _buildInfoRow("محل شهادت:", martyr['deathPlace']),
              _buildInfoRow("نام عملیات:", martyr['operation']),

              const SizedBox(height: 16),

              if (martyr['bio'] != null && martyr['bio'].toString().isNotEmpty)
                _buildCollapsibleSection(
                  title: "گلبرگ زندگی",
                  content: martyr['bio'],
                  isExpanded: showBio,
                  onToggle: () => setState(() => showBio = !showBio),
                ),

              if (martyr['will'] != null && martyr['will'].toString().isNotEmpty)
                _buildCollapsibleSection(
                  title: "گلواژه (وصیت‌نامه)",
                  content: martyr['will'],
                  isExpanded: showWill,
                  onToggle: () => setState(() => showWill = !showWill),
                ),

              if (martyr['quote'] != null &&
                  martyr['quote'].toString().isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade300, width: 1.5),
                  ),
                  child: Text(
                    martyr['quote'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepOrange,
                      fontFamily: 'Vazirmatn',
                      height: 1.6,
                    ),
                  ),
                ),

              if (martyr['poem'] != null && martyr['poem'].toString().isNotEmpty)
                _buildPoemSection(
                  martyr['name'],
                  martyr['poem'],
                  showPoem,
                  () => setState(() => showPoem = !showPoem),
                ),

              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16, bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red.shade50,
                      Colors.red.shade100,
                    ],
                  ),
                  border: Border.all(color: Colors.redAccent, width: 3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.redAccent,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "«برای شادی روح شهدا صلوات»",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Vazirmatn',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB00020),
                fontFamily: 'Vazirmatn',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                fontFamily: 'Vazirmatn',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required String content,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB00020),
                fontFamily: 'Vazirmatn',
              ),
            ),
            TextButton(
              onPressed: onToggle,
              child: Text(
                isExpanded ? "بستن" : "مشاهده کامل",
                style: const TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Vazirmatn',
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            isExpanded ? content : _getFirstLine(content),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              fontFamily: 'Vazirmatn',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPoemSection(
    String martyrName, String poem, bool isExpanded, VoidCallback onToggle) {
    final lines = poem.trim().split('\n');
    final preview = lines.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "شعر درباره $martyrName\nشاعر: حاج رسول دانا",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB00020),
                fontFamily: 'Vazirmatn',
              ),
            ),
            TextButton(
              onPressed: onToggle,
              child: Text(
                isExpanded ? "بستن" : "مشاهده کامل",
                style: const TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Vazirmatn',
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: isExpanded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < lines.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          lines[i],
                          textAlign:
                              i.isEven ? TextAlign.right : TextAlign.left,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.8,
                            fontFamily: 'Vazirmatn',
                          ),
                        ),
                      ),
                  ],
                )
              : Text(
                  preview,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    fontFamily: 'Vazirmatn',
                  ),
                ),
        ),
      ],
    );
  }
}