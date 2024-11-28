import 'package:flutter/material.dart';
import 'package:media_booster_app/screen/music/provider/music_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isGridView = true;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  late MusicProvider providerW;
  late MusicProvider providerR;

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<MusicProvider>();
    providerR = context.read<MusicProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isGridView ? Icons.list : Icons.grid_view,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isGridView = !isGridView;
              });
            },
          ),
        ],
        bottom: TabBar(
          labelColor: Colors.amber,
          unselectedLabelColor: Colors.white70,
          controller: tabController,
          indicatorColor: Colors.amber,
          tabs: const [
            Tab(icon: Icon(Icons.music_note), text: 'Music'),
            Tab(icon: Icon(Icons.video_camera_back_outlined), text: 'Video'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          isGridView
              ? GridView.builder(
                  itemCount: musicList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      providerR.idxMusic(index);
                      Navigator.pushNamed(
                        context,
                        'detail',
                        arguments: musicList[index],
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        providerR.idxMusic(index);
                        Navigator.pushNamed(
                          context,
                          'music',
                          arguments: musicList[index],
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(musicList[index].bimage!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              musicList[index].title ?? 'No Title',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: musicList.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      providerR.idxMusic(index);
                      Navigator.pushNamed(
                        context,
                        'music',
                        arguments: musicList[index],
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            musicList[index].bimage!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          musicList[index].title ?? 'No Title',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        subtitle: Text(
                          'Artist: ${musicList[index].artist ?? 'Unknown'}',
                          style: const TextStyle(color: Colors.blueGrey),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
          const Center(
            child: Text(
              'Videos Section Coming Soon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
