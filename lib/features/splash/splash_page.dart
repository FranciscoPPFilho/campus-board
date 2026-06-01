import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    
    // Inicia o temporizador de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Azul escuro
      body: Center(
        // Apenas a estrela branca centralizada
        child: Image.asset(
          'assets/images/unipe_logo.png', // Substitua pelo nome da sua imagem da estrela
          width: 300, // Ajuste o tamanho para ficar proporcional à tela
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}