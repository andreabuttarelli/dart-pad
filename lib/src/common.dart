// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library services.common;

import 'dart:io';

final String sampleCode = """
void main() {
  print("hello");
}
""";

final String sampleCodeWeb = """
import 'dart:html';

void main() {
  print("hello");
  querySelector('#foo').text = 'bar';
}
""";

final String sampleCodeMultiFoo = """
import 'bar.dart';

void main() {
  print(bar());
}
""";

final String sampleCodeMultiBar = """
bar() {
  return 4;
}
""";

final String sampleCodeAsync = """
import 'dart:html';

main() async {
  print("hello");
  querySelector('#foo').text = 'bar';
  var foo = await HttpRequest.getString('http://www.google.com');
  print(foo);
}
""";

final String sampleCodeError = """
void main() {
  print("hello")
}
""";

final String sampleCodeErrors = """
void main() {
  print1("hello");
  print2("hello");
  print3("hello");
}
""";

class Lines {
  List<int> _starts = [];

  Lines(String source) {
    List<int> units = source.codeUnits;
    for (int i = 0; i < units.length; i++) {
      if (units[i] == 10) _starts.add(i);
    }
  }

  /// Return the 0-based line number.
  int getLineForOffset(int offset) {
    assert(offset != null);
    for (int i = 0; i < _starts.length; i++) {
      if (offset <= _starts[i]) return i;
    }
    return _starts.length;
  }
}

/**
 * Returns the version of the current Dart runtime.
 *
 * The returned `String` is formatted as the [semver](http://semver.org) version
 * string of the current Dart runtime, possibly followed by whitespace and other
 * version and build details.
 */
String get vmVersion => Platform.version;

/// If [str] has leading and trailing quotes, remove them.
String stripMatchingQuotes(String str) {
  if (str.length <= 1) return str;

  if (str.startsWith("'") && str.endsWith("'")) {
    str = str.substring(1, str.length - 1);
  } else if (str.startsWith('"') && str.endsWith('"')) {
    str = str.substring(1, str.length - 1);
  }
  return str;
}
