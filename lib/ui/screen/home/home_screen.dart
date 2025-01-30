import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/ui/constant/color_pallete.dart';
import 'package:movie/ui/screen/home/section/categories/categories.dart';
import 'package:movie/ui/screen/home/section/now_playing/now_playing.dart';
import 'package:movie/ui/screen/home/section/upcoming/upcoming.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> category = ['Action', 'Comedy', 'Horor', 'Romantic'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Joko 👋',
                            style: TextStyle(
                                color: ColorPallete.colorGrey, fontSize: 14),
                          ),
                          Text(
                            "Let's Relax and watch a movie !",
                            style: TextStyle(
                                color: ColorPallete.colorWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        'assets/images/image.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(color: ColorPallete.colorWhite),
                  decoration: InputDecoration(
                      hintText: 'Search movie...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            BorderSide(width: 1, color: ColorPallete.colorGrey),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: ColorPallete.colorSecondary,
                      prefixIconColor: ColorPallete.colorGrey,
                      hintStyle: TextStyle(color: ColorPallete.colorGrey)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CategoriesSection(),
                const SizedBox(
                  height: 20,
                ),
                const NowPlayingSection(),
                const UpcomingSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
