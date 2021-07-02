import 'dart:convert';
import 'package:http/http.dart' as http;

const String kApiKey = '7F2385DB-0A94-43EA-AD2A-12071F260C4D';
const String kBaseurl = 'https://rest.coinapi.io/v1/exchangerate/';

getCoinData() {}
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData(this.selectedCurrency);
  final String selectedCurrency;
  Future getCoinData() async {
    Map<String, String> coinPrices = {};

    for (String crypto in cryptoList) {
      http.Response response =
          await http.get('$kBaseurl$crypto/$selectedCurrency?apikey=$kApiKey');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        coinPrices[crypto] = data['rate'].toStringAsFixed(0);
        print(coinPrices[crypto]);
      } else {
        print(response.statusCode);
      }
    }
    return coinPrices;
  }
}
