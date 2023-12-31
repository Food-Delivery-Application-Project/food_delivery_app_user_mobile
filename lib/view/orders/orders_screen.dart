import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/orders/orders_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/orders/orders_model.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/orders/order_foods_screen.dart';
import 'package:food_delivery_app/widgets/appbars/two_buttons_appbar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

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
    // refresh the orders after every 3 seconds
    // Timer.periodic(const Duration(seconds: 3), (timer) {
    //   ordersBloc.add(OrdersGetInitialDataEvent());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoButtonsAppbar(
        title: "Orders",
        icon: Icons.refresh,
        onPressed: () {
          ordersBloc.add(OrdersGetInitialDataEvent());
        },
      ),
      body: BlocConsumer<OrdersBloc, OrdersState>(
        bloc: ordersBloc,
        listener: (context, state) {
          if (state is OrdersGetInitialDataState) {
            orders = state.response.data;
          }
        },
        builder: (context, state) {
          // if (state is OrdersLoadingState) {
          //   return const Center(
          //     child: LoadingWidget(),
          //   );
          // } else if (state is OrdersErrorState) {
          //   return Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Image.asset(AppImages.four04),
          //           20.height,
          //           Text(
          //             state.message,
          //             style: boldTextStyle(),
          //           ),
          //           20.height,
          //           OutlinedButtonWidget(
          //             caption: "Reload Page",
          //             onPressed: () {
          //               ordersBloc.add(OrdersGetInitialDataEvent());
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          // }
          if (state is OrdersLoadingState) {
            return ListView.builder(
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                height: 60,
                alignment: Alignment.centerLeft,
                color: AppColors.lightGrey,
                child: const CircleAvatar(
                  backgroundColor: AppColors.grey,
                ),
              ),
              itemCount: 6,
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(
                  color: AppColors.dangerColor.withOpacity(0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: AppColors.dangerColor,
                      ),
                      10.width,
                      Text(
                        "Cancel Order",
                        style: boldTextStyle(color: AppColors.dangerColor),
                      ),
                      20.width,
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    orders.remove(orders[index]);
                  });
                },
                key: UniqueKey(),
                child: ListTile(
                  onTap: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: OrderFoodsScreen(
                        orderId: orders[index].orderId.toString(),
                      ),
                    );
                  },
                  tileColor: orders[index].status == "pending"
                      ? AppColors.grey
                      : AppColors.success.withOpacity(0.1),
                  leading: CircleAvatar(
                    radius: 30,
                    // last 4 digits order id
                    child: Text("${orders[index].orderId?.substring(0, 4)}"),
                  ),
                  title: Text(
                    "Total Price: ${orders[index].totalPrice}",
                    style: AppTextStyle.listTileTitle,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address: ${orders[index].address}"),
                      Text("Phone: ${orders[index].user?.phone}"),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("${orders[index].status}"),
                      Text(
                        timeago.format(
                          DateTime.parse(orders[index].createdAt.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
