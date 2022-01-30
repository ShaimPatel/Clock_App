class UserModel {
  String? uid;
  String? email;
  String? userName;
  String? password;
  String? phonenumber;

  UserModel(
      {this.uid, this.email, this.userName, this.password, this.phonenumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        userName: map['userName'],
        password: map['password'],
        phonenumber: map['contactno']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'password': password,
      'contactno': phonenumber,
    };
  }
}
