# Write a program that generates a random integer number 0 through 10 and asks the user to guess it, saying if the entered value is too small or too big #
my $n = 10.rand.round;
my $guess = prompt("Guess my number between 0 and 10: ");

while $guess != $n {
  if $guess < $n {
    say "Too small, guess again!";
  } elsif $guess > $n {
    say "Too big, guess again!";
  }
  $guess = prompt("Guess my number between 0 and 10: ");
}

say "Yes, $n is it!";

# Rewriting with ternary operators #
my $n = 10.rand.round;
my $guess = prompt("Guess my number between 0 and 10: ");

while $guess != $n {
  say $guess < $n ?? "Too small, guess again!" !! "Too big, guess again!";
  $guess = prompt("Guess my number between 0 and 10: ");
}

say "Yes, $n is it!";
