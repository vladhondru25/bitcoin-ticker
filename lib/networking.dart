import 'dart:convert';
import 'package:http/http.dart' as http;
import 'coin_data.dart';

const String apiKey = 'YOUR-KEY';

class CryptoExchanger {
  Map<String, String> cryptoValues = Map();
  String quoteName;

  Future updateData(String quoteName) async {
    this.quoteName = quoteName;

    for (String crypto in cryptoList) {
      cryptoValues[crypto] = await getRate(crypto);
    }
  }

  Future<String> getRate(String base) async {
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/$base/${this.quoteName}',
        headers: {'X-CoinAPI-Key': apiKey});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['rate'].toStringAsFixed(0);
    } else {
      print(response.statusCode);
    }
  }
}
