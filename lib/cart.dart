import 'package:eshop/apiModel/cartmodel.dart';
import 'package:eshop/constant/app_color.dart';
import 'package:eshop/reusable.dart/productpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartDatabaseHelper cartDatabaseHelper = CartDatabaseHelper();
  List<CartItem> cartItems = [];

  @override
  @override
  void initState() {
    loadCart();
    // TODO: implement initState
    super.initState();
  }

  void loadCart() async {
    final items = await CartDatabaseHelper().getCartItems();
    print("Loaded items: ${items.length}"); // For debug
    setState(() {
      cartItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      backgroundColor: const Color.fromRGBO(24, 22, 35, 1),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                print("wotkinhg");
                final item = cartItems[index];
                return Container(
                  color: AppColors.background,
                  margin: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 150,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8, top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "₹${item.price}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Total ₹${(item.price * item.quantity).toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () async {
                                    if (item.quantity > 0) {
                                      await CartDatabaseHelper().updateQuantity(
                                        item.id!,
                                        item.quantity - 1,
                                      );
                                      loadCart(); // refresh list
                                      setState(() {});
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () async {
                                    // refresh list

                                    bool success = await CartDatabaseHelper()
                                        .updateQuantity(
                                          item.id!,
                                          item.quantity + 1,
                                        );

                                    if (success) {
                                      print("✅ Quantity updated successfully!");
                                    } else {
                                      print("❌ Update failed: item not found.");
                                    }
                                    loadCart();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {},

                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  margin: EdgeInsets.only(top: 0, left: 40),
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Text(
                                    textAlign: TextAlign.end,
                                    "Buy now",
                                    style: GoogleFonts.poppins(
                                      backgroundColor: Colors.green,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18,
                                      color: Colors.white,

                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
