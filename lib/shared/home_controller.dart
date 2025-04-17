import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut/home/jobs.dart';
import 'package:tut/saved/saved.dart';
import 'package:tut/shared/bottom_nav/bottom_navigation.dart';
import 'package:tut/shared/job_style.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});
  
  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController>
    with TickerProviderStateMixin {

  final ValueNotifier<bool> _isActiveNotifier = ValueNotifier<bool>(false);
  
  late TabController _tabController;
  late TabController _tabController2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController2 = TabController(length: 2, vsync: this);
    _isActiveNotifier.value = true;  
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController2.dispose();
    _isActiveNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JobStyle.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/bg.svg",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _isActiveNotifier.value
                      ? _tabController
                      : _tabController2,
                  children: const [
                    HomeScreen(),
                    Saved(),  
                  
                  ],
                ),
              ),
              BottomNavigation(
                controller: _tabController,
                controller2: _tabController2,
                isActive: _isActiveNotifier,
                children: const [
                  HomeScreen(),
                  Saved(),
                
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
