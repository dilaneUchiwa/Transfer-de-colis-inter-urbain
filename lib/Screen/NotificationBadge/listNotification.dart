import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcceptRejectPackage extends StatefulWidget {
  const AcceptRejectPackage({Key? key}) : super(key: key);

  @override
  State<AcceptRejectPackage> createState() => _AcceptRejectPackageState();
}

class _AcceptRejectPackageState extends State<AcceptRejectPackage> {

  static Widget route(){
    return   AcceptRejectPackage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Package To..."),
      ),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
            height: 240,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12 ),
              boxShadow: [BoxShadow(color : Colors.black.withOpacity(0.1), blurRadius : 2)]
          ),
           child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             SizedBox(height: 10,),
             Text("Package Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
             SizedBox(height: 5,),
             Text("Name of the package" ),
             SizedBox(height: 10,),
             Text("Package Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
             SizedBox(height: 5,),
             Text("Name of the package Description"),
             SizedBox(height: 10,),
             Text("Photo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
             SizedBox(height: 5,),
             Text("Package photo"),
             SizedBox(height: 5,),
             Row(
               children: [

                 Expanded(
                   child: Text(""),
                 ),

                 ElevatedButton(
                   onPressed: (){

                   },
                   child: Text("Reject"),
                 ),
                 SizedBox(width: 20,),
                 ElevatedButton(
                   onPressed: (){

                   },
                   child: Text("Accept"),
                 )
               ],
             )
           ],
         ),
         ),
        ),
      ),
    );
  }
}
