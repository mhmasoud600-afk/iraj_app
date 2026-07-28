import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TvPage extends StatefulWidget {
  const TvPage({Key? key}) : super(key: key);

  @override
  State<TvPage> createState() => _TvPageState();
}

class _TvPageState extends State<TvPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  int _retryCount = 0;
  final String _url = 'https://telewebion.ir/';

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _hasError = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // فقط در صورت خطای واقعی و عدم بارگذاری کامل، خطا نشان داده شود
            if (error.errorCode != -1) { // -1 معمولاً خطای موقتی است
              setState(() {
                _isLoading = false;
                _hasError = true;
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            // اجازه همه ناوبری‌ها
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            // خطاهای HTTP را نادیده بگیرید
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..setUserAgent('Mozilla/5.0 (Linux; Android 10) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36')
      ..enableZoom(true)
      ..loadRequest(Uri.parse(_url));
  }

  void _reloadPage() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _retryCount = 0;
    });
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: _controller),
          
          // نشانگر بارگذاری
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.red,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'در حال بارگذاری...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          // صفحه خطا
          if (_hasError && !_isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_statusbar_null,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'خطا در بارگذاری صفحه',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontFamily: 'Vazirmatn',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لطفاً اتصال اینترنت خود را بررسی کنید',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontFamily: 'Vazirmatn',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'در صورت اتصال اینترنت، صفحه به صورت خودکار بارگذاری می‌شود',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontFamily: 'Vazirmatn',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _reloadPage,
                    icon: const Icon(Icons.refresh, size: 20),
                    label: const Text(
                      'تلاش مجدد',
                      style: TextStyle(
                        fontFamily: 'Vazirmatn',
                        fontSize: 14,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}