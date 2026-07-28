// lib/share_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../settings/app_settings.dart';

class SharePage extends StatefulWidget {
  final String? pageTitle;
  final String? pageContent;
  final String? pageImage;

  const SharePage({
    super.key,
    this.pageTitle,
    this.pageContent,
    this.pageImage,
  });

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> with SettingsAwareWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // لینک دانلود از بازار
  static const String appLink = 'http://cafebazaar.ir/app/?id=com.example.iraj_app&ref=share';
  static const String appName = 'ارابه';

  @override
  void initState() {
    super.initState();
    // تنظیم عنوان و متن بر اساس صفحه فعلی
    _titleController.text = widget.pageTitle ?? 'معرفی برنامه روستای ایراج';
    _messageController.text = _buildDefaultMessage();
  }

  String _buildDefaultMessage() {
    String content = widget.pageContent ?? '';
    String title = widget.pageTitle ?? 'برنامه روستای ایراج';
    
    if (content.isNotEmpty) {
      return '''
$title

$content

━━━━━━━━━━━━━━━━━━━━
📱 «$appName» را در بازار اندروید ببین:
$appLink
━━━━━━━━━━━━━━━━━━━━
''';
    } else {
      return '''
من از برنامه «$appName» استفاده می‌کنم.
در این برنامه می‌توانید با تاریخچه، فرهنگ، شاعران و مسیرهای این روستا آشنا شوید.
پیشنهاد می‌کنم شما هم این برنامه را ببینید.

📱 «$appName» را در بازار اندروید ببین:
$appLink
''';
    }
  }

  final List<String> templates = [
    'سلام\n'
    'من از برنامه روستای ایراج استفاده می‌کنم.\n'
    'در این برنامه می‌توانید با تاریخچه، فرهنگ، شاعران و مسیرهای این روستا آشنا شوید.\n'
    'پیشنهاد می‌کنم شما هم این برنامه را ببینید.',
    
    'اگر به شناخت روستاهای ایران علاقه دارید\n'
    'برنامه روستای ایراج اطلاعات جالبی درباره این منطقه ارائه می‌دهد.\n'
    'حتماً آن را ببینید.',
    
    'یک برنامه جالب درباره روستای ایراج پیدا کردم.\n'
    'داخل آن اطلاعات فرهنگی، تاریخی و مسیرهای منطقه قرار دارد.\n'
    'دیدنش خالی از لطف نیست.'
  ];

  int selectedTemplate = 0;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'متن کپی شد',
          style: TextStyle(fontFamily: settings.mainFontFamily),
        ),
        backgroundColor: settings.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _copyAll() {
    String text = '${_titleController.text}\n\n${_messageController.text}';
    _copyText(text);
  }

  void _shareAll() {
    String text = '${_titleController.text}\n\n${_messageController.text}';
    Share.share(text, subject: _titleController.text);
  }

  void _selectTemplate(int index) {
    setState(() {
      selectedTemplate = index;
      String baseText = templates[index];
      _messageController.text = '''
$baseText

📱 «$appName» را در بازار اندروید ببین:
$appLink
''';
    });
  }

  Widget _templateButton(int index) {
    return ElevatedButton(
      onPressed: () => _selectTemplate(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedTemplate == index ? settings.primaryColor : Colors.grey,
        foregroundColor: selectedTemplate == index ? Colors.white : Colors.black87,
        textStyle: TextStyle(
          fontFamily: settings.mainFontFamily,
          fontSize: settings.buttonFontSize,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text('متن ${index + 1}'),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.buttonFontSize,
          ),
        ),
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? settings.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: settings.pageBackgroundColor,
        appBar: AppBar(
          title: Text(
            'اشتراک‌گذاری',
            style: TextStyle(
              fontFamily: settings.mainFontFamily,
              fontSize: settings.mainFontSize + 2,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: settings.appBarColor,
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: _shareAll,
              tooltip: 'اشتراک‌گذاری',
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ======== آیکون ========
              Icon(
                Icons.share,
                size: 70,
                color: settings.primaryColor,
              ),
              const SizedBox(height: 10),
              
              // ======== عنوان ========
              Text(
                'اشتراک‌گذاری محتوا',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: settings.mainFontSize + 6,
                  fontWeight: FontWeight.bold,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
              
              // ======== نمایش صفحه فعلی ========
              if (widget.pageTitle != null)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: settings.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: settings.primaryColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ارسال محتوای صفحه: ${widget.pageTitle}',
                        style: TextStyle(
                          fontFamily: settings.mainFontFamily,
                          fontSize: settings.mainFontSize - 2,
                          color: settings.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 20),

              // ======== عنوان ========
              Text(
                'عنوان',
                style: TextStyle(
                  fontSize: settings.mainFontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: settings.mainFontSize,
                  color: settings.mainTextColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: settings.isDarkMode ? Colors.grey[850] : Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // ======== انتخاب متن آماده ========
              Text(
                'انتخاب متن آماده',
                style: TextStyle(
                  fontSize: settings.mainFontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _templateButton(0),
                  _templateButton(1),
                  _templateButton(2),
                ],
              ),
              const SizedBox(height: 20),

              // ======== متن معرفی ========
              Text(
                'متن معرفی',
                style: TextStyle(
                  fontSize: settings.mainFontSize,
                  fontWeight: FontWeight.bold,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _messageController,
                maxLines: 12,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: settings.mainFontSize,
                  color: settings.mainTextColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: settings.isDarkMode ? Colors.grey[850] : Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // ======== دکمه‌های عملیاتی ========
              _actionButton(
                icon: Icons.copy,
                title: 'کپی عنوان',
                onTap: () => _copyText(_titleController.text),
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 10),
              
              _actionButton(
                icon: Icons.copy,
                title: 'کپی متن معرفی',
                onTap: () => _copyText(_messageController.text),
                color: Colors.blueGrey,
              ),
              const SizedBox(height: 10),
              
              _actionButton(
                icon: Icons.copy_all,
                title: 'کپی کل متن',
                onTap: _copyAll,
                color: settings.primaryColor,
              ),
              const SizedBox(height: 10),
              
              _actionButton(
                icon: Icons.share,
                title: 'اشتراک‌گذاری مستقیم',
                onTap: _shareAll,
                color: Colors.green,
              ),
              const SizedBox(height: 20),

              // ======== اطلاعات برنامه ========
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: settings.isDarkMode ? Colors.grey[850] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: settings.primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: settings.primaryColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'لینک دانلود از بازار',
                          style: TextStyle(
                            fontFamily: settings.mainFontFamily,
                            fontSize: settings.mainFontSize,
                            fontWeight: FontWeight.bold,
                            color: settings.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '«$appName» را در بازار اندروید ببین:',
                      style: TextStyle(
                        fontFamily: settings.mainFontFamily,
                        fontSize: settings.mainFontSize - 2,
                        color: settings.mainTextColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _copyText(appLink),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          appLink,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: settings.mainFontFamily,
                            fontSize: settings.mainFontSize - 2,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '(برای کپی لینک، روی آن ضربه بزنید)',
                      style: TextStyle(
                        fontFamily: settings.mainFontFamily,
                        fontSize: settings.mainFontSize - 4,
                        color: settings.mainTextColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),

              // ======== راهنما ========
              Text(
                'بعد از کپی کردن متن، آن را در برنامه مورد نظر خود paste کنید.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  fontSize: settings.mainFontSize - 2,
                  color: settings.mainTextColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}