import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:media_booster_app/screen/music/modal/music_modal.dart';
import 'package:video_player/video_player.dart';

class MusicProvider with ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int selectedIndex = 0;
  int currentIndex = 0;

  Duration liveDuration = const Duration(seconds: 0);
  Duration totalDuration = const Duration(seconds: 0);

  Future<void> initMusic() async {
    await audioPlayer.play(AssetSource(musicList[currentIndex].path!));
  }

  void idxMusic(int index) {
    currentIndex = index;
    selectedIndex = index;
    notifyListeners();
  }

  void playMusic() {
    if (isPlaying) {
      audioPlayer.pause();
      isPlaying = false;
    } else {
      audioPlayer.resume();
      isPlaying = true;
    }
    getLivetime();
    notifyListeners();
  }

  void getTotaleTime() async {
    audioPlayer.onDurationChanged.listen(
      (event) {
        totalDuration = event;
        notifyListeners();
      },
    );
  }

  void songStop() {
    audioPlayer.stop();
    notifyListeners();
  }

  void getLivetime() {
    audioPlayer.onPositionChanged.listen((event) {
      liveDuration = event;
      notifyListeners();
    });
  }

  Future<void> nextSong() async {
    if (currentIndex < musicList.length) {
      currentIndex++;
      await initMusic();
      notifyListeners();
    } else {
      currentIndex = 0;
      await initMusic();
      notifyListeners();
    }
  }

  Future<void> previousSong() async {
    if (currentIndex > 0) {
      currentIndex--;
      await initMusic();
      notifyListeners();
    } else {
      currentIndex = musicList.length - 1;
      await initMusic();
      notifyListeners();
    }
  }

  void seekMusic(Duration duration) {
    audioPlayer.seek(duration);
    notifyListeners();
  }

  late VideoPlayerController videoPlayerController;

  videoControllerInit() {
    videoPlayerController = VideoPlayerController.networkUrl(
      (Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')),
    )..initialize().then((_) {
        notifyListeners();
      });
  }

  void playVideo() {
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    videoPlayerController.play();
  }
}

List<MusicModal> musicList = [
// 1
  MusicModal(
    title: "Halki Halki Si",
    artist: " Asees Kaur",
    path:
        "https://pagalfree.com/musics/128-Halki Halki Si - Asees Kaur 128 Kbps.mp3",
    bimage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTDRh4HnMMyLBRjKogs6sBsDWKfzmw6fVf7g&s",
    fimage:
        "https://feeds.abplive.com/onecms/images/uploaded-images/2022/06/08/aa431b2a2315ae75920ffc7716fd46ec_original.jpg",
  ),

  MusicModal(
    title: "Aayi Nai",
    artist: "Sachin-Jigar, Pawan Singh, Divya Kumar",
    path: "https://pagalfree.com/musics/128-Aayi Nai - Stree 2 128 Kbps.mp3",
    bimage:
        "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR4Wi7I5w0cH6OzxSQ0vPNACrCiEXJeRcSX_RsteIZRF9wVPg6Z",
    fimage:
        "https://img.wynk.in/unsafe/200x200/filters:no_upscale():strip_exif():format(jpg)/http://s3.ap-south-1.amazonaws.com/wynk-music-cms/srch_saregama/20240801205737000/8907212018256/1722528920624/resources/8907212018256.jpg",
  ),
// 2
  MusicModal(
    title: "Bhool Bhulaiyaa 3",
    artist: "Kartik Aaryan  ",
    path:
        "https://pagalfree.com/musics/128-Bhool Bhulaiyaa 3 - Title Track (Feat. Pitbull) - Bhool Bhulaiyaa 3 128 Kbps.mp3",
    bimage:
        "https://upload.wikimedia.org/wikipedia/en/6/6f/Bhool_bhulaiyaa.jpg",
    fimage: "https://static.toiimg.com/photo/114837280.cms?imgsize=35968",
  ),
// 3
  MusicModal(
      title: "Mere Mehboob Mere Sanam",
      artist: " Alka Yagnik",
      path:
          "https://pagalfree.com/download/320-Mere Mehboob Mere Sanam - Bad Newz 320 Kbps.mp3",
      bimage:
          "https://i.scdn.co/image/ab67616d00001e02e1e330d774b305917db5fa82",
      fimage:
          "https://c.saavncdn.com/947/Mere-Mehboob-Mere-Sanam-From-Bad-Newz-Hindi-2024-20240712103733-500x500.jpg"),
// 4
  MusicModal(
    title: "Maar Udi",
    artist: "Shreya Ghoshal",
    path: "https://pagalfree.com/musics/128-Maar Udi - Sarfira 128 Kbps.mp3",
    bimage: "https://i.scdn.co/image/ab67616d0000b27356f33d97add47c95c08a964c",
    fimage: "https://i.ytimg.com/vi/3X-KIObXxpA/sddefault.jpg",
  ),
// 5
  MusicModal(
    title: "Angaaron",
    artist: "Vikas Badisa & Ravi Krishnan ",
    path:
        "https://pagalfree.com/musics/128-Angaaron - Pushpa 2 The Rule 128 Kbps.mp3",
    bimage:
        "https://c.saavncdn.com/580/Angaaron-From-Pushpa-2-The-Rule-Hindi-2024-20240528221027-500x500.jpg",
    fimage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyUZSxrI62ZnzpZAvPNEoD6ZC3KEUHtiK7Nw&s",
  ),
// 6
  MusicModal(
    title: "Tauba Tauba",
    artist: "Karan Aujla & Vicky Kaushal",
    path:
        "https://pagalfree.com/download/320-Tauba Tauba - Bad Newz 320 Kbps.mp3",
    bimage:
        "https://stat4.bollywoodhungama.in/wp-content/uploads/2024/07/Vicky-Kaushal-and-Karan-Aujla-shine-on-Times-Square-with-viral-Tauba-Tauba-from-Bad-Newz-see-pics-1.jpg",
    fimage: "https://i.ytimg.com/vi/gVQlO6XDQp8/maxresdefault.jpg",
  ),

// 8
// 9
  MusicModal(
    title: "Satyanaas",
    artist: "Chandu Champion",
    path:
        "https://pagalfree.com/musics/128-Satyanaas - Chandu Champion 128 Kbps.mp3",
    bimage: "https://pbs.twimg.com/media/GObNFwhWcAA5Elo.jpg",
    fimage:
        "https://a10.gaanacdn.com/gn_img/albums/lJvKa16KDV/vKa5nPJXKD/size_m.jpg",
  ),
// 10
  MusicModal(
    title: "Zaalim",
    artist: "Badshah",
    path: "https://pagalfree.com/musics/128-Zaalim - Badshah 128 Kbps.mp3",
    bimage:
        "https://i1.sndcdn.com/artworks-SwgPKyuEp7yz5O7c-N2fWIA-t1080x1080.jpg",
    fimage: "https://i.ytimg.com/vi/3rWL1mavaKQ/maxresdefault.jpg",
  ),
// 11
  MusicModal(
    title: "Aaj Ki Raat",
    artist: "Sachin-Jigar",
    path: "https://pagalfree.com/musics/128-Aaj Ki Raat - Stree 2 128 Kbps.mp3",
    bimage:
        "https://cdns-images.dzcdn.net/images/cover/126dbc31ec91303660d1a1b74686aad2/0x1900-000000-80-0-0.jpg",
    fimage:
        "https://lyricsraag.com/wp-content/uploads/2024/07/Aaj-Ki-Raat-lyrics-english-Stree-2-Tamannaah-Bhatia.jpg",
  ),
// 12
  MusicModal(
    title: "Khaali Botal",
    artist: "Manan Bhardwaj",
    path:
        "https://pagalfree.com/musics/128-Khaali Botal - Manan Bhardwaj 128 Kbps.mp3",
    bimage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIOvtX0ZvPOHSlyguN7ngK60oG-mebaykDbg&s",
    fimage: "https://i.ytimg.com/vi/AyAzg7YZPRA/maxresdefault.jpg",
  ),
// 13
  MusicModal(
    title: "pushpa pushpa",
    artist: "Allu Arjun",
    path:
        "https://pagalfree.com/musics/128-Pushpa Pushpa - Pushpa 2 The Rule 128 Kbps.mp3",
    bimage:
        "https://upload.wikimedia.org/wikipedia/en/thumb/1/11/Pushpa_2-_The_Rule.jpg/220px-Pushpa_2-_The_Rule.jpg",
    fimage:
        "https://images.news18.com/ibnlive/uploads/2024/10/pushpa-2-release-date-2024-10-3a3d3b3c527135b709a35d5d47e54d3a.jpg?impolicy=website&width=360&height=270",
  ),
// 14
  MusicModal(
    title: "Yaad Aaunga",
    artist: "Stebin Ben",
    path:
        "https://pagalfree.com/musics/128-Main Yaad Aaunga - Stebin Ben 128 Kbps.mp3",
    bimage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzk-7OHKfPpQaa6kSCzYIyWzFiXC95ze8cwg&s",
    fimage: "https://i.ytimg.com/vi/02aYtxLwidM/hqdefault.jpg",
  ),
// 15
  MusicModal(
    title: "ghagra",
    artist: "Crew",
    path: "https://pagalfree.com/musics/128-Ghagra - Crew 128 Kbps.mp3",
    bimage: "https://i.scdn.co/image/ab67616d0000b273ab00f27207dbce8fb602d9b1",
    fimage:
        "https://english.cdn.zeenews.com/sites/default/files/styles/zm_500x286/public/2024/03/14/1376173-crew-ghagra.png",
  ),
// 16
  MusicModal(
    title: "Team India Hain HUm",
    artist: "Maidaan",
    path:
        "https://pagalfree.com/musics/128-Team India Hain Hum - Maidaan 128 Kbps.mp3",
    bimage:
        "https://c.saavncdn.com/499/Maidaan-Hindi-2024-20240427083419-500x500.jpg",
    fimage:
        "https://i.ytimg.com/vi/syL5y4G-gig/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCMhQ8dxY-nOVNEtSx8nOoCzEhJ2Q",
  ),
// 17
  MusicModal(
    title: "Tilasmi Bahein",
    artist: "Heeramandi",
    path:
        "https://pagalfree.com/musics/128-Tilasmi Bahein - Heeramandi 128 Kbps.mp3",
    bimage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSLEBQ-cCDv8Fi7yiaynmba31WZiZOBlJegnB13G-DDTrE4yipzSYyeJpjEKpbfADuBos&usqp=CAU",
    fimage:
        "https://miro.medium.com/v2/resize:fit:739/1*-g-4MNiotmgUwg2cu_mt6A.jpeg",
  ),
];
