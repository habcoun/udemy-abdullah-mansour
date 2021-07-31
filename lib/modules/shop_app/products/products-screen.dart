import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:structure/layout/shop_app/cubit/shop_cubit.dart';
import 'package:structure/models/shop-app/home-model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
              (ShopCubit.get(context).homeModel != null),
          widgetBuilder: (BuildContext context) =>
              productsBuilder(ShopCubit.get(context).homeModel),
          fallbackBuilder: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel? model) => Column(
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 250,
              initialPage: 0,
              reverse: false,
              enableInfiniteScroll: false,
              autoPlay: true,
              autoPlayInterval: Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: Duration(
                seconds: 1,
              ),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );
}
