void main() async{
  gorev1();
  String gorev2ninSonucu = await gorev2();
  gorev3(gorev2ninSonucu);
}

void gorev1() {
  String sonuc = 'gorev 1 in verisi';
  print('1. gorev tamamlandı');
}
Future<String> gorev2() async{
  String sonuc="";

  await Future.delayed(Duration(seconds: 3), (){
    sonuc = 'gorev 2 nin verisi';
    print('2. gorev tamamlandı');
  });
  return sonuc;
}

void gorev3(String gorev2ninVerisi) {
  String sonuc = 'gorev 3 ün verisi';
  print('3. gorev, $gorev2ninVerisi ile tamamlandı ');
}
