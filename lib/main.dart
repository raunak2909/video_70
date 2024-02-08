

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_70/audio_page.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String mUrl = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  VideoPlayerController? playerController;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

   /* var json = "";
    var mData = jsonDecode(json);
    var myModel = Model.fromJson(mData);*/

    playerController = VideoPlayerController.networkUrl(Uri.parse(mUrl));
    playerController!.initialize().then((value){
      setState(() {

      });
    });
    playerController!.addListener(() {
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: playerController!.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(playerController!),
                Center(
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5)
                      ),
                      child: IconButton(
                        onPressed: (){
                          if(playerController!.value.isPlaying){
                            playerController!.pause();
                            isVisible = true;
                          } else {
                            playerController!.play();
                            isVisible = false;
                          }
                          setState(() {

                          });
                        },
                        icon: Icon(playerController!.value.isPlaying? Icons.pause : Icons.play_arrow),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Slider(
                      thumbColor: Colors.amber,
                        activeColor: Colors.amber,
                        inactiveColor: Colors.grey,
                        value: playerController!.value.position.inSeconds.toDouble(),
                        min: 0,
                        max: playerController!.value.duration.inSeconds.toDouble(),
                        onChanged: (value){
                          playerController!.seekTo(Duration(seconds: value.toInt()));
                          setState(() {

                          });
                        }
                    ),
                  ),
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPage(),));
        },
        child: Text('Audio'),
      ),
    );
  }
}
