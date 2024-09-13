class UserModal
{
  String? name,email,phone,token,img;

  UserModal({required this.name,required this.email,required this.phone,required this.token,required this.img});

  factory UserModal.fromMap(Map m1)
  {
    return UserModal(name: m1['name'], email: m1['email'], phone: m1['phone'], token: m1['token'],img: m1['img']);

  }

  Map<String, String?> toMap(UserModal user)
  {
    return {
      'name' : user.name,
      'email' : user.email,
      'token' : user.token,
      'phone' : user.phone,
      'img' : user.img,
    };
  }
}