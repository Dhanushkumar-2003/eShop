import 'dart:math';

import 'package:eshop/apiModel/apimodel.dart';
import 'package:eshop/apiModel/cartmodel.dart';
import 'package:eshop/constant/app_color.dart';
import 'package:eshop/home.dart';
import 'package:eshop/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Productpage extends StatefulWidget {
  final Products item;
  const Productpage({super.key, required this.item});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        // height: 86,
        color: Color(0xFF303346),
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.asset("images/time.png"),
            SizedBox(width: 2),
            Container(
              // padding: EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  cartDatabaseHelper.insertItem(
                    CartItem(
                      id: widget.item.id!.toInt(),
                      name: widget.item.title.toString(),
                      price: widget.item.price!.toDouble(),
                      quantity: widget.item.minimumOrderQuantity!.toInt(),
                      imageUrl: widget.item.thumbnail.toString(),
                    ),
                  );
                },
                child: Container(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    "Add to cart",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(width: 8),
            // Image.asset("images/arrow.png"),

            /// Right Side (Button)
            Container(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 500),
                        pageBuilder: (_, __, ___) => UserFormPage(),
                        transitionsBuilder: (_, animation, __, child) {
                          final offsetAnimation =
                              Tween<Offset>(
                                begin: Offset(1.0, 0.0), // Slide from right
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeIn,
                                ),
                              );

                          final fadeAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          );

                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: fadeAnimation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF42B1CB),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    "Buy now",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF181623),
      body: Container(
        color: Color(0xFF181623),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,

          child: Container(
            width: double.infinity,

            color: Color(0xFF181623),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Image(
                          // height: 448,
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.item.thumbnail ?? ""),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      left: 14,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Home(),
                                // MyHomePage(),
                                transitionsBuilder:
                                    (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      // PUSH: Slide from bottom
                                      final pushTween =
                                          Tween<Offset>(
                                            begin: const Offset(0.0, 1.0),
                                            end: Offset.zero,
                                          ).chain(
                                            CurveTween(curve: Curves.easeInOut),
                                          );

                                      // POP: Slide down + fade out
                                      final popOffsetTween =
                                          Tween<Offset>(
                                            begin: Offset.zero,
                                            end: const Offset(0.0, 0.2),
                                          ).chain(
                                            CurveTween(curve: Curves.easeOut),
                                          );

                                      final fadeTween =
                                          Tween<double>(
                                            begin: 1.0,
                                            end: 0.0,
                                          ).chain(
                                            CurveTween(curve: Curves.easeOut),
                                          );

                                      return SlideTransition(
                                        position: animation.drive(
                                          pushTween,
                                        ), // forward animation
                                        child: FadeTransition(
                                          opacity: secondaryAnimation.drive(
                                            fadeTween,
                                          ), // backward fade
                                          child: SlideTransition(
                                            position: secondaryAnimation.drive(
                                              popOffsetTween,
                                            ), // backward slide down
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                              ),
                            );

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MyHomePage(),
                            //   ),
                            // );
                          },
                          child: Container(),
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.item.title.toString(),

                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 61,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 152, 147, 147),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 2),
                                child: Icon(
                                  Icons.star,
                                  color: Color(0xFFD9DB6D),
                                  size: 18,
                                ),
                              ),
                              Text(
                                "${widget.item.rating?.toString() ?? ""}/5",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 7, right: 16, top: 10),
                  child: Row(
                    children: [
                      // Container(
                      //   width: 14,
                      //   height: 16,
                      //   child: Image(image: AssetImage("images/l.png")),
                      // ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 16, top: 5),
                  child: Row(
                    children: [
                      Text(
                        " ${widget.item.discountPercentage ?? ""}%",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "\$${widget.item.price! * 100}",
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.w400,
                          color: AppColors.unselectcolor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "\$${widget.item.price ?? ""}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 16, top: 20),
                  child: Text(
                    "Description",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 26, right: 16, top: 10),
                  child: Text(
                    widget.item?.description ?? "",
                    style: TextStyle(color: Color(0xFF787B86)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20, right: 16, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Details",
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 173, 171, 171),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0, top: 10),
                        child: Text(
                          "Brand           :${widget.item.brand ?? "not mention"}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Dimension  :${widget.item.dimensions?.depth.toString() ?? ""}x${widget.item.dimensions!.height.toString()}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Status          :${widget.item.availabilityStatus?.toString() ?? ""}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "Category     :${widget.item.category?.toString() ?? ""}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 20),
                        child: Text(
                          "review       :${widget.item.reviews![0].comment.toString()}",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();
  factory CartDatabaseHelper() => _instance;
  CartDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart (
            id INTEGER PRIMARY KEY,
            name TEXT,
            price DOUBLE,
            quantity INTEGER,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertItem(CartItem item) async {
    try {
      final db = await database;
      final ak = await db.insert(
        'cart',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print("db>>$ak");
    } catch (e) {
      print("error>$e");
    }

    // print("db>>${ak}");
  }

  Future<List<CartItem>> getCartItems() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('cart');
      print("map>>${maps[0]['name']}");
      return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
    } catch (e) {
      print("error>>$e");
    }
    throw 'kln';
  }

  Future<bool> updateQuantity(int id, int newQuantity) async {
    final db = await database;
    final ak = await db.update(
      'cart',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [id],
    );

    print("ak>>${ak}");
    return ak > 0;
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
