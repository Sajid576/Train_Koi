class UserModel{
    String phone;
    String username;
    String uid;
    var session;
    String email;
    String dp;
    int coin;



    UserModel({this.dp,this.phone,this.username,this.uid,this.session,this.email,this.coin});



    UserModel.setUserJsonData(Map<String, dynamic> body)
    {
         this.email= body['email'];
         this.username= body['username'];
         this.phone= body['phone'];
         this.uid= body['uid'];
         this.coin= body['coins'];
    }

    setCoin(int coin)
    {
       this.coin=coin;
    }
    setUid(String uid)
    {
        this.uid=uid;
    }


    getUserJsonData()
    {
      var data = {
        'uid':this.uid,
        'email': this.email,
        'username':this.username,
        'phone':this.phone,
        'coins':this.coin,
        'dp':this.dp,
      };
      return data;
    }



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