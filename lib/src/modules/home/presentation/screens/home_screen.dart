import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_assets.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/categories_cubit/categories_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/favourites/favourites_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/products_cubit/products_cubit.dart';
import 'package:krtobaa_task/src/modules/product_details/presentation/screens/product_details.dart';

import '../../../../core/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoriesCubit>(context).init();
    BlocProvider.of<ProductsCubit>(context).init();
    BlocProvider.of<FavouritesCubit>(context).loadFavouritesIds();
    BlocProvider.of<CartCubit>(context).loadCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          centerTitle: true,
          title: const TextWidget(
            txt: AppStrings.home,
            fontSize: 20,
          ),
        ),
        drawer: const Drawer(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180.74,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageAssets.image1Slider),
                    fit: BoxFit.cover,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              Column(
                textDirection: TextDirection.rtl,
                children: [
                  (context.height * 0.09).ph,
                  SizedBox(
                    height: 38,
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.white.withOpacity(0.6),
                        hintText: AppStrings.search,
                        hintTextDirection: TextDirection.rtl,
                        suffixIcon: const Icon(
                          Icons.search,
                          color: AppColor.grey,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColor.transparent),
                            borderRadius: BorderRadius.circular(27)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColor.transparent),
                            borderRadius: BorderRadius.circular(27)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColor.transparent),
                            borderRadius: BorderRadius.circular(27)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: AppColor.transparent),
                            borderRadius: BorderRadius.circular(27)),
                      ),
                    ),
                  ),
                  10.ph,
                  buildCarouselSlider(),
                  5.ph,
                  buildCategories(),
                  20.ph,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      TextWidget(
                        txt: AppStrings.newArrival,
                        fontSize: 14,
                        fontWeight: FontWeightManger.bold,
                        color: AppColor.textGrey,
                      ),
                      TextWidget(
                        txt: AppStrings.viewAll,
                        fontSize: 12,
                        fontWeight: FontWeightManger.medium,
                        color: AppColor.textGrey,
                      ),
                    ],
                  ),
                  10.ph,
                  buildMostRecentProducts(),
                  20.ph,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      TextWidget(
                        txt: AppStrings.popular,
                        fontSize: 14,
                        fontWeight: FontWeightManger.bold,
                        color: AppColor.textGrey,
                      ),
                      TextWidget(
                        txt: AppStrings.viewAll,
                        fontSize: 12,
                        fontWeight: FontWeightManger.medium,
                        color: AppColor.textGrey,
                      ),
                    ],
                  ),
                  10.ph,
                  buildMostPopularProducts(),
                  20.ph,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMostRecentProducts() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) => current is MostRecentProducts,
      builder: (context, state) {
        if (state is MostRecentProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MostRecentProductsError) {
          debugPrint(state.message);
          return const Center(child: Text('Error'));
        }
        if (state is MostRecentProducts) {
          debugPrint('MostRecentProducts');

          return SizedBox(
            height: 205,
            child: buildProductsList(state),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildMostPopularProducts() {
    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen: (previous, current) => current is MostPopularProducts,
      builder: (context, state) {
        if (state is MostPopularProductsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MostPopularProductsError) {
          debugPrint(state.message);
          return const Center(child: Text('Error'));
        }
        if (state is MostPopularProducts) {
          debugPrint('MostPopularProducts');
          return SizedBox(
            height: 205,
            child: buildProductsList(state),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildProductsList(state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.productsEntity.results!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                      id: state.productsEntity.results![index].id.toString(),
                    )));
          },
          child: Container(
            height: 205,
            width: 133,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            color: AppColor.white,
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      state.productsEntity.results![index].imageLink!,
                      height: 115,
                      width: 121,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const SizedBox(
                            height: 115,
                            width: 121,
                            child: Icon(
                              Icons.info,
                              color: AppColor.red,
                            ));
                      },
                      fit: BoxFit.cover,
                    ),
                    BlocConsumer<FavouritesCubit, FavouritesState>(
                      listener: (context, state) {},
                      builder: (context, favouriteState) {
                        if (favouriteState is FavouritesLoaded) {
                          return IconButton(
                              onPressed: () {
                                if (favouriteState.favouritesIds.contains(state
                                    .productsEntity.results![index].name!)) {
                                  BlocProvider.of<FavouritesCubit>(context)
                                      .deleteFavouritesIds(
                                          state.productsEntity.results![index]
                                              .name!,
                                          state.productsEntity.results![index]
                                              .imageLink!,
                                          state.productsEntity.results![index]
                                              .name!,
                                          state.productsEntity.results![index]
                                              .price!);
                                } else {
                                  BlocProvider.of<FavouritesCubit>(context)
                                      .saveFavouritesIds(
                                    state.productsEntity.results![index].name!,
                                    state.productsEntity.results![index]
                                        .imageLink!,
                                    state.productsEntity.results![index].name!,
                                    state.productsEntity.results![index].price!,
                                  );
                                }
                              },
                              icon: Icon(
                                favouriteState.favouritesIds.contains(state
                                        .productsEntity.results![index].name!)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favouriteState.favouritesIds.contains(
                                        state.productsEntity.results![index]
                                            .name!)
                                    ? AppColor.secondary
                                    : AppColor.darkGrey,
                              ));
                        } else {
                          return IconButton(
                              color: AppColor.darkGrey,
                              onPressed: () {
                                BlocProvider.of<FavouritesCubit>(context)
                                    .saveFavouritesIds(
                                  state.productsEntity.results![index].name!,
                                  state.productsEntity.results![index]
                                      .imageLink!,
                                  state.productsEntity.results![index].name!,
                                  state.productsEntity.results![index].price!,
                                );
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                              ));
                        }
                      },
                    ),
                  ],
                ),
                5.ph,
                TextWidget(
                  txt: state.productsEntity.results![index].name!,
                  fontSize: 12,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeightManger.medium,
                  color: AppColor.textGrey,
                ),
                Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      txt: state.productsEntity.results![index].price!,
                      fontSize: 14,
                      fontWeight: FontWeightManger.bold,
                      color: AppColor.cyan,
                    ),
                    5.pw,
                    BlocConsumer<CartCubit, CartState>(
                      listener: (context, state) {},
                      builder: (context, cartState) {
                        if (cartState is CartLoaded) {
                          return IconButton(
                              onPressed: () {
                                if (cartState.cartItems.contains(state
                                    .productsEntity.results![index].name!)) {
                                  BlocProvider.of<CartCubit>(context)
                                      .deleteCartItem(
                                          state.productsEntity.results![index]
                                              .name!,
                                          state.productsEntity.results![index]
                                              .imageLink!,
                                          state.productsEntity.results![index]
                                              .price!);
                                } else {
                                  BlocProvider.of<CartCubit>(context)
                                      .saveCartItem(state.productsEntity.results![index]
                                      .name!,
                                      state.productsEntity.results![index]
                                          .imageLink!,
                                      state.productsEntity.results![index]
                                          .price!);
                                }
                              },
                              icon: Icon(
                                cartState.cartItems.contains(state
                                        .productsEntity.results![index].name!)
                                    ? Icons.add_shopping_cart
                                    : Icons.add_shopping_cart_outlined,
                                color: cartState.cartItems.contains(state
                                        .productsEntity.results![index].name!)
                                    ? AppColor.darkCyan
                                    : AppColor.darkGrey,
                              ));
                        } else {
                          return IconButton(
                              onPressed: () {
                                BlocProvider.of<CartCubit>(context)
                                    .saveCartItem(state.productsEntity.results![index]
                                    .name!,
                                    state.productsEntity.results![index]
                                        .imageLink!,
                                    state.productsEntity.results![index]
                                        .price!);
                              },
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                size: 24,
                                color: AppColor.darkGrey,
                              ));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategories() {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          debugPrint(state.message);
          return const Center(child: Text('Error'));
        } else if (state is AllCategoriesLoaded) {
          return SizedBox(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: state.categoriesEntity.results!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          state.categoriesEntity.results![index].imageLink!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 180.74, viewportFraction: 1),
      itemCount: ImageAssets.imagesSlider.length,
      itemBuilder: (context, index, realIndex) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.transparent,
              ),
              child: Image.asset(
                ImageAssets.imagesSlider[index],
                fit: BoxFit.contain,
                height: 140.74,
              ),
            ),
            10.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ImageAssets.imagesSlider.map((url) {
                int i = ImageAssets.imagesSlider.indexOf(url);
                return Container(
                  width: 18.0,
                  height: 4.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: i == index ? AppColor.cyan : AppColor.grey,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
