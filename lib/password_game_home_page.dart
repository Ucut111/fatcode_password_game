import 'package:fatcode_password_game/password_game_interactive_page.dart';
import 'package:flutter/material.dart';


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