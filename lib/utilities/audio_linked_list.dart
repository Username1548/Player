class MyLinkedList<T> extends Iterable<T> {
  /// MyLinkedList<T> - связной список
  ///
  /// [length] - Длинна связного списка
  /// [_head] - первый эллемент связного списка
  /// [_tail] - последний эллемент связного списка
  /// [list] - список данных, которые можно создать при инициализации списка

  @override
  int length = 0;
  

  Node<T>? _head;
  Node<T>? _tail;

  MyLinkedList([List<T>? list]) {
    if (list != null) {
      for (var i in list) {
        addLast(i);
      }
    }
  }

  @override
  bool get isEmpty => _head == null;


  void addFirs(T data) {
    Node<T> current = Node(data);
    length += 1;

    if (isEmpty) {
      _head = current;
      _tail = current;
    } else {
      _head!.previousNode = current;
      current.nextNode = _head;
      _head = current;
    }
  }

  void addLast(T data) {
    Node<T> current = Node(data);
    length += 1;

    if (isEmpty) {
      _head = current;
      _head!.previousNode = _tail;
    } else {
      _tail!.nextNode = current;
    }
    current.previousNode = _tail;
    current.nextNode = _head;
    _tail = current;
  }

  void addAt(int index, T data) {
    Node<T>? current = Node(data);
    if (index == 0) {
      addFirs(data);
      return;
    } else if (index == length || index == -1) {
      addLast(data);
      return;
    }
    if (isEmpty) {
      throw 'Index out of range';
    }
    if (index >= 0 && index < length) {
      int i = 0;
      var temp = _head;
      while (i < index) {
        temp = temp!.nextNode;
        i += 1;
      }
      temp!.previousNode!.nextNode = current;
      current.previousNode = temp.previousNode;
      current.nextNode = temp;
      temp.previousNode = current;
      length += 1;
      return;
    }
    if (index <= 0 && index >= -length) {
      int i = 0;
      var temp = _head;
      while (i <= length + index) {
        temp = temp!.nextNode;
        i += 1;
      }
      temp!.previousNode!.nextNode = current;
      current.previousNode = temp.previousNode;
      current.nextNode = temp;
      temp.previousNode = current;
      length += 1;
      return;
    }
    throw 'Index out of range';
  }

  /// Removes the first occurrence of [data] from this list.
  ///
  /// Returns true if [data] was in the list, false otherwise.
  bool remove(T data) {
    if (!isEmpty) {
      Node<T>? current = _head;
      int i = 0;
      while (i < length) {
        if (current!.data == data) {
          current.nextNode!.previousNode = current.previousNode;
          current.previousNode!.nextNode = current.nextNode;
          if (i == 0) {
            _head = current.nextNode;
          } else if (i == length - 1) {
            _tail = current.previousNode;
          }
          length -= 1;
          return true;
        }
        current = current.nextNode;
        i += 1;
      }
    }
    return false;
  }

  /// Removes the element at [index]
  /// Returns the data of element.
  ///
  /// The [index] must be -[length] <= [index] < [length].
  T removeAt(int index) {
    if (!isEmpty) {
      Node<T>? current = _head;
      int i = 0;
      while (i < length) {
        if (index == i) {
          current!.nextNode!.previousNode = current.previousNode;
          current.previousNode!.nextNode = current.nextNode;
          if (i == 0) {
            _head = current.nextNode;
          } else if (i == length - 1) {
            _tail = current.previousNode;
          }
          length -= 1;
          return current.data;
        } else if (length + index == i) {
          current!.nextNode!.previousNode = current.previousNode;
          current.previousNode!.nextNode = current.nextNode;
          if (i == 0) {
            _head = current.nextNode;
          } else if (i == length - 1) {
            _tail = current.previousNode;
          }
          length -= 1;
          return current.data;
        }
        current = current!.nextNode;
        i += 1;
      }
    }
    throw 'Index out of range';
  }

  /// Returns the first index of [data] if [data] was in the list,
  /// false otherwise.
  int indexOf(T data) {
    if (!isEmpty) {
      Node<T>? current = _head;
      int i = 0;
      while (i < length) {
        if (current!.data == data) {
          return i;
        }
        current = current.nextNode;
        i += 1;
      }
    }
    return -1;
  }

  /// Returns the element at [index].
  ///
  /// The [index] must be -[length] <= [index] < [length].
  @override
  T elementAt(int index) {
    if (!isEmpty) {
      Node<T>? current = _head;
      int i = 0;
      while (i < length) {
        if (i == index) {
          return current!.data;
        } else if (i == length + index) {
          return current!.data;
        }
        current = current!.nextNode;
        i += 1;
      }
    }
    throw 'Index out of range';
  }

  Node<T>? nodeAt(index) {
    Node<T>? current = _head;
      int i = 0;
      while (i < length) {
        if (i == index) {
          return current;
        } else if (i == length + index) {
          return current;
        }
        current = current!.nextNode;
        i += 1;
      }
      return null;
  }

  @override
  String toString() {
    var result = StringBuffer();
    if (_head != null) {
      Node<T>? currentNode = _head;
      int i = 0;
      while (i < length) {
        result.write('${currentNode!.data} ');
        currentNode = currentNode.nextNode;
        i += 1;
      }
      return result.toString();
    }
    return 'null';
  }

  @override
  Iterator<T> get iterator => _MyIterator<T>(_head, length);
}

class _MyIterator<T> implements Iterator<T> {
  Node<T>? _current;
  final Node<T>? _start;
  final int _length;
  int _currentIndex = 0;

  _MyIterator(this._start, this._length) {
    if (_length > 0) {
      _current = _start;
    }
  }
  @override
  T get current {
    if (_current == null) {
      throw StateError('Iterator has reached the end');
    }
    return _current!.data;
  }

  @override
  bool moveNext() {
    if (_currentIndex >= _length) {
      _current = null;
      return false;
    }
    if (_currentIndex > 0) {
      _current = _current!.nextNode;
    }
    _currentIndex++;
    return true;
  }

  
}

class Node<T> {
  ///
  ///
  ///
  ///
  Node<T>? nextNode;
  Node<T>? previousNode;
  T data;

  Node(this.data);
}
