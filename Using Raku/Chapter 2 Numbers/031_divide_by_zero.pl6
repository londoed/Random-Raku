# Do something with the division by zero #
my $v = 42 / 0;
say "It still works!";

say $v;
say "Execution error!";

# To catch the error using exception handling #
try {
  say 42 / 0;
  CATCH {
    default {
      say "Error!"
    }
  }
}
say "It still works!";
