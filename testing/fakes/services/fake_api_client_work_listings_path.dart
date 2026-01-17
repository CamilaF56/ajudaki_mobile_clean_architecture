import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'fake_api_client_path.dart';

class FakeApiClientWorkListingsPath extends FakeApiClientPath<WorkListing> {
  FakeApiClientWorkListingsPath()
    : super({
        "1": WorkListing(
          1,
          "Trocar tomada",
          "",
          50,
        ),
        "2": WorkListing(
          2,
          "Instalar lâmpada",
          "",
          40,
        )
      });
}
