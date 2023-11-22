import 'package:coin_track/features/authentication/presentation/pages/auth_check_wrapper.dart';
import 'package:coin_track/features/authentication/presentation/provider/auth_provider.dart';
import 'package:coin_track/features/authentication/presentation/provider/injection_container.dart';
import 'package:coin_track/features/expense_tracking/data/transaction_repository_imp.dart';
import 'package:coin_track/features/expense_tracking/domain/use_cases.dart';
import 'package:coin_track/features/expense_tracking/presentation/provider/transactions_provider.dart';
import 'package:coin_track/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeAuthDependencies();
  runApp(const CoinTrack());
}

class CoinTrack extends StatelessWidget {
  const CoinTrack({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(gt(), gt(), gt(), gt(), gt()),
        ),
        ChangeNotifierProxyProvider(
          create: (context) {
            final repository = TransactionRepositoryImp("");
            return TransactionProvider(
              GetTransactionsUseCase(repository),
              AddTransactionUseCase(repository),
              DeleteTransactionUseCase(repository),
              GetReportDataUseCase(repository),
              GetExpenseSummaryDataUseCase(repository),
              GetIncomeSummaryDataUseCase(repository),
              GetIncomeExpenseVariationDataUseCase(repository),
            );
          },
          update: (context, AuthProvider authProvider, transactionProvider) {
            final repository =
                TransactionRepositoryImp(authProvider.user?.userId ?? "");
            return TransactionProvider(
              GetTransactionsUseCase(repository),
              AddTransactionUseCase(repository),
              DeleteTransactionUseCase(repository),
              GetReportDataUseCase(repository),
              GetExpenseSummaryDataUseCase(repository),
              GetIncomeSummaryDataUseCase(repository),
              GetIncomeExpenseVariationDataUseCase(repository),
            );
          },
        )
      ],
      child: MaterialApp(
        title: "Coin Track",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
          useMaterial3: true,
        ),
        home: const AuthCheckWrapper(),
      ),
    );
  }
}
