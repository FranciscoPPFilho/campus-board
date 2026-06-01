import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  // Essa tela precisa receber os dados da publicação que foi clicada
  final Map<String, String> publicacao;
  final Map<String, String> usuarioLogado;

  const PostDetailPage({
    super.key, 
    required this.publicacao,
    required this.usuarioLogado
  });

  @override
  Widget build(BuildContext context) {
    // Simulando se o usuário logado é o dono do post para mostrar o botão de apagar
    final isDonoDoPost = publicacao['autor'] == usuarioLogado['nome'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B2053),
        title: const Text(
          'Detalhes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categoria (Tag)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB913).withValues(alpha: 0.2), // Fundo amarelo clarinho
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFDB913)),
              ),
              child: Text(
                publicacao['categoria']!,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B2053)),
              ),
            ),
            const SizedBox(height: 16),

            // Título
            Text(
              publicacao['titulo']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 24),

            // Informações do Autor e Tempo
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF0B2053),
                  radius: 24,
                  child: Text(
                    publicacao['autor']![0], // Primeira letra
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        publicacao['autor']!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Text(
                        publicacao['tempo']!,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(thickness: 1),
            const SizedBox(height: 24),

            // Conteúdo Completo
            Text(
              publicacao['conteudo']!,
              style: const TextStyle(fontSize: 16, color: Colors.black87, height: 1.6),
            ),
            const SizedBox(height: 40),

            // Botão de Excluir (Só aparece se o autor for "Você")
            if (isDonoDoPost)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Simula a exclusão voltando para o Feed e enviando um aviso de "deletar"
                    Navigator.pop(context, true); 
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  label: const Text(
                    'Excluir Publicação',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}