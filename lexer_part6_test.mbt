///|
/// Tests for tokenize_part6: \s*[\r\n]
/// This part handles zero or more whitespace followed by \r or \n
test "tokenize_part6: newline only (no leading whitespace)" {
  @json.inspect(try? tokenize_part6("\n"), content=({"Ok":"\n"}))
  @json.inspect(try? tokenize_part6("\r"), content=({"Ok":"\r"}))
}

///|
test "tokenize_part6: single whitespace + newline" {
  @json.inspect(try? tokenize_part6(" \n"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6(" \r"), content=({"Ok":" \r"}))
  @json.inspect(try? tokenize_part6("\t\n"), content=({"Ok":"\t\n"}))
  @json.inspect(try? tokenize_part6("\t\r"), content=({"Ok":"\t\r"}))
  @json.inspect(try? tokenize_part6("\u{C}\n"), content=({"Ok":"\f\n"}))
  @json.inspect(try? tokenize_part6("\u{C}\r"), content=({"Ok":"\f\r"}))
  @json.inspect(try? tokenize_part6("\u{B}\n"), content=({"Ok":"\u000b\n"}))
  @json.inspect(try? tokenize_part6("\u{B}\r"), content=({"Ok":"\u000b\r"}))
}

///|
test "tokenize_part6: multiple spaces + newline" {
  @json.inspect(try? tokenize_part6("  \n"), content=({"Ok":"  \n"}))
  @json.inspect(try? tokenize_part6("  \r"), content=({"Ok":"  \r"}))
  @json.inspect(try? tokenize_part6("   \n"), content=({"Ok":"   \n"}))
  @json.inspect(try? tokenize_part6("   \r"), content=({"Ok":"   \r"}))
  @json.inspect(try? tokenize_part6("    \n"), content=({"Ok":"    \n"}))
  @json.inspect(try? tokenize_part6("    \r"), content=({"Ok":"    \r"}))
}

///|
test "tokenize_part6: multiple tabs + newline" {
  @json.inspect(try? tokenize_part6("\t\t\n"), content=({"Ok":"\t\t\n"}))
  @json.inspect(try? tokenize_part6("\t\t\r"), content=({"Ok":"\t\t\r"}))
  @json.inspect(try? tokenize_part6("\t\t\t\n"), content=({"Ok":"\t\t\t\n"}))
  @json.inspect(try? tokenize_part6("\t\t\t\r"), content=({"Ok":"\t\t\t\r"}))
}

///|
test "tokenize_part6: mixed whitespace + newline" {
  @json.inspect(try? tokenize_part6(" \t\n"), content=({"Ok":" \t\n"}))
  @json.inspect(try? tokenize_part6(" \t\r"), content=({"Ok":" \t\r"}))
  @json.inspect(try? tokenize_part6("\t \n"), content=({"Ok":"\t \n"}))
  @json.inspect(try? tokenize_part6("\t \r"), content=({"Ok":"\t \r"}))
  @json.inspect(try? tokenize_part6("  \t\t\n"), content=({"Ok":"  \t\t\n"}))
  @json.inspect(try? tokenize_part6("  \t\t\r"), content=({"Ok":"  \t\t\r"}))
  @json.inspect(try? tokenize_part6("\t\t  \n"), content=({"Ok":"\t\t  \n"}))
  @json.inspect(try? tokenize_part6("\t\t  \r"), content=({"Ok":"\t\t  \r"}))
}

///|
test "tokenize_part6: form feed and vertical tab + newline" {
  @json.inspect(try? tokenize_part6("\u{C}\n"), content=({"Ok":"\f\n"}))
  @json.inspect(try? tokenize_part6("\u{C}\r"), content=({"Ok":"\f\r"}))
  @json.inspect(try? tokenize_part6("\u{B}\n"), content=({"Ok":"\u000b\n"}))
  @json.inspect(try? tokenize_part6("\u{B}\r"), content=({"Ok":"\u000b\r"}))
  @json.inspect(try? tokenize_part6("\u{C}\u{B}\n"), content=({"Ok":"\f\u000b\n"}))
  @json.inspect(try? tokenize_part6("\u{C}\u{B}\r"), content=({"Ok":"\f\u000b\r"}))
  @json.inspect(try? tokenize_part6("\u{B}\u{C}\n"), content=({"Ok":"\u000b\f\n"}))
  @json.inspect(try? tokenize_part6("\u{B}\u{C}\r"), content=({"Ok":"\u000b\f\r"}))
}

///|
test "tokenize_part6: unicode whitespace + newline" {
  // Non-breaking space + newlines
  @json.inspect(try? tokenize_part6("\u{00A0}\n"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6("\u{00A0}\r"), content=({"Ok":" \r"}))

  // Em space + newlines
  @json.inspect(try? tokenize_part6("\u{2003}\n"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6("\u{2003}\r"), content=({"Ok":" \r"}))

  // Thin space + newlines
  @json.inspect(try? tokenize_part6("\u{2009}\n"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6("\u{2009}\r"), content=({"Ok":" \r"}))
}

///|
test "tokenize_part6: mixed unicode and ascii whitespace + newline" {
  @json.inspect(
    try? tokenize_part6(" \u{00A0}\n"),
    content=({"Ok":"  \n"}),
  )
  @json.inspect(
    try? tokenize_part6("\u{00A0} \r"),
    content=({"Ok":"  \r"}),
  )
  @json.inspect(
    try? tokenize_part6("\t\u{2003}\n"),
    content=({"Ok":"\t \n"}),
  )
  @json.inspect(
    try? tokenize_part6("\u{2009}\t\r"),
    content=({"Ok":" \t\r"}),
  )
}

///|
test "tokenize_part6: long sequences of whitespace + newline" {
  @json.inspect(
    try? tokenize_part6("          \n"),
    content=({"Ok":"          \n"}),
  )
  @json.inspect(
    try? tokenize_part6("          \r"),
    content=({"Ok":"          \r"}),
  )
  @json.inspect(
    try? tokenize_part6("\t\t\t\t\t\t\t\t\t\t\n"),
    content=({"Ok":"\t\t\t\t\t\t\t\t\t\t\n"}),
  )
  @json.inspect(
    try? tokenize_part6("\t\t\t\t\t\t\t\t\t\t\r"),
    content=({"Ok":"\t\t\t\t\t\t\t\t\t\t\r"}),
  )
}

///|
test "tokenize_part6: complex mixed whitespace + newline" {
  @json.inspect(
    try? tokenize_part6("  \t\t  \u{C}\u{C}  \u{B}\u{B}  \n"),
    content=({"Ok":"  \t\t  \f\f  \u000b\u000b  \n"}),
  )
  @json.inspect(
    try? tokenize_part6("  \t\t  \u{C}\u{C}  \u{B}\u{B}  \r"),
    content=({"Ok":"  \t\t  \f\f  \u000b\u000b  \r"}),
  )
  @json.inspect(
    try? tokenize_part6("\t \u{C} \u{B} \t \u{C} \u{B} \n"),
    content=({"Ok":"\t \f \u000b \t \f \u000b \n"}),
  )
  @json.inspect(
    try? tokenize_part6("\t \u{C} \u{B} \t \u{C} \u{B} \r"),
    content=({"Ok":"\t \f \u000b \t \f \u000b \r"}),
  )
}

///|
test "tokenize_part6: whitespace + newline with trailing content" {
  // Should only consume up to the first \r or \n
  @json.inspect(try? tokenize_part6("\nhello"), content=({"Ok":"\n"}))
  @json.inspect(try? tokenize_part6("\rworld"), content=({"Ok":"\r"}))
  @json.inspect(try? tokenize_part6(" \ntest"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6(" \rmore"), content=({"Ok":" \r"}))
  @json.inspect(try? tokenize_part6("\t\n123"), content=({"Ok":"\t\n"}))
  @json.inspect(try? tokenize_part6("\t\r456"), content=({"Ok":"\t\r"}))
  @json.inspect(try? tokenize_part6("   \n!@#"), content=({"Ok":"   \n"}))
  @json.inspect(try? tokenize_part6("   \r$%^"), content=({"Ok":"   \r"}))
}

///|
test "tokenize_part6: error cases - empty string" {
  let result = try? tokenize_part6("")
  @json.inspect(result, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part6: error cases - no newline character" {
  // Only whitespace, no \r or \n
  let result1 = try? tokenize_part6(" ")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part6("\t")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part6("   ")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part6("\t\t\t")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part6(" \t ")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
  let result6 = try? tokenize_part6("\u{C}")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
  let result7 = try? tokenize_part6("\u{B}")
  @json.inspect(result7, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part6: error cases - starts with non-whitespace" {
  let result1 = try? tokenize_part6("hello\n")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part6("world\r")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part6("123\n")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part6("!@#\r")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part6("a\n")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
  let result6 = try? tokenize_part6("1\r")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part6: error cases - only letters/numbers/symbols" {
  let result1 = try? tokenize_part6("hello")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part6("world")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part6("123")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part6("!@#")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part6("abc123")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
  let result6 = try? tokenize_part6("你好")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part6: error cases - \r\n should not be included" {
  // Important: This pattern only matches ONE \r or \n, not both
  // \r\n would be matched as \r with trailing content
  @json.inspect(try? tokenize_part6("\r\n"), content=({"Ok":"\r"}))
  @json.inspect(try? tokenize_part6(" \r\n"), content=({"Ok":" \r"}))
  @json.inspect(try? tokenize_part6("\t\r\n"), content=({"Ok":"\t\r"}))

  // But \n\r would be matched as \n with trailing content
  @json.inspect(try? tokenize_part6("\n\r"), content=({"Ok":"\n"}))
  @json.inspect(try? tokenize_part6(" \n\r"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6("\t\n\r"), content=({"Ok":"\t\n"}))
}

///|
test "tokenize_part6: boundary cases - minimal valid patterns" {
  // Minimum: just \r or \n (zero whitespace allowed)
  @json.inspect(try? tokenize_part6("\n"), content=({"Ok":"\n"}))
  @json.inspect(try? tokenize_part6("\r"), content=({"Ok":"\r"}))

  // Single whitespace + newline
  @json.inspect(try? tokenize_part6(" \n"), content=({"Ok":" \n"}))
  @json.inspect(try? tokenize_part6(" \r"), content=({"Ok":" \r"}))
  @json.inspect(try? tokenize_part6("\t\n"), content=({"Ok":"\t\n"}))
  @json.inspect(try? tokenize_part6("\t\r"), content=({"Ok":"\t\r"}))
}

///|
test "tokenize_part6: edge cases - newline/carriage return distinction" {
  // Should work with either \n or \r, but only consume one
  @json.inspect(try? tokenize_part6("\n"), content=({"Ok":"\n"}))
  @json.inspect(try? tokenize_part6("\r"), content=({"Ok":"\r"}))

  // With whitespace prefix
  @json.inspect(try? tokenize_part6("   \n"), content=({"Ok":"   \n"}))
  @json.inspect(try? tokenize_part6("   \r"), content=({"Ok":"   \r"}))

  // Should not match other unicode line separators (if they exist)
  // Only \r (U+000D) and \n (U+000A) are matched by [\r\n]
}

///|
test "tokenize_part6: whitespace variations that should be handled" {
  // All standard ASCII whitespace characters (except \r\n which are handled specially)
  @json.inspect(try? tokenize_part6(" \n"), content=({"Ok":" \n"})) // space (U+0020)
  @json.inspect(try? tokenize_part6("\t\n"), content=({"Ok":"\t\n"})) // tab (U+0009)
  @json.inspect(try? tokenize_part6("\u{C}\n"), content=({"Ok":"\f\n"})) // form feed (U+000C)
  @json.inspect(try? tokenize_part6("\u{B}\n"), content=({"Ok":"\u000b\n"})) // vertical tab (U+000B)

  // Same with \r
  @json.inspect(try? tokenize_part6(" \r"), content=({"Ok":" \r"}))
  @json.inspect(try? tokenize_part6("\t\r"), content=({"Ok":"\t\r"}))
  @json.inspect(try? tokenize_part6("\u{C}\r"), content=({"Ok":"\f\r"}))
  @json.inspect(try? tokenize_part6("\u{B}\r"), content=({"Ok":"\u000b\r"}))
}

///|
test "tokenize_part6: patterns that exclude \r\n from whitespace prefix" {
  // The pattern is \s*[\r\n], meaning whitespace that is NOT \r or \n, followed by \r or \n
  // But wait - \r and \n ARE whitespace characters, so this is a bit tricky
  // Actually, \s includes \r and \n, so \s* can include them, then [\r\n] matches one more

  // Let's test patterns with \r\n in the whitespace part
  // This should work: space, then \r, then \n (matches space+\r, with \n as trailing)
  @json.inspect(try? tokenize_part6(" \r\n"), content=({"Ok":" \r"}))

  // This should work: space, then \n, then \r (matches space+\n, with \r as trailing)
  @json.inspect(try? tokenize_part6(" \n\r"), content=({"Ok":" \n"}))

  // Pure \r\n sequence: should match \r with \n as trailing
  @json.inspect(try? tokenize_part6("\r\n"), content=({"Ok":"\r"}))

  // Pure \n\r sequence: should match \n with \r as trailing
  @json.inspect(try? tokenize_part6("\n\r"), content=({"Ok":"\n"}))
}
