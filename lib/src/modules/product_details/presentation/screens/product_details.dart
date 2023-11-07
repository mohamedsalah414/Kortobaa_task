import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/core/widgets/text_widget.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/products_cubit/products_cubit.dart';

class ProductDetails extends StatefulWidget {
  final String id;

  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context)
        .getProductsById(int.parse(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
        ),
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductsInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsIdLoaded) {
              return Center(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.network(
                            state.result.imageLink!,
                            height: 340,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                  onPressed: () {},
                                  label: const TextWidget(
                                    txt: 'اضف للمفضله',
                                    color: AppColor.secondary,
                                    fontSize: 14,
                                    fontWeight: FontWeightManger.bold,
                                  ),
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: AppColor.secondary,
                                  )),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColor.darkGrey,
                              ),
                              TextButton.icon(
                                  onPressed: () {},
                                  label: const TextWidget(
                                    txt: 'مشاركة المنتج',
                                    color: AppColor.darkGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeightManger.bold,
                                  ),
                                  icon: const Icon(
                                    Icons.share,
                                    color: AppColor.darkGrey,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    20.ph,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            txt: state.result.name!,
                            color: AppColor.textGrey,
                            fontSize: 16,
                            fontWeight: FontWeightManger.medium,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                txt: '${state.result.price!} جنيه',
                                color: AppColor.cyan,
                                textAlign: TextAlign.start,
                                fontSize: 18,
                                fontWeight: FontWeightManger.medium,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextWidget(
                                    txt: state.result.rate!,
                                    color: AppColor.textGrey,
                                    textAlign: TextAlign.start,
                                    fontSize: 18,
                                    fontWeight: FontWeightManger.medium,
                                  ),
                                  2.pw,
                                  const Icon(
                                    Icons.star,
                                    color: AppColor.yellowStar,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          ExpansionTile(
                            title: const TextWidget(
                              txt: 'الوصف',
                              color: AppColor.textGrey,
                              fontSize: 16,
                              fontWeight: FontWeightManger.medium,
                            ),
                            children: [
                              TextWidget(
                                txt: state.result.description!,
                                color: AppColor.textGrey,
                                fontSize: 16,
                                fontWeight: FontWeightManger.medium,
                              ),
                            ],
                          ),
                          const Divider(),
                          BlocConsumer<CartCubit, CartState>(
                            listener: (context, state) {},
                            builder: (context, cartState) {
                              if (cartState is CountChanged) {
                                debugPrint('counter is ${cartState.count}');
                                return buildRowCounter(context, cartState.count,
                                    state.result.price!);
                              }
                              return buildRowCounter(
                                  context, 1, state.result.price!);
                            },
                          ),
                          40.ph,
                          Center(
                            child: SizedBox(
                              width: 180,
                              height: 60,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  BlocProvider.of<CartCubit>(context)
                                      .saveCartItem(state.result.name!,
                                          state.result.imageLink!, state.result.price!);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.cyan,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColor.white,
                                ),
                                label: const TextWidget(
                                  txt: 'اضف للسله',
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeightManger.medium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Row buildRowCounter(BuildContext context, count, price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                debugPrint('counter is ${count}');
                BlocProvider.of<CartCubit>(context).increase();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.cyan,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                ),
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.add,
                  color: AppColor.white,
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  color: AppColor.white,
                ),
                height: 45,
                width: 69,
                child: Center(
                  child: TextWidget(
                    txt: count.toString(),
                    color: AppColor.textGrey,
                    fontSize: 16,
                    fontWeight: FontWeightManger.medium,
                  ),
                )),
            GestureDetector(
              onTap: () {
                debugPrint('counter is ${count.toString()}');
                BlocProvider.of<CartCubit>(context).decrease();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.cyan,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                ),
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.remove,
                  color: AppColor.white,
                ),
              ),
            ),
            30.pw,
            Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 45,
                width: 160,
                child: Center(
                  child: TextWidget(
                    txt: '${double.parse(price) * count} جنيه',
                    color: AppColor.cyan,
                    fontSize: 16,
                    fontWeight: FontWeightManger.medium,
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
