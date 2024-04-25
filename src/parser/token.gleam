pub type Token {
  Plus
  Minus
  Asterisk
  Slash
  GreaterThan
  LessThan
  Assing
  Equal
  Bang
  NotEquals
  True
  False
  Return
  Function
  Comma
  SemiColon
  If
  Else
  Let
  Int(String)
  Ident(String)
  EOF
  Illegal
}

pub fn keyword(from str: String) -> Token {
  case str {
    "if" -> If
    "else" -> Else
    "return" -> Return
    "fn" -> Function
    "true" -> True
    "false" -> False
    "let" -> Let
    _ -> Ident(str)
  }
}
