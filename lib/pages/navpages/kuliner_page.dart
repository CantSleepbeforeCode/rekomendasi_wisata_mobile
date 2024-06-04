import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_states.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubits.dart';
import 'package:rekomendasi_wisata_2/env.dart';
import 'package:rekomendasi_wisata_2/misc/currency_format.dart';
import 'package:rekomendasi_wisata_2/misc/hex_colors.dart';
import 'package:rekomendasi_wisata_2/model/kuliner_model.dart';
import 'package:rekomendasi_wisata_2/widgets/app_text.dart';
import 'package:show_up_animation/show_up_animation.dart';

List<KulinerModel> kuliners = [];

class KulinerPage extends StatefulWidget {
  const KulinerPage({super.key});

  @override
  State<KulinerPage> createState() => _KulinerPageState();
}

class _KulinerPageState extends State<KulinerPage> with TickerProviderStateMixin {
  final Box _boxLogin = Hive.box("login");

  TextEditingController controller = new TextEditingController();
  List<Widget> imageSliders = [];
  List<KulinerModel> carouselImage = [];
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            if (state is LoadedState) {
              kuliners = state.kuliners;
              if (!isLoaded) {
                _searchResult = kuliners;

                if (kuliners.length >= 3) {
                  for (var i = 0; i <= 2; i++) {
                    carouselImage.add(kuliners[i]);
                  }
                } else {
                  for (var i = 0; i < kuliners.length; i++) {
                    carouselImage.add(kuliners[i]);
                  }
                }

                imageSliders = carouselImage
                    .map((item) => GestureDetector(
                      onTap: () {
                        MapsLauncher.launchCoordinates(
                                double.parse(item.kuliner_latitude),
                                double.parse(item.kuliner_longitude));
                      },
                      child: Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                          Env.urlAsset + item.kuliner_picture,
                                          fit: BoxFit.cover,
                                          width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Text(
                                            item.kuliner_name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                    ))
                    .toList();

                isLoaded = true;
              }
            }

            return Scaffold(
              backgroundColor: HexColor("#66afe2"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageSliders.isEmpty ? Container() : CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom),
                        items: imageSliders),
                    // Container(
                    //   padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           _boxLogin.put("loginStatus", false);

                    //           Navigator.of(context, rootNavigator: true)
                    //               .pushAndRemoveUntil(
                    //                   MaterialPageRoute(
                    //                       builder: (context) => Login()),
                    //                   (route) => false);
                    //         },
                    //         child: const Icon(
                    //           Icons.logout,
                    //           size: 32.0,
                    //           color: Colors.black45,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 10.0),
                    Container(
                      child: new Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text("Mau makan apa hari ini?", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),),
                        ),
                    ),
                    // const SizedBox(height: 5.0),
                    new Container(
                      child: new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Card(
                          child: new ListTile(
                            leading: new Icon(Icons.search),
                            title: new TextField(
                              controller: controller,
                              decoration: new InputDecoration(
                                  hintText: 'Cari Kuliner',
                                  border: InputBorder.none),
                              onChanged: onSearchTextChanged,
                            ),
                            trailing: new IconButton(
                              icon: new Icon(Icons.cancel),
                              onPressed: () {
                                controller.clear();
                                onSearchTextChanged('');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15.0),
                      height: double.maxFinite,
                      child: _searchResult.isEmpty
                          ? Text(
                              "Tidak ada data ditemukan",
                              textAlign: TextAlign.center,
                            )
                          : ListView.builder(
                              itemCount: _searchResult.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return ShowUpAnimation(
                                  direction: Direction.vertical,
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<AppCubits>(context)
                                          .detailDataKuliner(
                                              _searchResult[index]);
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      margin: const EdgeInsets.only(
                                          right: 15.0, top: 20.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(Env.urlAsset +
                                              _searchResult[index]
                                                  .kuliner_picture),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            bottom: 15,
                                            left: 10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AppText(
                                                  text: _searchResult[index]
                                                      .kuliner_name,
                                                  color: Colors.white,
                                                  isCenter: false,
                                                ),
                                                const SizedBox(height: 5.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.money,
                                                      color: Colors.white,
                                                      size: 14.0,
                                                    ),
                                                    const SizedBox(width: 2.0),
                                                    AppText(
                                                      text: "Mulai dari " +
                                                          CurrencyFormat
                                                              .convertToIdr(
                                                                  _searchResult[
                                                                          index]
                                                                      .kuliner_min_price,
                                                                  2),
                                                      color: Colors.white
                                                          .withOpacity(0.8),
                                                      size: 12.0,
                                                      isCenter: false,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult = [];
    setState(() {});
    if (text.isEmpty) {
      _searchResult = kuliners;
      setState(() {});
      return;
    } else {
      kuliners.forEach((wisata) {
        if (wisata.kuliner_name.contains(text)) {
          _searchResult.add(wisata);
        }
      });
      setState(() {});
    }
  }
}

List<KulinerModel> _searchResult = [];

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;

    Offset circleOffset = Offset(
        configuration.size!.width / 2, configuration.size!.height - radius);

    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
