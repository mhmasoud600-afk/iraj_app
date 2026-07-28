import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings/app_settings.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onSettingsChanged;

  const SettingsPage({Key? key, required this.onSettingsChanged}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SettingsAwareWidget {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await settings.loadSettings();
    setState(() {});
  }

  Future<void> _saveSettings() async {
    await settings.saveSettings();
    widget.onSettingsChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('تنظیمات با موفقیت ذخیره شد'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تنظیمات برنامه',
          style: TextStyle(
            fontFamily: settings.mainFontFamily,
            fontSize: settings.mainFontSize + 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: settings.appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveSettings,
            tooltip: 'ذخیره تنظیمات',
          ),
        ],
      ),
      backgroundColor: settings.pageBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'تنظیمات ظاهری',
              icon: Icons.palette,
              children: [
                _buildColorPicker(
                  label: 'رنگ اصلی برنامه',
                  value: settings.primaryColor,
                  onChanged: (color) => setState(() => settings.primaryColor = color),
                ),
                _buildColorPicker(
                  label: 'رنگ نوار بالا',
                  value: settings.appBarColor,
                  onChanged: (color) => setState(() => settings.appBarColor = color),
                ),
                _buildColorPicker(
                  label: 'رنگ پس‌زمینه صفحه',
                  value: settings.pageBackgroundColor,
                  onChanged: (color) => setState(() => settings.pageBackgroundColor = color),
                ),
                _buildColorPicker(
                  label: 'رنگ متن اصلی',
                  value: settings.mainTextColor,
                  onChanged: (color) => setState(() => settings.mainTextColor = color),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'تنظیمات فونت',
              icon: Icons.font_download,
              children: [
                _buildFontPicker(
                  label: 'فونت اصلی',
                  value: settings.mainFontFamily,
                  onChanged: (font) => setState(() => settings.mainFontFamily = font),
                ),
                _buildFontPicker(
                  label: 'فونت دکمه‌ها',
                  value: settings.buttonFontFamily,
                  onChanged: (font) => setState(() => settings.buttonFontFamily = font),
                ),
                _buildSlider(
                  label: 'اندازه فونت اصلی',
                  value: settings.mainFontSize,
                  min: 12,
                  max: 24,
                  onChanged: (v) => setState(() => settings.mainFontSize = v),
                ),
                _buildSlider(
                  label: 'اندازه فونت دکمه‌ها',
                  value: settings.buttonFontSize,
                  min: 10,
                  max: 20,
                  onChanged: (v) => setState(() => settings.buttonFontSize = v),
                ),
                // ============================================================
                // جدید: اسلایدر برای اندازه فونت منوی اصلی
                // ============================================================
                _buildSlider(
                  label: 'اندازه فونت منوی اصلی',
                  value: settings.menuFontSize,
                  min: 8,
                  max: 20,
                  onChanged: (v) => setState(() => settings.menuFontSize = v),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'حالت شب',
              icon: Icons.dark_mode,
              children: [
                SwitchListTile(
                  title: Text(
                    'فعال‌سازی حالت شب',
                    style: TextStyle(
                      fontFamily: settings.mainFontFamily,
                      color: settings.mainTextColor,
                    ),
                  ),
                  subtitle: Text(
                    'تغییر رنگ‌ها به حالت تاریک',
                    style: TextStyle(
                      fontFamily: settings.mainFontFamily,
                      color: settings.mainTextColor.withOpacity(0.7),
                    ),
                  ),
                  value: settings.isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      settings.isDarkMode = value;
                      if (value) {
                        settings.mainTextColor = Colors.white;
                        settings.pageBackgroundColor = Colors.grey[900]!;
                        settings.appBarColor = Colors.grey[850]!;
                        settings.primaryColor = Colors.teal[300]!;
                      } else {
                        settings.mainTextColor = Colors.black;
                        settings.pageBackgroundColor = Colors.white;
                        settings.appBarColor = Colors.teal;
                        settings.primaryColor = Colors.teal;
                      }
                    });
                  },
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.blue[200],
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'تنظیمات پیش‌فرض',
              icon: Icons.restore,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _resetToDefaults,
                    icon: const Icon(Icons.restore, size: 20),
                    label: Text(
                      'بازنشانی به تنظیمات پیش‌فرض',
                      style: TextStyle(
                        fontFamily: settings.mainFontFamily,
                        fontSize: settings.buttonFontSize,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'با این کار تمام تنظیمات به حالت اولیه باز می‌گردد',
                    style: TextStyle(
                      fontSize: settings.mainFontSize * 0.7,
                      color: Colors.grey,
                      fontFamily: settings.mainFontFamily,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      color: settings.isDarkMode ? Colors.grey[850] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: settings.primaryColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: settings.mainFontSize + 2,
                    fontWeight: FontWeight.bold,
                    color: settings.primaryColor,
                    fontFamily: settings.mainFontFamily,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker({
    required String label,
    required Color value,
    required ValueChanged<Color> onChanged,
  }) {
    final items = settings.colorMap.entries.map((entry) {
      return DropdownMenuItem<Color>(
        key: ValueKey(entry.key),
        value: entry.value,
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: entry.value,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              entry.key,
              style: TextStyle(
                fontFamily: settings.mainFontFamily,
                color: settings.mainTextColor,
              ),
            ),
          ],
        ),
      );
    }).toList();

    Color? validValue;
    if (settings.colorMap.values.contains(value)) {
      validValue = value;
    } else {
      validValue = settings.colorMap.values.first;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: settings.mainFontSize * 0.85,
              fontFamily: settings.mainFontFamily,
              color: settings.mainTextColor,
            ),
          ),
          DropdownButton<Color>(
            value: validValue,
            items: items,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: settings.mainTextColor),
            elevation: 8,
            style: TextStyle(
              fontSize: settings.mainFontSize * 0.85,
              fontFamily: settings.mainFontFamily,
              color: settings.mainTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontPicker({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    final items = settings.fontFamilies.map((font) {
      return DropdownMenuItem<String>(
        key: ValueKey(font),
        value: font,
        child: Text(
          font,
          style: TextStyle(
            fontFamily: font,
            color: settings.mainTextColor,
          ),
        ),
      );
    }).toList();

    String validValue = value;
    if (!settings.fontFamilies.contains(value)) {
      validValue = settings.fontFamilies.first;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: settings.mainFontSize * 0.85,
              fontFamily: settings.mainFontFamily,
              color: settings.mainTextColor,
            ),
          ),
          DropdownButton<String>(
            value: validValue,
            items: items,
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: settings.mainTextColor),
            elevation: 8,
            style: TextStyle(
              fontSize: settings.mainFontSize * 0.85,
              fontFamily: settings.mainFontFamily,
              color: settings.mainTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: settings.mainFontSize * 0.85,
                  fontFamily: settings.mainFontFamily,
                  color: settings.mainTextColor,
                ),
              ),
              Text(
                '${value.toInt()}',
                style: TextStyle(
                  fontSize: settings.mainFontSize,
                  fontWeight: FontWeight.bold,
                  color: settings.primaryColor,
                  fontFamily: settings.mainFontFamily,
                ),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: (max - min).toInt(),
            label: value.toInt().toString(),
            onChanged: onChanged,
            activeColor: settings.primaryColor,
            inactiveColor: settings.primaryColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await settings.loadSettings();
    setState(() {});
    widget.onSettingsChanged();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('تنظیمات به حالت پیش‌فرض بازگشت'),
          ],
        ),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}