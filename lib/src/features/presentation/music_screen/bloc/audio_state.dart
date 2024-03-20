part of 'audio_bloc.dart';

class AudioState {
  final List<SongModel> songs;

  const AudioState({this.songs = const []});

}

// class AudioCompleted extends AudioState {}
//
// class AudioDurationChanged extends AudioState {
//   final int newDuration;
//
//   const AudioDurationChanged(this.newDuration);
//
//   @override
//   List<Object> get props => [newDuration];
// }
