import 'package:flutter/material.dart';
import 'package:trainkoi/controller/LeftNavigationDrawyerController.dart';



class FAQScreen  extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> with SingleTickerProviderStateMixin{
  LeftNavDrawyer leftnavState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //instantiating left Navigation drawyer Object
    AnimationController controller=AnimationController(vsync:this ,duration: LeftNavDrawyer.duration);
    leftnavState=LeftNavDrawyer(controller);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    leftnavState.controller.dispose();

  }

  Widget FAQLayout(context)
  {
    return AnimatedPositioned(
      duration: LeftNavDrawyer.duration,
      top: 0,            //scale is done for top and bottom
      bottom: 0,
      left: leftnavState.isCollapsed ? 0 : 0.6 * MediaQuery.of(context).size.width ,
      right:leftnavState.isCollapsed ? 0 : -0.4 * MediaQuery.of(context).size.width,

      child: ScaleTransition(
        scale: LeftNavDrawyer.leftEnabled==true ? leftnavState.scaleAnimation : leftnavState.scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white,
          child: Scaffold(

            backgroundColor: Colors.white,
            appBar: AppBar(
              leading:
              IconButton(
                icon: Icon(Icons.menu,
                  color: Colors.white,),
                //onHorizontalDragEnd: (DragEndDetails details)=>_onHorizontalDrag(details),
                onPressed: (){
                  setState(() {
                    if(leftnavState.isCollapsed)
                    {
                      leftnavState.controller.forward();
                    }
                    else
                    {
                      leftnavState.controller.reverse();
                    }
                    LeftNavDrawyer.leftEnabled=!LeftNavDrawyer.leftEnabled;
                    leftnavState.isCollapsed = !leftnavState.isCollapsed;
                    //just reversing it to false
                  });
                },),
              title: Text("FAQ"),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),

            body: GestureDetector(
              onTap: (){
                setState(() {
                  if(!leftnavState.isCollapsed)
                  {
                    print("Gesture");
                    leftnavState.controller.reverse();
                    LeftNavDrawyer.leftEnabled=!LeftNavDrawyer.leftEnabled;
                    leftnavState.isCollapsed = !leftnavState.isCollapsed;
                  }
                });
              },
              child: SingleChildScrollView(

                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child:  ListView(
                        shrinkWrap: true,
                        children:  <Widget>[
                          Card(
                            color: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(

                              title: Text('1)How many services are there??   '
                                   ,style: TextStyle(
                                color: Colors.black,
                              ),

                             ),
                              subtitle: Text('Three.\n1)Location & address of the train \n2) Required distance and estimated time between train & Arriving station\n3) Required distance and estimated time between train & Destination station'
                                ,style: TextStyle(
                                    color: Colors.white
                                ),),

                            ),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: ListTile(

                              title: Text('Do I have to spend 1 coin for using for per feature ??'
                                ,style: TextStyle(
                                      color: Colors.black,
                                ),),
                              subtitle: Text('No.\nUsers can use all feature using only one coin.But if user goes back to HomeScreen he/she will have to spend another coin to query  .'
                              ,style: TextStyle(
                                  color: Colors.white
                                ),),
                            ),

                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[

          leftnavState.leftNavLayout(context),
          FAQLayout(context),
        ],
      ),
    );
  }
}
