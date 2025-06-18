import 'package:eshop/constant/apiservice.dart';
import 'package:eshop/constant/app_color.dart';
import 'package:eshop/reusable.dart/productpage.dart';
import 'package:eshop/reusable.dart/reusable_widget.dart';
import 'package:flutter/material.dart';

import 'package:eshop/apiModel/apimodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final String categoryName;

  ProductScreen({required this.categoryName});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Apiservice apiservice = Apiservice();
  ScrollController scroll = ScrollController();
  String titleOrder = "A-Z";
  List filterproduct = [];
  // int priceOrder = 0;
  String priceOrder = "None"; // "Ascending", "Descending"
  String quantityOrder = "None";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("Products: ${widget.categoryName}")),
      body: FutureBuilder(
        future: apiservice.productApi1(widget.categoryName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Products> products = snapshot.data!.products!;

            // Apply sorting
            if (titleOrder == 'A-Z') {
              products.sort(
                (a, b) =>
                    a.title!.toLowerCase().compareTo(b.title!.toLowerCase()),
              );
            } else {
              products.sort(
                (a, b) =>
                    b.title!.toLowerCase().compareTo(a.title!.toLowerCase()),
              );
            }

            return Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sort by Title: "),
                      DropdownButton<String>(
                        value: titleOrder,
                        items: ['A-Z', 'Z-A']
                            .map(
                              (order) => DropdownMenuItem(
                                value: order,
                                child: Text(order),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            titleOrder = value!;
                            priceOrder = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                /// GridView wrapped in Expanded to avoid overflow
                Expanded(
                  child: GridView.builder(
                    controller: scroll,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Productpage(item: product),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      var begin = const Offset(0.1, 0.5);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(
                                        begin: begin,
                                        end: end,
                                      ).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  child: Image.network(
                                    product.thumbnail ?? "",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${product.title}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(.0),
                                child: Text(
                                  "\$${product.price}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.7,
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
