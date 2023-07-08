// import 'package:flutter/material.dart';
// import 'package:transfert_colis_inter_urbain/Screen/Pages/SignInPage.dart';
// import 'package:transfert_colis_inter_urbain/Screen/recherche/login_screen.dart';
// import 'package:transfert_colis_inter_urbain/Screen/recherche/signup_screen.dart';

// import 'widget/MyWidgets/Button.dart';
// import 'ThirdSignup.dart';
// import '../HomePage.dart';

// class WelcomePage extends StatefulWidget {
//   const WelcomePage({Key? key}) : super(key: key);

//   // Navigation route
//   static Widget route(){
//     return   WelcomePage();
//   }

//   @override
//   State<WelcomePage> createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//        title: const Text("Welcome"),
//      ),

//       body: SingleChildScrollView(
//      child:SafeArea(
//        child: Center(
//           child: Column(
//             children:  [
//               const SizedBox(height: 30,),

//               const Text("Welcome To", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//               ),



//               const Text("EasyTransfer", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 30,),
//               const Text("A Platform Designed to make your \n shipping experience smooth, easy, \n and hassle-free",
//            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),),

//               const SizedBox(height: 30,),

//               Button(ButtonName : "Let's Start", RouteName: "/SignInForm",),

//               const SizedBox(height: 30,),
//               const Text('Frequently Transported Objects',
//                 style: TextStyle(fontSize: 20,
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,)
//               ),



//               SizedBox(height: 10,),

//               Container(
//                child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,

//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      children: [

//                        Container(
//                          height: 140,
//                          width: 160,
//                          decoration: BoxDecoration(

//                            gradient: const LinearGradient(begin:
//                            Alignment.topCenter,
//                                end: Alignment.bottomCenter,
//                                colors: [
//                                  Color.fromRGBO(0, 0, 0, .4),
//                                  Color.fromRGBO(0, 0, 0, .2),

//                                ]),
//                            borderRadius: BorderRadius.circular(30),
//                          ),


//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(30),
//                            child:   Image.asset('images/s1 (5).jpg',
//                              fit: BoxFit.cover,
//                            ),

//                          ),

//                        ),

//                        SizedBox(width: 10,),

//                        Container(
//                          height: 140,
//                          width: 160,
//                          decoration: BoxDecoration(

//                            gradient: const LinearGradient(begin:
//                            Alignment.topCenter,
//                                end: Alignment.bottomCenter,
//                                colors: [
//                                  Color.fromRGBO(0, 0, 0, .4),
//                                  Color.fromRGBO(0, 0, 0, .2),

//                                ]),
//                            borderRadius: BorderRadius.circular(30),
//                          ),


//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(30),
//                            child:   Image.asset('images/s1 (4).jpg',
//                              fit: BoxFit.cover,
//                            ),

//                          ),
//                        ),


//                        SizedBox(width: 10,),

//                        Container(
//                          height: 140,
//                          width: 160,
//                          decoration: BoxDecoration(

//                            gradient: const LinearGradient(begin:
//                            Alignment.topCenter,
//                                end: Alignment.bottomCenter,
//                                colors: [
//                                  Color.fromRGBO(0, 0, 0, .4),
//                                  Color.fromRGBO(0, 0, 0, .2),

//                                ]),
//                            borderRadius: BorderRadius.circular(30),
//                          ),


//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(30),
//                            child:   Image.asset('images/s1 (3).jpg',
//                              fit: BoxFit.cover,
//                            ),

//                          ),
//                        ),


//                        SizedBox(width: 10,),

//                        Container(
//                          height: 140,
//                          width: 160,
//                          decoration: BoxDecoration(

//                            gradient: const LinearGradient(begin:
//                            Alignment.topCenter,
//                                end: Alignment.bottomCenter,
//                                colors: [
//                                  Color.fromRGBO(0, 0, 0, .4),
//                                  Color.fromRGBO(0, 0, 0, .2),

//                                ]),
//                            borderRadius: BorderRadius.circular(30),
//                          ),


//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(30),
//                            child:   Image.asset('images/s1 (2).jpg',
//                              fit: BoxFit.cover,
//                            ),

//                          ),
//                        ),

//                        SizedBox(width: 10,),

//                        Container(
//                            height: 140,
//                            width: 160,
//                          decoration: BoxDecoration(

//                            gradient: const LinearGradient(begin:
//                            Alignment.topCenter,
//                                end: Alignment.bottomCenter,
//                                colors: [
//                                  Color.fromRGBO(0, 0, 0, .4),
//                                  Color.fromRGBO(0, 0, 0, .2),

//                                ]),
//                            borderRadius: BorderRadius.circular(30),
//                          ),


//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(30),
//                            child:   Image.asset('images/s1 (1).jpg',
//                              fit: BoxFit.cover,
//                            ),

//                          ),
//                        ),

//                      ],

//                    ),
//                  ),
//                 )

//               ),

//               TextButton(onPressed: (){},

//                   child: const Text("How It's Works",
//                   style: TextStyle(fontSize: 22,
//                     decoration:

//                     TextDecoration.underline,
//                   decorationThickness: 2,
//                   decorationStyle: TextDecorationStyle.solid,

//                   fontWeight: FontWeight.bold,
//                   )
//                     ,

//                   )
//               )
//             ],

//           ),
//         ),
//       ),
//       ),

//       drawer: Drawer(
//       child: ListView(
//         children:  [
//           Container(
//             height: 80,

//             child: const DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.lightBlue,

//                 ),


//                 child: Text("My Drawer",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.white,
//                       fontSize: 24),
//                 )


//             ),
//           ),


//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text("Home"),
//             onTap: (){
//               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  RegistrationScreen()));
//               print("home");
//             },

//           ),

//           ListTile(
//             leading: const Icon(Icons.person),
//             title: const Text("Profile"),
//             onTap: (){

//               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  WelcomePage()));
//               print("Profile");
//             },

//           ),

//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text("Settings"),
//             onTap: (){
//               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  SignInForm()));
//               print("Setting");
//             },

//           ),
//         ],
//       ),
//     ),
//     );
//   }
// }


import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}