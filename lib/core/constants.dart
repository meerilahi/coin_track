import 'package:flutter/material.dart';

const food = "Food";
const transportation = "Transportation";
const insurance = "Insurance";
const savings = "Savings";
const debtPayments = "Debt Payments";
const utilities = "Utilities";
const health = "Health";
const entertainment = "Entertainment";
const education = "Education";
const gifts = "Gifts";
const miscellaneous = "Miscellaneous";
const job = "Job";
const selfEmployment = "Self Employment";
const invenstment = "Invenstment";
const retirement = "Retirement";

const Map<String, IconData> expenseCategoriesIconsData = {
  food: Icons.food_bank,
  transportation: Icons.car_rental,
  insurance: Icons.security,
  savings: Icons.savings,
  debtPayments: Icons.payment,
  utilities: Icons.gas_meter,
  health: Icons.favorite,
  entertainment: Icons.sports_cricket,
  education: Icons.school,
  gifts: Icons.card_giftcard,
  miscellaneous: Icons.help,
};

const Map<String, Color> expenseCategoriesColorsData = {
  food: Colors.blue,
  transportation: Colors.green,
  insurance: Colors.purple,
  savings: Colors.orange,
  debtPayments: Colors.brown,
  utilities: Colors.pink,
  health: Colors.red,
  entertainment: Colors.teal,
  education: Colors.yellow,
  gifts: Colors.cyan,
  miscellaneous: Colors.indigoAccent,
};

const Map<String, IconData> incomeCategoriesIconsData = {
  job: Icons.work,
  selfEmployment: Icons.business,
  invenstment: Icons.trending_up_rounded,
  retirement: Icons.safety_check,
  gifts: Icons.card_giftcard_outlined,
  miscellaneous: Icons.help,
};

const Map<String, Color> incomeCategoriesColorsData = {
  job: Colors.blue,
  selfEmployment: Colors.green,
  invenstment: Colors.purple,
  retirement: Colors.indigo,
  gifts: Colors.red,
  miscellaneous: Colors.cyan,
};

const Map<int, String> weekDayNames = {
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thu",
  5: "Fri",
  6: "Sat",
  7: "Sun",
};

const Map<int, String> monthNames = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec",
};

const allTimes = "All times";
const lastMonth = "Last month";
const lastWeek = "Last week";

const transactionsNo = "Transactions";
const balance = "Balance";
const income = "Income";
const expense = "Expense";

const time = "Time";
const type = "Type";
const category = "Category";
const description = "Description";
const amount = "Amount";
