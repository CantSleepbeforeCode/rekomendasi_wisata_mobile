import 'package:bloc/bloc.dart';
import 'package:rekomendasi_wisata_2/cubit/app_cubit_states.dart';
import 'package:rekomendasi_wisata_2/model/kuliner_model.dart';
import 'package:rekomendasi_wisata_2/model/wisata_model.dart';
import 'package:rekomendasi_wisata_2/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }

  final DataServices data;
  late final wisatas;
  late final kuliners;

  void getData() async {
    try {
      emit(LoadingState());
      wisatas = await data.getInfoWisata();
      kuliners = await data.getInfoKuliner();
      emit(LoadedState(wisatas, kuliners, true));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  detailDataWisata(WisataModel data) {
    emit(DetailStateWisata(data));
  }

  detailDataKuliner(KulinerModel data) {
    emit(DetailStateKuliner(data));
  }

  goKuliner() {
    emit(LoadedState(wisatas, kuliners, false));
  }

  goWisata() {
    emit(LoadedState(wisatas, kuliners, true));
  }
}
