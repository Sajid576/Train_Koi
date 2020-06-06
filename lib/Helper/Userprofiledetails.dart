class Userprofiledetails{
  var phone;
  var username;
  var uid;
  var session;
  var email;
  var dp;
  var coin;

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