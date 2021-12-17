import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/models/getFavourites/getFavModel.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit, ShopHomeStates>
      (builder:(context , state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! ShopHomeGetFavLoadingState,
            builder: (context)=>ListView.separated(
            itemBuilder: (context , index)=> favItem(ShopHomeCubit.get(context).
            favouritesModel.data.data[index] , context),
            separatorBuilder: (context , index)=>Divider(),
            itemCount: ShopHomeCubit.get(context).favouritesModel.data.data.length,
          ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          )
        );
    },
      listener:(context , state){},
    );
  }

  Widget favItem(FavData data , context){
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage('${data.products.image}'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
                if (data.products.discount != 0)
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
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.products.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text(
                      '${data.products.price.round()}EG',
                      style: TextStyle(fontSize: 14, color: colorApp),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (data.products.discount != 0)
                      Text(
                        '${data.products.oldPrice.round()}',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),

                    IconButton(
                      icon: ShopHomeCubit.get(context).fav[data.products.id] ? Icon(Icons.favorite , color: colorApp,) : Icon(Icons.favorite_border) ,

                      onPressed: () {
                        ShopHomeCubit.get(context).changeFav(prodID: data.products.id);
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