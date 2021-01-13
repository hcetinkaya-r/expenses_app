import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personel_expenses_app/models/transaction.dart';
import 'package:personel_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    var list = new List<int>.generate(10, (i) => i + 2);
    print("List generate: ${list.toString()}");

    var numbers = [1,2,3,4,5,6,7,8,9];
    print("List subList: " + numbers.sublist(1,3).toString());
    print("List subList-2: " + numbers.sublist(1).toString());
    numbers.shuffle();
    print("Numbers shuffle(): " + numbers.toString());
    print("Numbers reversed: " + numbers.reversed.toList().toString());
    print("Numbers asMap: " + numbers.asMap().toString());

    var myList = [1, "a", 2, "b", 3, "c", 4, "d"];
    var nums= myList.whereType<int>();
    print("My List whereType:" + nums.toString());
    print("My List getRange: " + myList.getRange(1, 4).toString());
    myList.replaceRange(2, 4, ["hakan"]);
    print("My list replaceRange: " + myList.toString());

    List<String> liste = ["hakan", "elif", "hulya", "bilge", "tarik", "a"];
    print("Liste firstWhere: "+ liste.firstWhere((i) => i.length < 2 ));
    print("Liste singleWhere:" + liste.singleWhere((i) => i == "tarik"));
    //Eğer aynı elemandan 2 veya daha fazla varsa bu metodu kullanmamız halinde
    //hata alırız.
    // Bu durumda firstWhere() metodunu kullanarak eşleşen ilk elemanı elde edebiliriz.

    var res = [1,2,3,4,5];
    var res2 = res.fold(5, (i, j) => i + j);
    print("Res List fold: " + res2.toString());
    var res3 = res.reduce((i, j) => i + j);
    print("Res list reduce:" + res3.toString());
    // Bu metodun fold() metodundan farkı; ilk elemanı almaması ve toplama işlemine
    // dahil etmemesi ile boş bir liste üzerinde işlem yapılmak istenildiğinde
    // hata vermesidir.


    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
