import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';
import 'package:krtobaa_task/src/core/utils/helper_extenstions.dart';
import 'package:krtobaa_task/src/core/widgets/text_widget.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/cart/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          centerTitle: true,
          title: const TextWidget(
            txt: AppStrings.cart,
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CartInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartLoaded) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8),
                                  child: TextWidget(
                                    txt:
                                        '(${state.cartItems.length.toString()}) عنصر',
                                    color: AppColor.cyan,
                                    fontSize: 14,
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeightManger.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8),
                                child: TextWidget(
                                  txt:
                                      ' الاجمالي ${state.prices.length.toString()} ج.م',
                                  color: AppColor.cyan,
                                  fontSize: 14,
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeightManger.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: state.cartItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8),
                              child: Container(
                                height: 165,
                                width: 330,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColor.white,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          state.images[index],
                                          height: 111,
                                          width: 123,
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
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextWidget(
                                                txt: state.cartItems[index],
                                                color: AppColor.textGrey,
                                                fontSize: 16,
                                                textAlign: TextAlign.start,
                                                fontWeight:
                                                    FontWeightManger.medium,
                                              ),
                                              50.ph,
                                              TextWidget(
                                                txt: state.prices[index] + ' ج.م',
                                                color: AppColor.cyan,
                                                fontSize: 14,
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeightManger.bold,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    BlocConsumer<CartCubit, CartState>(
                                      listener: (context, state) {},
                                      builder: (context, cartState) {
                                        if (cartState is CountChanged) {
                                          debugPrint(
                                              'counter is ${cartState.count}');
                                          return buildRowCounter(
                                              context,
                                              cartState.count,
                                              state.prices[index]);
                                        }
                                        return buildRowCounter(
                                            context, 1, state.prices[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8),
                                      child: TextWidget(
                                        txt: 'الإجمالي',
                                        color: AppColor.cyan,
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeightManger.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: TextWidget(
                                      txt:
                                          ' ${state.prices.length.toString()} ج.م',
                                      color: AppColor.textGrey,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeightManger.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8),
                                      child: TextWidget(
                                        txt: 'الضرائب',
                                        color: AppColor.cyan,
                                        fontSize: 14,
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeightManger.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8),
                                    child: TextWidget(
                                      txt: '5.00 ج.م',
                                      color: AppColor.textGrey,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeightManger.bold,
                                    ),
                                  ),
                                ],
                              ),
                              40.ph,
                              Center(
                                child: SizedBox(
                                  width: context.width * 0.9,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.cyan,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: const TextWidget(
                                      txt: 'إتمام الشراء',
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
                    );
                  } else if (state is CartError) {
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
                // BlocProvider.of<CartCubit>(context).increase();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.cyan,
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
                // BlocProvider.of<CartCubit>(context).decrease();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.cyan,
                ),
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.remove,
                  color: AppColor.white,
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  color: AppColor.white,
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
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColor.secondary,
                ),
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.delete,
                  color: AppColor.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
