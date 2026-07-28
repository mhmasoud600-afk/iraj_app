import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'global_music_player.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final GlobalMusicPlayer player = GlobalMusicPlayer();

 
  // لیست ترانه‌ها
  final List<Map<String, String>> songs = [
    {"title": "ایران", "artist": "سالار عقیلی", "file": "music/song12.ogg"},
    {"title": "عشق اهورایی", "artist": "مجتبی شجاع", "file": "music/song13.ogg"},
    {"title": "شمشاد", "artist": "علیرضا افتخاری", "file": "music/song1.ogg"},
    {"title": "از دل و جان", "artist": "علیرضا افتخاری", "file": "music/song2.ogg"},
    {"title": "شب کوچه‌ها", "artist": "علیرضا افتخاری", "file": "music/song3.ogg"},
    {"title": "ای دل اگر عاشقی", "artist": "علیرضا افتخاری", "file": "music/song4.ogg"},
    {"title": "خانه به دوش", "artist": "علیرضا افتخاری", "file": "music/song5.ogg"},
    {"title": "الهه ناز", "artist": "علیرضا افتخاری", "file": "music/song6.ogg"},
    {"title": "ساقی بده جامی", "artist": "علیرضا افتخاری", "file": "music/song7.ogg"},
    {"title": "شیدا", "artist": "علیرضا افتخاری", "file": "music/song8.ogg"},
    {"title": "تمنای وصال", "artist": "عبدالحسین مختاباد", "file": "music/song9.ogg"},
    {"title": "شکوه", "artist": "عبدالحسین مختاباد", "file": "music/song10.ogg"},
    {"title": "شبانگاهان", "artist": "عبدالحسین مختاباد", "file": "music/song11.ogg"},
  ];

  Widget _buildSongsTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        final isPlaying = player.currentSong == song["file"];

        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                if (isPlaying) {
                  await player.stop();
                } else {
                  await player.play(song["file"]!);
                }
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: isPlaying ? Colors.green : Colors.blueGrey,
                child: Icon(
                  isPlaying ? Icons.pause : Icons.music_note,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () async {
                if (isPlaying) {
                  await player.stop();
                } else {
                  await player.play(song["file"]!);
                }
                setState(() {});
              },
              child: Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Text(
                  '${song["artist"]} - ${song["title"]}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Vazirmatn",
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isPlaying ? Icons.stop : Icons.play_arrow,
                    color: isPlaying ? Colors.red : Colors.green,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      await player.stop();
                    } else {
                      await player.play(song["file"]!);
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("صفحه ترانه"),
      ),
      body: _buildSongsTab(),
    );
  }
}