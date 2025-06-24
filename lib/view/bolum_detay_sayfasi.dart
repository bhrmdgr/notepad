import 'package:flutter/material.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/view/bolumler_sayfasi.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class BolumDetaySayfasi extends StatefulWidget {

  final Bolum _bolum;

  BolumDetaySayfasi(this._bolum, {super.key});

  @override
  State<BolumDetaySayfasi> createState() => _BolumDetaySayfasiState();
}

class _BolumDetaySayfasiState extends State<BolumDetaySayfasi> {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  TextEditingController _icerikController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: Text(widget._bolum.baslik),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: _icerigiKaydet,)
      ],
    );
  }

  Widget _buildBody(){
    _icerikController.text = widget._bolum.icerik;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _icerikController,
        maxLines: 1000,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        ),
      ),
    );
  }

  void _icerigiKaydet() async {

    widget._bolum.icerik = _icerikController.text;
    await _yerelVeriTabani.updateBolum(widget._bolum);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('İçerik kaydedildi'),
            duration: Duration(seconds: 2), // Mesajın ne kadar süre görüneceği
          ),
      );

    });


  }


}
