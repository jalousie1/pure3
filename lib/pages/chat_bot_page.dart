import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String aiInstructions = '''
Você é um assistente especializado em saúde mental e bem-estar, com foco em acolhimento e suporte emocional.

PRIORIDADE MÁXIMA - Em casos de ideação suicida ou crise:
1. Responda com empatia e seriedade
2. Forneça imediatamente os contatos:
   - CVV (Centro de Valorização da Vida): 188 (24h/dia)
   - SAMU: 192
   - Emergência: 190
3. Enfatize que a pessoa não está sozinha e que existem profissionais preparados para ajudar
4. Incentive buscar ajuda profissional ou conversar com alguém de confiança
5. Ofereça dicas práticas e imediatas de segurança

**Outros casos de saúde mental:**
- Fique atento às necessidades do usuário e forneça suporte com informações baseadas em evidências, como:
   - Gerenciamento de estresse e ansiedade
   - Depressão e outros transtornos mentais
   - Mindfulness e técnicas de relaxamento
   - Equilíbrio vida pessoal/profissional
   - Práticas de autocuidado
   - Higiene do sono
   - Hábitos saudáveis

**Diretrizes para respostas:**
1. Use português do Brasil
2. Mantenha tom acolhedor e empático
3. Forneça informações baseadas em evidências
4. Use formatação clara com parágrafos e bullet points
5. Priorize dicas práticas e alcançáveis
6. Sempre incentive busca por ajuda profissional quando necessário
7. Máximo 3 parágrafos por resposta

Em qualquer situação de risco ou sofrimento intenso:
- Nunca minimize os sentimentos da pessoa
- Sempre ofereça recursos de ajuda
- Mantenha tom de esperança e suporte
- Forneça orientações práticas e imediatas
''';


class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  static const routeName = 'ChatBotPage';

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isTyping = false;  // Add this line

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
      _isTyping = true;  // Add this line
    });

    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['GEMINI_API_URL']}?key=${dotenv.env['GEMINI_API_KEY']}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "contents": [{
            "parts": [{
              "text": "$aiInstructions\n\nUsuário: $message"
            }]
          }]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botResponse = data['candidates'][0]['content']['parts'][0]['text'];
        setState(() {
          _messages.add({'sender': 'bot', 'text': botResponse});
          _isTyping = false;  // Add this line
        });
      } else {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'text': 'Error: Unable to get response. Status: ${response.statusCode}'
          });
          _isTyping = false;  // Add this line
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'text': 'Erro: Não foi possível obter uma resposta. Por favor, tente novamente.'
        });
        _isTyping = false;  // Add this line
      });
    }
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                const SizedBox(
                  width: 8,
                  height: 8,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Pensando...',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'Conversa com MindBot',
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length + (_isTyping ? 1 : 0),  // Update this line
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: _buildTypingIndicator(),
                  );
                }

                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isUser 
                            ? theme.primaryColor
                            : theme.cardColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black12,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        message['text']!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isUser ? Colors.white : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      hintStyle: theme.textTheme.labelMedium,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.dividerColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: () {
                    final message = _controller.text;
                    if (message.isNotEmpty) {
                      _controller.clear();
                      _sendMessage(message);
                    }
                  },
                  backgroundColor: theme.primaryColor,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
