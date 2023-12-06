// ignore_for_file: use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/blocs/orders/orders_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_toast.dart';
import 'package:food_delivery_app/view/foods/food_details_screen.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Pagination
  int page = 1;
  int paginatedBy = 10;

  // Lists
  List<CartFoodModel> foodList = [];
  List foodQuantity = [];

  double total = 0.0;

  String? userId;
  int currentIndex = 0;

  @override
  void initState() {
    initBloc();
    super.initState();
  }

  initBloc() {
    context.read<CartBloc>().add(CartGetInitialDataEvent());
  }

  initGetMoreDataBloc() {}

  void _incrementQuantity(int index) {
    currentIndex = index;
    context.read<CartBloc>().add(
          CartIncrementQtyEvent(
            foodId: foodList[index].foodId!.sId.toString(),
          ),
        );
    setState(() {
      foodQuantity[index]['quantity']++;
      incrementTotal(index);
    });
  }

  void _decrementQuantity(int index) {
    if (foodQuantity[index]['quantity'] > 1) {
      currentIndex = index;
      context.read<CartBloc>().add(
            CartDecrementQtyEvent(
              foodId: foodList[index].foodId!.sId.toString(),
            ),
          );
      setState(() {
        foodQuantity[index]['quantity']--;
        decrementTotal(index);
      });
    }
  }

  void calculateTotalPrice() {
    // Calculate total price from food quantity and food list
    if (foodList.isEmpty) {
      return;
    }
    for (int i = 0; i < foodQuantity.length; i++) {
      total +=
          foodList[i].foodId!.price!.toDouble() * foodQuantity[i]['quantity'];
    }
  }

  // increment price by food price of single food
  void incrementTotal(int index) {
    setState(() {
      total += foodList[index].foodId!.price!.toDouble();
    });
  }

  // decrement single quantity price from total
  void decrementTotal(int index) {
    setState(() {
      total -= foodList[index].foodId!.price!.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartGetInitialDataState) {
          // set quantity to 1 for all the available items
          foodList.addAll(state.response.data);
          for (var item in state.response.data) {
            foodQuantity.add({
              'id': item.foodId!.sId.toString(),
              'quantity': item.quantity,
            });
          }
          // calculate total price
          calculateTotalPrice();
        } else if (state is CartUpdateQtyLoadingState) {
          // update quantity
        } else if (state is CartIncrementQtyErrorState) {
          foodQuantity[currentIndex]['quantity']--;
        } else if (state is CartDecrementQtyErrorState) {
          foodQuantity[currentIndex]['quantity']++;
        } else if (state is CartIncrementQtyState) {
          // update quantity
          print('value incremented');
        } else if (state is CartDecrementQtyState) {
          // update quantity
          print('value decremented');
        }
      },
      builder: (context, state) {
        if (state is CartInitialLoadingState) {
          return const Center(
            child: LoadingWidget(),
          );
        } else if (state is CartErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.message),
                // Reload Button
                20.height,
                ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(CartGetInitialDataEvent());
                  },
                  child: const Text('Reload'),
                ),
              ],
            ),
          );
        } else if (state is CartEmptyState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.emptyCart),
                20.height,
                Text(
                  'Your cart is empty',
                  style: AppTextStyle.headings,
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  TotolAmountWidget(
                    totalPrice: total,
                    discount: 0,
                    deliveryFee: 0,
                  ).visible(foodList.isNotEmpty && foodQuantity.isNotEmpty),
                  20.height,
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(
                            foodList[index].foodId!.foodName.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Quantity: ${foodQuantity[index]['quantity']}'),
                              Text(
                                'Price: ${foodList[index].foodId!.price}',
                              ),
                            ],
                          ),
                          leading: GestureDetector(
                            onTap: () {
                              AppNavigator.goToPage(
                                context: context,
                                screen: FoodDetailsScreen(
                                  food: foodList[index].foodId as FoodModel,
                                ),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl:
                                  foodList[index].foodId!.image.toString(),
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) =>
                                  Image.asset(AppImages.logoTrans),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppColors.red,
                                ),
                                onPressed: () => _decrementQuantity(index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColors.success,
                                ),
                                onPressed: () => _incrementQuantity(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: foodList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class TotolAmountWidget extends StatefulWidget {
  const TotolAmountWidget({
    super.key,
    required this.totalPrice,
    required this.discount,
    required this.deliveryFee,
  });

  final double totalPrice;
  final double discount;
  final double deliveryFee;

  @override
  State<TotolAmountWidget> createState() => _TotolAmountWidgetState();
}

class _TotolAmountWidgetState extends State<TotolAmountWidget> {
  final TextEditingController addressController = TextEditingController();

  // Blocs
  OrdersBloc ordersBloc = OrdersBloc();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrdersBloc, OrdersState>(
      bloc: ordersBloc,
      listener: (context, state) {
        if (state is OrdersLoadingState) {
          Navigator.pop(context);
          AppDialogs.loadingDialog(context);
        } else if (state is OrdersPlaceState) {
          AppDialogs.closeDialog(context);
          context.read<CartBloc>().add(CartGetInitialDataEvent());
          AppToast.success(state.response.message);
        } else if (state is OrdersErrorState) {
          AppDialogs.closeDialog(context);
          AppToast.danger(state.message);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.discount.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery fee',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  widget.deliveryFee.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'PKR: ${widget.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PrimaryButtonWidget(
              onPressed: () {
                // Show bottom sheet with one text field for address
                showBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: context.height() * 0.7,
                      decoration: const BoxDecoration(
                        color: AppColors.darkBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Enter your address',
                            style: AppTextStyle.headings.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFieldWidget(
                            labelText: "",
                            controller: addressController,
                            hintText: "Enter your address",
                          ),
                          const SizedBox(height: 16),
                          PrimaryButtonWidget(
                            onPressed: () {
                              // Place order
                              ordersBloc.add(
                                OrderPlaceEvent(
                                  address: addressController.text,
                                  totalPrice: widget.totalPrice,
                                ),
                              );
                            },
                            caption: "Place order",
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              caption: "Proceed to payment",
              backgroundColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
