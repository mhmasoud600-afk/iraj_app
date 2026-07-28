import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// مدل‌های صوت و ذاکر
class ZakerAudio {
  final String audioPath;
  final String title;
  final String description;
  final Duration duration;

  const ZakerAudio({
    required this.audioPath,
    required this.title,
    required this.description,
    required this.duration,
  });
}

class ZakerModel {
  final String name;
  final String desc;
  final String image;
  final List<ZakerAudio>? audios;

  const ZakerModel({
    required this.name,
    required this.desc,
    required this.image,
    this.audios,
  });
}

class ZakerinDetail extends StatefulWidget {
  final String name;
  final String imagePath;
  final String description;
  final List<ZakerAudio>? audios;
  final Color primaryColor;
  final Color lightColor;

  const ZakerinDetail({
    super.key,
    required this.name,
    required this.imagePath,
    required this.description,
    this.audios,
    this.primaryColor = Colors.green,
    this.lightColor = Colors.green,
  });

  @override
  State<ZakerinDetail> createState() => _ZakerinDetailState();
}

class _ZakerinDetailState extends State<ZakerinDetail> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _duration = const Duration(seconds: 1);
  Duration _position = Duration.zero;
  int _currentAudioIndex = 0;
  PlayerState _playerState = PlayerState.stopped;
  double _playbackRate = 1.0;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _setupAudioListeners();
  }

  void _setupAudioListeners() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
        _isPlaying = state == PlayerState.playing;
        if (state == PlayerState.completed) {
          _position = _duration;
        }
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _position = _duration;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(String path) async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = '';
      });

      if (_isPlaying) {
        await _audioPlayer.stop();
      }

      await _audioPlayer.play(AssetSource(path));
      await _audioPlayer.setPlaybackRate(_playbackRate);

      setState(() {
        _isPlaying = true;
        _isLoading = false;
      });

      _showSnackBar('در حال پخش...', widget.primaryColor);
    } catch (e) {
      print('خطا در پخش صوت: $e');

      setState(() {
        _hasError = true;
        _errorMessage = 'خطا در پخش صوت: ${e.toString()}';
        _isLoading = false;
        _isPlaying = false;
      });

      String errorMessage = 'خطا در پخش صوت';
      if (e.toString().contains('assets') ||
          e.toString().contains('not found') ||
          e.toString().contains('Unable') ||
          e.toString().contains('Source error')) {
        errorMessage = 'فایل صوتی یافت نشد\nمسیر: $path';
      }

      _showSnackBar(errorMessage, Colors.red);
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } catch (e) {
      print('خطا در توقف صوت: $e');
    }
  }

  Future<void> _resumeAudio() async {
    try {
      await _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    } catch (e) {
      print('خطا در ادامه پخش: $e');
    }
  }

  Future<void> _stopAudio() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    } catch (e) {
      print('خطا در توقف کامل صوت: $e');
    }
  }

  Future<void> _seekAudio(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('خطا در جستجوی صوت: $e');
    }
  }

  Future<void> _setPlaybackRate(double rate) async {
    try {
      await _audioPlayer.setPlaybackRate(rate);
      setState(() {
        _playbackRate = rate;
      });
      _showSnackBar('سرعت پخش تنظیم شد: ${rate}x', Colors.blue);
    } catch (e) {
      print('خطا در تنظیم سرعت: $e');
    }
  }

  void _playNextAudio() {
    if (widget.audios != null && widget.audios!.isNotEmpty) {
      if (_currentAudioIndex < widget.audios!.length - 1) {
        setState(() {
          _currentAudioIndex++;
        });
        _playAudio(widget.audios![_currentAudioIndex].audioPath);
      } else {
        _showSnackBar('این آخرین صوت در لیست است', Colors.blue);
      }
    }
  }

  void _playPreviousAudio() {
    if (widget.audios != null && widget.audios!.isNotEmpty) {
      if (_currentAudioIndex > 0) {
        setState(() {
          _currentAudioIndex--;
        });
        _playAudio(widget.audios![_currentAudioIndex].audioPath);
      } else {
        _showSnackBar('این اولین صوت در لیست است', Colors.blue);
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: "Vazirmatn"),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSpeedButton(double rate, String label) {
    final bool isSelected = _playbackRate == rate;
    return SizedBox(
      height: 28,
      child: ElevatedButton(
        onPressed: () => _setPlaybackRate(rate),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? widget.primaryColor : widget.lightColor,
          foregroundColor: isSelected ? Colors.white : Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          minimumSize: Size.zero,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "Vazirmatn",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasMultipleAudios =
        widget.audios != null && widget.audios!.length > 1;
    final bool hasAudios = widget.audios != null && widget.audios!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: const TextStyle(fontFamily: "Vazirmatn"),
        ),
        backgroundColor: widget.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ========== بخش تصویر اصلاح‌شده ==========
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: widget.lightColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: widget.primaryColor.withOpacity(0.7), width: 3),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.imagePath,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.7,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'تصویر یافت نشد',
                            style: TextStyle(
                              fontFamily: "Vazirmatn",
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // بخش پخش صوت (اگر صوت وجود دارد)
            if (hasAudios)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.lightColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: widget.primaryColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'نمونه صوت',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Vazirmatn",
                        fontWeight: FontWeight.bold,
                        color: widget.primaryColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.audios![_currentAudioIndex].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Vazirmatn",
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.audios![_currentAudioIndex].description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Vazirmatn",
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),

                    // نوار پیشرفت
                    Column(
                      children: [
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            thumbShape:
                                const RoundSliderThumbShape(enabledThumbRadius: 8),
                            overlayShape:
                                const RoundSliderOverlayShape(overlayRadius: 16),
                            activeTrackColor: widget.primaryColor,
                            inactiveTrackColor:
                                widget.primaryColor.withOpacity(0.3),
                            thumbColor: widget.primaryColor,
                          ),
                          child: Slider(
                            min: 0,
                            max: _duration.inSeconds > 0
                                ? _duration.inSeconds.toDouble()
                                : 1.0,
                            value: _position.inSeconds.toDouble().clamp(
                                0,
                                _duration.inSeconds > 0
                                    ? _duration.inSeconds.toDouble()
                                    : 1.0),
                            onChanged: (value) {
                              _seekAudio(Duration(seconds: value.toInt()));
                            },
                            onChangeEnd: (value) {
                              _seekAudio(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(_position),
                                style: const TextStyle(
                                  fontFamily: "Vazirmatn",
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                _formatDuration(_duration),
                                style: const TextStyle(
                                  fontFamily: "Vazirmatn",
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // کنترل‌های پخش
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasMultipleAudios)
                          IconButton(
                            onPressed: _playPreviousAudio,
                            icon: Icon(
                              Icons.skip_previous,
                              size: 32,
                              color: _currentAudioIndex > 0
                                  ? widget.primaryColor
                                  : Colors.grey,
                            ),
                          ),
                        if (hasMultipleAudios) const SizedBox(width: 20),

                        Container(
                          decoration: BoxDecoration(
                            color: widget.lightColor,
                            shape: BoxShape.circle,
                          ),
                          child: _isLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 3,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () async {
                                    if (!hasAudios) {
                                      _showSnackBar(
                                          'هیچ فایل صوتی موجود نیست', Colors.orange);
                                      return;
                                    }

                                    if (_isPlaying) {
                                      await _pauseAudio();
                                    } else {
                                      if (_playerState == PlayerState.paused &&
                                          _position < _duration) {
                                        await _resumeAudio();
                                      } else {
                                        await _playAudio(widget
                                            .audios![_currentAudioIndex]
                                            .audioPath);
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 36,
                                    color: widget.primaryColor,
                                  ),
                                  iconSize: 36,
                                ),
                        ),

                        if (hasMultipleAudios) const SizedBox(width: 20),

                        if (hasMultipleAudios)
                          IconButton(
                            onPressed: _playNextAudio,
                            icon: Icon(
                              Icons.skip_next,
                              size: 32,
                              color: _currentAudioIndex <
                                      widget.audios!.length - 1
                                  ? widget.primaryColor
                                  : Colors.grey,
                            ),
                          ),

                        const SizedBox(width: 20),

                        IconButton(
                          onPressed: _stopAudio,
                          icon: Icon(
                            Icons.stop,
                            size: 32,
                            color: widget.primaryColor,
                          ),
                        ),
                      ],
                    ),

                    // کنترل‌های سرعت پخش
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'سرعت پخش:',
                          style: TextStyle(
                            fontFamily: "Vazirmatn",
                            fontSize: 14,
                            color: widget.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          alignment: WrapAlignment.center,
                          children: [
                            _buildSpeedButton(0.5, '0.5x'),
                            _buildSpeedButton(0.75, '0.75x'),
                            _buildSpeedButton(1.0, '1.0x'),
                            _buildSpeedButton(1.25, '1.25x'),
                            _buildSpeedButton(1.5, '1.5x'),
                            _buildSpeedButton(2.0, '2.0x'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.lightColor,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: widget.primaryColor, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.speed,
                            size: 14,
                            color: widget.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'سرعت فعلی: ${_playbackRate}x',
                            style: TextStyle(
                              fontFamily: "Vazirmatn",
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (hasMultipleAudios)
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'لیست صوت‌ها',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Vazirmatn",
                              fontWeight: FontWeight.bold,
                              color: widget.primaryColor,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.audios!.length,
                            itemBuilder: (context, index) {
                              final audio = widget.audios![index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: _currentAudioIndex == index
                                      ? widget.lightColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _currentAudioIndex == index
                                        ? widget.primaryColor
                                        : Colors.grey[200]!,
                                    width: 1,
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: _currentAudioIndex == index
                                        ? widget.primaryColor
                                        : Colors.grey[300],
                                    child: Icon(
                                      Icons.music_note,
                                      color: _currentAudioIndex == index
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                  title: Text(
                                    audio.title,
                                    style: TextStyle(
                                      fontFamily: "Vazirmatn",
                                      fontWeight: _currentAudioIndex == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  subtitle: Text(
                                    audio.description,
                                    style: const TextStyle(
                                      fontFamily: "Vazirmatn",
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  trailing: Text(
                                    _formatDuration(audio.duration),
                                    style: const TextStyle(
                                      fontFamily: "Vazirmatn",
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _currentAudioIndex = index;
                                    });
                                    _playAudio(audio.audioPath);
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // بخش توضیحات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.lightColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: widget.primaryColor, width: 1),
              ),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.7,
                  fontFamily: "Vazirmatn",
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}