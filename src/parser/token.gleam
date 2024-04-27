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
  Semicolon
  LParen
  RParen
  LBrace
  RBrace
  If
  Else
  Let
  Int(BitArray)
  Ident(BitArray)
  EOF
  Illegal(BitArray)
}

pub fn keyword(from str: BitArray) -> Token {
  case str {
    <<"if":utf8>> -> If
    <<"else":utf8>> -> Else
    <<"return":utf8>> -> Return
    <<"fn":utf8>> -> Function
    <<"true":utf8>> -> True
    <<"false":utf8>> -> False
    <<"let":utf8>> -> Let
    _ -> Ident(str)
  }
}
