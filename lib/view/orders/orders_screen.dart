import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/orders/orders_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/orders/orders_model.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/orders/order_foods_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/outlined_button.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
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
                  20.height,
                  OutlinedButtonWidget(
                    caption: "Reload Page",
                    onPressed: () {
                      ordersBloc.add(OrdersGetInitialDataEvent());
                    },
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.white,
                    ),
                  ),
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
                        : AppColors.lightGrey,
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(AppImages.logoTrans),
                    ),
                    title: Text(
                      orders[index].user!.fullname.toString(),
                      style: AppTextStyle.listTileTitle,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Price: ${orders[index].totalPrice}"),
                        Text("Address: ${orders[index].address}"),
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
          }
        },
      ),
    );
  }
}
