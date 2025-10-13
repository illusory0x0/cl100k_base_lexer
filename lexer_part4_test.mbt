///|
/// Tests for tokenize_part4: [ ]?[^\s\p{L}\p{N}]++[\r\n]*+
/// This part handles: optional space + required non-whitespace/non-letter/non-number + optional \r\n
test "tokenize_part4: symbols without space prefix" {
  @json.inspect(try? tokenize_part4("!"), content=({"Ok":"!"}))
  @json.inspect(try? tokenize_part4("@"), content=({"Ok":"@"}))
  @json.inspect(try? tokenize_part4("#"), content=({"Ok":"#"}))
  @json.inspect(try? tokenize_part4("$"), content=({"Ok":"$"}))
  @json.inspect(try? tokenize_part4("%"), content=({"Ok":"%"}))
  @json.inspect(try? tokenize_part4("^"), content=({"Ok":"^"}))
  @json.inspect(try? tokenize_part4("&"), content=({"Ok":"&"}))
  @json.inspect(try? tokenize_part4("*"), content=({"Ok":"*"}))
}

///|
test "tokenize_part4: symbols with space prefix" {
  @json.inspect(try? tokenize_part4(" !"), content=({"Ok":" !"}))
  @json.inspect(try? tokenize_part4(" @"), content=({"Ok":" @"}))
  @json.inspect(try? tokenize_part4(" #"), content=({"Ok":" #"}))
  @json.inspect(try? tokenize_part4(" $"), content=({"Ok":" $"}))
  @json.inspect(try? tokenize_part4(" %"), content=({"Ok":" %"}))
  @json.inspect(try? tokenize_part4(" ^"), content=({"Ok":" ^"}))
  @json.inspect(try? tokenize_part4(" &"), content=({"Ok":" &"}))
  @json.inspect(try? tokenize_part4(" *"), content=({"Ok":" *"}))
}

///|
test "tokenize_part4: multiple consecutive symbols" {
  @json.inspect(try? tokenize_part4("!@#"), content=({"Ok":"!@#"}))
  @json.inspect(try? tokenize_part4("$%^"), content=({"Ok":"$%^"}))
  @json.inspect(try? tokenize_part4("&*()"), content=({"Ok":"&*()"}))
  @json.inspect(try? tokenize_part4("-_=+"), content=({"Ok":"-_=+"}))
  @json.inspect(try? tokenize_part4("[]{}"), content=({"Ok":"[]{}"}))
  @json.inspect(try? tokenize_part4("\\|"), content=({"Ok":"\\|"}))
  @json.inspect(try? tokenize_part4(";:"), content=({"Ok":";:"}))
  @json.inspect(try? tokenize_part4("'\""), content=({"Ok":"'\""}))
  @json.inspect(try? tokenize_part4(",."), content=({"Ok":",."}))
  @json.inspect(try? tokenize_part4("<>"), content=({"Ok":"<>"}))
  @json.inspect(try? tokenize_part4("/?"), content=({"Ok":"/?"}))
}

///|
test "tokenize_part4: multiple symbols with space prefix" {
  @json.inspect(try? tokenize_part4(" !@#"), content=({"Ok":" !@#"}))
  @json.inspect(try? tokenize_part4(" $%^"), content=({"Ok":" $%^"}))
  @json.inspect(try? tokenize_part4(" &*()"), content=({"Ok":" &*()"}))
  @json.inspect(try? tokenize_part4(" -_=+"), content=({"Ok":" -_=+"}))
  @json.inspect(try? tokenize_part4(" []{}"), content=({"Ok":" []{}"}))
  @json.inspect(try? tokenize_part4(" \\|"), content=({"Ok":" \\|"}))
}

///|
test "tokenize_part4: symbols with newlines at end" {
  @json.inspect(try? tokenize_part4("!\r"), content=({"Ok":"!\r"}))
  @json.inspect(try? tokenize_part4("@\n"), content=({"Ok":"@\n"}))
  @json.inspect(try? tokenize_part4("#\r\n"), content=({"Ok":"#\r\n"}))
  @json.inspect(try? tokenize_part4("$\n\r"), content=({"Ok":"$\n\r"}))
  @json.inspect(try? tokenize_part4("%\r\r"), content=({"Ok":"%\r\r"}))
  @json.inspect(try? tokenize_part4("^\n\n"), content=({"Ok":"^\n\n"}))
}

///|
test "tokenize_part4: space + symbols + newlines" {
  @json.inspect(try? tokenize_part4(" !\r"), content=({"Ok":" !\r"}))
  @json.inspect(try? tokenize_part4(" @\n"), content=({"Ok":" @\n"}))
  @json.inspect(try? tokenize_part4(" #\r\n"), content=({"Ok":" #\r\n"}))
  @json.inspect(try? tokenize_part4(" $\n\r"), content=({"Ok":" $\n\r"}))
  @json.inspect(try? tokenize_part4(" %\r\r"), content=({"Ok":" %\r\r"}))
  @json.inspect(try? tokenize_part4(" ^\n\n"), content=({"Ok":" ^\n\n"}))
}

///|
test "tokenize_part4: multiple symbols + newlines" {
  @json.inspect(try? tokenize_part4("!@#\r"), content=({"Ok":"!@#\r"}))
  @json.inspect(try? tokenize_part4("$%^\n"), content=({"Ok":"$%^\n"}))
  @json.inspect(try? tokenize_part4("&*()\r\n"), content=({"Ok":"&*()\r\n"}))
  @json.inspect(try? tokenize_part4("-_=+\n\r"), content=({"Ok":"-_=+\n\r"}))
  @json.inspect(
    try? tokenize_part4("[]{}\\|\r\r"),
    content=({"Ok":"[]{}\\|\r\r"}),
  )
  @json.inspect(
    try? tokenize_part4(";:'\".,<>/?∎\n\n"),
    content=({"Ok":";:'\".,<>/?∎\n\n"}),
  )
}

///|
test "tokenize_part4: space + multiple symbols + newlines" {
  @json.inspect(try? tokenize_part4(" !@#\r"), content=({"Ok":" !@#\r"}))
  @json.inspect(try? tokenize_part4(" $%^\n"), content=({"Ok":" $%^\n"}))
  @json.inspect(try? tokenize_part4(" &*()\r\n"), content=({"Ok":" &*()\r\n"}))
  @json.inspect(try? tokenize_part4(" -_=+\n\r"), content=({"Ok":" -_=+\n\r"}))
  @json.inspect(
    try? tokenize_part4(" []{}\\|\r\r"),
    content=({"Ok":" []{}\\|\r\r"}),
  )
}

///|
test "tokenize_part4: unicode symbols and emojis" {
  @json.inspect(try? tokenize_part4("©"), content=({"Ok":"©"}))
  @json.inspect(try? tokenize_part4("™"), content=({"Ok":"™"}))
  @json.inspect(try? tokenize_part4("®"), content=({"Ok":"®"}))
  @json.inspect(try? tokenize_part4("°"), content=({"Ok":"°"}))
  @json.inspect(try? tokenize_part4("±"), content=({"Ok":"±"}))
  @json.inspect(try? tokenize_part4("×"), content=({"Ok":"×"}))
  @json.inspect(try? tokenize_part4("÷"), content=({"Ok":"÷"}))
  @json.inspect(try? tokenize_part4("≠"), content=({"Ok":"≠"}))
  @json.inspect(try? tokenize_part4("≤"), content=({"Ok":"≤"}))
  @json.inspect(try? tokenize_part4("≥"), content=({"Ok":"≥"}))
  @json.inspect(try? tokenize_part4("∞"), content=({"Ok":"∞"}))
  @json.inspect(try? tokenize_part4("§"), content=({"Ok":"§"}))
  @json.inspect(try? tokenize_part4("¶"), content=({"Ok":"¶"}))
  @json.inspect(try? tokenize_part4("•"), content=({"Ok":"•"}))
}

///|
test "tokenize_part4: emoji symbols" {
  @json.inspect(try? tokenize_part4("🎉"), content=({"Ok":"🎉"}))
  @json.inspect(try? tokenize_part4("⭐"), content=({"Ok":"⭐"}))
  @json.inspect(try? tokenize_part4("❤️"), content=({"Ok":"❤️"}))
  @json.inspect(try? tokenize_part4("🌍"), content=({"Ok":"🌍"}))
  @json.inspect(try? tokenize_part4("🔥"), content=({"Ok":"🔥"}))
  @json.inspect(try? tokenize_part4("💯"), content=({"Ok":"💯"}))
}

///|
test "tokenize_part4: mixed unicode symbols with space and newlines" {
  @json.inspect(try? tokenize_part4(" ©™®\r"), content=({"Ok":" ©™®\r"}))
  @json.inspect(
    try? tokenize_part4(" ≠≤≥\n"),
    content=({"Ok":" ≠≤≥\n"}),
  )
  @json.inspect(
    try? tokenize_part4(" ∞§¶•\r\n"),
    content=({"Ok":" ∞§¶•\r\n"}),
  )
  @json.inspect(
    try? tokenize_part4("🎉⭐❤️\n\r"),
    content=({"Ok":"🎉⭐❤️\n\r"}),
  )
}

///|
test "tokenize_part4: symbols with trailing content (should stop at letters/numbers/whitespace)" {
  @json.inspect(try? tokenize_part4("!hello"), content=({"Ok":"!"}))
  @json.inspect(try? tokenize_part4("@123"), content=({"Ok":"@"}))
  @json.inspect(try? tokenize_part4("# world"), content=({"Ok":"#"}))
  @json.inspect(try? tokenize_part4("$\t"), content=({"Ok":"$"}))
  @json.inspect(try? tokenize_part4("%\f"), content=({"Ok":"%"}))
  @json.inspect(try? tokenize_part4("^a"), content=({"Ok":"^"}))
  @json.inspect(try? tokenize_part4("&5"), content=({"Ok":"&"}))
  @json.inspect(try? tokenize_part4("* "), content=({"Ok":"*"}))
}

///|
test "tokenize_part4: space + symbols with trailing content" {
  @json.inspect(try? tokenize_part4(" !hello"), content=({"Ok":" !"}))
  @json.inspect(try? tokenize_part4(" @123"), content=({"Ok":" @"}))
  @json.inspect(try? tokenize_part4(" # world"), content=({"Ok":" #"}))
  @json.inspect(try? tokenize_part4(" $\t"), content=({"Ok":" $"}))
  @json.inspect(try? tokenize_part4(" %a"), content=({"Ok":" %"}))
  @json.inspect(try? tokenize_part4(" ^5"), content=({"Ok":" ^"}))
  @json.inspect(try? tokenize_part4(" & "), content=({"Ok":" &"}))
}

///|
test "tokenize_part4: multiple symbols with trailing content" {
  @json.inspect(try? tokenize_part4("!@#hello"), content=({"Ok":"!@#"}))
  @json.inspect(try? tokenize_part4("$%^123"), content=({"Ok":"$%^"}))
  @json.inspect(try? tokenize_part4("&*() world"), content=({"Ok":"&*()"}))
  @json.inspect(try? tokenize_part4("-_=+\ttest"), content=({"Ok":"-_=+"}))
  @json.inspect(try? tokenize_part4("[]{}a"), content=({"Ok":"[]{}"}))
  @json.inspect(try? tokenize_part4("\\|5"), content=({"Ok":"\\|"}))
}

///|
test "tokenize_part4: error cases - no symbols" {
  // Empty string
  let result1 = try? tokenize_part4("")
  @json.inspect(result1, content=({"Err":"BackTracing"}))

  // Only space (no symbols after)
  let result2 = try? tokenize_part4(" ")
  @json.inspect(result2, content=({"Err":"BackTracing"}))

  // Only letters
  let result3 = try? tokenize_part4("hello")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Only numbers
  let result4 = try? tokenize_part4("123")
  @json.inspect(result4, content=({"Err":"BackTracing"}))

  // Only whitespace (tabs, newlines, etc.)
  let result5 = try? tokenize_part4("\t")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
  let result6 = try? tokenize_part4("\n")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
  let result7 = try? tokenize_part4("\r")
  @json.inspect(result7, content=({"Err":"BackTracing"}))
  let result8 = try? tokenize_part4("   ")
  @json.inspect(result8, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part4: error cases - starts with letters" {
  let result1 = try? tokenize_part4("abc")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part4("hello")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part4("ABC")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part4("你好")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part4("مرحبا")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part4: error cases - starts with numbers" {
  let result1 = try? tokenize_part4("123")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part4("0")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part4("999")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Unicode numbers
  let result4 = try? tokenize_part4("٢٠٢٣")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part4("௧௨௩")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part4: error cases - starts with whitespace other than space" {
  // Tab first
  let result1 = try? tokenize_part4("\t!@#")
  @json.inspect(result1, content=({"Err":"BackTracing"}))

  // Newline first  
  let result2 = try? tokenize_part4("\n!@#")
  @json.inspect(result2, content=({"Err":"BackTracing"}))

  // Carriage return first
  let result3 = try? tokenize_part4("\r!@#")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Form feed first
  let result4 = try? tokenize_part4("\f!@#")
  @json.inspect(result4, content=({"Err":"BackTracing"}))

  // Multiple spaces (should only consume one space)
  // This should work - only the first space is consumed as optional prefix
  @json.inspect(try? tokenize_part4("  !@#"), content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part4: error cases - space followed by invalid content" {
  // Space followed by letters
  let result1 = try? tokenize_part4(" hello")
  @json.inspect(result1, content=({"Err":"BackTracing"}))

  // Space followed by numbers
  let result2 = try? tokenize_part4(" 123")
  @json.inspect(result2, content=({"Err":"BackTracing"}))

  // Space followed by whitespace
  let result3 = try? tokenize_part4(" \t")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part4(" \n")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part4(" \r")
  @json.inspect(result5, content=({"Err":"BackTracing"}))

  // Space followed by another space
  let result6 = try? tokenize_part4("  ")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part4: boundary cases - minimal valid patterns" {
  // Single symbol (minimum required)
  @json.inspect(try? tokenize_part4("!"), content=({"Ok":"!"}))
  @json.inspect(try? tokenize_part4("@"), content=({"Ok":"@"}))

  // Space + single symbol (optional space + minimum required symbol)
  @json.inspect(try? tokenize_part4(" !"), content=({"Ok":" !"}))
  @json.inspect(try? tokenize_part4(" @"), content=({"Ok":" @"}))

  // Single symbol + single newline
  @json.inspect(try? tokenize_part4("!\r"), content=({"Ok":"!\r"}))
  @json.inspect(try? tokenize_part4("@\n"), content=({"Ok":"@\n"}))

  // Space + single symbol + single newline (all optional/minimum components)
  @json.inspect(try? tokenize_part4(" !\r"), content=({"Ok":" !\r"}))
  @json.inspect(try? tokenize_part4(" @\n"), content=({"Ok":" @\n"}))
}

///|
test "tokenize_part4: long sequences of symbols and newlines" {
  // Many symbols
  @json.inspect(
    try? tokenize_part4("!@#$%^&*()-_=+[]{}\\|;:'\",.<>/?"),
    content=({"Ok":"!@#$%^&*()-_=+[]{}\\|;:'\",.<>/?"}),
  )

  // Many symbols with space prefix
  @json.inspect(
    try? tokenize_part4(" !@#$%^&*()-_=+[]{}\\|;:'\",.<>/?"),
    content=({"Ok":" !@#$%^&*()-_=+[]{}\\|;:'\",.<>/?"}),
  )

  // Symbols with many newlines
  @json.inspect(
    try? tokenize_part4("!@#\r\n\r\n\r\n"),
    content=({"Ok":"!@#\r\n\r\n\r\n"}),
  )

  // Space + symbols + many newlines
  @json.inspect(
    try? tokenize_part4(" !@#\r\n\r\n\r\n"),
    content=({"Ok":" !@#\r\n\r\n\r\n"}),
  )
}
