import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:uic_tz/src/config/routes/routes.dart';
import 'package:uic_tz/src/core/resours/app_style/style.dart';
import 'package:uic_tz/src/features/presentation/music_screen/cubit/audio_cubit.dart';

import '../bloc/audio_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // final player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        centerTitle: true,
        // backgroundColor: AppColors.c111111,
        // elevation: 0,
      ),
      // backgroundColor: AppColors.c111111,
      body: BlocBuilder<AudioCubit, AudioPlaylistState>(
        builder: (context, state) {
          if (state is AudioLoadSuccess) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final song = state.songs[index];

                return GestureDetector(
                  onTap: () {
                    context.read<AudioBloc>().add(StartedAudio(audioUrl: song.data));
                    context.read<AudioCubit>().currentSong = index;
                    Navigator.pushNamed(context, RouteNames.music, arguments: song);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color(0xFF232323), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: QueryArtworkWidget(id: song.id, type: ArtworkType.AUDIO),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                style: AppStyle.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(song.artist ?? 'Unknown', style: AppStyle.bodySmall),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Text(
                            formatSeconds(song.duration! ~/ 3600),
                            style: AppStyle.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: state.songs.length,
            );
          } else if (state is AudioLoadFailure) {
            return Text(state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MusicDetail extends StatelessWidget {
  const MusicDetail({
    super.key,
    required this.song,
  });

  final SongModel song;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: BlocBuilder<AudioBloc, AudioState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<AudioBloc, AudioState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        QueryArtworkWidget(id: song.id, type: ArtworkType.AUDIO),
                        const SizedBox(height: 20),
                        Text(song.title, style: AppStyle.bodyMedium),
                        const SizedBox(height: 10),
                        Text(song.artist ?? 'Unknown', style: AppStyle.bodySmall),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Text('00:00'),
                            Text('00:00'),
                          ],
                        ),
                        Slider(

                            value: 0,
                        //     max: state.maxDuration.toDouble(),
                            onChanged: (value) {
                        //       context
                        //           .read<AudioBloc>()
                        //           .add(SeekAudio(targetPosition: value.toInt()));
                            }),

                      ],
                    );
                  },
                ),
                // IconButton(
                //     onPressed: () {
                //       if (state is AudioInitial || state is AudioStopped) {
                //         // context.read<AudioBloc>().add(
                //         //     const StartedAudio(audioUrl: 'musics/Uzmir-Onamni_asra_Robbim.mp3'));
                //       } else if (state is AudioPlaying) {
                //         context.read<AudioBloc>().add(PauseAudio());
                //       } else if (state is AudioPaused) {
                //         context.read<AudioBloc>().add(PlayAudio());
                //       }
                //     },
                //     icon: state is AudioPlaying
                //         ? const Icon(Icons.pause)
                //         : const Icon(Icons.play_arrow))
              ],
            );
          },
        )),
      ),
    );
  }
}

String formatSeconds(int seconds) {
  if (seconds < 3600) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  } else {
    int hours = seconds ~/ 3600;
    int remainingMinutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
