class Kitap {

  int? id;
  String isim;
  DateTime olusutulmaTarihi;

  Kitap(this.isim, this.olusutulmaTarihi);

  Kitap.fromMap(Map<String, dynamic> map):
      id = map["id"],
      isim = map["isim"],
      olusutulmaTarihi = DateTime.fromMillisecondsSinceEpoch(map["olusturulmaTarihi"]);

  Map<String, dynamic> toMap(){
    return{
      "id": id,
      "isim": isim,
      "olusturulmaTarihi": olusutulmaTarihi.millisecondsSinceEpoch,
    };
  }

}