class User {
  int loginType;
  int code;
  String msg;
  Account account;
  Profile profile;

  User({
    this.loginType,
    this.code,
    this.msg,
    this.account,
    this.profile,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginType'] = this.loginType;
    data['code'] = this.code;
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.toJson();
    }
    return data;
  }
  User.fromJson(Map<String, dynamic> json) {
    loginType = json['loginType'];
    profile = json['profile'];
    account = json['account'];
    msg = json['msg'];
  }
}

class Account {
  int id;
  String userName;
  int status;
  String token;
  int createTime;

  Account({
    this.id,
    this.userName,
    this.status,
    this.token,
    this.createTime,
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    status = json['status'];
    createTime = json['createTime'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['token'] = this.token;
    data['status'] = this.status;
    data['createTime'] = this.createTime;
    return data;
  }
}

class Profile {
  int gender;
  String avatarUrl;
  String nickname;
  int birthday;
  String description;

  Profile({
    this.gender,
    this.avatarUrl,
    this.nickname,
    this.birthday,
    this.description,
    
  });

  Profile.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
   
    avatarUrl = json['avatarUrl'];
    nickname = json['nickname'];
    birthday = json['birthday'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    data['avatarUrl'] = this.avatarUrl;
    data['nickname'] = this.nickname;
    data['birthday'] = this.birthday;
    data['description'] = this.description;
    return data;
  }
}
