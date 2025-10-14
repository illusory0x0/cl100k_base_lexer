///|
/// Tests for tokenize_part5: \s++$
/// This part handles one or more whitespace characters at the end of string (possessive quantifier)
test "tokenize_part5: single whitespace at end" {
  @json.inspect(try? tokenize_part5(" "), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("\t"), content={ "Ok": "\t" })
  @json.inspect(try? tokenize_part5("\n"), content={ "Ok": "\n" })
  @json.inspect(try? tokenize_part5("\r"), content={ "Ok": "\r" })
  @json.inspect(try? tokenize_part5("\u{C}"), content={ "Ok": "\f" })
}

///|
test "tokenize_part5: multiple spaces at end" {
  @json.inspect(try? tokenize_part5("  "), content={ "Ok": "  " })
  @json.inspect(try? tokenize_part5("   "), content={ "Ok": "   " })
  @json.inspect(try? tokenize_part5("    "), content={ "Ok": "    " })
  @json.inspect(try? tokenize_part5("     "), content={ "Ok": "     " })
}

///|
test "tokenize_part5: multiple tabs at end" {
  @json.inspect(try? tokenize_part5("\t\t"), content={ "Ok": "\t\t" })
  @json.inspect(try? tokenize_part5("\t\t\t"), content={ "Ok": "\t\t\t" })
  @json.inspect(try? tokenize_part5("\t\t\t\t"), content={ "Ok": "\t\t\t\t" })
}

///|
test "tokenize_part5: multiple newlines at end" {
  @json.inspect(try? tokenize_part5("\n\n"), content={ "Ok": "\n\n" })
  @json.inspect(try? tokenize_part5("\r\r"), content={ "Ok": "\r\r" })
  @json.inspect(try? tokenize_part5("\r\n"), content={ "Ok": "\r\n" })
  @json.inspect(try? tokenize_part5("\n\r"), content={ "Ok": "\n\r" })
  @json.inspect(try? tokenize_part5("\r\n\r\n"), content={ "Ok": "\r\n\r\n" })
}

///|
test "tokenize_part5: mixed whitespace at end" {
  @json.inspect(try? tokenize_part5(" \t"), content={ "Ok": " \t" })
  @json.inspect(try? tokenize_part5("\t "), content={ "Ok": "\t " })
  @json.inspect(try? tokenize_part5(" \n"), content={ "Ok": " \n" })
  @json.inspect(try? tokenize_part5("\n "), content={ "Ok": "\n " })
  @json.inspect(try? tokenize_part5(" \r"), content={ "Ok": " \r" })
  @json.inspect(try? tokenize_part5("\r "), content={ "Ok": "\r " })
  @json.inspect(try? tokenize_part5(" \t\n"), content={ "Ok": " \t\n" })
  @json.inspect(try? tokenize_part5("\t \r"), content={ "Ok": "\t \r" })
  @json.inspect(try? tokenize_part5(" \t\n\r"), content={ "Ok": " \t\n\r" })
}

///|
test "tokenize_part5: complex mixed whitespace patterns at end" {
  @json.inspect(try? tokenize_part5("  \t\t"), content={ "Ok": "  \t\t" })
  @json.inspect(try? tokenize_part5("\t  \t"), content={ "Ok": "\t  \t" })
  @json.inspect(try? tokenize_part5("   \n\n"), content={ "Ok": "   \n\n" })
  @json.inspect(try? tokenize_part5("\n   \n"), content={ "Ok": "\n   \n" })
  @json.inspect(try? tokenize_part5("   \r\r"), content={ "Ok": "   \r\r" })
  @json.inspect(try? tokenize_part5("\r   \r"), content={ "Ok": "\r   \r" })
  @json.inspect(try? tokenize_part5("  \t\n\r  "), content={
    "Ok": "  \t\n\r  ",
  })
  @json.inspect(try? tokenize_part5("\t \n \r \t"), content={
    "Ok": "\t \n \r \t",
  })
}

///|
test "tokenize_part5: unicode whitespace at end" {
  // Non-breaking space
  @json.inspect(try? tokenize_part5("\u{00A0}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("  \u{00A0}"), content={ "Ok": "   " })

  // Em space
  @json.inspect(try? tokenize_part5("\u{2003}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("  \u{2003}"), content={ "Ok": "   " })

  // Thin space
  @json.inspect(try? tokenize_part5("\u{2009}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("  \u{2009}"), content={ "Ok": "   " })

  // Hair space
  @json.inspect(try? tokenize_part5("\u{200A}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("  \u{200A}"), content={ "Ok": "   " })
}

///|
test "tokenize_part5: form feed and vertical tab at end" {
  @json.inspect(try? tokenize_part5("\u{C}"), content={ "Ok": "\f" })
  @json.inspect(try? tokenize_part5("\u{B}"), content={ "Ok": "\u000b" })
  @json.inspect(try? tokenize_part5("\u{C} \u{C}"), content={ "Ok": "\f \f" })
  @json.inspect(try? tokenize_part5("\u{B}\u{B}"), content={
    "Ok": "\u000b\u000b",
  })
  @json.inspect(try? tokenize_part5("\u{C}\u{B}"), content={ "Ok": "\f\u000b" })
  @json.inspect(try? tokenize_part5("\u{B}\u{C}"), content={ "Ok": "\u000b\f" })
  @json.inspect(try? tokenize_part5(" \u{C}\u{B} "), content={
    "Ok": " \f\u000b ",
  })
}

///|
test "tokenize_part5: error cases - empty string" {
  let result = try? tokenize_part5("")
  @json.inspect(result, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part5: error cases - no whitespace" {
  let result1 = try? tokenize_part5("hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part5("123")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part5("!@#")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part5(".")
  @json.inspect(result4, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part5: error cases - whitespace not at end" {
  // Whitespace followed by non-whitespace should fail (not at end of string)
  let result1 = try? tokenize_part5(" hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part5("\thello")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part5("\nworld")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part5("\rtest")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part5("   123")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part5("\t\t!")
  @json.inspect(result6, content={ "Err": "BackTracing" })
  let result7 = try? tokenize_part5(" \n.")
  @json.inspect(result7, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part5: error cases - mixed content with whitespace at end" {
  // Text followed by whitespace should fail ($ means end of string, only whitespace allowed)
  let result1 = try? tokenize_part5("hello ")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part5("world\t")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part5("test\n")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part5("123 ")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part5("!@#   ")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part5("a\t\t")
  @json.inspect(result6, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part5: error cases - non-whitespace at start" {
  let result1 = try? tokenize_part5("a ")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part5("1\t")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part5("!\n")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part5(".\r")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part5("你好 ")
  @json.inspect(result5, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part5: boundary cases - exactly at string end" {
  // These should work because whitespace is at the very end
  @json.inspect(try? tokenize_part5(" "), content={ "Ok": " " })
  @json.inspect(try? tokenize_part5("\t"), content={ "Ok": "\t" })
  @json.inspect(try? tokenize_part5("\n"), content={ "Ok": "\n" })
  @json.inspect(try? tokenize_part5("\r"), content={ "Ok": "\r" })

  // Multiple whitespace at end
  @json.inspect(try? tokenize_part5("  "), content={ "Ok": "  " })
  @json.inspect(try? tokenize_part5("\t\t"), content={ "Ok": "\t\t" })
  @json.inspect(try? tokenize_part5("\n\n"), content={ "Ok": "\n\n" })
  @json.inspect(try? tokenize_part5("\r\r"), content={ "Ok": "\r\r" })
}

///|
test "tokenize_part5: long sequences of whitespace" {
  // Many spaces
  @json.inspect(try? tokenize_part5("          "), content={
    "Ok": "          ",
  })

  // Many tabs
  @json.inspect(try? tokenize_part5("\t\t\t\t\t\t\t\t\t\t"), content={
    "Ok": "\t\t\t\t\t\t\t\t\t\t",
  })

  // Many newlines
  @json.inspect(try? tokenize_part5("\n\n\n\n\n"), content={
    "Ok": "\n\n\n\n\n",
  })

  // Mixed long sequence
  @json.inspect(try? tokenize_part5("    \t\t\t\t    \n\n\n    \r\r\r    "), content={
    "Ok": "    \t\t\t\t    \n\n\n    \r\r\r    ",
  })
}

///|
test "tokenize_part5: edge cases with different whitespace types" {
  // Test all common whitespace characters at end
  @json.inspect(try? tokenize_part5(" "), content={ "Ok": " " }) // space (U+0020)
  @json.inspect(try? tokenize_part5("\t"), content={ "Ok": "\t" }) // tab (U+0009)
  @json.inspect(try? tokenize_part5("\n"), content={ "Ok": "\n" }) // line feed (U+000A)
  @json.inspect(try? tokenize_part5("\r"), content={ "Ok": "\r" }) // carriage return (U+000D)
  @json.inspect(try? tokenize_part5("\u{C}"), content={ "Ok": "\f" }) // form feed (U+000C)
  @json.inspect(try? tokenize_part5("\u{B}"), content={ "Ok": "\u000b" }) // vertical tab (U+000B)
}

///|
test "tokenize_part5: all whitespace types mixed at end" {
  @json.inspect(try? tokenize_part5(" \t\n\r\u{C}\u{B}"), content={
    "Ok": " \t\n\r\f\u000b",
  })
  @json.inspect(try? tokenize_part5("\u{B}\u{C}\r\n\t "), content={
    "Ok": "\u000b\f\r\n\t ",
  })
  @json.inspect(try? tokenize_part5("  \t\t\n\n\r\r\u{C}\u{C}\u{B}\u{B}  "), content={
    "Ok": "  \t\t\n\n\r\r\f\f\u000b\u000b  ",
  })
}
