import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/modules/cart/presentation/screens/cart_screen.dart';
import 'package:krtobaa_task/src/modules/categories/presentation/screens/categories.dart';
import 'package:krtobaa_task/src/modules/favourites/presentation/screens/favourites_screen.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/screens/home_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _bottomNavIndex = 0;

  _buildScreens() {
    return [
      const HomeScreen(),
      const CategoriesPage(),
      const FavouritesPage(),
      const HomeScreen(),
    ];
  }
  @override
  void initState() {

    super.initState();

    BlocProvider.of<CartCubit>(context).loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: _buildScreens()[_bottomNavIndex],
        floatingActionButton: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CartLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ));
                },
                shape: const CircleBorder(),
                backgroundColor: AppColor.secondary,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${state.cartItems.length}',
                        style: const TextStyle(
                            color: AppColor.white, fontSize: 12)),
                    const Icon(Icons.shopping_cart, color: AppColor.white),
                  ],
                ),
              );
            }
            return const Visibility(
              visible: false,
              child: SizedBox(
                height: 0,
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? AppColor.cyan : AppColor.darkGrey;
            final icons = [
              Icons.home,
              Icons.category,
              Icons.favorite,
              Icons.person,
            ];
            final titles = [
              AppStrings.home,
              AppStrings.categories,
              AppStrings.favourites,
              AppStrings.profile,
            ];
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icons[index], color: color, size: 24),
                const SizedBox(height: 4),
                Text(titles[index],
                    style: TextStyle(color: color, fontSize: 12)),
              ],
            );
          },
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) => setState(() => _bottomNavIndex = index),
          //other params
        ),
      ),
    );
  }
}
