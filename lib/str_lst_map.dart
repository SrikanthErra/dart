void main() {
  // List<int> marks = [6, 7, 8, 2, 3, 4, 1, 5];
  // marks.add(5);
  // marks.addAll([10, 11, 12]);
//  marks.insert(4, 30);
//  marks.remove(79);
  // marks.clear();
//  marks.removeAt(1);
  // marks.last;//Map
  // final result = marks.map((xyz) => xyz + 10).toList();
  //  print("map result $result");
  // print("hello");
  // print(marks);
  // marks.sort((a, b) => a.compareTo(b));
  // print(marks);
  // var b = marks.contains(7);
  // print(b);

//Map
  // var s = {'name': 'Srikanth', 'age': '22', 'gender': 'Male'};
  // print(s);
  Map<String, dynamic> mapValue = {
    'name': 'Srikanth',
    'age': '22',
    'gender': 'Male'
  };
  print(mapValue);
  print(mapValue.isEmpty);
  print(mapValue.isNotEmpty);
  print(mapValue.length);
  print(mapValue.entries);
  print(mapValue.keys);
  print(mapValue.values);
  mapValue.remove('age');
  mapValue.addAll({'num': '1203213', 'mail': 'assahbcsdca'});
   print(mapValue);
  mapValue.forEach((key, value) => print('$key: $value'));
 

  ////where
  //////
  // final finalElements = marks.where((element1) => element1 < 2).toList();
  // print(finalElements);

  // print("Hello world");
  // bool a = true;
  // print(a);
  // String s = 'It\'s okay'
  //     ' Be cool';
  // print(s);
  // String s1 = 'Sri';
  // String s2 = 'Good morning $s1';
  // print(s2);
  // // print('the length of s2 is ' + s2.length.toString());
  // print('the length of s1 is ${s1.length}');

  // dynamic isEmpty = s1.isEmpty;
  // if (isEmpty is int) {
  //   print("it is boolean");
  // }
  // print("get the uppercase ${s1.toUpperCase()}");
  // print("get the uppercase ${s1.toLowerCase()}");

  // String name = ' Sri   kanth ';
  // print("get the trim value${name.trim()}");
  // dynamic splitValues = "ghghj , ygjh, khkh ,vbbvbn".split(",");
  // print("vxsh${splitValues}");

  // const b = 10;
  // print(b);
  // int c = 15, d = 12;
  // c < d ? print('c is smaller') : print('d is smaller');
  // // String name = null;
  // // print(name ?? 'Guest User');
  // List lang = ['c', 'java', 'c++', 'python'];
  // for (var item in lang) {
  //   print(item);
  // }

//break statement and label in dart
  // label1:
  // for (var i = 1; i <= 3; i++) {
  //   for (var j = 1; j <= 3; j++) {
  //     print('$i $j');
  //     if (i == 2 && j == 2) {
  //       break label1;
  //     }
  //   }
  // }
//   var sum = add(2, 3);
//   print('the sum is $sum');
//   mul(5, 6);
//   city('hyd');
  // add(10, 20, z: 30); //for default optional parameters
}

//default optional parameters
// void add(int x, int y, {int z = 10}) {
//   var result = x + y + z;
//   print('the sum is $result');
// }
// int add(int x, int y) => x + y;
// void mul(int x, int y) => print('the product is ${x + y}');
// void city(String c, [String c1, String c2]) {
//   print('city1 is  $c');
//   print('city2 is  $c1');
//   print('city3 is  $c2');

 //}
