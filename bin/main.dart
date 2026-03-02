// ignore_for_file: avoid_print
import 'dart:io';
import 'examples/theory.dart' as ex;

void main() {
  int? option = 1;

  while (option != 0) {
    print("|================================================================================|");
    print("|                                      Menu                                      |");
    print("| 1: Simple list.                                                                |");
    print("| 2: Simple Set.                                                                 |");
    print("| 3: Simple Map.                                                                 |");
    print("| 4: List.                                                                       |");
    print("| 5: List, Set, cycles and objects functions.                                    |");
    print("| 6: Async and await.                                                            |");
    print("| 7:                                                                             |");
    print("| 8:                                                                             |");
    print("| 9:                                                                             |");
    print("| 0: Exit                                                                        |");
    print("|================================================================================|");
    print("");
    print("Please enter an option: ");
    option = int.tryParse(stdin.readLineSync()!);

    clearConsole();
    printTitle(option.toString());

    switch (option) {
      case 1:
        ex.simpleListExamples();
        break;
      case 2:
        ex.simpleSetExamples();
        break;
      case 3:
        ex.simpleMapExamples();
        break;
      case 4:
        ex.listExamples();
        break;
      case 5:
        ex.cycleExamples([]);
        break;
      case 6:
        ex.asyncAndAwait();
        return;
      case 0:
        print("Exiting program...");
        return;
      default:
        print("Invalid option try again...");
        break;
    }

    print("");
    print("Press any key to continue: ");
    stdin.readLineSync();
  }
}

void clearConsole() {
  // Clear console for windows and linux or macos
  if(Platform.isWindows) {
    print(Process.runSync("cls", [], runInShell: true).stdout); 
  } else {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}

void printTitle(String option) {
  print("|=============================== Example $option started ==============================|");
}
