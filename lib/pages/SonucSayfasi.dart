import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sayisal_loto/main.dart';
import 'package:sayisal_loto/pages/repository/cekilis_sonucu_repository.dart';
import 'package:sayisal_loto/pages/repository/secilen_kolon_repository.dart';

class SonucSayfasi extends ConsumerWidget {

  const SonucSayfasi({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final secilenKolonRepository = ref.watch(secilenKolonProvider);
    final cekilisSonucuRepository = ref.watch(cekilisSonucuProvider);
    cekilisSonucuRepository.cekilisYap();
    print('çekiliş : ${cekilisSonucuRepository.cekilisSonucu.length}');
    print('kolon : ${secilenKolonRepository.secilenKolon.length}');


    return Scaffold(
      appBar: AppBar(title: Text('Çekiliş Sonuç Sayfası')),

      body: Column(

        children: [
          SizedBox(height: 25,),

          const Center(
            child: Text(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                'Çekiliş Sonucu'
            ),
          ),
          SizedBox(height: 20,),


          Row(
            children: [
              for(int i =0 ; i<6 ; i++)
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.yellow, // <-- Button color
                      foregroundColor: Colors.blue, // <-- Splash color
                    ),
                    child: Text('${cekilisSonucuRepository.cekilisSonucu[i]}',style: const TextStyle(fontSize: 16),),

                  ),
                ),
            ],
          ),

        const SizedBox(height: 60,),






        if(secilenKolonRepository.secilenKolon.length >=6)

          Expanded(

            child: Column(
              children:  [
                 BirinciKolon(cekilisSonucuRepository.kolonuSirala(secilenKolonRepository.secilenKolon, 1),),
                const SizedBox(height: 15,),



                RichText(
                  text: TextSpan(
                    text: '1. Kolon : ',
                    style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(

                        text: cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon,1) == 0 ?
                        'Maalesef 0 bildiniz :(' : 'Tebrikler ${cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon, 1)} bildiniz)',
                        style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),
                      ),



                    ],

                  ),

                ),




              ],
            ),
          ),
          if(secilenKolonRepository.secilenKolon.length >=12)
            Expanded(
              child: Column(
                children: [
                  IkinciKolon(cekilisSonucuRepository.kolonuSirala(secilenKolonRepository.secilenKolon, 2),),
                  const SizedBox(height: 15,),

                  RichText(
                    text: TextSpan(
                        text: '2. Kolon : ',
                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(

                          text: cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon,2) == 0 ?
                'Maalesef 0 bildiniz :(' : 'Tebrikler ${cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon, 2)} bildiniz)',
                          style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),
                  ),



                    ],

                  ),

               ),
               ]  ,
              ),
            ),

          if(secilenKolonRepository.secilenKolon.length>=18)
            Expanded(

              child: Column(

                children: [
                  UcuncuKolon(cekilisSonucuRepository.kolonuSirala(secilenKolonRepository.secilenKolon, 3),),
                  const SizedBox(height: 15,),


                  RichText(
                    text: TextSpan(
                      text: '3. Kolon : ',
                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(

                          text: cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon,3) == 0 ?
                          'Maalesef 0 bildiniz :(' : 'Tebrikler ${cekilisSonucuRepository.kacBildik(secilenKolonRepository.secilenKolon, 3)} bildiniz)',
                          style: const TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),
                        ),



                      ],

                    ),

                  ),


                ],
              ),
            ),

        ],
      ),
    );
  }


}
