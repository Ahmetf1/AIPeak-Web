// A model that represents portfolio apps on landing page.
class ShowcaseAppModel {
  final String name;
  final String? appStoreURL;
  final String? playStoreURL;
  final String? githubURL;
  final String image;
  final String topic;

  const ShowcaseAppModel.withNetworkAsset({
    required this.name,
    this.appStoreURL,
    this.playStoreURL,
    this.githubURL,
    required this.image,
    required this.topic,
  }) : _isNetworkImage = true;

  const ShowcaseAppModel.withLocalAsset({
    required this.name,
    this.appStoreURL,
    this.playStoreURL,
    this.githubURL,
    required this.image,
    required this.topic,
  }) : _isNetworkImage = true;

  final bool _isNetworkImage;
  bool get isNetworkImage => _isNetworkImage;
}

// List of apps that will be listed on landing page.
const apps = [
  ShowcaseAppModel.withNetworkAsset(
    name: 'KOLI',
    image: 'https://play-lh.googleusercontent.com/atPmL9orJu8IbwlnyENdPm1PRnN04yoWkyT258tfQIsGek5O5Ij43b34rJoPDFphZ4_u=w3024-h1730-rw',
    playStoreURL: 'https://play.google.com/store/apps/details?id=az.koli.app',
    appStoreURL: 'https://apps.apple.com/az/app/koli/id1610779509',
    topic: 'Cargo',
  ),
];
