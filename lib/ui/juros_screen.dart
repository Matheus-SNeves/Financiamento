import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JurosScreen extends StatefulWidget {
  const JurosScreen({Key? key}) : super(key: key);

  @override
  _JurosScreenState createState() => _JurosScreenState();
}

class _JurosScreenState extends State<JurosScreen> {
  final TextEditingController _valorFinanciamentoController = TextEditingController();
  final TextEditingController _taxaJurosController = TextEditingController();
  final TextEditingController _numeroParcelasController = TextEditingController();
  final TextEditingController _demaisTaxasController = TextEditingController();

  double _valorTotal = 0.0;
  double _valorParcela = 0.0;

  void _calcularFinanciamento() {
    final double valorFinanciamento = double.tryParse(_valorFinanciamentoController.text) ?? 0.0;
    final double taxaJuros = (double.tryParse(_taxaJurosController.text) ?? 0.0) / 100;
    final int numeroParcelas = int.tryParse(_numeroParcelasController.text) ?? 0;
    final double demaisTaxas = double.tryParse(_demaisTaxasController.text) ?? 0.0;

    if (numeroParcelas > 0) {
      setState(() {
        final double montante = valorFinanciamento * pow(1 + taxaJuros, numeroParcelas) + demaisTaxas;
        _valorTotal = montante;
        _valorParcela = montante / numeroParcelas;
      });
    } else {
      setState(() {
        _valorTotal = 0.0;
        _valorParcela = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Financiamento'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'Valor do financiamento:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _valorFinanciamentoController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Text(
              'Taxa de juros ao mês:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _taxaJurosController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: InputDecoration(
                hintText: 'Digite a taxa de juros',
                suffixText: '%',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Text(
              'Número de parcelas:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _numeroParcelasController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: 'Digite o número de parcelas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Text(
              'Demais taxas e custos:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _demaisTaxasController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
              decoration: InputDecoration(
                hintText: 'Digite o total de taxas e custos adicionais',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: _calcularFinanciamento,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Calcular',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Valor total a ser pago: R\$ ${_valorTotal.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Valor da parcela: R\$ ${_valorParcela.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}