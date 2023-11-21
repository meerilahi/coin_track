import 'dart:async';
import 'package:coin_track/features/expense_tracking/domain/table_transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/domain/variation_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:coin_track/core/constants.dart';
import 'package:coin_track/features/expense_tracking/domain/transaction_entity.dart';
import 'package:coin_track/features/expense_tracking/domain/use_cases.dart';

class TransactionProvider extends ChangeNotifier {
  final GetTransactionsUseCase _getTransactionsUseCase;
  final AddTransactionUseCase _addTransactionUseCase;
  final DeleteTransactionUseCase _deleteTransactionUseCase;
  final GetReportDataUseCase _getReportDataUseCase;
  final GetExpenseSummaryDataUseCase _expenseSummaryData;
  final GetIncomeSummaryDataUseCase _getIncomeSummaryDataUseCase;
  final GetIncomeExpenseVariationDataUseCase
      _getIncomeExpenseVariationDataUseCase;
  TransactionProvider(
    this._getTransactionsUseCase,
    this._addTransactionUseCase,
    this._deleteTransactionUseCase,
    this._getReportDataUseCase,
    this._expenseSummaryData,
    this._getIncomeSummaryDataUseCase,
    this._getIncomeExpenseVariationDataUseCase,
  );

  List<TransactionEntity> getTransactions = [];
  List<TableTransactionEntity> getTableTransactions = [];
  String _filter = allTimes;
  Map<String, int> _weeklyReportWidgetData = {};
  Map<String, int> _monthlyReportWidgetData = {};
  Map<String, int> _allTimesReportWidgetData = {};
  Map<String, double> _weeklyExpenseSummaryChartData = {};
  Map<String, double> _monthlyExpenseSummaryChartData = {};
  Map<String, double> _allTimesExpenseSummaryChartData = {};
  Map<String, double> _weeklyIncomeSummaryChartData = {};
  Map<String, double> _monthlyIncomeSummaryChartData = {};
  Map<String, double> _allTimesIncomeSummaryChartData = {};
  List<VariationData> _weeklyIncomeExpenseVariationChartData = [];
  List<VariationData> _monthlyIncomeExpenseVariationChartData = [];
  List<VariationData> _allTimesIncomeExpenseVariationChartData = [];

  String get filter => _filter;

  set filter(newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  Map<String, int> get reportWidgetData {
    if (filter == lastWeek) {
      return _weeklyReportWidgetData;
    } else if (filter == lastMonth) {
      return _monthlyReportWidgetData;
    } else {
      return _allTimesReportWidgetData;
    }
  }

  Map<String, double> get expenseSummaryChartData {
    if (filter == lastWeek) {
      return _weeklyExpenseSummaryChartData;
    } else if (filter == lastMonth) {
      return _monthlyExpenseSummaryChartData;
    } else {
      return _allTimesExpenseSummaryChartData;
    }
  }

  Map<String, double> get incomeSummaryChartData {
    if (filter == lastWeek) {
      return _weeklyIncomeSummaryChartData;
    } else if (filter == lastMonth) {
      return _monthlyIncomeSummaryChartData;
    } else {
      return _allTimesIncomeSummaryChartData;
    }
  }

  List<VariationData> get incomeExpenseVariationChartData {
    if (filter == lastWeek) {
      return _weeklyIncomeExpenseVariationChartData;
    } else if (filter == lastMonth) {
      return _monthlyIncomeExpenseVariationChartData;
    } else {
      return _allTimesIncomeExpenseVariationChartData;
    }
  }

  void setupStreams() {

    _getTransactionsUseCase().listen(
      (newTransactions) {
        getTransactions = newTransactions;
        newTransactions
            .map(
              (tableTransaction) =>
                  TableTransactionEntity.fromTransactionEntity(
                      tableTransaction),
            )
            .toList();
        getTableTransactions = newTransactions
            .cast()
            .map(
              (e) => TableTransactionEntity.fromTransactionEntity(e),
            )
            .toList();
        notifyListeners();
      },
    );

    _getReportDataUseCase.weekly().listen(
      (newReportWidgetData) {
        _weeklyReportWidgetData = newReportWidgetData;
        notifyListeners();
      },
    );

    _getReportDataUseCase.monthly().listen(
      (newReportWidgetData) {
        _monthlyReportWidgetData = newReportWidgetData;
        notifyListeners();
      },
    );

    _getReportDataUseCase.allTimes().listen(
      (newReportWidgetData) {
        _allTimesReportWidgetData = newReportWidgetData;
        notifyListeners();
      },
    );

    _expenseSummaryData.weekly().listen(
      (newExpenseSummaryChartData) {
        _weeklyExpenseSummaryChartData = newExpenseSummaryChartData;
        notifyListeners();
      },
    );

    _expenseSummaryData.monthly().listen(
      (newExpenseSummaryChartData) {
        _monthlyExpenseSummaryChartData = newExpenseSummaryChartData;
        notifyListeners();
      },
    );

    _expenseSummaryData.allTimes().listen(
      (newExpenseSummaryChartData) {
        _allTimesExpenseSummaryChartData = newExpenseSummaryChartData;
        notifyListeners();
      },
    );

    _getIncomeSummaryDataUseCase.weekly().listen(
      (newIncomeSummaryChartData) {
        _weeklyIncomeSummaryChartData = newIncomeSummaryChartData;
        notifyListeners();
      },
    );

    _getIncomeSummaryDataUseCase.monthly().listen(
      (newIncomeSummaryChartData) {
        _monthlyIncomeSummaryChartData = newIncomeSummaryChartData;
        notifyListeners();
      },
    );

    _getIncomeSummaryDataUseCase.allTimes().listen(
      (newIncomeSummaryChartData) {
        _allTimesIncomeSummaryChartData = newIncomeSummaryChartData;
        notifyListeners();
      },
    );

    _getIncomeExpenseVariationDataUseCase.weekly().listen(
      (newIncomeExpenseVariationChartData) {
        _weeklyIncomeExpenseVariationChartData =
            newIncomeExpenseVariationChartData;
      },
    );

    _getIncomeExpenseVariationDataUseCase.monthly().listen(
      (newIncomeExpenseVariationChartData) {
        _monthlyIncomeExpenseVariationChartData =
            newIncomeExpenseVariationChartData;
      },
    );

    _getIncomeExpenseVariationDataUseCase.allTimes().listen(
      (newIncomeExpenseVariationChartData) {
        _allTimesIncomeExpenseVariationChartData =
            newIncomeExpenseVariationChartData;
      },
    );
  }

  void changeSelection(TableTransactionEntity transaction, bool value) {
    int index = getTableTransactions.indexOf(transaction);
    getTableTransactions[index].isSelected = value;
  }

  Future<void> deleteSelectedTransactions() async {
    await Future.forEach(getTableTransactions, (tableTransaction) async {
      if (tableTransaction.isSelected == true) {
        final transaction =
            TableTransactionEntity.toTransactionEntity(tableTransaction);
        await _deleteTransactionUseCase(transaction);
      }
    });
  }

  Future<void> addTransaction(TransactionEntity transactionEntity) async {
    await _addTransactionUseCase(transactionEntity);
  }

  Future<void> deleteTransaction(TransactionEntity transactionEntity) async {
    await _deleteTransactionUseCase(transactionEntity);
  }
}
