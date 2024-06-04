import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_states.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubits.dart';
import 'package:rekomendasi_wisata_2/misc/colors.dart';
import 'package:rekomendasi_wisata_2/pages/navpages/kuliner_page.dart';
import 'package:rekomendasi_wisata_2/pages/navpages/profile_page.dart';
import 'package:rekomendasi_wisata_2/pages/navpages/wisata_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const WisataPage(),
    const KulinerPage(),
    const ProfilePage(),
  ];

  int currentIndex = 0;
  bool definedIndex = false;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!definedIndex) {
      CubitStates test = BlocProvider.of<AppCubits>(context).state;
      if (test is LoadedState) {
        int index = 0;
        if (test.isWisata) {
          index = 0;
        } else {
          index = 1;
        }

        setState(() {
          currentIndex = index;
        });
      }

      definedIndex = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.mainColor.withOpacity(0.3),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: '', icon: Icon(Icons.beach_access)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.food_bank)),
          BottomNavigationBarItem(label: '', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
