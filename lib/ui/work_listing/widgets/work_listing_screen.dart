import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/work_listing_view_controller.dart';
import 'work_listing_category_filter.dart';
import 'work_listing_entry.dart';
import 'work_listing_top_bar.dart';

/// Tela principal responsável por exibir a listagem de serviços.
///
/// Integra filtros, barra superior e lista de resultados,
/// consumindo o estado fornecido pelo [WorkListingViewModel].
class WorkListingScreen extends StatefulWidget {
  /// Cria a tela de listagem de serviços.
  const WorkListingScreen(
    [final Key? key]
    ) : super(key: key);


  @override
  State<WorkListingScreen> createState() => _WorkListingScreenState();
}

class _WorkListingScreenState extends State<WorkListingScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(context.read<WorkListingViewModel>().init());
    });
  }

  @override
  Widget build(final BuildContext context) {
    final vm = context.watch<WorkListingViewModel>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 236, 237, 1),
      body: Column(
        children: [
          WorkListingTopBar(),
          const Divider(
            height: 1,
            thickness: 2,
            color: Color.fromRGBO(171, 186, 255, 1),
          ),
          WorkListingCategoryFilter(vm.categories),
          Expanded(child: _buildBody(vm)),
        ],
      ),
    );
  }

  /// Constrói o corpo principal da tela de acordo com o estado atual.
  ///
  /// Exibe indicador de carregamento, mensagens de erro,
  /// mensagem de lista vazia ou a lista de serviços.
  Widget _buildBody(final WorkListingViewModel vm) {
    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return const Center(child: Text('Erro ao carregar os serviços'));
    }

    if (vm.listings.isEmpty) {
      return const Center(child: Text('Nenhum serviço encontrado'));
    }

    return ListView.builder(
      itemCount: vm.listings.length,
      itemBuilder: (final context, final index) {
        final listing = vm.listings[index];

        return WorkListingEntry( listing);
      },
    );
  }
}
