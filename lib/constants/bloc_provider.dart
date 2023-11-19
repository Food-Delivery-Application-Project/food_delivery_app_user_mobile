import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/blocs/category/all_categories_bloc.dart';
import 'package:food_delivery_app/blocs/image_picker/image_picker_bloc.dart';
import 'package:food_delivery_app/blocs/timer_cubit/timer_cubit_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
    BlocProvider<ImagePickerBloc>(create: (context) => ImagePickerBloc()),
    BlocProvider<AllCategoriesBloc>(
      create: (context) => AllCategoriesBloc()..add(GetAllCategoriesEvent()),
    ),
  ];
}
