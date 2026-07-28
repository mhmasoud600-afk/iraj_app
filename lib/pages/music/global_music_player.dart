import 'package:audioplayers/audioplayers.dart';

class GlobalMusicPlayer {
  // Singleton instance
  static final GlobalMusicPlayer _instance = GlobalMusicPlayer._internal();
  factory GlobalMusicPlayer() => _instance;

  GlobalMusicPlayer._internal();

  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // وضعیت پخش
  bool isPlaying = false;
  String? currentSong;

  /// پخش فایل موسیقی یا دعا
  Future<void> play(String filePath) async {
    try {
      // اگر چیزی در حال پخش است، اول قطع شود
      await _audioPlayer.stop();

      // پخش فایل از assets
      await _audioPlayer.play(AssetSource(filePath));

      isPlaying = true;
      currentSong = filePath;
    } catch (e) {
      print("خطا در پخش فایل: $e");
    }
  }

  /// توقف پخش
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      isPlaying = false;
      currentSong = null;
    } catch (e) {
      print("خطا در توقف پخش: $e");
    }
  }

  /// بررسی وضعیت پخش
  bool get playing => isPlaying;
}