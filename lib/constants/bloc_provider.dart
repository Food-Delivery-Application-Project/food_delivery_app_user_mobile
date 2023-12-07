import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/blocs/category/all_categories_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/blocs/image_picker/image_picker_bloc.dart';
import 'package:food_delivery_app/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
    BlocProvider<ImagePickerBloc>(create: (context) => ImagePickerBloc()),
    BlocProvider<WishlistBloc>(create: (context) => WishlistBloc()),
    BlocProvider<AllCategoriesBloc>(
      create: (context) => AllCategoriesBloc()..add(GetAllCategoriesEvent()),
    ),
    BlocProvider<FoodBloc>(
      create: (context) => FoodBloc()..add(RandomFoodEvent()),
    ),
    BlocProvider<CartBloc>(
      create: (context) => CartBloc()..add(CartGetInitialDataEvent()),
    ),
  ];
}
