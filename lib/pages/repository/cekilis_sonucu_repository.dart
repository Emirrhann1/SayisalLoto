import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayisal_loto/pages/repository/secilen_kolon_repository.dart';

class CekilisSonucuRepository extends ChangeNotifier {
  final List<int> cekilisSonucu = [];
  final List<int> siraliKolonListe = [];
  final secilenKolonRepository = SecilenKolonRepository();



  void cekilisYap() {
    final List<int> sayilar = [for(int i = 1; i <= 30; i++) i];



    var randomSayi = 30;


    for (int i = 0; i < 6; i++) {
      var eklenecekSayiIndex = Random().nextInt(randomSayi);

      cekilisSonucu.add(sayilar[eklenecekSayiIndex]);

      sayilar.removeAt(eklenecekSayiIndex);
      randomSayi--;


    }
    cekilisSonucu.sort();


  }

  List<int>kolonuSirala(List<int>kolon,int kolonBilgisi){ // Kolonumuzu küçükten büyüğe göstermek için
    int baslangicIndex=0;
    int bitisIndex=0;

    if(kolonBilgisi == 1){
      baslangicIndex = 0;
      bitisIndex=5;
    }
    else if(kolonBilgisi == 2){
      baslangicIndex = 6;
      bitisIndex = 11;
    }
    else if (kolonBilgisi == 3){
      baslangicIndex = 12;
      bitisIndex = 17;
    }

    List<int> geciciSiraliListe = [for(int i = baslangicIndex ; i<bitisIndex+1 ; i++) kolon[i]]; //Oynanan kolonu alıp sıralıyoruz.

    geciciSiraliListe.sort();

    for(var sayi in geciciSiraliListe){
      siraliKolonListe.add(sayi);
    }





    return siraliKolonListe;

  }


  int kacBildik(List<int>kolon,int kolonBilgisi) {
    int dogruSayisi = 0;
    int i = 0;
    int s = 5;
    if (kolonBilgisi == 1) {
      i = 0;
      s = 6;
    }
    else if (kolonBilgisi == 2) {
      i = 6;
      s = 12;
    }
    else if (kolonBilgisi == 3) {
      i = 12;
      s = 18;
    }
    else {

    }
    for (int a = i; a < s; a++) {
      for (int j = 0; j < 6; j++) {
        if (kolon[a] == cekilisSonucu[j]) {
          dogruSayisi++;
        }
      }
    }


    return dogruSayisi;
  }

}
final cekilisSonucuProvider = ChangeNotifierProvider.autoDispose((ref) => CekilisSonucuRepository());