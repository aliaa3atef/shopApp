import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/cubit.dart';
import 'package:shop_app/layout/shopAppHome/shopCubit/states.dart';
import 'package:shop_app/models/categoryModel/categoryModel.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopHomeCubit,ShopHomeStates>(
        builder: (context,state){
          return ConditionalBuilder(
            condition: ShopHomeCubit.get(context).categoryModel != null,
            builder: (context) =>  Container(
              width: double.infinity,
              child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        buildCatItems(ShopHomeCubit.get(context).categoryModel.dataModel.data[index]),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                    itemCount: ShopHomeCubit.get(context).categoryModel.dataModel.data.length,
                  ),
            ),
            fallback:(context)=> Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context,state){}
        );
  }
  Widget buildCatItems(Data data) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Image(
                image: NetworkImage('${data.image}'),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),

              SizedBox(width: 20,),

              Text(
                  '${data.name}'.toUpperCase(),
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              Spacer(),
              IconButton(icon: Icon(Icons.arrow_forward_ios , color: colorApp,), onPressed: (){}),
            ],
          ),
        ),
    );
  }
}