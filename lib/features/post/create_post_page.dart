import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();
  String? _categoriaSelecionada;

  final List<String> _categorias = [
    'Evento',
    'Vaga',
    'Recado',
    'Achado/Perdido'
  ];

  // Função mock para simular a publicação
  void _publicar() {
    final titulo = _tituloController.text;
    final conteudo = _conteudoController.text;

    if (titulo.isEmpty || conteudo.isEmpty || _categoriaSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

// 1. Montamos um mapa com os dados no mesmo formato que o Feed espera
    final novoPost = {
      'autor': 'Você', // Como não temos sistema de usuários ativo ainda
      'tempo': 'Agora mesmo',
      'categoria': _categoriaSelecionada!,
      'titulo': titulo,
      'conteudo': conteudo,
    };

    // Simulando o sucesso e voltando para o Feed
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Publicação criada com sucesso! (Demo)'),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context, novoPost); // Fecha a tela e volta pro Feed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B2053),
        title: const Text(
          'Nova Publicação',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Seta de voltar branca
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'O que você quer compartilhar?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),

            // Campo de Título
            const Text('Título', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                hintText: 'Ex: Aula magna no auditório',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Seletor de Categoria
            const Text('Categoria', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              hint: const Text('Selecione uma categoria'),
              initialValue: _categoriaSelecionada,
              items: _categorias.map((String categoria) {
                return DropdownMenuItem<String>(
                  value: categoria,
                  child: Text(categoria),
                );
              }).toList(),
              onChanged: (String? novaCategoria) {
                setState(() {
                  _categoriaSelecionada = novaCategoria;
                });
              },
            ),
            const SizedBox(height: 20),

            // Campo de Conteúdo (Maior)
            const Text('Conteúdo', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _conteudoController,
              maxLines: 6, // Deixa o campo mais alto para textos longos
              decoration: InputDecoration(
                hintText: 'Escreva os detalhes aqui...',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Botão Publicar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _publicar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDB913),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Publicar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}