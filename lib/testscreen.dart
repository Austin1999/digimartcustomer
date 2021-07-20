// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:digimartcustomer/constants/controllers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TestPaginationScreen extends StatefulWidget {
//   @override
//   _TestPaginationScreenState createState() => _TestPaginationScreenState();
// }

// class _TestPaginationScreenState extends State<TestPaginationScreen> {
//   final ScrollController scrollController = ScrollController();
//   var category = "Masala";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     scrollController.addListener(scrollListener);
//     producsController.getNextProducts(category);
//   }

//   @override
//   void dispose() {
//     scrollController.dispose();
//     super.dispose();
//   }

//   void scrollListener() {
//     if (scrollController.offset >= scrollController.position.maxScrollExtent/1.5 ) {
//       if (producsController.hasNext.value) {
//         producsController.getNextProducts(category);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Obx(
//       () => ListView(
//         controller: scrollController,
//         children: [
//           ...producsController.products.map(
//             (dataval) => Column(
//               children: [
//                 ListTile(
//                   leading: CachedNetworkImage(
//                     imageUrl: dataval.photo[0],
//                     width: 100,
//                     imageBuilder: (context, imageProvider) => Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: imageProvider,
                            
//                              fit: BoxFit.cover,
//                             ),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     placeholder: (context, url) => Image.asset(
//                       'assets/images/loading.gif',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                   title: Text(dataval.name),
//                   subtitle: Text(dataval.category),
//                 ),
//                 Divider()
//               ],
//             ),
//           ),
//           // Column(
//           //   crossAxisAlignment: CrossAxisAlignment.start,
//           //   children: <Widget>[
//           //     Expanded(
//           //       child: CachedNetworkImage(
//           //         imageUrl: dataval.photo[0],
//           //         imageBuilder:
//           //             (context, imageProvider) =>
//           //                 Container(
//           //           decoration: BoxDecoration(
//           //             image: DecorationImage(
//           //                 image: imageProvider,
//           //                 fit: BoxFit.cover),
//           //             borderRadius:
//           //                 BorderRadius.circular(5),
//           //           ),
//           //         ),
//           //         placeholder: (context, url) =>
//           //             Image.asset(
//           //           'assets/images/loading.gif',
//           //           fit: BoxFit.contain,
//           //         ),
//           //       ),
//           //     ),
//           //     dataval.quantity == 0
//           //         ? Text(
//           //             'Out of Stock',
//           //             style: Theme.of(context)
//           //                 .textTheme
//           //                 .subtitle2
//           //                 .copyWith(color: Colors.red),
//           //           )
//           //         : !dataval.pincode.contains(
//           //                 userController
//           //                     .userModel.value.pincode)
//           //             ? Text(
//           //                 'Not Deliverable',
//           //                 style: Theme.of(context)
//           //                     .textTheme
//           //                     .subtitle2
//           //                     .copyWith(
//           //                         color: Colors.red),
//           //               )
//           //             : Text(
//           //                 'Deliverable',
//           //                 style: Theme.of(context)
//           //                     .textTheme
//           //                     .subtitle2
//           //                     .copyWith(
//           //                         color: Colors.green),
//           //               ),

//           //     SizedBox(height: 5),
//           //     Text(
//           //       dataval.name,
//           //       style:
//           //           Theme.of(context).textTheme.bodyText1,
//           //       overflow: TextOverflow.ellipsis,
//           //     ),
//           //     SizedBox(height: 2),
//           //     Text(
//           //       '${dataval.dummy.first.offerprice} / ${dataval.dummy.first.variation}',
//           //       style:
//           //           Theme.of(context).textTheme.caption,
//           //       overflow: TextOverflow.ellipsis,
//           //     )
//           //   ],
//           // ),).toList(),
//           if (producsController.hasNext.value)
//             Center(
//               child: CircularProgressIndicator(),
//             )
//         ],
//       ),
//     ));
//   }
// }
