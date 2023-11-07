import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krtobaa_task/src/core/utils/app_colors.dart';
import 'package:krtobaa_task/src/core/utils/app_strings.dart';
import 'package:krtobaa_task/src/core/utils/app_values.dart';
import 'package:krtobaa_task/src/core/widgets/text_widget.dart';
import 'package:krtobaa_task/src/modules/home/presentation/controller/categories_cubit/categories_cubit.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CategoriesCubit>(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.white,
          centerTitle: true,
          title: const TextWidget(
            txt: AppStrings.categories,
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
            child: BlocConsumer<CategoriesCubit, CategoriesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is CategoriesInitial) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is AllCategoriesLoaded) {
                  return ListView.builder(
                    itemCount: state.categoriesEntity.results!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 8),
                        child: Container(
                          height: 122,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColor.transparent,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  state.categoriesEntity.results![index]
                                      .imageLink!,
                                  height: 122,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
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
                              Center(
                                child: TextWidget(
                                  txt: state
                                      .categoriesEntity.results![index].name!,
                                  color: AppColor.white,
                                  fontSize: 24,
                                  fontWeight: FontWeightManger.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is CategoriesError) {
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
