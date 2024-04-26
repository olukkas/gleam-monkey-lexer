import gleam/bit_array

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

pub fn keyword(from str: BitArray) -> Token {
  case str {
    <<"if":utf8>> -> If
    <<"else":utf8>> -> Else
    <<"return":utf8>> -> Return
    <<"fn":utf8>> -> Function
    <<"true":utf8>> -> True
    <<"false":utf8>> -> False
    <<"let":utf8>> -> Let
    _ -> {
      let assert Ok(str) = bit_array.to_string(str)
      Ident(str)
    }
  }
}
