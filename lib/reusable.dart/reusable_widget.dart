import 'package:eshop/apiModel/apimodel.dart';
import 'package:eshop/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    Key? key,
    required this.title,
    this.actionText = 'See All',
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408,
      padding: const EdgeInsets.only(top: 16, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textcolor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// eplace with the actual path to Discover class

class DiscoverCard extends StatelessWidget {
  final Products item;

  const DiscoverCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 240,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: 160,
        height: 240,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                color: Colors.white,
                width: 160,
                height: 240,
                foregroundDecoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 0.0, 0.5, 0.9],
                  ),
                ),
                child: Image.network(
                  item.thumbnail ?? '',
                  width: 160,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Positioned(
            //   top: 16,
            //   right: 10,
            //   child: Image.asset("images/save2.png"),
            // ),
            Positioned(
              bottom: 50,
              left: 8,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 51,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Color(0xFFD9DB6D), size: 18),
                      SizedBox(width: 2),
                      Text(
                        "4/5",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 8,
              right: 8,
              child: Text(
                "\$:${item.price.toString()}" ?? '',
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                  color: const Color(0xFFE5E5E8),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
