import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
// Importe a biblioteca foundation do Flutter para checar a plataforma
import 'package:flutter/foundation.dart'; 

void main() {
  // Cria uma variável que verifica se está rodando no Linux, Windows ou Mac
  bool isDesktop = defaultTargetPlatform == TargetPlatform.linux || 
                   defaultTargetPlatform == TargetPlatform.windows ||
                   defaultTargetPlatform == TargetPlatform.macOS;

  runApp(
    DevicePreview(
      // O preview só será ativado nos computadores de mesa.
      // Nos emuladores (TargetPlatform.android), ele desativa sozinho!
      enabled: isDesktop, 
      builder: (context) => const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'App da Equipe',
      home: const Scaffold(
        body: Center(
          child: Text('Olá Equipe!'),
        ),
      ),
    );
  }
}