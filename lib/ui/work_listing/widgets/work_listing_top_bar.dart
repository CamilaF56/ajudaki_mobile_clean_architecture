import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/work_listing/work_listing_view_controller.dart';

/// Barra superior da tela de listagem de serviços.
///
/// Responsável por exibir o logotipo da aplicação ou o campo de busca,
/// além de fornecer ações de navegação para retorno à tela inicial
/// e ativação/desativação do modo de pesquisa.
class WorkListingTopBar extends StatefulWidget  {
  /// Cria a barra superior da listagem de serviços.
  const WorkListingTopBar(
    [final Key? key]
  ) : super(key: key);

  @override
  WorkListingTopBarState createState() => WorkListingTopBarState();
}

class WorkListingTopBarState extends State<WorkListingTopBar> {
  bool isShowingTextBox = false;

  @override
  Widget build(final BuildContext context) {
    final vm = context.watch<WorkListingViewController>();
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

                if (vm.searchTerm != null) {
                  vm.searchTerm = '';
                  setState(() {
                    isShowingTextBox = false;
                  });
                  await vm.reloadCommand.execute();
                } else {
                  await vm.reloadCommand.execute();
                }
              },
            ),
          ),

          const SizedBox(width: 12),

          if (isShowingTextBox)
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar serviço...',
                  isDense: true,
                ),
                onChanged: (final value) => vm.searchTerm = value,
                onSubmitted: (final value) => vm.searchCommand.execute()
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
                isShowingTextBox ? Icons.close : Icons.search,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

                if (isShowingTextBox) {
                  vm.searchTerm = '';
                  await vm.reloadCommand.execute();

                  setState(() {
                    isShowingTextBox = false;
                  });
                } else {
                  vm.searchTerm = '';

                  setState(() {
                    isShowingTextBox = true;
                  });
                }
              }
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>(
      'isShowingTextBox', isShowingTextBox));
  }
}
