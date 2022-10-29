import 'dart:math';



void main() {

  var secilenKolon = [1,2,3,4,5,6,7,8,9,10,11,12,2,14,15,16,17,3];
  var cekilisSonucu = [];
  cekilisSonucu.removeLast();

  secilenKolon.removeRange(1, secilenKolon.length);

  for(var sayi in secilenKolon){
    print(sayi);
  }







  int kacBildik(int kolonBilgisi) {
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
    for (i; i < s; i++) {
      for (int j = 0; j < 6; j++) {

        if (secilenKolon[i] == cekilisSonucu[j]) {
          dogruSayisi++;
        }
      }
    }

    return dogruSayisi;
  }


}


