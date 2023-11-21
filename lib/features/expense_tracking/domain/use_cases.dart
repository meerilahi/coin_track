import 'dart:async';
import 'package:coin_track/core/constants.dart';
import 'package:coin_track/core/utils.dart';
import 'package:coin_track/features/expense_tracking/domain/variation_data_entity.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository _repository;
  GetTransactionsUseCase(this._repository);
  Stream<List<TransactionEntity>> call() => _repository.getTransactions.map(
        (list) => list
          ..sort((TransactionEntity a, TransactionEntity b) =>
              b.time.compareTo(a.time)),
      );
}

class AddTransactionUseCase {
  final TransactionRepository _repository;
  AddTransactionUseCase(this._repository);
  Future<void> call(TransactionEntity transactionEntity) =>
      _repository.addTransaction(transactionEntity);
}

class DeleteTransactionUseCase {
  final TransactionRepository _repository;
  DeleteTransactionUseCase(this._repository);
  Future<void> call(TransactionEntity transactionEntity) =>
      _repository.deleteTransaction(transactionEntity);
}

class GetReportDataUseCase {
  final TransactionRepository _repository;
  final weeklyStreamController = StreamController<Map<String, int>>();
  final monthlyStreamController = StreamController<Map<String, int>>();
  final allTimesStreamController = StreamController<Map<String, int>>();

  GetReportDataUseCase(this._repository);

  Stream<Map<String, int>> weekly() {
    _repository.getTransactions.listen((transactionsList) {
      final currentDate = DateTime.now();
      transactionsList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 7);
      int totalTransactions = transactionsList.length;
      int totalExpenses = 0;
      int totalIncome = 0;
      for (int i = 0; i < transactionsList.length; i++) {
        if (transactionsList[i].type == expense) {
          totalExpenses += transactionsList[i].amount;
        }
        if (transactionsList[i].type == income) {
          totalIncome += transactionsList[i].amount;
        }
      }
      weeklyStreamController.add({
        balance: totalIncome - totalExpenses,
        transactionsNo: totalTransactions,
        expense: totalExpenses,
        income: totalIncome,
      });
    });

    return weeklyStreamController.stream;
  }

  Stream<Map<String, int>> monthly() {
    _repository.getTransactions.listen((transactionsList) {
      final currentDate = DateTime.now();
      transactionsList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 31);
      int totalTransactions = transactionsList.length;
      int totalExpenses = 0;
      int totalIncome = 0;
      for (int i = 0; i < transactionsList.length; i++) {
        if (transactionsList[i].type == expense) {
          totalExpenses += transactionsList[i].amount;
        }
        if (transactionsList[i].type == income) {
          totalIncome += transactionsList[i].amount;
        }
      }
      monthlyStreamController.add({
        balance: totalIncome - totalExpenses,
        transactionsNo: totalTransactions,
        expense: totalExpenses,
        income: totalIncome,
      });
    });

    return monthlyStreamController.stream;
  }

  Stream<Map<String, int>> allTimes() {
    _repository.getTransactions.listen((transactionsList) {
      int totalTransactions = transactionsList.length;
      int totalExpenses = 0;
      int totalIncome = 0;
      for (int i = 0; i < transactionsList.length; i++) {
        if (transactionsList[i].type == expense) {
          totalExpenses += transactionsList[i].amount;
        }
        if (transactionsList[i].type == income) {
          totalIncome += transactionsList[i].amount;
        }
      }
      allTimesStreamController.add({
        balance: totalIncome - totalExpenses,
        transactionsNo: totalTransactions,
        expense: totalExpenses,
        income: totalIncome,
      });
    });

    return allTimesStreamController.stream;
  }
}

class GetExpenseSummaryDataUseCase {
  final TransactionRepository _repository;
  final weeklyStreamController = StreamController<Map<String, double>>();
  final monthlyStreamController = StreamController<Map<String, double>>();
  final allTimesStreamController = StreamController<Map<String, double>>();
  GetExpenseSummaryDataUseCase(this._repository);

  Stream<Map<String, double>> weekly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 7 &&
          transaction.type == expense);
      Map<String, double> expenseSummaryData = {
        food: 0,
        transportation: 0,
        insurance: 0,
        savings: 0,
        debtPayments: 0,
        utilities: 0,
        health: 0,
        entertainment: 0,
        education: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        expenseSummaryData[transactionList[i].category] =
            expenseSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      expenseSummaryData.removeWhere((key, value) => value == 0);
      weeklyStreamController.add(expenseSummaryData);
    });
    return weeklyStreamController.stream;
  }

  Stream<Map<String, double>> monthly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 30 &&
          transaction.type == expense);
      Map<String, double> expenseSummaryData = {
        food: 0,
        transportation: 0,
        insurance: 0,
        savings: 0,
        debtPayments: 0,
        utilities: 0,
        health: 0,
        entertainment: 0,
        education: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        expenseSummaryData[transactionList[i].category] =
            expenseSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      expenseSummaryData.removeWhere((key, value) => value == 0);
      monthlyStreamController.add(expenseSummaryData);
    });
    return monthlyStreamController.stream;
  }

  Stream<Map<String, double>> allTimes() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 365 &&
          transaction.type == expense);
      Map<String, double> expenseSummaryData = {
        food: 0,
        transportation: 0,
        insurance: 0,
        savings: 0,
        debtPayments: 0,
        utilities: 0,
        health: 0,
        entertainment: 0,
        education: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        expenseSummaryData[transactionList[i].category] =
            expenseSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      expenseSummaryData.removeWhere((key, value) => value == 0);
      allTimesStreamController.add(expenseSummaryData);
    });
    return allTimesStreamController.stream;
  }
}

class GetIncomeSummaryDataUseCase {
  final TransactionRepository _repository;
  final weeklyStreamController = StreamController<Map<String, double>>();
  final monthlyStreamController = StreamController<Map<String, double>>();
  final allTimesStreamController = StreamController<Map<String, double>>();
  GetIncomeSummaryDataUseCase(this._repository);

  Stream<Map<String, double>> weekly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 7 &&
          transaction.type == income);
      Map<String, double> incomeSummaryData = {
        job: 0,
        selfEmployment: 0,
        invenstment: 0,
        retirement: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        incomeSummaryData[transactionList[i].category] =
            incomeSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      incomeSummaryData.removeWhere((key, value) => value == 0);
      weeklyStreamController.add(incomeSummaryData);
    });
    return weeklyStreamController.stream;
  }

  Stream<Map<String, double>> monthly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 30 &&
          transaction.type == income);
      Map<String, double> incomeSummaryData = {
        job: 0,
        selfEmployment: 0,
        invenstment: 0,
        retirement: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        incomeSummaryData[transactionList[i].category] =
            incomeSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      incomeSummaryData.removeWhere((key, value) => value == 0);
      monthlyStreamController.add(incomeSummaryData);
    });
    return monthlyStreamController.stream;
  }

  Stream<Map<String, double>> allTimes() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 365 &&
          transaction.type == income);
      Map<String, double> incomeSummaryData = {
        job: 0,
        selfEmployment: 0,
        invenstment: 0,
        retirement: 0,
        gifts: 0,
        miscellaneous: 0,
      };
      for (var i = 0; i < transactionList.length; i++) {
        incomeSummaryData[transactionList[i].category] =
            incomeSummaryData[transactionList[i].category]! +
                transactionList[i].amount;
      }
      incomeSummaryData.removeWhere((key, value) => value == 0);
      allTimesStreamController.add(incomeSummaryData);
    });
    return allTimesStreamController.stream;
  }
}

class GetIncomeExpenseVariationDataUseCase {
  final TransactionRepository _repository;
  final weeklyStreamController = StreamController<List<VariationData>>();
  final monthlyStreamController = StreamController<List<VariationData>>();
  final allTimesStreamController = StreamController<List<VariationData>>();
  GetIncomeExpenseVariationDataUseCase(this._repository);

  Stream<List<VariationData>> weekly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 7);

      final Map<int, List<int>> variationDataMap = Map.fromIterable(
        List.generate(7, (index) => index + 1),
        key: (element) => element,
        value: (element) => [0, 0],
      );
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].type == expense) {
          variationDataMap[transactionList[i].time.weekday]![0] +=
              transactionList[i].amount;
        } else {
          variationDataMap[transactionList[i].time.weekday]![1] +=
              transactionList[i].amount;
        }
      }
      final weekDays = getWeekDays().reversed.toList();
      final List<VariationData> weeklyVariationData = [];
      for (var i = 0; i < weekDays.length; i++) {
        if (variationDataMap[weekDays[i]] != null) {
          weeklyVariationData.add(
            VariationData(
              expense: variationDataMap[weekDays[i]]![0],
              income: variationDataMap[weekDays[i]]![1],
            ),
          );
        }
      }
      weeklyStreamController.add(weeklyVariationData);
    });

    return weeklyStreamController.stream;
  }

  Stream<List<VariationData>> monthly() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 31);
      final Map<int, List<int>> variationDataMap = Map.fromIterable(
        List.generate(31, (index) => index + 1),
        key: (element) => element,
        value: (element) => [0, 0],
      );
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].type == expense) {
          variationDataMap[transactionList[i].time.day]![0] +=
              transactionList[i].amount;
        } else {
          variationDataMap[transactionList[i].time.day]![1] +=
              transactionList[i].amount;
        }
      }
      final monthDays = getMonthDays();
      final List<VariationData> monthlyVariationData = [];
      for (var i = 0; i < monthDays.length; i++) {
        if (variationDataMap[monthDays[i]] != null) {
          monthlyVariationData.add(
            VariationData(
              expense: variationDataMap[monthDays[i]]![0],
              income: variationDataMap[monthDays[i]]![1],
            ),
          );
        }
      }
      monthlyStreamController.add(monthlyVariationData);
    });

    return monthlyStreamController.stream;
  }

  Stream<List<VariationData>> allTimes() {
    _repository.getTransactions.listen((transactionList) {
      final currentDate = DateTime.now();
      transactionList.retainWhere((transaction) =>
          currentDate.difference(transaction.time).inDays <= 365);
      final Map<int, List<int>> variationDataMap = Map.fromIterable(
        List.generate(12, (index) => index + 1),
        key: (element) => element,
        value: (element) => [0, 0],
      );
      for (var i = 0; i < transactionList.length; i++) {
        if (transactionList[i].type == expense) {
          variationDataMap[transactionList[i].time.month]![0] +=
              transactionList[i].amount;
        } else {
          variationDataMap[transactionList[i].time.month]![1] +=
              transactionList[i].amount;
        }
      }
      final yearMonths = getYearMonths();
      final List<VariationData> yearlyVariationData = [];
      for (var i = 0; i < yearMonths.length; i++) {
        if (variationDataMap[yearMonths[i]] != null) {
          yearlyVariationData.add(
            VariationData(
              expense: variationDataMap[yearMonths[i]]![0],
              income: variationDataMap[yearMonths[i]]![1],
            ),
          );
        }
      }
      allTimesStreamController.add(yearlyVariationData);
    });

    return allTimesStreamController.stream;
  }
}
