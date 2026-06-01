import 'package:campus_board/features/post/create_post_page.dart';
import 'package:flutter/material.dart';
import '../auth/login_page.dart';
import '../post/post_detail_page.dart'; // Importante para poder clicar nos posts do perfil

class ProfilePage extends StatefulWidget {
  final Map<String, String> usuarioLogado;
  // Recebe a lista do feed
  final List<Map<String, String>> todasPublicacoes; 
  
  const ProfilePage({
    super.key, 
    required this.usuarioLogado,
    required this.todasPublicacoes,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _sair(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // FILTRO MÁGICO: Separa apenas os posts onde o autor é o usuário atual
    final minhasPublicacoes = widget.todasPublicacoes
        .where((pub) => pub['autor'] == widget.usuarioLogado['nome'])
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B2053),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Meu Perfil',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0B2053),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(top: 50, left: 16, right: 16),
                  padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.usuarioLogado['nome']!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInfoRow(Icons.school_outlined, 'Ciência da Computação'),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.email_outlined, widget.usuarioLogado['email']!),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today_outlined, 'Membro desde maio de 2026'),
                      
                      const SizedBox(height: 24),
                      const Divider(height: 1, thickness: 1, color: Colors.black12),
                      const SizedBox(height: 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Mostra a contagem real de posts!
                          _buildStatColumn('${minhasPublicacoes.length}', 'Publicações', const Color(0xFF0B2053)),
                          _buildStatColumn('${minhasPublicacoes.length}', 'Ativas', Colors.green), // Simplificação para demo
                          _buildStatColumn('0', 'Encerradas', Colors.grey[700]!),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Positioned(
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color(0xFF0B2053),
                      child: Text(
                        widget.usuarioLogado['iniciais']!,
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Minhas Publicações',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // LÓGICA CONDICIONAL: Mostra vazio ou mostra a lista
            if (minhasPublicacoes.isEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                      child: const Icon(Icons.calendar_today_outlined, size: 32, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Você ainda não fez nenhuma publicação',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // 1. Abre a tela de criar post e aguarda o resultado
                        final novoPost = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreatePostPage()),
                        );

                        // 2. Se o usuário criou um post (não cancelou)
                        if (novoPost != null && novoPost is Map<String, String>) {
                          // Força o autor a ser o nome real do usuário logado
                          novoPost['autor'] = widget.usuarioLogado['nome']!; 
                          
                          // Atualiza a tela de perfil na mesma hora!
                          setState(() {
                            widget.todasPublicacoes.insert(0, novoPost);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDB913),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Criar primeira publicação',
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                    ),


























                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true, // Importante para usar ListView dentro de ScrollView
                physics: const NeverScrollableScrollPhysics(), // Desativa o scroll interno para rolar com a página toda
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: minhasPublicacoes.length,
                itemBuilder: (context, index) {
                  final pub = minhasPublicacoes[index];
                  
                  return GestureDetector(
                    onTap: () async {
                      // Permite clicar na postagem, ver detalhes e excluir direto do perfil!
                      final deveDeletar = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PostDetailPage(publicacao: pub, usuarioLogado: widget.usuarioLogado,)),
                      );

                      if (deveDeletar == true) {
                        setState(() {
                          widget.todasPublicacoes.remove(pub);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Publicação Excluída!'), backgroundColor: Colors.red),
                        );
                      }
                    },
                    child: Card(
                      color: Colors.grey[100],
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xFF0B2053),
                                      radius: 16,
                                      child: Text(pub['autor']![0], style: const TextStyle(color: Colors.white, fontSize: 14)),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(pub['autor']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                                  ],
                                ),
                                Text(pub['tempo']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                              child: Text(pub['categoria']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 8),
                            Text(pub['titulo']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(pub['conteudo']!, style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => _sair(context),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text('Sair da conta', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 14))),
      ],
    );
  }

  Widget _buildStatColumn(String number, String label, Color numberColor) {
    return Column(
      children: [
        Text(number, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: numberColor)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}