// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:transfert_colis_interurbain/Domain/Model/Packages.dart';

// // ignore: camel_case_types
// class packageDescriptionItem extends StatefulWidget {
//   const packageDescriptionItem({super.key});

//   @override
//   State<packageDescriptionItem> createState() => _packageDescriptionItemState();
// }

// // ignore: camel_case_types
// class _packageDescriptionItemState extends State<packageDescriptionItem> {
//   final GlobalKey _formkey = GlobalKey<FormState>();
//   Packages package = Packages.empty();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.only(left: 2, right: 2, bottom: 20, top: 20),
//       decoration: BoxDecoration(
//           border: Border.all(width: 1),
//           borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.only(left: 20),
//                 child: Text(
//                   "Valeur",
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                 ),
                
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 5),
//                 child:  IconButton(onPressed: (){

//                 }, 
//                 icon: const Icon(Icons.delete , color:  (Color.fromARGB(255, 248, 7, 7)),))
//               )
//             ],
//           ), 
//           Container(
//               width: 200,
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//               child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   onSaved: (value) => package.packageValue = int.parse(value!),
//                   validator: (value) =>
//                       value != null ? null : "Enter Colis Value",
//                   decoration: const InputDecoration(
//                     hintText: "Exple : 50.0000 Fcfa",
//                     // hintText: "Enter Email",
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     border: OutlineInputBorder(
//                       // borderSide: BorderSide(width:50),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.0),
//                       ),
//                     ),
//                   ))),
//           const SizedBox(height: 20),
//           const Padding(
//             padding: EdgeInsets.only(
//               left: 20,
//             ),
//             child: Text(
//               "Nom de l'objet",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//               //height: 1
//               padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//               child: TextFormField(
//                   onSaved: (value) => package.packageDescription = value!,
//                   validator: (value) =>
//                       value != null ? null : "packet Description",
//                   minLines: 1,
//                   maxLines: 5,
//                   decoration: const InputDecoration(
//                     hintText:
//                         "Ex: My package is made up of \n two documents and one T-Shirt...",
//                     border: OutlineInputBorder(
//                       // borderSide: BorderSide(width:50),
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(10.0),
//                       ),
//                     ),
//                   ))),
//         ],
//       ),
//     );
//   }
// }
