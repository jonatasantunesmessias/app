import 'package:flutter/material.dart';

import './controller.dart';

// Este algoritmo é um widget Flutter que cria uma calculadora simples. Ele tem uma classe chamada Calculator que é um estado mutável (ou StatefulWidget) e outra classe _CalculatorState que gerencia o estado da Calculator.
// A classe _CalculatorState tem um objeto _data da classe Controller, que é uma classe definida externamente que gerencia as operações aritméticas da calculadora. A interface da calculadora é composta por um AppBar que tem um título definido como "Calculadora", um Column que contém dois widgets: _createDisplay() e _createKeyboard(). _createDisplay() cria um Container que mostra o resultado atual e _createKeyboard() cria um Container que contém os botões numéricos e operacionais.
// O método _createDisplay() cria o display da calculadora, que é um Container que ocupa todo o espaço vertical disponível. O Container tem um fundo vermelho e contém um Column que ocupa todo o espaço vertical disponível. Dentro deste Column, há um Padding que contém um FittedBox que mostra o resultado atual.
// O método _createKeyboard() cria o teclado da calculadora, que é um Container com altura fixa de 400.0. O teclado é composto por cinco Rows, cada uma com quatro ElevatedButtons, que são os botões da calculadora. Os botões numéricos são criados usando _createButton(), que é um método que cria um botão e recebe um label, um flex, uma cor de texto e uma cor de fundo como parâmetros.
// O método _createButton() cria um botão ElevatedButton que contém um Text com o label fornecido. O botão pode ser configurado para ter um flex específico (que determina quanto espaço horizontal ele deve ocupar), uma cor de texto e uma cor de fundo. Quando o botão é pressionado, o método onPressed é chamado e chama o método executeOperation() do objeto _data com o label do botão pressionado como parâmetro. Em seguida, chama setState(), que notifica o Flutter de que o estado da Calculator foi alterado e que uma nova renderização deve ser feita.
// No geral, este algoritmo é uma implementação simples de uma calculadora usando Flutter. Ele é facilmente personalizável e pode ser estendido para adicionar mais recursos e funcionalidades, dependendo das necessidades do desenvolvedor.

class Calculator extends StatefulWidget {
  // Este é o widget principal da aplicação
  const Calculator({super.key}); // Aqui é definido o construtor da classe

  @override
  _CalculatorState createState() =>
      _CalculatorState(); // Aqui é criado o estado do widget
}

class _CalculatorState extends State<Calculator> {
  // Aqui é definido o estado do widget
  final _data = Controller(); // Aqui é criado o objeto da classe Controller
  @override
  Widget build(BuildContext context) {
    // Este método é chamado toda vez que o estado do widget é alterado
    return Scaffold(
      appBar: AppBar(
        // Aqui é criado o AppBar
        backgroundColor: Colors.red,
        title: const Text('Comunodora'), // Aqui é definido o título do AppBar
      ),
      body: Column(
        children: <Widget>[
          _createDisplay(), // Aqui é chamado o método que cria o display que é um widget que mostra o resultado
          const Divider(
              height:
                  0.1), // Aqui é criado um Divider que é um widget que cria uma linha horizontal
          _createKeyboard(), // Aqui é chamado o método que cria o teclado que é um widget que contém os botões
        ],
      ),
    );
  }

  Widget _createButton(String label) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.yellow,
          backgroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 24),
        ),
        child: Text(label),
        onPressed: () {
          setState(() {
            _data.executeOperation(label);
          });
        },
      ),
    );
  }

  Widget _createKeyboard() {
    // Aqui é criado o teclado que é um widget que contém os botões
    return Container(
      color: Colors.red,
      height: 400.0,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createButton('AC'),
                _createButton('DEL'),
                _createButton('%'),
                _createButton('/'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createButton('7'),
                _createButton('8'),
                _createButton('9'),
                _createButton('x'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createButton('4'),
                _createButton('5'),
                _createButton('6'),
                _createButton('+'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createButton('1'),
                _createButton('2'),
                _createButton('3'),
                _createButton('-'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _createButton('='),
                _createButton('0'),
                _createButton('.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDisplay() {
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    _data.currentResult,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none,
                      fontSize: 80.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
