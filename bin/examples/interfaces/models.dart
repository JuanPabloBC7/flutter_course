/* Models
 * | Class      | It can be instanced | It can be extended        | It can be implemented |
 * | ---------- |:-------------------:|:-------------------------:|:---------------------:|
 * | Abstract   | No                  | Yes                       | Yes                   |
 * | Mixin      | No                  | No                        | Yes (with)            |
 * | Interface  | Yes                 | No (Outside the bookstore)| Yes                   |
 * | Base       | Yes                 | Yes (Same base)           | No                    |
 * | Final      | Yes                 | No                        | No                    |
 * | Sealed     | No                  | Yes (On bookstore)        | Yes (On bookstore)    |
*/
class BankAccount { 
  final String accountNumber; 
  final String accountName; 
  final double accountBalance; 
  final bool accountStatus; 
  BankAccount({ 
    required this.accountNumber, 
    required this.accountName, 
    required this.accountBalance, 
    this.accountStatus = true, 
  });
}

class Movement {
  String id; 
  DateTime date; 
  double amount; 
  String type; 
  String channel; 

  Movement(this.id, this.date, this.amount, this.type, this.channel,);
}

class Student {
  String name;
  int age;
  double grade;

  Student(this.name, this.age, this.grade);
}
