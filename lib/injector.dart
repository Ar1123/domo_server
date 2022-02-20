import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/data/datasource/data_source_data.dart';
import 'src/data/repository/remote_city_repo_impl.dart';
import 'src/data/repository/repository_data.dart';
import 'src/domain/repository/repository_domain.dart';
import 'src/domain/usecase/service_use_case.dart';
import 'src/domain/usecase/use_case_domain.dart';
import 'src/presentation/blocs/blocs.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
/*
.......##.......##.########..##........#######...######...######.
......##.......##..##.....##.##.......##.....##.##....##.##....##
.....##.......##...##.....##.##.......##.....##.##.......##......
....##.......##....########..##.......##.....##.##........######.
...##.......##.....##.....##.##.......##.....##.##.............##
..##.......##......##.....##.##.......##.....##.##....##.##....##
.##.......##.......########..########..#######...######...######.
*/

  locator.registerFactory(() => AuthBloc(
        firebaseAuth: locator(),
        authUseCaseDomnain: locator(),
        uSerCaseDomain: locator(),
        sharedPrefencesUseCase: locator(),
        localCityUseCase: locator(),
        remoteCityUseCase: locator(),
      ));

  locator.registerFactory(
    () => UserBloc(
      categoryServiceUseCase: locator(),
      authUseCaseDomnain: locator(),
      uSerCaseDomain:locator(),
      getImageFromLocalUseCase: locator(),
      localCityUseCase: locator(),
    ),
  );
  locator.registerFactory(() => ServiceBloc(
    serviceUseCase: locator(),
    offerUseCase: locator(),
    userBloc: locator(),
    notificationUseCase: locator(),
  ));

/*
.......##.......##.##.....##..######..########..######.....###.....######..########
......##.......##..##.....##.##....##.##.......##....##...##.##...##....##.##......
.....##.......##...##.....##.##.......##.......##........##...##..##.......##......
....##.......##....##.....##..######..######...##.......##.....##..######..######..
...##.......##.....##.....##.......##.##.......##.......#########.......##.##......
..##.......##......##.....##.##....##.##.......##....##.##.....##.##....##.##......
.##.......##........#######...######..########..######..##.....##..######..########
*/

  locator.registerLazySingleton(
      () => AuthUseCaseDomnain(authRepositoryDomain: locator()));
  locator.registerLazySingleton(() =>
      SharedPrefencesUseCase(sharedPreferencesRepositoryDomain: locator()));
  locator.registerLazySingleton(() => LocalCityUseCase(locator()));
  locator.registerLazySingleton(() => RemoteCityUseCase(locator()));
  locator.registerLazySingleton(
      () => UserUSerCaseDomain(userRepositoryDomain: locator()));
  locator.registerLazySingleton(() => GetImageFromLocalUseCase(locator()));
  locator.registerLazySingleton(
      () => ServiceUseCase(serviceRepositoryDomanin: locator()));
  locator.registerLazySingleton(
      () => CategoryServiceUseCase(categoryServiceRepositoryDomain:  locator()));
  locator.registerLazySingleton(
      () => OfferUseCase(offerRepositoryDomain:  locator()));
  locator.registerLazySingleton(
      () => NotificationUseCase(locator()));

/*
.......##.......##.########..########.########...#######...######..####.########..#######..########..##....##
......##.......##..##.....##.##.......##.....##.##.....##.##....##..##.....##....##.....##.##.....##..##..##.
.....##.......##...##.....##.##.......##.....##.##.....##.##........##.....##....##.....##.##.....##...####..
....##.......##....########..######...########..##.....##..######...##.....##....##.....##.########.....##...
...##.......##.....##...##...##.......##........##.....##.......##..##.....##....##.....##.##...##......##...
..##.......##......##....##..##.......##........##.....##.##....##..##.....##....##.....##.##....##.....##...
.##.......##.......##.....##.########.##.........#######...######..####....##.....#######..##.....##....##...
*/
  locator.registerLazySingleton<AuthRepositoryDomain>(
      () => AuthRepositoryImpl(authRemoteDataSource: locator()));
  locator.registerLazySingleton<SharedPreferencesRepositoryDomain>(() =>
      SharedPreferencesRepositoryImpl(
          sharedPreferencesLocalDataSource: locator()));
  locator.registerLazySingleton<UserRepositoryDomain>(
      () => UserRepositoryImpl(userRemoteDataSource: locator()));
  locator.registerLazySingleton<RemoteCityRepoDomain>(
      () => RemoteCityRepositoryImpl(locator()));
  locator.registerLazySingleton<LocalCityRepositoryDomain>(
      () => CityRepositoryLocalImpl(locator()));
  locator.registerLazySingleton<GetImageFromLocalRepositoryDomain>(
      () => GetimageFromCameraRepoImpl(locator()));
  locator.registerLazySingleton<ServiceRepositoryDomanin>(
      () => ServiceRepositoryImpl(serviceRemoteDataSource: locator()));
  locator.registerLazySingleton<CategoryServiceRepositoryDomain>(
      () => CategoryServiceRepositoryImpl(categoryServiceRemoteDataSource:  locator()));
  locator.registerLazySingleton<OfferRepositoryDomain>(
      () => OfferRepositoryImpl(offerRemoteDataSource:  locator()));
  locator.registerLazySingleton<NotificationRepositoryDomain>(
      () => NotificationRepositoryImpl(locator()));

/*
.......##.......##.########.....###....########....###.....######...#######..##.....##.########...######..########......
......##.......##..##.....##...##.##......##......##.##...##....##.##.....##.##.....##.##.....##.##....##.##............
.....##.......##...##.....##..##...##.....##.....##...##..##.......##.....##.##.....##.##.....##.##.......##............
....##.......##....##.....##.##.....##....##....##.....##..######..##.....##.##.....##.########..##.......######........
...##.......##.....##.....##.#########....##....#########.......##.##.....##.##.....##.##...##...##.......##............
..##.......##......##.....##.##.....##....##....##.....##.##....##.##.....##.##.....##.##....##..##....##.##............
.##.......##.......########..##.....##....##....##.....##..######...#######...#######..##.....##..######..########......
*/

  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(auth: locator()));
  locator.registerLazySingleton<SharedPreferencesLocalDataSource>(
      () => SharedPreferencesLocalDataSourceImpl(sharedPreferences: locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  locator.registerLazySingleton<CityRemote>(() => CityRemoteImpl());
  locator.registerLazySingleton<CityLocalDataSource>(
      () => CityLocalDataSourceImpl());
  locator.registerLazySingleton<GetImageFromCameraLocal>(
      () => GetImageFromCameraLocalimpl());
  locator.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl());
  locator.registerLazySingleton<CategoryServiceRemoteDataSource>(
      () => CategoryServiceRemoteDataSourceImpl());
  locator.registerLazySingleton<OfferRemoteDataSource>(
      () => OfferRemoteDataSourceImpl());
  locator.registerLazySingleton<NotificationRemoteDataSource>(
      () => NotificationRemoteDataSourceImpl(locator()));

  /*
  .......##.......##.########.##.....##.########.########.########..##....##..#######.
  ......##.......##..##........##...##.....##....##.......##.....##.###...##.##.....##
  .....##.......##...##.........##.##......##....##.......##.....##.####..##.##.....##
  ....##.......##....######......###.......##....######...########..##.##.##.##.....##
  ...##.......##.....##.........##.##......##....##.......##...##...##..####.##.....##
  ..##.......##......##........##...##.....##....##.......##....##..##...###.##.....##
  .##.......##.......########.##.....##....##....########.##.....##.##....##..#######.
  */
  final sharedPreferences = await SharedPreferences.getInstance();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => _messaging);
}
