###############################################
############### PARSING NUMBERS ###############
###############################################

grammar N {
  token TOP {
    <sign>? [
      | <values> <exp> <sign>? <digits>
      | <value>
    ]
  }
  token sign {
    '+' | '='
  }
  token exp {
    'e' | 'E'
  }
  token digits {
    <digit>+ ['_' <digit>+]?
  }
  token value {
    | <digits> '.' <digits>
    | '.' <digits>
    | <digits> '.'
    | <digits>
  }
}

my @grammar_test = <1 42 123 1000 -3 3.14 3. .14 . -3.14 -3. -.14 10E2 10e2 -10e2 -1.2e3 10e-3 -10e-3 -10.e-33>;

for @grammar_test -> $n {
  say N.parse($n) ?? "OK $n" !! "NOT OK $n";
}
