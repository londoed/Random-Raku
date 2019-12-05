# Check if the parenthesis in a given string are balanced, i.e., whether every opening parenthesis has the corresponding closing one #
my @tests = (
  'a', '(a)', '(a b c)', 'a (b)',
  '(b) a', '(b (a))', '( ( c))', 'a(b)c',
  'a (', 'a)', '(a) b c)', 'a b)', '(b a',
  '((b (a))', '((c)', '(((a(((', ')a(',
);

grammar Balanced {
  token TOP {
    <expression>+
  }

  rule expression {
    | <:alpha>+ <expression>?
    | '(' ~ ')' <expression>
  }
}

for @tests -> $test {
  my $result = Balanced.parse($test);
  printf("%-12s is%s balanced\n", $test, $result ?? '' !! ' not');
}
