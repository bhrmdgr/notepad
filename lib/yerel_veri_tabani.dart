import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/model/kitap.dart';

class YerelVeriTabani{
  YerelVeriTabani.privateConstructor();
  static final YerelVeriTabani _nesne = YerelVeriTabani.privateConstructor();

  factory YerelVeriTabani(){
    return _nesne;
  }

  Database? _veriTabani;
  String _kitaplarTabloAdi = "kitaplar";
  String _idKitaplar = "id";
  String _isimKitaplar = "isim";
  String _olusturulmaTarihiKitaplar = "olusturulmaTarihi";

  String _bolumlerTabloAdi = "bolumler";
  String _idBolumler = "id";
  String _kitapIdBolumler = "kitapId";
  String _baslikBolumler = "baslik";
  String _icerikBolumler = "icerik";
  String _olusturulmaTarihiBolumler = "olusturulmaTarihi";

  Future<Database?> _veriTabaniniGetir() async {
    if(_veriTabani == null){
      String dosyaYolu = await getDatabasesPath();
      String veriTabaniYolu = join(dosyaYolu, "yazar.db");
      _veriTabani= await  openDatabase(
          veriTabaniYolu,
        version: 1,
        onCreate:
          _tabloOlustur,

      );
    }
    return _veriTabani;
  }

  Future<void> _tabloOlustur(Database db , int versiyon) async {
    await db.execute(
      """
          CREATE TABLE $_kitaplarTabloAdi (
          $_idKitaplar INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          $_isimKitaplar TEXT NOT NULL,
          $_olusturulmaTarihiKitaplar INTEGER
    ); 
    """
    );
    await db.execute(
        """
          CREATE TABLE $_bolumlerTabloAdi (
          $_idBolumler INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          $_kitapIdBolumler INTEGER NOT NULL,
          $_baslikBolumler TEXT NOT NULL,
          $_icerikBolumler TEXT,
          $_olusturulmaTarihiBolumler TEXT DEFAULT CURRENT_TIMESTAMP,
	        FOREIGN KEY("$_kitapIdBolumler") REFERENCES "$_kitaplarTabloAdi"("$_idKitaplar") ON UPDATE CASCADE ON DELETE CASCADE
    ); 
    """
    );
  }

  Future<int> createKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.insert(_kitaplarTabloAdi, kitap.toMap());
    }else{
      return -1;
    }
  }

  Future<List<Kitap>> readTumKitaplar() async {
    Database? db = await _veriTabaniniGetir();
    List<Kitap> kitaplar = [];

    if(db != null){
     List<Map<String,dynamic>> kitaplarMap = await db.query(_kitaplarTabloAdi);
     for(Map<String, dynamic> m in kitaplarMap){
       Kitap k = Kitap.fromMap(m);
       kitaplar.add(k);
     }
    }
    return kitaplar;

  }

  Future<int> updateKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.update(_kitaplarTabloAdi, kitap.toMap(),
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    }else{
      return 0;
    }
  }

  Future<int> deleteKitap(Kitap kitap) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.delete(
        _kitaplarTabloAdi,
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    }else{
      return 0;
    }


  }

  Future<int> createBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.insert(_bolumlerTabloAdi, bolum.toMap());
    }else{
      return -1;
    }
  }

  Future<List<Bolum>> readTumBolumler(int kitapId) async {
    Database? db = await _veriTabaniniGetir();
    List<Bolum> bolumler = [];

    if(db != null){
      List<Map<String,dynamic>> bolumlerMap = await db.query(
        _bolumlerTabloAdi,
        where: "$_kitapIdBolumler = ?",
        whereArgs: [kitapId],

      );
      for(Map<String, dynamic> m in bolumlerMap){
        Bolum b = Bolum.fromMap(m);
        bolumler.add(b);
      }
    }
    return bolumler;

  }

  Future<int> updateBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.update(_bolumlerTabloAdi, bolum.toMap(),
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    }else{
      return 0;
    }
  }

  Future<int> deleteBolum(Bolum bolum) async {
    Database? db = await _veriTabaniniGetir();
    if(db!= null){
      return await db.delete(
        _bolumlerTabloAdi,
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    }else{
      return 0;
    }


  }


}