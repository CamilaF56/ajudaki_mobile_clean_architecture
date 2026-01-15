import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../work_listing/view_models/work_listing_view_model.dart';

/// Barra superior da tela de listagem de serviços.
///
/// Responsável por exibir o logotipo da aplicação ou o campo de busca,
/// além de fornecer ações de navegação para retorno à tela inicial
/// e ativação/desativação do modo de pesquisa.
class WorkListingTopBar extends StatelessWidget {
  /// Cria a barra superior da listagem de serviços.
  ///
  /// Os callbacks [onMenuTap] e [onSearchTap] são opcionais e permitem
  /// customização, caso necessário.
  const WorkListingTopBar({super.key, this.onMenuTap, this.onSearchTap});

  /// Callback acionado ao tocar no botão de menu (home).
  final VoidCallback? onMenuTap;

  /// Callback acionado ao tocar no botão de busca.
  final VoidCallback? onSearchTap;

  @override
  Widget build(final BuildContext context) {
    final viewModel = context.watch<WorkListingViewModel>();
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: 64 + statusBarHeight,
      padding: EdgeInsets.fromLTRB(16, statusBarHeight, 16, 0),
      color: const Color.fromRGBO(235, 236, 237, 1),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              style: ButtonStyle(
                iconColor: WidgetStateProperty.resolveWith<Color>(
                  (final states) => states.contains(WidgetState.hovered)
                      ? Colors.blue
                      : const Color.fromARGB(255, 171, 186, 255),
                ),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              icon: const Icon(Icons.house_rounded, size: 28),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

                if (viewModel.isSearching) {
                  await viewModel.toggleSearch();
                }

                await viewModel.loadBackHome();
                onMenuTap?.call();
              },
            ),
          ),

          const SizedBox(width: 12),

          if (viewModel.isSearching)
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar serviço...',
                  isDense: true,
                ),
                onChanged: (final value) => viewModel.searchTerm = value,
                onSubmitted: viewModel.search,
              ),
            )
          else
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 32,
                  child: Image.asset('lib/assets/logo.png'),
                ),
              ),
            ),

          const SizedBox(width: 12),

          SizedBox(
            width: 48,
            height: 48,
            child: IconButton(
              style: ButtonStyle(
                iconColor: WidgetStateProperty.resolveWith<Color>(
                  (final states) => states.contains(WidgetState.hovered)
                      ? Colors.blue
                      : const Color.fromARGB(255, 171, 186, 255),
                ),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              icon: Icon(
                viewModel.isSearching ? Icons.close : Icons.search,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                await viewModel.toggleSearch();
                onSearchTap?.call();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback?>.has('onMenuTap', onMenuTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSearchTap', onSearchTap));
  }
}
