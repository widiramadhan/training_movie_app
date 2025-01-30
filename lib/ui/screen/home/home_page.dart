import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/ui/screen/home/home_screen.dart';
import 'package:movie/ui/screen/home/section/categories/cubit/categories_cubit.dart';
import 'package:movie/ui/screen/home/section/now_playing/cubit/now_playing_cubit.dart';
import 'package:movie/ui/screen/home/section/upcoming/cubit/upcoming_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CategoriesCubit()..getGenres(),
        ),
        BlocProvider(
          create: (_) => NowPlayingCubit()..getNowPlaying(),
        ),
        BlocProvider(
          create: (_) => UpcomingCubit()..getUpcoming(),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}
