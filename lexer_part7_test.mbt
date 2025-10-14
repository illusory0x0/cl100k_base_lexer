///|
/// Tests for tokenize_part7: \s+(?!\S)
/// This part handles one or more whitespace NOT followed by non-whitespace (negative lookahead)
/// IMPORTANT: This targets the uncovered lines in tokenize_part7 function
test "tokenize_part7: whitespace at end of string (should work)" {
  @json.inspect(try? tokenize_part7(" "), content={ "Ok": " " })
  @json.inspect(try? tokenize_part7("  "), content={ "Ok": "  " })
  @json.inspect(try? tokenize_part7("\t"), content={ "Ok": "\t" })
  @json.inspect(try? tokenize_part7("\t\t"), content={ "Ok": "\t\t" })
  @json.inspect(try? tokenize_part7("\n"), content={ "Ok": "\n" })
  @json.inspect(try? tokenize_part7("\r"), content={ "Ok": "\r" })
  @json.inspect(try? tokenize_part7("\u{C}"), content={ "Ok": "\f" })
  @json.inspect(try? tokenize_part7("\u{B}"), content={ "Ok": "\u000b" })
}

///|
test "tokenize_part7: mixed whitespace at end of string" {
  @json.inspect(try? tokenize_part7(" \t"), content={ "Ok": " \t" })
  @json.inspect(try? tokenize_part7("\t "), content={ "Ok": "\t " })
  @json.inspect(try? tokenize_part7(" \n"), content={ "Ok": " \n" })
  @json.inspect(try? tokenize_part7("\n "), content={ "Ok": "\n " })
  @json.inspect(try? tokenize_part7(" \t\n\r"), content={ "Ok": " \t\n\r" })
  @json.inspect(try? tokenize_part7("\t \n \r "), content={ "Ok": "\t \n \r " })
}

///|
test "tokenize_part7: whitespace followed by more whitespace (should work)" {
  @json.inspect(try? tokenize_part7("  \t"), content={ "Ok": "  \t" })
  @json.inspect(try? tokenize_part7("  \n"), content={ "Ok": "  \n" })
  @json.inspect(try? tokenize_part7("\t\t "), content={ "Ok": "\t\t " })
  @json.inspect(try? tokenize_part7("\t\t\n"), content={ "Ok": "\t\t\n" })
  @json.inspect(try? tokenize_part7("   \t\t\t"), content={ "Ok": "   \t\t\t" })
  @json.inspect(try? tokenize_part7("\t\t\t   "), content={ "Ok": "\t\t\t   " })
}

///|
test "tokenize_part7: CRITICAL - empty string error case" {
  // This should trigger the uncovered line: if len == 0 { raise BackTracing }
  let result = try? tokenize_part7("")
  @json.inspect(result, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: CRITICAL - no whitespace error case" {
  // These should trigger the uncovered line: if len == 0 { raise BackTracing }
  let result1 = try? tokenize_part7("hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("123")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part7("!@#")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part7("a")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part7("1")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part7("!")
  @json.inspect(result6, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: CRITICAL - whitespace followed by non-whitespace" {
  // These should trigger the uncovered line: _ => raise BackTracing 
  // Because the negative lookahead (?!\S) fails when followed by non-whitespace
  let result1 = try? tokenize_part7(" hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("\tworld")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part7(" 123")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part7("\t!@#")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part7("  a")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part7("\t\t1")
  @json.inspect(result6, content={ "Err": "BackTracing" })
  let result7 = try? tokenize_part7("   !")
  @json.inspect(result7, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: CRITICAL - single whitespace at end (specific case)" {
  // This should trigger the uncovered line: [] => try! input[0:len]
  // When we have exactly one whitespace character at the end of string
  @json.inspect(try? tokenize_part7(" "), content={ "Ok": " " })
  @json.inspect(try? tokenize_part7("\t"), content={ "Ok": "\t" })
  @json.inspect(try? tokenize_part7("\n"), content={ "Ok": "\n" })
  @json.inspect(try? tokenize_part7("\r"), content={ "Ok": "\r" })
  @json.inspect(try? tokenize_part7("\u{C}"), content={ "Ok": "\f" })
  @json.inspect(try? tokenize_part7("\u{B}"), content={ "Ok": "\u000b" })
}

///|
test "tokenize_part7: unicode whitespace cases" {
  // Unicode whitespace at end of string
  @json.inspect(try? tokenize_part7("\u{00A0}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part7("\u{2003}"), content={ "Ok": " " })
  @json.inspect(try? tokenize_part7("\u{2009}"), content={ "Ok": " " })

  // Unicode whitespace followed by more whitespace
  @json.inspect(try? tokenize_part7("\u{00A0} "), content={ "Ok": "  " })
  @json.inspect(try? tokenize_part7("\u{2003}\t"), content={ "Ok": " \t" })

  // Unicode whitespace followed by non-whitespace (should fail)
  let result1 = try? tokenize_part7("\u{00A0}hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("\u{2003}123")
  @json.inspect(result2, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: complex patterns for negative lookahead" {
  // Multiple whitespace followed by letters
  let result1 = try? tokenize_part7("   hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("\t\t\tworld")
  @json.inspect(result2, content={ "Err": "BackTracing" })

  // Multiple whitespace followed by numbers
  let result3 = try? tokenize_part7("   123")
  @json.inspect(result3, content={ "Err": "BackTracing" })
  let result4 = try? tokenize_part7("\t\t\t456")
  @json.inspect(result4, content={ "Err": "BackTracing" })

  // Multiple whitespace followed by symbols
  let result5 = try? tokenize_part7("   !@#")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part7("\t\t\t$%^")
  @json.inspect(result6, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: edge cases - whitespace only followed by whitespace" {
  // This should work because whitespace followed by whitespace satisfies (?!\S)
  @json.inspect(try? tokenize_part7("  \t"), content={ "Ok": "  \t" })
  @json.inspect(try? tokenize_part7("\t\t "), content={ "Ok": "\t\t " })
  @json.inspect(try? tokenize_part7("   \n"), content={ "Ok": "   \n" })
  @json.inspect(try? tokenize_part7("\n\n\n "), content={ "Ok": "\n\n\n " })
  @json.inspect(try? tokenize_part7(" \t\n\r \t"), content={
    "Ok": " \t\n\r \t",
  })
}

///|
test "tokenize_part7: boundary cases for pattern length" {
  // Very long whitespace sequences at end
  @json.inspect(try? tokenize_part7("          "), content={
    "Ok": "          ",
  })
  @json.inspect(try? tokenize_part7("\t\t\t\t\t\t\t\t\t\t"), content={
    "Ok": "\t\t\t\t\t\t\t\t\t\t",
  })

  // Very long whitespace followed by non-whitespace (should fail)
  let result1 = try? tokenize_part7("          hello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("\t\t\t\t\t\t\t\t\t\tworld")
  @json.inspect(result2, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: newline and carriage return special cases" {
  // Newlines are whitespace, so these should work at end of string
  @json.inspect(try? tokenize_part7("\n"), content={ "Ok": "\n" })
  @json.inspect(try? tokenize_part7("\r"), content={ "Ok": "\r" })
  @json.inspect(try? tokenize_part7("\r\n"), content={ "Ok": "\r\n" })
  @json.inspect(try? tokenize_part7("\n\r"), content={ "Ok": "\n\r" })

  // Newlines followed by non-whitespace should fail
  let result1 = try? tokenize_part7("\nhello")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("\rworld")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part7("\r\nhello")
  @json.inspect(result3, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part7: mixed content patterns" {
  // Start with non-whitespace (should fail immediately due to \s+ requirement)
  let result1 = try? tokenize_part7("hello ")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part7("123\t")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part7("!@#\n")
  @json.inspect(result3, content={ "Err": "BackTracing" })

  // Start with letters/numbers/symbols should fail the \s+ requirement
  let result4 = try? tokenize_part7("a ")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part7("1\t")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part7("!\n")
  @json.inspect(result6, content={ "Err": "BackTracing" })
}
