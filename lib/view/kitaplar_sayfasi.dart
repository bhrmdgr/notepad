import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yazar/model/kitap.dart';
import 'package:yazar/view/bolumler_sayfasi.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class KitaplarSayfasi extends StatefulWidget {
  @override
  State<KitaplarSayfasi> createState() => _KitaplarSayfasiState();
}

class _KitaplarSayfasiState extends State<KitaplarSayfasi> {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  List<Kitap> _kitaplar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildKitapEkleFab(context),

    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: Text("Works and Notes",
      style: TextStyle(
        fontSize: 28,
      ),
      ),
      elevation: 1,
    );
  }

  Widget _buildBody(){
    return FutureBuilder(
        future: _tumKitaplariGetir(),
        builder: _buildListView,
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapshot){
    return ListView.builder(
    itemCount: _kitaplar.length,
        itemBuilder: _buildListItem
    );
  }

  Widget _buildListItem(BuildContext context, int index){
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.arrow_forward_sharp
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit,
            ),
            onPressed: (){
              _kitapGuncelle(context, index);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
              onPressed: (){
                _kitapSil(index);
              },
          )
        ],
      ),
      title: Text(_kitaplar[index].isim),
      onTap: (){
        _bolumlerSayfasiniAc(context, index);
      },

    );
  }

  Widget _buildKitapEkleFab(BuildContext context){
    return FloatingActionButton(
      child: Icon(
        Icons.add,
      ),
        onPressed: (){
          _kitapEkle(context);
        },
    );
  }

  void _kitapEkle(BuildContext context) async {
   String? kitapAdi = await _pencereAc(context);

   if(kitapAdi != null){
     Kitap yeniKitap = Kitap(kitapAdi, DateTime.now());
     int kitapIdsi = await _yerelVeriTabani.createKitap(yeniKitap);
     print("Kitap ID si: $kitapIdsi");
     setState(() {

     });
   }
  }

  void _kitapGuncelle(BuildContext context ,int index) async {
    String? yeniKitapAdi = await _pencereAc(context);

    if(yeniKitapAdi != null){
      Kitap kitap = _kitaplar[index];
      kitap.isim = yeniKitapAdi;
      int guncellenenSatirSayisi = await _yerelVeriTabani.updateKitap(kitap);
      if(guncellenenSatirSayisi > 0){
        setState(() {});
      }
    }

  }

  void _kitapSil(int index) async {
    Kitap kitap = _kitaplar[index];
    int silinenSatirSayisi = await _yerelVeriTabani.deleteKitap(kitap);
    if(silinenSatirSayisi > 0){
      setState(() {});
    }
  }

  Future<void> _tumKitaplariGetir() async {
    _kitaplar = await _yerelVeriTabani.readTumKitaplar();

  }

  Future<String?> _pencereAc(BuildContext context){
    return showDialog<String>(
        context: context,
        builder: (context){
          String? sonuc;
         return AlertDialog(
           title:  Center(child: Text("Not Başlığını Girin")),
           content: TextField(
             onChanged: (yeniDeger){
               sonuc = yeniDeger;
             },
           ),
           actions: [
             TextButton(
               child: Text("iptal"),
               onPressed: (){
                 Navigator.pop(context);
               },
             ),
             TextButton(
               child: Text("kaydet"),
               onPressed: (){
                 Navigator.pop(context , sonuc);
               },
             ),

           ],
         );
        }
        );
  }

  void _bolumlerSayfasiniAc(BuildContext context, int index){

    MaterialPageRoute sayfaYolu = MaterialPageRoute(
        builder: (context){
          return BolumlerSayfasi(_kitaplar[index]
          );

        }

    );
    Navigator.push(context, sayfaYolu);

  }

}
