// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart'
    as _i675;
import 'package:personal_portfolio/freamwork/controller/splash/splash_controller.dart'
    as _i1052;
import 'package:personal_portfolio/freamwork/dependency_injection/module/firebase_module.dart'
    as _i146;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i1052.SplashController>(() => _i1052.SplashController());
    gh.factory<_i974.FirebaseFirestore>(
      () => firebaseModule.getFirebaseFirestoreInstance(),
    );
    gh.factory<_i675.HomeController>(
      () => _i675.HomeController(gh<_i974.FirebaseFirestore>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i146.FirebaseModule {}
