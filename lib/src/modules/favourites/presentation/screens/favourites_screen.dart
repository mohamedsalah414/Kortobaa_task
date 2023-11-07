import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/core/widgets/text_widget.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/favourites/favourites_cubit.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FavouritesCubit>(context).loadFavouritesIds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: const TextWidget(
          txt: AppStrings.favourites,
          fontSize: 20,
          color: AppColor.textGrey,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColor.black,
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocConsumer<FavouritesCubit, FavouritesState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FavouritesInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavouritesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavouritesLoaded) {
                return ListView.builder(
                  itemCount: state.favouritesIds.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 8),
                      child: Container(
                        height: 424,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppColor.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    state.images[index],
                                    height: 260,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const Center(
                                        child: Text('Error'),
                                      );
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                                BlocConsumer<FavouritesCubit, FavouritesState>(
                                  listener: (context, state) {},
                                  builder: (context, favouriteState) {
                                    if (favouriteState is FavouritesLoaded) {
                                      return IconButton(
                                          onPressed: () {
                                            if (favouriteState.favouritesIds
                                                .contains(state
                                                    .favouritesIds[index])) {
                                              BlocProvider.of<FavouritesCubit>(
                                                      context)
                                                  .deleteFavouritesIds(
                                                state.favouritesIds[index],
                                                state.images[index],
                                                state.names[index],
                                                state.prices[index],
                                              );
                                            } else {
                                              BlocProvider.of<FavouritesCubit>(
                                                      context)
                                                  .saveFavouritesIds(
                                                state.favouritesIds[index],
                                                state.images[index],
                                                state.names[index],
                                                state.prices[index],
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            favouriteState.favouritesIds
                                                    .contains(state
                                                        .favouritesIds
                                                        [index])
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: favouriteState.favouritesIds
                                                    .contains(state
                                                        .favouritesIds
                                                        [index])
                                                ? AppColor.secondary
                                                : AppColor.darkGrey,
                                          ));
                                    } else {
                                      return IconButton(
                                          color: AppColor.darkGrey,
                                          onPressed: () {
                                            BlocProvider.of<FavouritesCubit>(
                                                    context)
                                                .saveFavouritesIds(
                                              state.favouritesIds[index],
                                              state.images[index],
                                              state.names[index],
                                              state.prices[index],
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
                            20.ph,
                            Expanded(
                              child: TextWidget(
                                txt: state.favouritesIds[index],
                                color: AppColor.textGrey,
                                fontSize: 16,
                                textAlign: TextAlign.start,
                                fontWeight: FontWeightManger.medium,
                              ),
                            ),
                            TextWidget(
                              txt: state.prices[index] + ' ج.م',
                              color: AppColor.cyan,
                              fontSize: 14,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeightManger.bold,
                            ),
                            10.ph,
                            Container(
                              height: 40,
                              width: double.infinity,
                              color: AppColor.cyan,
                              child: Center(
                                child: TextWidget(
                                  txt: AppStrings.addToCart,
                                  color: AppColor.white,
                                  fontSize: 16,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeightManger.bold,
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (state is FavouritesError) {
                return const Center(
                  child: Text('Error'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
