import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecilenKolonRepository extends ChangeNotifier{

  final List<int> secilenKolon = [];
  final List<int>birinciKolonButonKontrolListe=[];
  final List<int>ikinciKolonButonKontrolListe=[];
  final List<int>ucuncuKolonButonKontrolListe=[];


  void kolonaEkle(eklenecekSayi){
    secilenKolon.add(eklenecekSayi);
    notifyListeners();

  }

  void sil(){
    secilenKolon.removeLast();
    notifyListeners();
  }




}

final secilenKolonProvider = ChangeNotifierProvider.autoDispose((ref) {
  return SecilenKolonRepository();
});