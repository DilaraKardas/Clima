import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  final String url;

  NetworkHelper(this.url);

  Future getData() async{

    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){ //http kodu 200 ise veri çekmede bir sorun yaşamamışsın demektir. bu yüzden verinin içeriğini görmek istersen görebilirisin.
      String data = response.body;
      //print(data); // datayı bastırırsan tüm bilgileri verir
      //spesifik özellikleri bastımak için spesifik girdiler vermen lazım. özelliklerin json dosyasındakiyle bire bir aynı olmasına dikkat et.
      var decodedData = jsonDecode(data);
      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }
  }
}