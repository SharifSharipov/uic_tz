import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:uic_tz/src/features/data/repository/audio_repository.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioPlaylistState> {
  final AudioRepository _repository = AudioRepository();

  AudioCubit() : super(AudioPlaylistInitial());
  int currentSong = -1;

  Future<void> fetchSongs() async {
    try {
      final songs = await _repository.getAllSongs();
      songs.isSuccess
          ? emit(AudioLoadSuccess(songs.data))
          : emit(AudioLoadFailure(message: songs.errorMessage ?? "Something went wrong"));
    } catch (e) {
      emit(AudioLoadFailure(message: e.toString()));
    }
  }
}
