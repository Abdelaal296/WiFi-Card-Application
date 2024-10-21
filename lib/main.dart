import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_card/constants.dart';
import 'package:wifi_card/core/utils/api_service.dart';
import 'package:wifi_card/core/utils/cache_helper.dart';
import 'package:wifi_card/core/widgets/bloc_observer.dart';
import 'package:wifi_card/features/layout/presentation/view_models/cubit/home_service_cubit.dart';
import 'package:wifi_card/features/layout/presentation/views/service_layout.dart';
import 'package:wifi_card/features/login/presentation/views/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  user_role = CacheHelper.getData(key: 'user_role');
  print(token);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeServiceCubit>(
            create: (context) => HomeServiceCubit()
              ..showUser()
              ..getBalance()
              ..getNotifications()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: KPrimaryColor1,
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
                centerTitle: true,
                backgroundColor: KPrimaryColor2,
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: Kprimaryfont))),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: (token != null && user_role != 'admin')
              ? ServiceLayout()
              : LoginScreen(),
        ),
      ),
    );
  }
}
//+20109650500999
