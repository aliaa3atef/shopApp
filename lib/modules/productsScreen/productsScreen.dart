import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/models/categoryModel/categoryModel.dart';
import 'package:shop_app/models/homeModel/homeModel.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>(
      builder: (context, state) {
        var cubit = ShopHomeCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) =>
              buildProducts(cubit.homeModel, cubit.categoryModel , context),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {
        if(state is ShopHomeChangeFavSuccessState)
          {
            if(!state.editFavourites.status)
              {
                showToast(state.editFavourites.message , Colors.red , context);
              }
            else showToast(state.editFavourites.message , Colors.green , context);
          }
      },
    );
  }

  Widget buildProducts(HomeModel model, CategoryModel catModel , context) =>
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage("${e.image}"),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                initialPage: 0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.ease,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCatItems(catModel.dataModel.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: catModel.dataModel.data.length,
                    ),
                  ),
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.75,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                children: List.generate(model.data.products.length,
                    (index) => buildGridItems(model.data.products[index] , context )),
              ),
            ),
          ],
        ),
      );

  Widget buildCatItems(Data data) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${data.image}'),
                width: 180,
                height: 100,
                fit: BoxFit.fill,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 180,
                child: Text(
                  '${data.name}'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildGridItems(Products products , BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage('${products.image}'),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              if (products.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(fontSize: 12),
                  ),
                  color: Colors.yellow,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  '${products.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${products.price.round()}EG',
                      style: TextStyle(fontSize: 14, color: colorApp),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    if (products.discount != 0)
                      Text(
                        '${products.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),

                    IconButton(
                      icon: ShopHomeCubit.get(context).fav[products.id] ? Icon(Icons.favorite , color: colorApp,) : Icon(Icons.favorite_border) ,

                      onPressed: () {
                        ShopHomeCubit.get(context).changeFav(prodID: products.id);
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
