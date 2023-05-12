import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CurrencyConventerScreen extends StatefulWidget {
  const CurrencyConventerScreen({super.key});

  @override
  State<CurrencyConventerScreen> createState() =>
      _CurrencyConventerScreenState();
}

class _CurrencyConventerScreenState extends State<CurrencyConventerScreen> {
  double input = 0;
  double output = 0;

  String currencyInput = 'IDR';
  String currencyOutput = 'IDR';
  String result = '';

  TextEditingController inputController = TextEditingController();

  void onInputChanged(String value) {
    setState(() {
      input = double.tryParse(value) ?? 0;
    });
  }

  void onCurrencyInputChanged(String? value) {
    setState(() {
      currencyInput = value ?? 'IDR';
    });

    setState(() {
      switch (currencyInput) {
        case 'IDR':
          switch (currencyOutput) {
            case 'IDR':
              output = input;
              break;
            case 'USD':
              output = input / 14200;
              break;
            case 'EUR':
              output = input / 17000;
              break;
          }
          break;
        case 'USD':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 14200;
              break;
            case 'USD':
              output = input;
              break;
            case 'EUR':
              output = input * 0.85;
              break;
          }
          break;
        case 'EUR':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 17000;
              break;
            case 'USD':
              output = input * 1.17;
              break;
            case 'EUR':
              output = input;
              break;
          }
          break;
      }
      result = output.toStringAsFixed(2);
    });
  }

  void onCurrencyOutputChanged(String? value) {
    setState(() {
      currencyOutput = value ?? 'IDR';
    });

    setState(() {
      switch (currencyInput) {
        case 'IDR':
          switch (currencyOutput) {
            case 'IDR':
              output = input;
              break;
            case 'USD':
              output = input / 14200;
              break;
            case 'EUR':
              output = input / 17000;
              break;
          }
          break;
        case 'USD':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 14200;
              break;
            case 'USD':
              output = input;
              break;
            case 'EUR':
              output = input * 0.85;
              break;
          }
          break;
        case 'EUR':
          switch (currencyOutput) {
            case 'IDR':
              output = input * 17000;
              break;
            case 'USD':
              output = input * 1.17;
              break;
            case 'EUR':
              output = input;
              break;
          }
          break;
      }
      result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Currency Converter',
          style: titleHeader,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: TextField(
                        onChanged: onInputChanged,
                        controller: inputController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton(
                      value: currencyInput,
                      items: const <String>['IDR', 'USD', 'EUR']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: onCurrencyInputChanged,
                    )
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'To',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                        ),
                        color: Colors.grey.shade200,
                      ),
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 50,
                      child: Text(
                        result,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton(
                      value: currencyOutput,
                      items: const <String>['IDR', 'USD', 'EUR']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      onChanged: onCurrencyOutputChanged,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
