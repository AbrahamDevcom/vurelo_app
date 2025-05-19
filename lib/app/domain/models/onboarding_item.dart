class OnboardingItem {
  String title;
  String description;
  String image;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });

  factory OnboardingItem.fromMap(Map<String, dynamic> json) => OnboardingItem(
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "image": image,
      };
}
