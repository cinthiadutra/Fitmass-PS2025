
import 'package:fitmass_flutter_test/features/Home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;


void setupHomeInkection(){

getIt.registerFactory(()=> HomeCubit());
  
}