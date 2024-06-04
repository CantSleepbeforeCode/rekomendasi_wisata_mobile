import 'package:equatable/equatable.dart';
import 'package:rekomendasi_wisata_2/model/kuliner_model.dart';
import 'package:rekomendasi_wisata_2/model/wisata_model.dart';

abstract class CubitStates extends Equatable {}

class InitialState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class WelcomeState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CubitStates {
  @override
  List<Object?> get props => [];
}

class LoadedState extends CubitStates {
  final List<WisataModel> wisatas;
  final List<KulinerModel> kuliners;
  final bool isWisata;

  LoadedState(this.wisatas, this.kuliners, this.isWisata);

  @override
  List<Object?> get props => [wisatas, kuliners, isWisata];
}

class DetailStateWisata extends CubitStates {
  final WisataModel wisata;

  DetailStateWisata(this.wisata);

  @override
  List<Object?> get props => [wisata];
}

class DetailStateKuliner extends CubitStates {
  final KulinerModel kuliner;

  DetailStateKuliner(this.kuliner);

  @override
  List<Object?> get props => [kuliner];
}

class ErrorState extends CubitStates {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
