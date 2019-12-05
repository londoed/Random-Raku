# Create a program that calculates mathematical operations with two operands, for example: 4 + 5.3 or 7.8 / 3 #
my $expression = "14 * 16.4";
$expression ~~ /(<[-\d\.]>+) \s* ('+' | '-' | '*' | '/') \s* (<[-\d\.]>+)/;

given $1 {
  when '+' { say $0 + $2 }
  when '-' { say $0 - $2 }
  when '*' { say $0 * $2 }
  when '/' { say $0 / $2 }
}

# Solving the problem with a grammar #
grammar Calc {
  rule TOP {
    <value> <operator> <value> {
      given $<operator> {
        when '+' { say $<value>[0] + $<value>[1] }
        when '-' { say $<value>[0] - $<value>[1] }
        when '*' { say $<value>[0] * $<value>[1] }
        when '/' { say $<value>[0] / $<value>[1] }
      }
    }
  }

  token value {
    '-'? \d+ [ '.' \d+ ]?
  }

  token operator {
    '+' | '-' | '*' | '/'
  }
}

my $expression = "14 * 16.2";
Calc.parse($expression); #=> 226.8
