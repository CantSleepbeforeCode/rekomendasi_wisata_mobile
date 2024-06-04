import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rekomendasi_wisata_2/env.dart';
import 'package:rekomendasi_wisata_2/model/kuliner_model.dart';
import 'package:rekomendasi_wisata_2/model/wisata_model.dart';

class DataServices {

  Future<List<WisataModel>> getInfoWisata() async {
    http.Response res = await http.get(Uri.parse(Env.urlApi + '/list-wisata'));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body)['data'];
        return list.map((e) => WisataModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
  Future<List<KulinerModel>> getInfoKuliner() async {
    http.Response res = await http.get(Uri.parse(Env.urlApi + '/list-kuliner'));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body)['data'];
        return list.map((e) => KulinerModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
