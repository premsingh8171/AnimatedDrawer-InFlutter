import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar_animation_drawer/sidebar/menu_item.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 40,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: const Color(0xFFEFA726),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      ListTile(
                        title: Text(
                          "Prem Singh",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w800),
                        ),
                        subtitle: Text(
                          "premsingh8171@gmail.com",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.perm_identity,
                            color: Color(0xFFEFA726),
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 1.0,
                        color: Colors.white.withOpacity(0.5),
                        indent: 32,
                        endIndent: 32,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: <Widget>[
                            MenuItem(
                              icon: Icons.home,
                              title: "Home",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigationEvents.HomePageClickedEvent);
                              },
                            ),
                            MenuItem(
                              icon: Icons.person,
                              title: "My Account",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context).add(
                                    NavigationEvents.MyAccountClickedEvent);
                              },
                            ),
                            MenuItem(
                              icon: Icons.shopping_basket,
                              title: "My Orders",
                              onTap: () {
                                onIconPressed();
                                BlocProvider.of<NavigationBloc>(context)
                                    .add(NavigationEvents.MyOrdersClickedEvent);
                              },
                            ),
                            MenuItem(
                              icon: Icons.card_giftcard,
                              title: "Wishlist",
                              onTap: () {},
                            ),
                            Divider(
                              height: 64,
                              thickness: 1.0,
                              color: Colors.white.withOpacity(0.3),
                              indent: 10,
                              endIndent: 12,
                            ),
                            MenuItem(
                              icon: Icons.settings,
                              title: "Settings",
                              onTap: () {},
                            ),
                            MenuItem(
                              icon: Icons.exit_to_app,
                              title: "Logout",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFFEFA726),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Color(0xFFFFFFFF),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
