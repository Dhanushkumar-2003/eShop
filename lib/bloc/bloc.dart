import 'package:eshop/bloc/blocstate.dart';
import 'package:eshop/bloc/blocevent.dart';
import 'package:eshop/constant/apiservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class productbloc extends Bloc<productevent, Productstate> {
  Apiservice apiservice = Apiservice();
  productbloc() : super(Productinital(message: 'hi')) {
    on<Productapi>((event, emit) async {
      emit(ProductLoading(error: ''));

      try {
        // Await these if needed
        final product = await apiservice.productApi();
        final cat = await apiservice.fetchCategories();

        final smart = await apiservice.smartphone();

        emit(Productloaded(smartphone: smart, category: product));
        //  emit(Categoryloaded(category: product));
      } catch (e) {
        emit(Producterror(error: e.toString()));
        emit(CategoryError(error: e.toString()));
      }
    });
  }
}
