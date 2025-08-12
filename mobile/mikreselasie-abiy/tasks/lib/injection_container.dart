import 'package:ecommerce/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce/features/auth/data/data_sources/auth_local_data_source_impl.dart';
import 'package:ecommerce/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_out.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerce/features/chat/data/data_sources/chat_local_data_source.dart';
import 'package:ecommerce/features/chat/data/data_sources/chat_local_data_source_impl.dart';
import 'package:ecommerce/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:ecommerce/features/chat/data/data_sources/chat_remote_data_source_impl.dart';
import 'package:ecommerce/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:ecommerce/features/chat/domain/repositories/chat_repository.dart';
import 'package:ecommerce/features/chat/domain/usecases/get_chat_messages.dart';
import 'package:ecommerce/features/chat/domain/usecases/get_my_chats.dart';
import 'package:ecommerce/features/chat/domain/usecases/initiate_chat.dart';
import 'package:ecommerce/features/chat/domain/usecases/send_message.dart';
import 'package:ecommerce/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:ecommerce/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:ecommerce/features/product/data/data_sources/product_remote_data_source_impl.dart';
import 'package:ecommerce/features/product/data/data_sources/products_local_data_source.dart';
import 'package:ecommerce/features/product/data/data_sources/products_local_data_source_impl.dart';
import 'package:ecommerce/features/product/data/data_sources/products_remote_data_source.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/http.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_current_user.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/get_all_products.dart';
import 'features/product/domain/usecases/get_product.dart';
import 'features/product/domain/usecases/update_product.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features
  //! Feature_#1 (Product) -----------------------------------------------------

  // Bloc
  serviceLocator.registerFactory(
    () => ProductBloc(
      createProduct: serviceLocator(),
      updateProduct: serviceLocator(),
      getAllProducts: serviceLocator(),
      deleteProduct: serviceLocator(),
      getSingleProduct: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => CreateProduct(serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateProduct(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteProduct(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetAllProducts(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => GetProduct(repository: serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
    ),
  );

  // Data
  serviceLocator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: serviceLocator()),
  );

  //! Features
  //! Feature_#2 (Auth) -----------------------------------------------------

  // Bloc
  serviceLocator.registerFactory(
    () => AuthBloc(
      loginUsecase: serviceLocator(),
      registerUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
      getMeUsecase: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => LogIn(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SignUp(serviceLocator()));
  serviceLocator.registerLazySingleton(() => Logout(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCurrentUser(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      client: serviceLocator(),
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Data
  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: serviceLocator()),
  );

  //! Feature_#3 (Chat) --------------------------------------------------------
  // Bloc
  serviceLocator.registerFactory(
    () =>
        ChatsBloc(getMyChats: serviceLocator(), initiateChat: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => MessageBloc(
      getChatMessages: serviceLocator(),
      sendMessage: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetMyChats(serviceLocator()));
  serviceLocator.registerLazySingleton(() => InitiateChat(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetChatMessages(serviceLocator()));
  serviceLocator.registerLazySingleton(() => SendMessage(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
    ),
  );

  // Data
  serviceLocator.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(client: serviceLocator()),
  );

  //! Core ---------------------------------------------------------------------
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectionChecker: serviceLocator()),
  );

  //! External -----------------------------------------------------------------
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(
    () => HttpClient(
      multipartRequestFactory: multipartRequestFactory,
      client: serviceLocator(),
    ),
  );
}
