import 'package:flutter/material.dart';
import 'package:tut/shared/bottom_nav_widgets/nav_item.dart';
import 'package:tut/shared/job_style.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    required this.controller,
    required this.controller2,
    required this.isActive, required List<Widget> children,
  });

  final TabController controller;
  final TabController controller2;
  final ValueNotifier<bool> isActive;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late TabController _currentController;

  @override
  void initState() {
    super.initState();
    _currentController =
        widget.isActive.value ? widget.controller : widget.controller2;
    widget.controller.addListener(_navListener);
    widget.controller2.addListener(_navListener);
    widget.isActive.addListener(_activeListener);
  }

  void _navListener() {
    setState(() {});
  }

  void _activeListener() {
    setState(() {
      _currentController =
          widget.isActive.value ? widget.controller : widget.controller2;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_navListener);
    widget.controller2.removeListener(_navListener);
    widget.isActive.removeListener(_activeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      child: Material(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: JobStyle.borderRadiusButton,
        ),
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: JobStyle.borderRadius,
            child: Material(
              elevation: JobStyle.elevation,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavItem(
                    img: "assets/images/home.png",
                    text: "Home",
                    onTap: () {
                      _currentController.animateTo(0);
                    },
                    color: _currentController.index == 0
                        ? JobStyle.purple
                        : const Color.fromARGB(255, 19, 4, 4),
                    imgColor: _currentController.index == 0
                        ? JobStyle.purple
                        : Colors.grey,
                  ),
                  if (widget.isActive.value)
                    NavItem(
                      img: "assets/images/saved.png",
                      text: "Saved",
                      onTap: () {
                        _currentController.animateTo(1);
                      },
                      color: _currentController.index == 1
                          ? JobStyle.purple
                          : JobStyle.black,
                      imgColor: _currentController.index == 1
                          ? JobStyle.purple
                          : Colors.grey,
                    ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
