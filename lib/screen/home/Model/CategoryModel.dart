class CategoryModel {
  String? title;
  String? description;
  String? firstMessage;
  int? categoryID;
  String? LastMessageTime;
  String? image;

  CategoryModel(
      {this.title,
      this.description,
      this.firstMessage,
      this.categoryID,
      this.image,
      this.LastMessageTime = ""});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    firstMessage = json['firstMessage'];
    categoryID = json['categoryID'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['firstMessage'] = this.firstMessage;
    data['categoryID'] = this.categoryID;
    data['image'] = this.image;
    return data;
  }
}
