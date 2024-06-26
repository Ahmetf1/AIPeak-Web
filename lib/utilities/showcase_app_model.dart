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
  ShowcaseAppModel.withLocalAsset(
    name: 'Job Description Generator',
    image: 'assets/assets/images/job_description_img.png',
    topic: 'Generate job\ndescriptions',
  ),
  ShowcaseAppModel.withLocalAsset(
    name: 'Interview Question Generator',
    image: 'assets/assets/images/question_generator_img.png',
    topic: 'Generate interview\nquestions',
  ),
  ShowcaseAppModel.withLocalAsset(
    name: 'app 2',
    image: 'assets/assets/images/question_generator_img.png',
    topic: 'app 2',
  ),
];
