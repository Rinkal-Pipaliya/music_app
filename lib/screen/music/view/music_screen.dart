import 'package:flutter/material.dart';
import 'package:media_booster_app/screen/music/modal/music_modal.dart';
import 'package:media_booster_app/screen/music/provider/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late MusicProvider providerR;
  late MusicProvider providerW;

  @override
  void initState() {
    context.read<MusicProvider>().initMusic();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MusicProvider>().songStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<MusicProvider>();
    providerW = context.watch<MusicProvider>();

    MusicModal modal = ModalRoute.of(context)!.settings.arguments as MusicModal;

    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            modal.bimage!,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.infinity,
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Spacer(),
                // Round CD Artwork
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(modal.fimage!),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  modal.title ?? 'Unknown Title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  modal.artist ?? 'Unknown Artist',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Slider(
                  value: providerW.liveDuration.inSeconds.toDouble(),
                  max: providerW.totalDuration.inSeconds.toDouble(),
                  onChanged: (val) {
                    providerW.seekMusic(Duration(seconds: val.toInt()));
                  },
                  activeColor: Colors.amber,
                  inactiveColor: Colors.white30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${providerW.liveDuration.inMinutes.toString().padLeft(2, '0')} : ${(providerW.liveDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "${providerW.totalDuration.inMinutes.toString().padLeft(2, '0')} : ${(providerW.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        providerR.previousSong();
                      },
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        providerR.playMusic();
                      },
                      icon: Icon(
                        providerW.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: Colors.amber,
                        size: 60,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        providerR.nextSong();
                      },
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Share.share("${modal.title}\n${modal.path}");
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
