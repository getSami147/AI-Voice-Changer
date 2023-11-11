class CommentModel {
  CommentModel({
     this.data,
  });
   List<Data>? data;
  
  CommentModel.fromJson(Map<String, dynamic> json){
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
     this.commentUid,
     this.commentMessage,
     this.isActive,
     this.createdAt,
     this.updatedAt,
     this.communityId,
  });
   String? id;
   CommentUid? commentUid;
   String? commentMessage;
   bool? isActive;
   String? createdAt;
   String? updatedAt;
   String? communityId;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    commentUid = CommentUid.fromJson(json['commentUid']);
    commentMessage = json['commentMessage'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    communityId = json['communityId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['commentUid'] = commentUid!.toJson();
    _data['commentMessage'] = commentMessage;
    _data['isActive'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['communityId'] = communityId;
    return _data;
  }
}

class CommentUid {
  CommentUid({
     this.id,
     this.name,
     this.userName,
     this.email,
     this.role,
     this.status,
    required this.userImageURl,
     this.contact,
     this.isVerified,
     this.gender,
     this.isActive,
     this.createdAt,
     this.updatedAt,
     this.V,
     this.passwordChangedAt,
  });
  late final String? id;
  late final String? name;
  late final String? userName;
  late final String? email;
  late final String? role;
  late final String? status;
  late final String userImageURl;
  late final String? contact;
  late final bool? isVerified;
  late final String? gender;
  late final bool? isActive;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;
  late final String? passwordChangedAt;
  
  CommentUid.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    userImageURl = json['userImageURl'];
    contact = json['contact'];
    isVerified = json['isVerified'];
    gender = json['gender'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    passwordChangedAt = json['passwordChangedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['userName'] = userName;
    _data['email'] = email;
    _data['role'] = role;
    _data['status'] = status;
    _data['userImageURl'] = userImageURl;
    _data['contact'] = contact;
    _data['isVerified'] = isVerified;
    _data['gender'] = gender;
    _data['isActive'] = isActive;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['passwordChangedAt'] = passwordChangedAt;
    return _data;
  }
}