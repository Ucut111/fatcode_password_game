import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PasswordGameHomePage(),
    );
  }
}

class PasswordGameHomePage extends StatelessWidget {
  const PasswordGameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FatCode Present"),
        ),
        body: Column(
          children: [
            const Text("Привет %user_name"),
            const Text(
                "Пользователи часто ставят одинаковые, легко взламываемые пароли"),
            const Text(
                "Мы предлогаем тебе выбрать из пары самый популярный пароль"),
            const Spacer(),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PasswordGameInteractiveScreen(),
                  ),
                );
              },
              child: const Text("Ну ок"),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordGameInteractiveScreen extends StatefulWidget {
  const PasswordGameInteractiveScreen({Key? key}) : super(key: key);

  @override
  _PasswordGameInteractiveScreenState createState() =>
      _PasswordGameInteractiveScreenState();
}

@override
void initState() {}

class _PasswordGameInteractiveScreenState
    extends State<PasswordGameInteractiveScreen> {
  List<Password> passwords = [
    Password(1, "123456", 1),
    Password(2, "123456789", 1),
    Password(3, "password", 1),
    Password(4, "senha", 10),
    Password(5, "Million2", 10800),
    Password(6, "iloveyou", 1),
    Password(7, "qwer123456", 4),
    Password(8, "666666", 1),
    Password(9, "unknown", 1020),
    Password(10, "princess", 1),
    Password(11, "pokemon", 1),
    Password(12, "qwerty123", 1),
  ];

  late Password firstPassword;
  late Password secondPassword;
  late Password mostPopular;
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    firstPassword = passwords[Random().nextInt(12)];
    secondPassword = passwords[Random().nextInt(12)];
    if (firstPassword.position == secondPassword.position) {
      secondPassword = passwords[Random().nextInt(12)];
    }
    if (firstPassword.position > secondPassword.position) {
      mostPopular = secondPassword;
    } else {
      mostPopular = firstPassword;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Серия угадываний: $counter"),
      ),
      body: Row(
        children: [
          _card(firstPassword.passwordText, Colors.red),
          _card(secondPassword.passwordText, Colors.blue),
        ],
      ),
    );
  }

  Widget _card(String passwordText, Color color) {
    return GestureDetector(
      onTap: () {
        _showMaterialDialog(passwordText);
      },
      child: Container(
        color: color,
        width: MediaQuery.of(context).size.width / 2,
        child: Center(
          child: Text(passwordText),
        ),
      ),
    );
  }

  void _showMaterialDialog(String passwordText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(passwordText == mostPopular.passwordText
              ? "Вы угадали"
              : "Вы не угадали"),
          content: Text(
              "Пароль ${mostPopular.passwordText} является самым популярным в этой паре\nна его взлом нужно всего ${mostPopular.timeToCrack} секунд"),
          actions: [
            RaisedButton(
              onPressed: () {
                setState(() {
                  if (passwordText == mostPopular.passwordText) {
                    counter++;
                  } else {
                    counter = 0;
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text("Еще раз!"),
            ),
          ],
        );
      },
    );
  }
}

class Password {
  Password(this.position, this.passwordText, this.timeToCrack);

  int position;
  String passwordText;
  int timeToCrack;
}
