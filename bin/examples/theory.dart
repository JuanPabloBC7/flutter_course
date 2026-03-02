// ignore_for_file: avoid_print
import '../examples/interfaces/models.dart';

/* ===== Simple List Examples ===== */
void simpleListExamples() {
  final List<Movement> movements = [];

  movements.add(
    Movement(
      'TX-9001',
      DateTime(2026, 1, 20, 9, 15),
      120000.00,
      'deposit',
      'APP',
    )
  );
  movements.add(
    Movement(
      'TX-9002',
      DateTime(2026, 1, 20, 11, 40),
      250000.00,
      'payment',
      'PSE',
    )
  );

  for (var mov in movements) {
    print('{ id: ${mov.id}, date: ${mov.date}, amount: ${mov.amount}, type: ${mov.type}, channel: ${mov.channel} }');
  }

  print('');
  print('Deleting the last element of the movements list');
  movements.removeLast(); // delete last element of the list
  for (var mov in movements) {
    print('{ id: ${mov.id}, date: ${mov.date}, amount: ${mov.amount}, type: ${mov.type}, channel: ${mov.channel} }');
  }
}
/* ===== End Simple List Examples ===== */

/* ===== Simple Set Examples ===== */
void simpleSetExamples() {
  final Set<Movement> movements = {};

  movements.add(
    Movement(
      'TX-9001',
      DateTime(2026, 1, 20, 9, 15),
      120000.00,
      'deposit',
      'APP',
    )
  );
  movements.add(
    Movement(
      'TX-9002',
      DateTime(2026, 1, 20, 11, 40),
      250000.00,
      'payment',
      'PSE',
    )
  );

  for (var mov in movements) {
    print('{ id: ${mov.id}, date: ${mov.date}, amount: ${mov.amount}, type: ${mov.type}, channel: ${mov.channel} }');
  }
}
/* ===== End Simple Set Examples ===== */

/* ===== Simple Set Examples ===== */
void simpleMapExamples() {
  final Map<String, Map<String, String>> currency = {
    "quetzales": { 'name': 'quetzal', 'value': 'Q', 'city': 'Guatemala' },
    "dollar": { 'name': 'quetzal', 'value': 'Q', 'city': 'Guatemala' },
  };

  print(currency);

  print('');
  final Map<int, String> days = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
  
  print(days);
}
/* ===== End Simple Set Examples ===== */

/* ===== List Examples ===== */
void listExamples() {
  List<String> students = ['Ana', 'Luis', 'Ana', 'Carlos', 'Luis'];
  Set<String> uniqueStudents = students.toSet();

  print('Students');
  for (var i = 0; i < students.length; i++) {
    print('id: $i, name: ${students[i].toUpperCase()}');
  }

  print('');
  print('Unique Students');
  for (var student in uniqueStudents) {
    print(student.toUpperCase());
  }

  print('');
  print('Unique Students Count: ${uniqueStudents.length}');
  
  print('');
  print('Adding new student: Maria and Ana');
  uniqueStudents.add('Maria');
  uniqueStudents.add('Ana');
  for (var student in uniqueStudents) {
    print(student);
  }

  print('');
  print('Unique Students Count: ${uniqueStudents.length}');
}
/* ===== End List Examples ===== */

/* ===== Cycle Examples ===== */
void cycleExamples(List<String> arguments) {
  List<Student> studentList = [
    Student('Juan', 20, 3.5),
    Student('María', 22, 4.2),
    Student('Pedro', 19, 2.8),
    Student('Ana', 21, 3.0),
  ];

  print('Estudiantes:');
  studentList.forEach((student) {
    print(student.name);
  });

  print('');
  print('Estudiantes con nota mayor a 3:');
  List<Student> approvedStudents = studentList.where((student) => student.grade >= 3.0).toList();
  approvedStudents.forEach((s) => print(s.name));

  print('');
  bool existsMaria = studentList.any((student) => student.name == 'María');
  print('Existe maria? $existsMaria');

  print('');
  studentList.sort((a, b) => b.grade.compareTo(a.grade));
  print('Ordenados por nota (mayor a menor):');
  studentList.forEach((s) => print('${s.name} - ${s.grade}'));


  List<int> ages = studentList.map((student) => student.age).toList();

  print('');
  print('Edades: $ages');
}
/* ===== End Cycle Examples ===== */

/* ===== Async and Await Examples ===== */
void asyncAndAwait() {
  print('estado 1');
  getBalanceByName();
  print('estado 2');
}

Future<void> getBalanceByName() async{
  // return getName().then((name) {
  //   return getBalance(name).then((balance) => print(balance));
  // });

  final name = await getName();
  final balance = await getBalance(name);
  print('Name: $name, Balance: $balance');
}

Future<String> getName () {
  return Future.delayed(Duration(seconds: 2), () => 'Jomazao');
}

Future<double> getBalance(String name) async {
  double balance;
  switch (name) {
    case 'Jomazao':
      balance = 500000;
      break;
    case 'Maria':
      balance = 7000000;
      break; 
    default:
      balance = 0;
  }
  return Future.value(balance);
}
/* ===== End Async and Await Examples ===== */

/* ===== New Examples ===== */
void newExamples() {
  
}
/* ===== End New Examples ===== */