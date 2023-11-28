import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/orders/orders_bloc.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/models/orders/orders_model.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrdersBloc ordersBloc = OrdersBloc();

  List<OrdersModel> orders = [];

  @override
  void initState() {
    ordersBloc.add(OrdersGetInitialDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Orders"),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        bloc: ordersBloc,
        listener: (context, state) {
          if (state is OrdersGetInitialDataState) {
            orders.addAll(state.response.data);
          }
        },
        builder: (context, state) {
          if (state is OrdersLoadingState) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is OrdersErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.four04),
                  20.height,
                  Text(
                    state.message,
                    style: boldTextStyle(),
                  ),
                  10.height,
                  ElevatedButton(
                    onPressed: () {
                      ordersBloc.add(OrdersGetInitialDataEvent());
                    },
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // give it a style
                  onTap: () {},
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.logoTrans),
                  ),
                  title: Text(orders[index].user!.fullname!),
                  subtitle: Text("Total Price: ${orders[index].totalPrice}"),
                  trailing: Text(orders[index].address.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
