import 'package:eshop/apiModel/apimodel.dart';
import 'package:eshop/constant/apiservice.dart';

abstract class Productstate {}

class Productinital extends Productstate {
  final String message;
  Productinital({required this.message});
}

class Producterror extends Productstate {
  final String error;
  Producterror({required this.error});
}

class ProductLoading extends Productstate {
  final String error;
  ProductLoading({required this.error});
}

class Productloaded extends Productstate {
  final List<Products> category;

  final List<Products> smartphone;
  Productloaded({required this.smartphone, required this.category});
}

class Categoryloaded extends Productstate {
  final List<Products> category;
  Categoryloaded({required this.category});
}

class CategoryError extends Productstate {
  final String error;
  CategoryError({required this.error});
}
