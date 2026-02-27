// ignore_for_file: avoid_print
import 'dart:io';
import 'examples/theory.dart' as ex;

void main() {
  int? option = 1;

  while (option != 0) {
    print("|================================================================================|");
    print("|                                      Menu                                      |");
    print("| 1: Simple list.                                                                |");
    print("| 2: List, Set, cycles and objects functions.                                    |");
    print("| 3: Async and await.                                                            |");
    print("| 4:                                                                             |");
    print("| 5:                                                                             |");
    print("| 6:                                                                             |");
    print("| 7:                                                                             |");
    print("| 8:                                                                             |");
    print("| 9:                                                                             |");
    print("| 0: Exit                                                                        |");
    print("|================================================================================|");
    print("");
    print("Please enter an option: ");
    option = int.tryParse(stdin.readLineSync()!);

    clearConsole();

    switch (option) {
      case 1:
        printTitle(option.toString());
        ex.listExamples();
        break;
      case 2:
        printTitle(option.toString());
        ex.cycleExamples([]);
        break;
      case 3:
        printTitle(option.toString());
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
