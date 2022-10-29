import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayisal_loto/pages/SonucSayfasi.dart';
import 'package:sayisal_loto/pages/repository/cekilis_sonucu_repository.dart';
import 'package:sayisal_loto/pages/repository/secilen_kolon_repository.dart';

void main() {

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Süper Loto',
      theme: ThemeData(

        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Süper Loto'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
   const MyHomePage({super.key, required this.title});


  final String title;



  @override
  Widget build(BuildContext context,WidgetRef ref) {



    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    final cekilis = CekilisSonucuRepository();

    final kolonElemanSayisi = secilenKolonRepository.secilenKolon.length;











    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
                'Numaralarınızı Seçin'
            ),
            const SizedBox(height: 10,),

            Column(

              children:  [
                const SecilecekSayilar(),

                BirinciKolon(secilenKolonRepository.secilenKolon),
                const SizedBox(height: 20,),

                IkinciKolon(secilenKolonRepository.secilenKolon),
                const SizedBox(height: 20,),

                UcuncuKolon(secilenKolonRepository.secilenKolon),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: kolonElemanSayisi %6 != 0 || kolonElemanSayisi==0 ? null : ()async{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Çekiliş Başlıyor')));
                        await Future.delayed(const Duration(seconds: 2));
                        await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SonucSayfasi()));
                        ref.refresh(secilenKolonProvider);



                      },
                      child: const Text(
                          'Oyna'
                      ),
                    ),
                    ElevatedButton(
                      onPressed: kolonElemanSayisi<1 ? null : (){
                        secilenKolonRepository.sil();
                        if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                          secilenKolonRepository.birinciKolonButonKontrolListe.removeLast();
                        }
                        else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                          secilenKolonRepository.ikinciKolonButonKontrolListe.removeLast();
                        }
                        else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                          secilenKolonRepository.ucuncuKolonButonKontrolListe.removeLast();
                        }

                      },
                      child: const Text(
                          'Sil'
                      ),
                    ),

                  ],
                ),


              ],
            ),


          ],
        ),
      ),


    );
  }
}








class SecilecekSayilar extends ConsumerStatefulWidget {




  const SecilecekSayilar(
      {
    Key? key,
  }) : super(key: key);

  @override
    _SecilecekSayilarState createState() => _SecilecekSayilarState();
}

class _SecilecekSayilarState extends ConsumerState<SecilecekSayilar> {

int eklemeSayisi=0;





  @override
  Widget build(BuildContext context) {
    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    List<int>?geciciButonKontrolListe;

    if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
      geciciButonKontrolListe = secilenKolonRepository.birinciKolonButonKontrolListe;
    }
    else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
      geciciButonKontrolListe = secilenKolonRepository.ikinciKolonButonKontrolListe;
    }
    else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
      geciciButonKontrolListe = secilenKolonRepository.ucuncuKolonButonKontrolListe;
    }


    return Column(
      children: [
        Row(
          children: [
            for(int i =1 ; i<7 ; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: OutlinedButton(
                  onPressed: secilenKolonRepository.secilenKolon.length >= 18 ||geciciButonKontrolListe!.contains(i)? null :(){


                          //Sayıları seçtikçe butonların sönmesi ve yeni kolona geçtikçe tekrar açılması için her kolon için ayrı butonkontrol listesi oluşturuyorum
                    if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                      secilenKolonRepository.birinciKolonButonKontrolListe.add(i);
                    }
                    else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                      secilenKolonRepository.ikinciKolonButonKontrolListe.add(i);
                    }
                    else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                      secilenKolonRepository.ucuncuKolonButonKontrolListe.add(i);
                    }
                    secilenKolonRepository.kolonaEkle(i);



                    },
                    child: Text('$i'),
                ),
              ),
            )
          ],

        ),
        Row(
          children: [
            for(int i =7 ; i<13 ; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OutlinedButton(

                    onPressed: secilenKolonRepository.secilenKolon.length >= 18 ||geciciButonKontrolListe!.contains(i)? null :(){

                      if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                        secilenKolonRepository.birinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                        secilenKolonRepository.ikinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                        secilenKolonRepository.ucuncuKolonButonKontrolListe.add(i);
                      }
                      secilenKolonRepository.kolonaEkle(i);
                    },
                    child: Text('$i'),
                  ),
                ),
              )
          ],

        ),
        Row(
          children: [
            for(int i =13 ; i<19 ; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OutlinedButton(


                    onPressed: secilenKolonRepository.secilenKolon.length >= 18 ||geciciButonKontrolListe!.contains(i)? null :(){

                      if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                        secilenKolonRepository.birinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                        secilenKolonRepository.ikinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                        secilenKolonRepository.ucuncuKolonButonKontrolListe.add(i);
                      }
                      secilenKolonRepository.kolonaEkle(i);



                    },
                    child:Text('$i'),
                  ),
                ),
              )
          ],

        ),
        Row(
          children: [
            for(int i =19 ; i<25 ; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OutlinedButton(

                    onPressed: secilenKolonRepository.secilenKolon.length >= 18 ||geciciButonKontrolListe!.contains(i)? null :(){

                      if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                        secilenKolonRepository.birinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                        secilenKolonRepository.ikinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                        secilenKolonRepository.ucuncuKolonButonKontrolListe.add(i);
                      }
                      secilenKolonRepository.kolonaEkle(i);
                    },
                    child: Text('$i'),
                  ),
                ),
              )
          ],

        ),
        Row(
          children: [
            for(int i =25 ; i<31 ; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: OutlinedButton(

                    onPressed: secilenKolonRepository.secilenKolon.length >= 18 ||geciciButonKontrolListe!.contains(i)? null :(){

                      if(secilenKolonRepository.secilenKolon .length >=0 && secilenKolonRepository.secilenKolon.length<6){
                        secilenKolonRepository.birinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=6 && secilenKolonRepository.secilenKolon.length<12){
                        secilenKolonRepository.ikinciKolonButonKontrolListe.add(i);
                      }
                      else if(secilenKolonRepository.secilenKolon .length >=12 && secilenKolonRepository.secilenKolon.length<18){
                        secilenKolonRepository.ucuncuKolonButonKontrolListe.add(i);
                      }
                      secilenKolonRepository.kolonaEkle(i);
                    },
                    child: Text('$i'),
                  ),
                ),
              )
          ],

        ),




          ],
        );
      }
      }

class BirinciKolon extends ConsumerWidget {
  final List<int> kolon;
  const BirinciKolon(this.kolon,{
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    return Row(

    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[



    for(int i =0 ; i<6 ; i++)
    Expanded(
    child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(15),
    backgroundColor: Colors.blue, // <-- Button color
    foregroundColor: Colors.red, // <-- Splash color
    ),
    child: Text(kolon.length< i+1 ? '' : '${kolon[i]}',style: const TextStyle(fontSize: 16),), // Seçmediysek boş kalsın

    ),
    ),


    ],
    );
  }
}

class IkinciKolon extends ConsumerWidget {
  final List<int>kolon;
  const IkinciKolon(this.kolon,{
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[



        for(int i =6 ; i<12 ; i++)
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.blue, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
              child: Text(kolon.length< i+1 ? '' : '${kolon[i]}',style: const TextStyle(fontSize: 16),),

            ),
          ),


      ],
    );
  }
}
class UcuncuKolon extends ConsumerWidget {
  final List<int>kolon;
  const UcuncuKolon(this.kolon,{
    Key? key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[



        for(int i =12 ; i<18 ; i++)
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
                backgroundColor: Colors.blue, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
              child: Text(kolon.length< i+1 ? '' : '${kolon[i]}',style: const TextStyle(fontSize: 16),), // Daha sayı seçilmediyse kutucuk boş kalsın

            ),
          ),


      ],
    );
  }
}


