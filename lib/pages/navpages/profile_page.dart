import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rekomendasi_wisata_2/auth/login.dart';
import 'package:rekomendasi_wisata_2/misc/colors.dart';
import 'package:rekomendasi_wisata_2/misc/hex_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Box _boxLogin = Hive.box('login');
    final Box _boxAccounts = Hive.box('accounts');

    return Scaffold(
      backgroundColor: HexColor("#66afe2"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 18),
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Informasi Akun",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          "Nama: " + _boxAccounts.get('person_name'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(
                        "Nomor Telpon: " + _boxAccounts.get('person_phone'),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Email: " + _boxAccounts.get('person_email'),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Umur: " + _boxAccounts.get('person_age'),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Alamat: " + _boxAccounts.get('person_address'),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
          onPressed: () {
            _boxLogin.put("loginStatus", false);

            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false);
          },
          child: const Center(
            child: Text(
              'Keluar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
