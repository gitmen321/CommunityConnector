//loggedIn
//loggedOut
import 'package:flutter/material.dart';
import 'package:reddit_fullstack/feautures/auth/screens/login_screen.dart';
import 'package:reddit_fullstack/feautures/community/screens/community_screen.dart';
import 'package:reddit_fullstack/feautures/community/screens/create_community_screen.dart';
import 'package:reddit_fullstack/feautures/community/screens/edit_community_screen.dart';
import 'package:reddit_fullstack/feautures/community/screens/mod_tools_screen.dart';
import 'package:reddit_fullstack/feautures/home/screens/home_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOurRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()), 
  '/create-community': (_) => const MaterialPage(
        child: CreateCommunityScreen(),
      ),
  '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(
          name: route.pathParameters['name']!,
        ),
      ),
      '/mod-tools/:name': (routeData) =>  MaterialPage(
        child: ModToolsScreen(name: routeData.pathParameters['name']!,),
      ),
      '/edit-community/:name': (routeData) =>  MaterialPage(
        child: EditCommunityScreev(name: routeData.pathParameters['name']!,),
      ),

});
