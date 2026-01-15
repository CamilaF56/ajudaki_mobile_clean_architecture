import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dependencies.dart';
import 'ui/work_listing/widgets/work_listing_screen.dart';

/// Ponto de entrada da aplicação.
///
/// Inicializa a injeção de dependências e
/// registra o widget raiz da aplicação.
void main() {
  runApp(MultiProvider(providers: providersRemote, child: const MyApp()));
}

/// Widget raiz da aplicação.
///
/// Responsável por configurar o tema e
/// definir a tela inicial.
class MyApp extends StatelessWidget {
  /// Cria a instância do widget raiz.
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return const MaterialApp(
      /// Remove o banner de debug.
      debugShowCheckedModeBanner: false,

      /// Tela inicial da aplicação.
      home: WorkListingScreen(),
    );
  }
}
