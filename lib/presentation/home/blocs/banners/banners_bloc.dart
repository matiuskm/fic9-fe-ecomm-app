import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/banner_remote_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/banner_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banners_event.dart';
part 'banners_state.dart';
part 'banners_bloc.freezed.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc() : super(const _Initial()) {
    on<_GetAllBanners>((event, emit) async {
      emit(const _Loading());
      final response = await BannerRemoteDatasource().getAllBanners();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
