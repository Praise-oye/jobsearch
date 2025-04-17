import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String img;
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color imgColor;

  const NavItem({
    super.key,
    required this.img,
    required this.text,
    required this.onTap,
    required this.color,
    required this.imgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              imgColor,
              BlendMode.srcIn,
            ),
            child: Image.asset(img, width: 30, height: 30),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
