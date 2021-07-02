import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> coinRateMap = {};

  void initState() {
    super.initState();
    coinRate(selectedCurrency);
  }

  List<DropdownMenuItem> getDropdownItens() {
    List<DropdownMenuItem<String>> dropdownItens = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newIten = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItens.add(newIten);
    }

    return dropdownItens;
  }

  Column getBitCoinsItens() {
    List<Padding> cardItens = [];
    String courrentCoin;

    for (String crypto in cryptoList) {
      courrentCoin = coinRateMap[crypto];
      //print(courrentCoin);
      Padding newPadding = Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = $courrentCoin $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      cardItens.add(newPadding);
    }
    return Column(
      children: cardItens,
    );
  }

  void coinRate(String selectedCurrency) async {
    CoinData coinData = CoinData(selectedCurrency);

    try {
      var valor = await coinData.getCoinData();
      setState(() {
        coinRateMap = valor;
        //rateCoinBTC = valor.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getBitCoinsItens(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
                value: selectedCurrency,
                items: getDropdownItens(),
                onChanged: (value) {
                  selectedCurrency = value;
                  coinRate(selectedCurrency);
                }),
          ),
        ],
      ),
    );
  }
}
