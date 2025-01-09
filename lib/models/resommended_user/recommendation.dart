class Recommendation{
  int compatability;
  String userId;
  List<String> compatibleTags;

  Recommendation(this.compatability, this.userId, this.compatibleTags);
  
  factory Recommendation.fromJson(data){
    return Recommendation(data['compatability'], data['userId'], data['compatibleTags'].cast<String>());
  }
}