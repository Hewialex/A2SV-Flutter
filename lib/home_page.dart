// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_bloc.dart';
// import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_event.dart';
// import 'package:layout_in_flutter/feature/product/presentation/bloc/bloc/product_state.dart';
// import 'package:layout_in_flutter/injection_container.dart';
// import 'description_page.dart';
// import 'add_page.dart';
// import 'search_product_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late ProductBloc _productBloc;

//   @override
//   void initState() {
//     super.initState();
//     _productBloc = sl<ProductBloc>();
//     _productBloc.add(LoadAllProductEvent());
//   }

//   @override
//   void dispose() {
//     _productBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => _productBloc,
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
//         appBar: AppBar(
//           backgroundColor: const Color.fromRGBO(254, 254, 254, 1),
//           leading: const Icon(
//             Icons.square_rounded,
//             size: 50,
//             color: Color.fromARGB(255, 184, 182, 182),
//           ),
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'July 14, 2023',
//                 style: TextStyle(
//                   fontFamily: 'Syne',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   height: 14.4 / 12,
//                   color: Color.fromARGB(255, 170, 170, 170),
//                 ),
//               ),
//               RichText(
//                 text: const TextSpan(
//                   text: 'Hello, ',
//                   style: TextStyle(
//                     fontFamily: 'Sora',
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                     height: 18.9 / 15,
//                     color: Colors.black,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: 'Yohannes',
//                       style: TextStyle(
//                         fontFamily: 'Sora',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         height: 18.9 / 15,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             Container(
//               width: 40,
//               height: 40,
//               margin: const EdgeInsets.only(right: 15),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(9),
//                 border: Border.all(color: const Color.fromRGBO(221, 221, 221, 1)),
//               ),
//               child: IconButton(
//                 icon: const Icon(Icons.notifications_outlined),
//                 color: Colors.black.withOpacity(0.7),
//                 iconSize: 20,
//                 onPressed: () {
//                   print('Notification icon tapped!');
//                 },
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const AddProductPage(),
//               ),
//             );
//           },
//           backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
//           foregroundColor: Colors.white,
//           shape: const CircleBorder(),
//           child: const Icon(Icons.add),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Available Products',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 36 / 24,
//                       color: Color.fromRGBO(62, 62, 62, 1),
//                     ),
//                   ),
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(9),
//                       border: Border.all(color: const Color.fromRGBO(221, 221, 221, 1)),
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.search),
//                       color: Colors.black.withOpacity(0.3),
//                       iconSize: 20,
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SearchProductPage(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: BlocBuilder<ProductBloc, ProductState>(
//                   builder: (context, state) {
//                     if (state is ProductLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is ProductLoadedAll) {
//                       return ListView.builder(
//                         itemCount: state.products.length,
//                         itemBuilder: (context, index) {
//                           final product = state.products[index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 10.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => DescriptionPage(
//                               product: ProductModel(
//     imageUrl: product.imageUrl, // Ensure these properties are available in ProductEntity
//     productName: product.productName,
//     price: product.price,
//     description: product.description,
//   ),
// ),
//                                   ),
//                                 );
//                               },
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16.0),
//                                 ),
//                                 color: Colors.white,
//                                 elevation: 4,
//                                 shadowColor: const Color.fromRGBO(63, 81, 243, 1).withOpacity(0.3),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.all(10.0),
//                                       width: 100,
//                                       height: 100,
//                                       decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: NetworkImage(product.imageUrl),
//                                           fit: BoxFit.cover,
//                                         ),
//                                         borderRadius: BorderRadius.circular(8.0),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           Text(
//                                             product.productName,
//                                             style: const TextStyle(
//                                               fontFamily: 'Sora',
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           Text(
//                                             '\$${product.price}',
//                                             style: const TextStyle(
//                                               fontFamily: 'Sora',
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                               color: Color.fromRGBO(63, 81, 243, 1),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     } else if (state is ProductError) {
//                       return Center(child: Text(state.message));
//                     } else {
//                       return const Center(child: Text('No products available.'));
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
