import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_tz/src/config/routes/routes.dart';
import 'package:uic_tz/src/features/presentation/music_screen/bloc/audio_bloc.dart';
import 'package:uic_tz/src/features/presentation/music_screen/cubit/audio_cubit.dart';
import 'package:uic_tz/src/features/presentation/music_screen/page/music_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AudioBloc()),
        BlocProvider(create: (context) => AudioCubit()..fetchSongs()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: HomeScreen(),
    );
  }
}
