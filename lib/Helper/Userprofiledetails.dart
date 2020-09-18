class Userprofiledetails{
  String phone;
  String username;
  String uid;
  var session;
  String email;
  String dp;
  int coin;

  Userprofiledetails({this.dp,this.phone,this.username,this.uid,this.session,this.email,this.coin});

  getDP()
  {
    return dp;
  }

  getphone(){
    return phone;
  }

  getuid(){
    return uid;
  }

  getusername(){
    return username;
  }

  getsession(){
    return session;
  }
  getemail(){
    return email;
  }
  getCoin()
  {
    return coin;
  }
}