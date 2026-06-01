import 'package:campus_board/features/auth/register_page.dart';
import 'package:campus_board/features/feed/feed_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //lista de usuarios
  final Map<String, Map<String, String>> _usuariosGrupo = {
    'francisco@unipe.edu.br': {
      'nome': 'Francisco Paulino',
      'iniciais': 'F',
      'email': 'francisco@unipe.edu.br'
    },
    'arthur@unipe.edu.br': {
      'nome': 'Arthur Murilo',
      'iniciais': 'A',
      'email': 'arthur@unipe.edu.br'
    },
    'matheus@unipe.edu.br': {
      'nome': 'Matheus Barbosa',
      'iniciais': 'M',
      'email': 'matheus@unipe.edu.br'
    },
    'luan@unipe.edu.br': {
      'nome': 'Luan Kennedy',
      'iniciais': 'L',
      'email': 'luan@unipe.edu.br'
    },
    'marlon@unipe.edu.br': {
      'nome': 'Marlon Mena',
      'iniciais': 'M',
      'email': 'marlon@unipe.edu.br'
    },
  };

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _fazerLogin() {
    final email = _emailController.text.trim().toLowerCase();
    final senha = _passwordController.text;

    // Verifica se o email existe no nosso "banco" e se a senha tem 6 chars
    if (_usuariosGrupo.containsKey(email) && senha.length >= 6) {
      final usuarioLogado = _usuariosGrupo[email]!;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // Passamos o usuário logado para o Feed
          builder: (context) => FeedPage(usuarioLogado: usuarioLogado), 
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail não cadastrado ou senha inválida.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B2053), // Azul escuro UNIPÊ
      body: Stack(
        children: [
          // Fundo azul e detalhes podem ir aqui

          // Painel Branco inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75, // Ocupa 75% da tela
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bem-vindo de volta!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Entre com seu e-mail institucional',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),

                    // Campo de E-mail
                    const Text('E-mail institucional', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'seu.email@unipe.edu.br',
                        prefixIcon: const Icon(Icons.mail_outline),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo de Senha
                    const Text('Senha', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    
                    // Esqueceu a senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Exibe um Dialog elegante simulando a ação
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Row(
                                children: [
                                  Icon(Icons.lock_reset, color: Color(0xFF0B2053)),
                                  SizedBox(width: 8),
                                  Text('Recuperar Senha', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              content: const Text(
                                'Na versão final, enviaremos um link de recuperação para o seu e-mail institucional.\n\n(Funcionalidade simulada na Demo)',
                                style: TextStyle(color: Colors.black87),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context), // Fecha o aviso
                                  child: const Text('Entendi', style: TextStyle(color: Color(0xFF0B2053), fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Esqueceu a senha?', style: TextStyle(color: Color(0xFF0B2053))),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Botão Entrar
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _fazerLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDB913), // Amarelo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Caixa de Demo
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.lightbulb_outline, size: 20, color: Colors.amber),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Demo: Use qualquer e-mail @unipe.edu.br e senha com 6+ caracteres',
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Criar conta
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Não tem uma conta?', style: TextStyle(color: Colors.grey)),
                          TextButton(
                            onPressed: () async {
                              // Aguarda o resultado da tela de cadastro
                              final novoUsuario = await Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPage()),
                              );

                              // Se voltou com um usuário válido, adiciona no nosso "banco" em memória
                              if (novoUsuario != null && novoUsuario is Map<String, String>) {
                                setState(() {
                                  _usuariosGrupo[novoUsuario['email']!] = novoUsuario;
                                });
                                
                                // Opcional: Um aviso visual de que deu certo
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Agora você já pode fazer login!'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Criar conta', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B2053))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Ícone flutuante
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25 - 40,
            left: MediaQuery.of(context).size.width * 0.5 - 40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Dá um recuo para a logo não encostar nas bordas do quadrado
                child: Image.asset(
                  'assets/images/estrela.jpg', // Caminho da sua logo completa
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}