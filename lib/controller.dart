// - O construtor é responsável por inicializar as variáveis, definir a operação como vazia e chamar o método _resetBuffer(), que limpa a calculadora.
// - O método _resetBuffer() é responsável por limpar a calculadora, definindo o resultado como 0, o índice do buffer como 0, e a variável _operationUsed como false.
// - O método executeOperation() é responsável por receber os comandos e fazer as operações necessárias para que a calculadora funcione. Ele verifica qual comando foi passado, e chama o método correspondente.
// - O método _removeLastDigit() é responsável por deletar o último dígito do resultado. Ele verifica se o resultado tem mais de um dígito, se tiver ele é deletado, se não, o resultado é definido como 0. Em seguida, o valor do array é definido com o resultado.
// - O método _appendDigit() é responsável por adicionar o dígito no resultado. Ele verifica se a operação já foi utilizada, se sim, o resultado é definido como 0. Ele também verifica se o resultado já contém um ponto, se sim, o ponto não é adicionado. Se o resultado é 0, o dígito é adicionado no resultado. Por fim, o valor do array é definido com o resultado, e _operationUsed é definido como false.
// - O método _setBufferOperation() é responsável por definir a operação. Ele verifica se a operação já foi utilizada e se a operação é a mesma que já foi utilizada, se sim, a operação não é realizada. Se o índice do array é 0, ele é definido como 1. Se a operação é igual, a operação é definida como igual. Se o índice do array é 1, a operação é realizada.
// - A variável operations é um array que contém as operações que a calculadora suporta.
// - A variável _currentOperation é responsável por guardar a operação que está sendo realizada.
// - A variável _operationUsed é responsável por verificar se a operação já foi utilizada.
// - O array _buffer é responsável por guardar os valores que serão utilizados na operação.
// - A variável _currentIndex é responsável por guardar o índice do array que está sendo utilizado.
// - A variável currentResult é responsável por guardar o resultado da operação.

// Essa classe é responsável por fazer o controle de tudo que acontece na calculadora,
// ela é responsável por receber os comandos e fazer as operações necessárias para que a calculadora funcione.
class Controller {
  static const operations = [
    '%',
    '/',
    '+',
    '-',
    'x',
    '='
  ]; // Esse é o array de operações que a calculadora suporta
  String
      _currentOperation; // Essa variável é responsável por guardar a operação que está sendo realizada
  bool _operationUsed =
      false; // Essa variável é responsável por verificar se a operação já foi utilizada
  final _buffer = [
    0.0,
    0.0
  ]; // Esse array é responsável por guardar os valores que serão utilizados na operação
  int _currentIndex =
      0; // Essa variável é responsável por guardar o índice do array que está sendo utilizado

  String currentResult =
      '0'; // Essa variável é responsável por guardar o resultado da operação

  Controller() : _currentOperation = "" {
    // Esse é o construtor da classe, ele é responsável por inicializar as variáveis
    _resetBuffer(); // Aqui é chamado o método que limpa a calculadora
  }

  void _resetBuffer() {
    // Esse método é responsável por limpar a calculadora
    currentResult = '0'; // Aqui é definido o valor inicial do resultado
    _buffer.setAll(0, [0.0, 0.0]); // Aqui é definido o valor inicial do array
    _currentIndex = 0; // Aqui é definido o valor inicial do índice do array
    _operationUsed = false; // Aqui é definido o valor inicial da variável
  }

  void executeOperation(String command) {
    // Esse método é responsável por receber os comandos e fazer as operações necessárias para que a calculadora funcione
    if (command == 'AC') {
      // Aqui é verificado se o comando é AC
      _resetBuffer(); // Aqui é chamado o método que limpa a calculadora
    } else if (command == 'DEL') {
      // Aqui é verificado se o comando é DEL
      _removeLastDigit(); // Aqui é chamado o método que deleta o último dígito do resultado
    } else if (operations.contains(command)) {
      // Aqui é verificado se o comando é uma operação
      _setBufferOperation(
          command); // Aqui é chamado o método que define a operação
    } else {
      // Aqui é verificado se o comando é um dígito
      _appendDigit(
          command); // Aqui é chamado o método que adiciona o dígito no resultado
    }
  }

  void _removeLastDigit() {
    // Esse método é responsável por deletar o último dígito do resultado
    currentResult = currentResult.length > 1
        ? currentResult.substring(0, currentResult.length - 1)
        : '0'; // Aqui é verificado se o resultado tem mais de um dígito, se tiver ele é deletado, se não, o resultado é definido como 0
    _buffer[_currentIndex] = double.tryParse(
        currentResult)!; // Aqui é definido o valor do array com o resultado
  }

  void _appendDigit(String digit) {
    // Esse método é responsável por adicionar o dígito no resultado
    if (_operationUsed)
      currentResult =
          '0'; // Aqui é verificado se a operação já foi utilizada, se sim, o resultado é definido como 0

    if (currentResult.contains('.') && digit == '.')
      digit =
          ''; // Aqui é verificado se o resultado já contém um ponto, se sim, o ponto não é adicionado
    if (currentResult == '0' && digit != '.')
      currentResult =
          ''; // Aqui é verificado se o resultado é 0, se sim, o dígito é adicionado no resultado

    currentResult += digit; // Aqui é adicionado o dígito no resultado

    _buffer[_currentIndex] = double.tryParse(
        currentResult)!; // Aqui é definido o valor do array com o resultado
    _operationUsed = false; // Aqui é definido que a operação não foi utilizada
  }

  void _setBufferOperation(String operation) {
    // Esse método é responsável por definir a operação
    if (_operationUsed && operation == _currentOperation)
      return; // Aqui é verificado se a operação já foi utilizada e se a operação é a mesma que já foi utilizada, se sim, a operação não é realizada

    if (_currentIndex == 0) {
      // Aqui é verificado se o índice do array é 0
      _currentIndex = 1; // Aqui é definido o índice do array como 1

      if (operation == '=')
        _currentOperation =
            operation; // Aqui é verificado se a operação é igual, se sim, a operação é definida como igual
    } else {
      // Aqui é verificado se o índice do array é 1
      _buffer[0] =
          _compute(); // Aqui é definido o valor do array com o resultado da operação
    }

    if (operation != '=')
      _currentOperation =
          operation; // Aqui é verificado se a operação é diferente de igual, se sim, a operação é definida como a operação que foi passada

    currentResult = _buffer[0]
        .toString(); // Aqui é definido o resultado com o valor do array
    currentResult = currentResult.endsWith(
            '.0') // Aqui é verificado se o resultado termina com .0 e se sim, o .0 é removido do resultado e o resultado é definido como o valor do array sem o .0 ou o resultado é definido como o valor do array sem o .0
        ? currentResult.split('.')[0]
        : currentResult;

    _operationUsed = true; // Aqui é definido que a operação foi utilizada
  }

  double _compute() {
    // Esse método é responsável por realizar a operação com os valores do array e retornar o resultado como um double
    switch (_currentOperation) {
      // Aqui é verificado qual operação será realizada
      case '%': // Porcentagem
        return _buffer[0] % _buffer[1];
      case '/': // Divisão
        return _buffer[0] / _buffer[1];
      case 'x': // Multiplicação
        return _buffer[0] * _buffer[1];
      case '+': // Soma
        return _buffer[0] + _buffer[1];
      case '-': // Subtração
        return _buffer[0] - _buffer[1];
      default: // Caso não seja nenhuma das operações acima, o valor 0.0 é retornado
        return 0.0; // Aqui é definido o valor do array com o resultado da operação
    }
  }
}
