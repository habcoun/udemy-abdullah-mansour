import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure/layout/shop_app/cubit/shop_cubit.dart';
import 'package:structure/models/shop-app/categories_model.dart';
import 'package:structure/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatIteam(
              ShopCubit.get(context).categorieModel!.data!.data![index]),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: ShopCubit.get(context).categorieModel!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCatIteam(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.imageCategorie}'),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${model.nameCategorie}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward,
            )
          ],
        ),
      );
}
