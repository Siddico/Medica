class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final int mode; // 0 = left circle + bottom text, 1 = right circle + top text

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.mode,
  });
}
