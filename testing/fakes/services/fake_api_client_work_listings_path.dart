import 'package:ajudaki_mobile_clean_architecture/domain/work_listing.dart';
import 'fake_api_client_path.dart';

class FakeApiClientWorkListingsPath extends FakeApiClientPath<WorkListing> {
  FakeApiClientWorkListingsPath()
    : super({
        "1": WorkListing(
          id: 1,
          title: "Trocar tomada",
          description: "",
          estimatedPrice: 50,
        ),
        "2": WorkListing(
          id: 2,
          title: "Instalar lâmpada",
          description: "",
          estimatedPrice: 40,
        ),
      });
}
