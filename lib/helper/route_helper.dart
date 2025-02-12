

import 'package:get/get.dart';
import 'package:journey/pages/auth_pages/sign_up_page.dart';
import 'package:journey/pages/home_page.dart';
import 'package:journey/pages/posts/posts_page.dart';
import 'package:journey/pages/profile_page.dart';

import '../pages/auth_pages/sign_in_page.dart';

class RouteHelper 
{
  static const String initial = "/";
  static const String homepage = "/home";
  static const String profilePage = "/profile_page";
  static const String signIn = "/sign_in";
  static const String signUp = "/sign_up";
  static const String postsPage = "/posts_page";



   static String getInitial()=>initial;
   static String getHome()=>homepage;
   static String getProfile()=>profilePage;
  static String getSignIn()=>signIn;
  static String getSignUp()=>signUp;
  static String getPostsPage()=> postsPage;

  static List<GetPage> routes = 
  [       

          GetPage(name:signIn, page: ()=>const SigninPage()),
          GetPage(name:signUp, page: ()=> const SignupPage()),
          GetPage(name:profilePage, page: ()=> const Profile()),
          GetPage(name: postsPage, page:()=> const PostsPage()),
          GetPage(name: homepage, page:()=> const HomePage()),

  ];
}