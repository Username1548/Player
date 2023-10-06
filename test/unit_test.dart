// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/utilities/audio_linked_list.dart';

void main() {
  test('Cоздание MyLinkedList и toString()', () {
    //Arange
    const List data = [1, 2, 3, 4, 5];

    //Act
    String res1 = MyLinkedList(data).toString();
    String res2 = MyLinkedList().toString();

    //Asert
    expect(res1, '1 2 3 4 5');
    expect(res2, 'empty');
  });

  test('Получение length и isEmpty', () {
    //Arange
    const List data = [1, 2, 3, 4, 5];
    MyLinkedList filledList = MyLinkedList(data);
    MyLinkedList emptyListt = MyLinkedList();

    //Act
    bool res1 = filledList.isEmpty;
    bool res2 = emptyListt.isEmpty;
    int res3 = filledList.length;
    int res4 = emptyListt.length;

    //Asert
    expect(res1, false);
    expect(res2, true);
    expect(res3, 5);
    expect(res4, 0);
  });

  test('тест addFirst()', () {
    //Arange
    const List data = [1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList();

    //Act
    for (int i in data) {
      list.addFirs(i);
    }
    String res = list.toString();

    //Asert
    expect(res, '5 4 3 2 1');
  });

  test('тест addLast()', () {
    //Arange
    const List data = [1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList();

    //Act
    for (int i in data) {
      list.addLast(i);
    }
    String res = list.toString();

    //Asert
    expect(res, '1 2 3 4 5');
  });

  test('тест addAt()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList();

    //Act
    for (int i in data) {
      int index = i;
      list.addAt(index, i);
    }
    String res1 = list.toString();
    void res2() {
      list.addAt(7, 7);
    }

    //Asert
    expect(res1, '0 1 2 3 4 5');
    expect(res2, throwsException);
  });

  test('тест remove()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);

    //Act
    bool res1 = list.remove(5);
    bool res2 = list.remove(2);
    String res3 = list.toString();
    bool res4 = list.remove(10);

    //Asert
    expect(res1, true);
    expect(res2, true);
    expect(res3, '0 1 3 4');
    expect(res4, false);
  });

  test('тест removeAt()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);

    //Act
    int res1 = list.removeAt(1);
    int res2 = list.removeAt(3);
    String res3 = list.toString();
    void res4() {
      list.removeAt(10);
    }

    //Asert
    expect(res1, 1);
    expect(res2, 4);
    expect(res3, '0 2 3 5');
    expect(res4, throwsException);
  });

  test('тест indexOf()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);

    //Act
    int res1 = list.indexOf(0);
    int res2 = list.indexOf(3);
    int res3 = list.indexOf(10);

    //Asert
    expect(res1, 0);
    expect(res2, 3);
    expect(res3, -1);
  });

  test('тест elementAt()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);

    //Act
    int res1 = list.elementAt(0);
    int res2 = list.elementAt(3);
    void res3() {
      list.elementAt(10);
    }

    //Asert
    expect(res1, 0);
    expect(res2, 3);
    expect(res3, throwsException);
  });

  test('тест nodeAt()', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);

    //Act
    bool res1 = list.nodeAt(0) is Node;
    Node? res2 = list.nodeAt(10);

    //Asert
    expect(res1, true);
    expect(res2, null);
  });

  test('получение iterator', () {
    //Arange
    const List data = [0, 1, 2, 3, 4, 5];
    MyLinkedList list = MyLinkedList(data);
    Iterator iter = list.iterator;

    //Act
    List<int> res1 = List.empty(growable: true);
    while (iter.moveNext()) {
      res1.add(iter.current);
    }
    void res2() {
      iter.current;
    }

    //Asert
    expect(res1, [0, 1, 2, 3, 4, 5]);
    expect(res2, throwsStateError);
  });
}
