import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/orders/orders_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';

class OrderFoodsScreen extends StatefulWidget {
  final String orderId;
  const OrderFoodsScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderFoodsScreen> createState() => _OrderFoodsScreenState();
}

class _OrderFoodsScreenState extends State<OrderFoodsScreen> {
  final List<CartFoodModel> foods = [];

  OrdersBloc ordersBloc = OrdersBloc();

  @override
  void initState() {
    ordersBloc.add(OrderFoodInitialEvent(orderId: widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Ordered Foods"),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        bloc: ordersBloc,
        listener: (context, state) {
          if (state is OrderFoodsInitialDataState) {
            foods.addAll(state.response.data);
          }
        },
        builder: (context, state) {
          if (state is OrderFoodsLoadingInitialState) {
            return const Center(child: LoadingWidget());
          } else if (state is OrdersErrorState) {
            return Container();
          }
          return Column(
            children: [
              ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: foods[index].foodId!.image.toString(),
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    foods[index].foodId!.foodName.toString(),
                    style: AppTextStyle.listTileTitle,
                  ),
                  subtitle: Text(
                    "Price: ${foods[index].foodId!.price}",
                    style: AppTextStyle.subHeading,
                  ),
                  trailing: Text("Quantity: ${foods[index].quantity}"),
                ),
                itemCount: foods.length,
                shrinkWrap: true,
              ),
            ],
          );
        },
      ),
    );
  }
}
