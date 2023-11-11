class CommunityAllModel {
  CommunityAllModel({
     this.data,
  });
  late final List<Data>? data;
  
  CommunityAllModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
     this.id,
     this.audioURL,
     this.referenceToVoice,
     this.communityDescription,
     this.isLiked,
     this.userId,
     this.likes,
     this.downloads,
     this.shares,
     this.isActive,
     this.createdAt,
     this.referenceToUser,
  });
  late final String? id;
  late final String? audioURL;
  late final String? referenceToVoice;
  late final String? communityDescription;
  late final bool? isLiked;
  late final List<String>? userId;
  late final int? likes;
  late final int? downloads;
  late final int? shares;
  late final bool? isActive;
  late final Null createdAt;
  late final ReferenceToUser? referenceToUser;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    audioURL = null;
    referenceToVoice = null;
    communityDescription = json['communityDescription'];
    isLiked = json['isLiked'];
    userId = List.castFrom<dynamic, String>(json['userId']);
    likes = json['likes'];
    downloads = json['downloads'];
    shares = json['shares'];
    isActive = json['isActive'];
    createdAt = null;
    referenceToUser = ReferenceToUser.fromJson(json['referenceToUser']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['audioURL'] = audioURL;
    _data['referenceToVoice'] = referenceToVoice;
    _data['communityDescription'] = communityDescription;
    _data['isLiked'] = isLiked;
    _data['userId'] = userId;
    _data['likes'] = likes;
    _data['downloads'] = downloads;
    _data['shares'] = shares;
    _data['isActive'] = isActive;
    _data['createdAt'] = createdAt;
    _data['referenceToUser'] = referenceToUser!.toJson();
    return _data;
  }
}

class ReferenceToUser {
  ReferenceToUser({
     this.name,
     this.userImageURl,
  });
  late final String? name;
  late final String? userImageURl;
  
  ReferenceToUser.fromJson(Map<String, dynamic> json){
    name = json['name'];
    userImageURl = json['userImageURl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['userImageURl'] = userImageURl;
    return _data;
  }
}