import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../domain/work_listing.dart';

/// Widget responsável por exibir um anúncio de trabalho.
///
/// Apresenta informações do profissional, área de atuação,
/// tipo de serviço, descrição e valor estimado.
class WorkListingEntry extends StatelessWidget {
  /// Cria o widget de exibição de um anúncio de trabalho.
  const WorkListingEntry({required this.listing, super.key});

  /// Anúncio de trabalho a ser exibido.
  final WorkListing listing;

  @override
  Widget build(final BuildContext context) {
    final pictureUrl = listing.professional?.pictureUrl;
    final priceEstimed = listing.estimatedPrice.toStringAsFixed(2);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: const Color.fromRGBO(247, 242, 250, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar do profissional.
            CircleAvatar(
              radius: 42,
              backgroundColor: const Color.fromRGBO(235, 236, 237, 1),
              child: ClipOval(
                child: (pictureUrl != null && pictureUrl.isNotEmpty)
                    ? Image.network(
                        pictureUrl,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (final context, final error, final stackTrace) {
                              return const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.grey,
                              );
                            },
                      )
                    : const Icon(Icons.person, size: 48, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 24),

            /// Informações do anúncio.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Nome do profissional.
                  Text(
                    listing.professional?.name ?? 'Não disponível',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D6EBD),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  /// Categoria do trabalho.
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: listing.workType?.workCategory?.name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Tipo de serviço prestado.
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Faço '),
                        TextSpan(
                          text: listing.workType?.name.toLowerCase() ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Descrição do serviço.
                  Text(listing.description),

                  const SizedBox(height: 8),

                  /// Valor estimado do serviço.
                  Text(
                    r'Valor estimado: R$ '
                    '$priceEstimed',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WorkListing>('listing', listing));
  }
}
