import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_logics.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubits.dart';
import 'package:rekomendasi_wisata_2/services/data_services.dart';


class AppMaster extends StatelessWidget {
  const AppMaster({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AppCubits(data: DataServices()),
        child: const AppCubitLogics(),
      ),
    );
  }
}
