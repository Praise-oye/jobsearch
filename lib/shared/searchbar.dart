import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.purple.shade200, // Background color similar to the image
        borderRadius: BorderRadius.circular(30.0), // Rounded corners
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white, // Hint text color
                ),
              ),
              style: TextStyle(
                color: Colors.white, // Input text color
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white, // Icon color
            onPressed: () {
              // Add your search logic here
            },
          ),
        ],
      ),
    );
  }
}
