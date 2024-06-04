import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_states.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubits.dart';
import 'package:rekomendasi_wisata_2/misc/colors.dart';
import 'package:rekomendasi_wisata_2/pages/detail_page_kuliner.dart';
import 'package:rekomendasi_wisata_2/pages/detail_page_wisata.dart';
import 'package:rekomendasi_wisata_2/pages/navpages/main_page.dart';
import 'package:rekomendasi_wisata_2/pages/welcome_page.dart';
import 'package:rekomendasi_wisata_2/widgets/app_text_large.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is WelcomeState) {
            return const WelcomePage();
          } else if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.mainColor));
          } else if (state is LoadedState) {
            return const MainPage();
          } else if (state is DetailStateWisata) {
            return const DetailPageWisata();
          } else if (state is DetailStateKuliner) {
            return const DetailPageKuliner();
          } else if (state is ErrorState) {
            return Center(child: AppTextLarge(text: state.message));
          } else {
            print(state);
            return const Center(child: AppTextLarge(text: 'BLoC Failed'));
          }
        },
      ),
    );
  }
}
