import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String mAudio = "https://raag.fm/files/mp3/128/Hindi-Singles/23303/Kesariya%20(Brahmastra)%20-%20(Raag.Fm).mp3";
  AudioPlayer? mPlayer;
  Duration? totalDuration = Duration.zero;
  Duration? bufferedPos = Duration.zero;

  @override
  void initState() {
    super.initState();

    setUpMyAudioPlayer();
  }

  void setUpMyAudioPlayer() async{
    mPlayer = AudioPlayer();

    totalDuration = await mPlayer!.setUrl(mAudio);

    mPlayer!.play();

    mPlayer!.positionStream.listen((event) {
      setState(() {

      });
    });

    mPlayer!.bufferedPositionStream.listen((event) {
      bufferedPos = event;
      setState(() {

      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressBar(
                progress: mPlayer!.position,
                total: totalDuration!,
                buffered: bufferedPos,
                thumbColor: Colors.amber,
                onSeek: (value){
                  mPlayer!.seek(value);
                  setState(() {

                  });
                },
                thumbGlowColor: Colors.amber.withOpacity(0.2),
                baseBarColor: Colors.grey,
                progressBarColor: Colors.amber,
                bufferedBarColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)
                    ),
                    child: IconButton(
                      onPressed: (){
                      },
                      icon: Icon(Icons.skip_previous),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)
                    ),
                    child: IconButton(
                      onPressed: (){
                        if(mPlayer!.playing){
                          mPlayer!.pause();
                        } else {
                          mPlayer!.play();
                        }
                        setState(() {

                        });
                      },
                      icon: Icon(mPlayer!.playing? Icons.pause : Icons.play_arrow),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)
                    ),
                    child: IconButton(
                      onPressed: (){
                      },
                      icon: Icon(Icons.skip_next),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
