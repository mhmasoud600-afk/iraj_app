import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../settings/app_settings.dart';

class RoutingPage extends StatefulWidget {
  const RoutingPage({Key? key}) : super(key: key);

  @override
  State<RoutingPage> createState() => _RoutingPageState();
}

class _RoutingPageState extends State<RoutingPage> with WidgetsBindingObserver, SettingsAwareWidget {
  Position? _currentPosition;
  final MapController _mapController = MapController();
  bool _isLoading = true;
  bool _locationEnabled = false;

  // مختصات روستاها
  final LatLng irajVillage = const LatLng(33.458675, 54.871059);
  final LatLng khanjVillage = const LatLng(33.431476, 54.908964);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initLocationTracking();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _checkLocationAndUpdate();
    }
  }

  Future<void> _checkLocationAndUpdate() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (serviceEnabled && !_locationEnabled) {
        await _getCurrentPosition();
      }
    } catch (e) {
      print("خطا در بررسی موقعیت: $e");
    }
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      if (mounted) {
        setState(() {
          _currentPosition = pos;
          _locationEnabled = true;
          _isLoading = false;
        });
        _mapController.move(LatLng(pos.latitude, pos.longitude), 15);
      }
    } catch (e) {
      print("خطا در دریافت موقعیت: $e");
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _initLocationTracking() async {
    setState(() => _isLoading = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        setState(() {
          _locationEnabled = false;
          _isLoading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();

        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            _isLoading = false;
            _locationEnabled = false;
          });
          return;
        }
      }

      setState(() => _locationEnabled = true);
      await _getCurrentPosition();

    } catch (e) {
      print("خطا در راه‌اندازی ردیابی: $e");
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// نمایش لیست همه برنامه‌های مسیریابی
  Future<void> _showAllNavigationApps(LatLng destination) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "لطفا منتظر دریافت موقعیت فعلی باشید",
            style: TextStyle(
              fontFamily: settings.mainFontFamily,
            ),
          ),
          backgroundColor: settings.primaryColor,
        ),
      );
      return;
    }

    try {
      final List<AvailableMap> installedMaps = await MapLauncher.installedMaps;
      final List<MapApp> allApps = [];

      for (var map in installedMaps) {
        allApps.add(MapApp(
          name: _getPersianName(map.mapName),
          mapType: map.mapType,
          availableMap: map,
          isIranian: false,
          icon: _getMapIcon(map.mapType),
          color: _getMapColor(map.mapType),
        ));
      }

      final iranianMaps = await _getInstalledIranianMaps();
      allApps.addAll(iranianMaps);

      if (allApps.isEmpty) {
        allApps.addAll(_getDefaultApps());
      }

      final uniqueApps = _removeDuplicateApps(allApps);

      if (uniqueApps.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "هیچ برنامه مسیریابی معتبری پیدا نشد",
              style: TextStyle(
                fontFamily: settings.mainFontFamily,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _showAppSelectionDialog(uniqueApps, destination);

    } catch (e) {
      print("خطا در دریافت لیست برنامه‌ها: $e");
      await _showFallbackAppSelection(destination);
    }
  }

  /// دریافت برنامه‌های ایرانی نصب شده
  Future<List<MapApp>> _getInstalledIranianMaps() async {
    final iranianMaps = <MapApp>[];

    final List<Map<String, dynamic>> iranianApps = [
      {
        'name': 'نشان',
        'packageName': 'com.neshan.maps',
        'androidUrl': 'neshanmaps://direction?origin=%lat1%,%lng1%&destination=%lat2%,%lng2%&type=car',
        'iosUrl': 'neshanmaps://direction?origin=%lat1%,%lng1%&destination=%lat2%,%lng2%&type=car',
        'icon': Icons.flag,
        'color': Colors.blue,
      },
      {
        'name': 'بلد (نسخه بازار)',
        'packageName': 'ir.balad',
        'androidUrl': 'balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        'iosUrl': 'balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        'icon': Icons.navigation,
        'color': Colors.orange,
      },
      {
        'name': 'بلد (نسخه گوگل پلی)',
        'packageName': 'com.baladmaps',
        'androidUrl': 'baladmaps://nav?src=%lat1%,%lng1%&dst=%lat2%,%lng2%',
        'iosUrl': 'baladmaps://nav?src=%lat1%,%lng1%&dst=%lat2%,%lng2%',
        'icon': Icons.navigation,
        'color': Colors.deepOrange,
      },
      {
        'name': 'بلد (نسخه قدیمی)',
        'packageName': 'com.parsijoo.balad',
        'androidUrl': 'parsijoo.balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        'iosUrl': 'parsijoo.balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        'icon': Icons.navigation,
        'color': Colors.orangeAccent,
      },
      {
        'name': 'بیتوته',
        'packageName': 'ir.bitoorte.app',
        'androidUrl': 'biiit://nav?src=%lat1%,%lng1%&dst=%lat2%,%lng2%',
        'iosUrl': 'biiit://nav?src=%lat1%,%lng1%&dst=%lat2%,%lng2%',
        'icon': Icons.place,
        'color': Colors.purple,
      },
    ];

    for (var app in iranianApps) {
      bool isInstalled = await _isAppInstalled(app['packageName']);

      if (isInstalled) {
        bool alreadyAdded = iranianMaps.any((m) => m.name.contains('بلد') && app['name'].contains('بلد'));

        if (!alreadyAdded) {
          String? workingUrl = await _findWorkingUrlForApp(app['packageName'], app['androidUrl']);

          if (workingUrl != null) {
            iranianMaps.add(MapApp(
              name: app['name'],
              packageName: app['packageName'],
              androidUrl: workingUrl,
              iosUrl: app['iosUrl'],
              isIranian: true,
              icon: app['icon'],
              color: app['color'],
              mapType: null,
              availableMap: null,
            ));
          }
        }
      }
    }

    return iranianMaps;
  }

  /// پیدا کردن URL کارآمد برای برنامه
  Future<String?> _findWorkingUrlForApp(String packageName, String defaultUrl) async {
    List<String> possibleUrls = [
      defaultUrl,
      'balad://nav?from=%lat1%,%lng1%&to=%lat2%,%lng2%',
      'baladmaps://route?from=%lat1%,%lng1%&to=%lat2%,%lng2%',
      'parsijoo.balad://nav?from=%lat1%,%lng1%&to=%lat2%,%lng2%',
      'balad://map?src=%lat1%,%lng1%&dst=%lat2%,%lng2%',
    ];

    for (var urlTemplate in possibleUrls) {
      String testUrl = urlTemplate
          .replaceAll('%lat1%', '35.715298')
          .replaceAll('%lng1%', '51.404343')
          .replaceAll('%lat2%', '35.715298')
          .replaceAll('%lng2%', '51.404343')
          .replaceAll('%lat1', '35.715298')
          .replaceAll('%lng1', '51.404343')
          .replaceAll('%lat2', '35.715298')
          .replaceAll('%lng2', '51.404343');

      try {
        if (await canLaunchUrl(Uri.parse(testUrl))) {
          return urlTemplate;
        }
      } catch (e) {
        continue;
      }
    }

    return defaultUrl;
  }

  /// بررسی نصب بودن برنامه
  Future<bool> _isAppInstalled(String packageName) async {
    try {
      List<String> testUrls = [
        "$packageName://",
        "balad://",
        "baladmaps://",
        "parsijoo.balad://",
      ];

      for (var url in testUrls) {
        try {
          if (await canLaunchUrl(Uri.parse(url))) {
            return true;
          }
        } catch (e) {
          continue;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// لیست برنامه‌های پیش‌فرض
  List<MapApp> _getDefaultApps() {
    return [
      MapApp(
        name: 'گوگل مپس',
        packageName: 'com.google.android.apps.maps',
        androidUrl: 'https://www.google.com/maps/dir/?api=1&origin=%lat1%,%lng1%&destination=%lat2%,%lng2%&travelmode=driving',
        iosUrl: 'comgooglemaps://?saddr=%lat1%,%lng1%&daddr=%lat2%,%lng2%&directionsmode=driving',
        isIranian: false,
        icon: Icons.map,
        color: Colors.red,
        mapType: MapType.google,
        availableMap: null,
      ),
      MapApp(
        name: 'نشان',
        packageName: 'com.neshan.maps',
        androidUrl: 'neshanmaps://direction?origin=%lat1%,%lng1%&destination=%lat2%,%lng2%&type=car',
        iosUrl: 'neshanmaps://direction?origin=%lat1%,%lng1%&destination=%lat2%,%lng2%&type=car',
        isIranian: true,
        icon: Icons.flag,
        color: Colors.blue,
        mapType: null,
        availableMap: null,
      ),
      MapApp(
        name: 'بلد',
        packageName: 'ir.balad',
        androidUrl: 'balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        iosUrl: 'balad://route?srcLat=%lat1%&srcLon=%lng1%&dstLat=%lat2%&dstLon=%lng2%',
        isIranian: true,
        icon: Icons.navigation,
        color: Colors.orange,
        mapType: null,
        availableMap: null,
      ),
      MapApp(
        name: 'ویز',
        packageName: 'com.waze',
        androidUrl: 'https://waze.com/ul?ll=%lat2%,%lng2%&navigate=yes',
        iosUrl: 'waze://?ll=%lat2%,%lng2%&navigate=yes',
        isIranian: false,
        icon: Icons.directions_car,
        color: Colors.green,
        mapType: MapType.waze,
        availableMap: null,
      ),
    ];
  }

  /// حذف برنامه‌های تکراری
  List<MapApp> _removeDuplicateApps(List<MapApp> apps) {
    final uniqueApps = <MapApp>[];
    final addedNames = <String>{};

    for (var app in apps) {
      if (app.name.contains('بلد')) {
        if (!addedNames.contains('بلد')) {
          uniqueApps.add(app);
          addedNames.add('بلد');
        }
      } else {
        if (!addedNames.contains(app.name)) {
          uniqueApps.add(app);
          addedNames.add(app.name);
        }
      }
    }

    return uniqueApps;
  }

  /// نمایش دیالوگ انتخاب برنامه
  void _showAppSelectionDialog(List<MapApp> apps, LatLng destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "انتخاب برنامه مسیریابی",
              style: TextStyle(
                fontSize: settings.mainFontSize + 4,
                fontWeight: FontWeight.bold,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "برنامه مورد نظر خود را انتخاب کنید:",
              style: TextStyle(
                color: settings.mainTextColor.withOpacity(0.7),
                fontFamily: settings.mainFontFamily,
                fontSize: settings.mainFontSize - 2,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  final app = apps[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: app.color,
                        ),
                        child: Icon(
                          app.icon,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      title: Text(
                        app.name,
                        style: TextStyle(
                          fontSize: settings.mainFontSize,
                          fontWeight: FontWeight.w500,
                          fontFamily: settings.mainFontFamily,
                          color: settings.mainTextColor,
                        ),
                      ),
                      subtitle: Text(
                        app.isIranian ? "برنامه ایرانی" : "برنامه بین‌المللی",
                        style: TextStyle(
                          fontFamily: settings.mainFontFamily,
                          fontSize: settings.mainFontSize - 4,
                          color: settings.mainTextColor.withOpacity(0.7),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: settings.primaryColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _launchApp(app, destination);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "انصراف",
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  color: settings.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// نمایش لیست جایگزین
  Future<void> _showFallbackAppSelection(LatLng destination) async {
    final List<Map<String, dynamic>> apps = [
      {
        'name': 'گوگل مپس',
        'android': 'https://www.google.com/maps/dir/?api=1&origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${destination.latitude},${destination.longitude}&travelmode=driving',
        'ios': 'comgooglemaps://?saddr=${_currentPosition!.latitude},${_currentPosition!.longitude}&daddr=${destination.latitude},${destination.longitude}&directionsmode=driving',
        'package': 'com.google.android.apps.maps',
        'icon': Icons.map,
        'color': Colors.red,
      },
      {
        'name': 'نشان',
        'android': 'neshanmaps://direction?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${destination.latitude},${destination.longitude}&type=car',
        'ios': 'neshanmaps://direction?origin=${_currentPosition!.latitude},${_currentPosition!.longitude}&destination=${destination.latitude},${destination.longitude}&type=car',
        'package': 'com.neshan.maps',
        'icon': Icons.flag,
        'color': Colors.blue,
      },
      {
        'name': 'بلد (نسخه بازار)',
        'android': 'balad://route?srcLat=${_currentPosition!.latitude}&srcLon=${_currentPosition!.longitude}&dstLat=${destination.latitude}&dstLon=${destination.longitude}',
        'ios': 'balad://route?srcLat=${_currentPosition!.latitude}&srcLon=${_currentPosition!.longitude}&dstLat=${destination.latitude}&dstLon=${destination.longitude}',
        'package': 'ir.balad',
        'icon': Icons.navigation,
        'color': Colors.orange,
      },
      {
        'name': 'بلد (نسخه گوگل پلی)',
        'android': 'baladmaps://nav?src=${_currentPosition!.latitude},${_currentPosition!.longitude}&dst=${destination.latitude},${destination.longitude}',
        'ios': 'baladmaps://nav?src=${_currentPosition!.latitude},${_currentPosition!.longitude}&dst=${destination.latitude},${destination.longitude}',
        'package': 'com.baladmaps',
        'icon': Icons.navigation,
        'color': Colors.deepOrange,
      },
      {
        'name': 'ویز',
        'android': 'https://waze.com/ul?ll=${destination.latitude},${destination.longitude}&navigate=yes',
        'ios': 'waze://?ll=${destination.latitude},${destination.longitude}&navigate=yes',
        'package': 'com.waze',
        'icon': Icons.directions_car,
        'color': Colors.green,
      },
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "برنامه مسیریابی را انتخاب کنید",
              style: TextStyle(
                fontSize: settings.mainFontSize + 2,
                fontWeight: FontWeight.bold,
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor,
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: app['color'],
                    ),
                    child: Icon(
                      app['icon'],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    app['name'],
                    style: TextStyle(
                      fontFamily: settings.mainFontFamily,
                      color: settings.mainTextColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _launchDirectApp(app, destination);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "بستن",
                style: TextStyle(
                  fontFamily: settings.mainFontFamily,
                  color: settings.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// راه‌اندازی برنامه
  Future<void> _launchApp(MapApp app, LatLng destination) async {
    try {
      if (app.availableMap != null) {
        await app.availableMap!.showDirections(
          origin: Coords(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
          ),
          destination: Coords(
            destination.latitude,
            destination.longitude,
          ),
        );
        return;
      }

      await _launchIranianApp(app, destination);

    } catch (e) {
      print("خطا در باز کردن ${app.name}: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "خطا در باز کردن ${app.name}",
            style: TextStyle(
              fontFamily: settings.mainFontFamily,
            ),
          ),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'دانلود',
            textColor: Colors.white,
            onPressed: () => _openAppStore(app),
          ),
        ),
      );
    }
  }

  /// راه‌اندازی برنامه ایرانی
  Future<void> _launchIranianApp(MapApp app, LatLng destination) async {
    final lat1 = _currentPosition!.latitude;
    final lng1 = _currentPosition!.longitude;
    final lat2 = destination.latitude;
    final lng2 = destination.longitude;

    String? url = Platform.isAndroid ? app.androidUrl : app.iosUrl;

    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "آدرس برنامه ${app.name} معتبر نیست",
            style: TextStyle(
              fontFamily: settings.mainFontFamily,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    url = url
        .replaceAll('%lat1%', lat1.toString())
        .replaceAll('%lng1%', lng1.toString())
        .replaceAll('%lat2%', lat2.toString())
        .replaceAll('%lng2%', lng2.toString())
        .replaceAll('%lat1', lat1.toString())
        .replaceAll('%lng1', lng1.toString())
        .replaceAll('%lat2', lat2.toString())
        .replaceAll('%lng2', lng2.toString());

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      await _openAppStore(app);
    }
  }

  /// راه‌اندازی مستقیم برنامه
  Future<void> _launchDirectApp(Map<String, dynamic> app, LatLng destination) async {
    try {
      String url = Platform.isAndroid ? app['android'] : app['ios'];

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        await _openDirectAppStore(app['package']);
      }
    } catch (e) {
      print("خطا در باز کردن ${app['name']}: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "خطا در باز کردن ${app['name']}",
            style: TextStyle(
              fontFamily: settings.mainFontFamily,
            ),
          ),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'دانلود',
            textColor: Colors.white,
            onPressed: () => _openDirectAppStore(app['package']),
          ),
        ),
      );
    }
  }

  /// باز کردن فروشگاه برنامه
  Future<void> _openAppStore(MapApp app) async {
    if (app.packageName == null) return;

    String storeUrl = Platform.isAndroid
        ? "market://details?id=${app.packageName}"
        : "itms-apps://itunes.apple.com/app/id${app.packageName}";

    if (!await canLaunchUrl(Uri.parse(storeUrl))) {
      storeUrl = Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=${app.packageName}"
          : "https://apps.apple.com/app/id${app.packageName}";
    }

    if (await canLaunchUrl(Uri.parse(storeUrl))) {
      await launchUrl(Uri.parse(storeUrl));
    }
  }

  /// باز کردن مستقیم فروشگاه
  Future<void> _openDirectAppStore(String packageName) async {
    String storeUrl = Platform.isAndroid
        ? "market://details?id=$packageName"
        : "itms-apps://itunes.apple.com/app/id$packageName";

    if (!await canLaunchUrl(Uri.parse(storeUrl))) {
      storeUrl = Platform.isAndroid
          ? "https://play.google.com/store/apps/details?id=$packageName"
          : "https://apps.apple.com/app/id$packageName";
    }

    if (await canLaunchUrl(Uri.parse(storeUrl))) {
      await launchUrl(Uri.parse(storeUrl));
    }
  }

  // توابع کمکی
  String _getPersianName(String englishName) {
    final names = {
      'google_maps': 'گوگل مپس',
      'waze': 'ویز',
      'apple_maps': 'اپل مپس',
      'yandex_maps': 'یاندکس',
    };
    return names[englishName] ?? englishName;
  }

  IconData _getMapIcon(MapType mapType) {
    switch (mapType) {
      case MapType.google:
        return Icons.map;
      case MapType.apple:
        return Icons.location_on;
      case MapType.waze:
        return Icons.navigation;
      default:
        return Icons.map_outlined;
    }
  }

  Color _getMapColor(MapType mapType) {
    switch (mapType) {
      case MapType.google:
        return Colors.red;
      case MapType.apple:
        return Colors.black;
      case MapType.waze:
        return Colors.blue;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settings.pageBackgroundColor,
      appBar: AppBar(
        title: Text(
          "مسیر‌یابی",
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
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _initLocationTracking,
            tooltip: "بروزرسانی موقعیت",
          ),
          IconButton(
            icon: const Icon(Icons.gps_fixed, color: Colors.white),
            onPressed: () async {
              if (!_locationEnabled) {
                await Geolocator.openLocationSettings();
                await Future.delayed(const Duration(seconds: 2));
                _checkLocationAndUpdate();
              }
            },
            tooltip: "تنظیمات GPS",
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showAllNavigationApps(irajVillage),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: settings.primaryColor.withOpacity(0.1),
                          foregroundColor: settings.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.navigation, size: 28),
                        label: Text(
                          "مسیریابی به ایراج",
                          style: TextStyle(
                            fontSize: settings.mainFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: settings.mainFontFamily,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _showAllNavigationApps(khanjVillage),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: settings.secondaryColor.withOpacity(0.1),
                          foregroundColor: settings.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.navigation, size: 28),
                        label: Text(
                          "مسیریابی به خنج",
                          style: TextStyle(
                            fontSize: settings.mainFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: settings.mainFontFamily,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _locationEnabled
                        ? settings.primaryColor.withOpacity(0.08)
                        : Colors.orange.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _locationEnabled ? settings.primaryColor : Colors.orange,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _locationEnabled ? Icons.gps_fixed : Icons.gps_not_fixed,
                        color: _locationEnabled ? settings.primaryColor : Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _locationEnabled
                              ? "موقعیت‌یابی فعال ✓"
                              : "GPS غیرفعال - برای مسیریابی فعال کنید",
                          style: TextStyle(
                            color: _locationEnabled ? settings.primaryColor : Colors.orange,
                            fontWeight: FontWeight.w500,
                            fontFamily: settings.mainFontFamily,
                            fontSize: settings.mainFontSize - 2,
                          ),
                        ),
                      ),
                      if (!_locationEnabled)
                        TextButton(
                          onPressed: () async {
                            await Geolocator.openLocationSettings();
                            await Future.delayed(const Duration(seconds: 2));
                            _checkLocationAndUpdate();
                          },
                          child: Text(
                            "فعال‌سازی",
                            style: TextStyle(
                              fontFamily: settings.mainFontFamily,
                              color: settings.primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: settings.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "در حال دریافت موقعیت...",
                          style: TextStyle(
                            fontFamily: settings.mainFontFamily,
                            color: settings.mainTextColor,
                            fontSize: settings.mainFontSize,
                          ),
                        ),
                      ],
                    ),
                  )
                : _currentPosition == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_off,
                              size: 64,
                              color: settings.mainTextColor.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "موقعیت جغرافیایی در دسترس نیست",
                              style: TextStyle(
                                fontSize: settings.mainFontSize + 2,
                                color: settings.mainTextColor.withOpacity(0.7),
                                fontFamily: settings.mainFontFamily,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _initLocationTracking,
                              icon: const Icon(Icons.refresh),
                              label: Text(
                                "تلاش مجدد برای دریافت موقعیت",
                                style: TextStyle(
                                  fontFamily: settings.mainFontFamily,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: settings.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          center: LatLng(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                          ),
                          zoom: 15,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: const ['a', 'b', 'c'],
                            userAgentPackageName: 'com.example.erabeh',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                ),
                                width: 80,
                                height: 80,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.my_location,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "موقعیت من",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: settings.mainFontSize - 4,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: settings.mainFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Marker(
                                point: irajVillage,
                                width: 80,
                                height: 80,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "روستای ایراج",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: settings.mainFontSize - 4,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: settings.mainFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Marker(
                                point: khanjVillage,
                                width: 80,
                                height: 80,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.green,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "روستای خنج",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: settings.mainFontSize - 4,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: settings.mainFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class MapApp {
  final String name;
  final MapType? mapType;
  final AvailableMap? availableMap;
  final String? packageName;
  final String? androidUrl;
  final String? iosUrl;
  final bool isIranian;
  final IconData icon;
  final Color color;

  const MapApp({
    required this.name,
    this.mapType,
    this.availableMap,
    this.packageName,
    this.androidUrl,
    this.iosUrl,
    required this.isIranian,
    required this.icon,
    required this.color,
  });
}