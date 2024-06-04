import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_states.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubits.dart';
import 'package:rekomendasi_wisata_2/env.dart';
import 'package:rekomendasi_wisata_2/misc/colors.dart';
import 'package:rekomendasi_wisata_2/misc/currency_format.dart';
import 'package:rekomendasi_wisata_2/widgets/app_text.dart';
import 'package:rekomendasi_wisata_2/widgets/app_text_large.dart';
import 'package:show_up_animation/show_up_animation.dart';

class DetailPageKuliner extends StatefulWidget {
  const DetailPageKuliner({super.key});

  @override
  State<DetailPageKuliner> createState() => _DetailPageKulinerState();
}

class _DetailPageKulinerState extends State<DetailPageKuliner> {
  int selectedIndex = -1;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppCubits>(context).goKuliner();
        // Navigator.pop(context, true);
        return false;
      },
      child: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          DetailStateKuliner detail = state as DetailStateKuliner;

          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor),
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () async {
                            MapsLauncher.launchCoordinates(
                                double.parse(detail.kuliner.kuliner_latitude),
                                double.parse(detail.kuliner.kuliner_longitude));
                          },
                          child: Container(
                              margin: const EdgeInsets.only(left: 20.0),
                              child: const AppText(
                                text: 'Berangkat Sekarang',
                                color: Colors.white,
                                isCenter: true,
                              )),
                        ),
                      ),
              ),
              body: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                Env.urlAsset + detail.kuliner.kuliner_picture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50.0,
                      left: 20.0,
                      right: 20.0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ShowUpAnimation(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_rounded),
                                onPressed: () =>
                                    BlocProvider.of<AppCubits>(context)
                                        .goKuliner(),
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 360,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 35.0, horizontal: 30.0),
                        width: MediaQuery.of(context).size.width,
                        height: 650,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40.0),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShowUpAnimation(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppTextLarge(
                                        text: detail.kuliner.kuliner_name,
                                        color: Colors.black.withOpacity(0.8)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              ShowUpAnimation(
                                child: Row(
                                  children: [
                                    const Icon(Icons.price_check,
                                        color: AppColors.mainColor),
                                    const SizedBox(width: 5.0),
                                    AppText(
                                      text: CurrencyFormat.convertToIdr(
                                              detail.kuliner.kuliner_min_price,
                                              2) +
                                          " - " +
                                          CurrencyFormat.convertToIdr(
                                              detail.kuliner.kuliner_max_price,
                                              2),
                                      color: AppColors.mainColor,
                                      isCenter: false,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              ShowUpAnimation(
                                child: AppTextLarge(
                                  text: 'Deskripsi',
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              ShowUpAnimation(
                                child: AppText(
                                  text: detail.kuliner.kuliner_description,
                                  color: AppColors.mainTextColor,
                                  isCenter: false,
                                ),
                                //     child: SingleChildScrollView(
                                //   child: Html(
                                //     data: detail.kuliner.kuliner_description +
                                //         "<br> testiskuda",
                                //   ),
                                // )
                              ),
                              const SizedBox(height: 35.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 30,
                    //   left: 20,
                    //   right: 20,
                    //   child:
                    // ShowUpAnimation(
                    //     child: Flexible(
                    //         child: Container(
                    //   width: double.maxFinite,
                    //   height: 60,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15.0),
                    //     color: AppColors.mainColor,
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () async {
                    //           MapsLauncher.launchCoordinates(
                    //               double.parse(detail.kuliner.kuliner_latitude),
                    //               double.parse(detail.kuliner.kuliner_longitude));
                    //         },
                    //         child: Container(
                    //             margin: const EdgeInsets.only(left: 20.0),
                    //             child: const AppText(
                    //               text: 'Berangkat Sekarang',
                    //               color: Colors.white,
                    //               isCenter: true,
                    //             )),
                    //       ),
                    //     ],
                    //   ),
                    // ))),
                    // ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
