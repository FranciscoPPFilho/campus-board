import 'package:campus_board/features/post/create_post_page.dart';
import 'package:campus_board/features/post/post_detail_page.dart';
import 'package:campus_board/features/profile/profile_page.dart';
import 'package:flutter/material.dart';

  final List<Map<String, String>> publicacoesGlobais = [
    {
      'autor': 'Prof. Leandro Melo',
      'tempo': 'Há 2 horas',
      'categoria': 'Evento',
      'titulo': 'Semana da Computação',
      'conteudo': 'Não percam as palestras sobre desenvolvimento mobile e mercado de trabalho que acontecerão no auditório principal nesta sexta-feira.',
    },
    {
      'autor': 'Maria Silva (RH)',
      'tempo': 'Há 4 horas',
      'categoria': 'Vaga',
      'titulo': 'Estágio em Desenvolvimento Web',
      'conteudo': 'Empresa parceira está buscando estudantes a partir do 4º período para estágio em React e Node.js. Envie seu currículo!',
    },
    {
      'autor': 'João Souza',
      'tempo': 'Há 1 dia',
      'categoria': 'Achado/Perdido',
      'titulo': 'Caderno esquecido na biblioteca',
      'conteudo': 'Encontrei um caderno de capa preta da disciplina de Banco de Dados. Deixei na recepção da biblioteca central.',
    },
    {
      'autor': 'Coordenação',
      'tempo': 'Há 1 dia',
      'categoria': 'Recado',
      'titulo': 'Manutenção no Bloco D',
      'conteudo': 'Aviso: Os laboratórios do Bloco D estarão fechados para manutenção da rede amanhã durante o turno da manhã.',
    },
  ];

class FeedPage extends StatefulWidget {
  final Map<String, String> usuarioLogado;
  const FeedPage({super.key, required this.usuarioLogado});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // Controle do filtro selecionado
  String _categoriaSelecionada = 'Todos';

  // Opções de filtro
  final List<String> _categorias = [
    'Todos',
    'Evento',
    'Vaga',
    'Recado',
    'Achado/Perdido'
  ];

  // Mock de dados (Banco de dados falso em memória)


  @override
  Widget build(BuildContext context) {
    // Lógica para filtrar a lista com base no botão clicado
    final publicacoesFiltradas = _categoriaSelecionada == 'Todos'
        ? publicacoesGlobais
        : publicacoesGlobais.where((pub) => pub['categoria'] == _categoriaSelecionada).toList();

    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco conforme documento
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B2053), // Azul Institucional
        title: const Text(
          'CampusBoard',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Remove a seta de voltar do login
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    usuarioLogado: widget.usuarioLogado,
                    todasPublicacoes: publicacoesGlobais, // Passamos a lista toda!
                  ),
                ),
              ).then((_) => setState(() {})); // Atualiza o feed ao voltar
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Barra de Filtros (Scroll Horizontal)
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categorias.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                final isSelected = categoria == _categoriaSelecionada;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      categoria,
                      style: TextStyle(
                        color: isSelected ? Colors.black87 : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFDB913), // Amarelo Destaque
                    backgroundColor: const Color(0xFF0B2053).withValues(alpha: 0.8), // Azul escuro
                    onSelected: (selected) {
                      setState(() {
                        _categoriaSelecionada = categoria;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Lista de Publicações (Feed)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: publicacoesFiltradas.length,
              itemBuilder: (context, index) {
                final pub = publicacoesFiltradas[index];

                return GestureDetector(
                  onTap: () async {
                    final deveDeletar = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailPage(publicacao: pub, usuarioLogado: widget.usuarioLogado,),
                      ),
                    );

                    if (deveDeletar == true) {
                      setState(() {
                        // Remova a linha abaixo:
                        // publicacoesGlobais.removeAt(index);
                        
                        // Substitua por esta linha:
                        publicacoesGlobais.remove(pub);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Publicação Excluída!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: Colors.grey[100], // Cards em cinza claro
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
                          // Cabeçalho do Card (Autor e Tempo)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xFF0B2053),
                                    radius: 16,
                                    child: Text(
                                      pub['autor']![0], // Primeira letra do nome
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    pub['autor']!,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ],
                              ),
                              Text(
                                pub['tempo']!,
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Categoria (Tag)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              pub['categoria']!,
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Título e Conteúdo
                          Text(
                            pub['titulo']!,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pub['conteudo']!,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Botão Flutuante de Criar Publicação
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFDB913),
        onPressed: () async {
          final novoPost = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostPage()),
          );

          if (novoPost != null && novoPost is Map<String, String>) {

            novoPost['autor'] = widget.usuarioLogado['nome']!;
            setState(() {
              publicacoesGlobais.insert(0, novoPost);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.black87),
      ),
    );
  }
}