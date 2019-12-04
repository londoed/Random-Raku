# Find the longest palindromic substring of a given string #

my $string = prompt("Enter string: ");
my $length = $string.chars;
my $found = '';

for 0..$length -> $start {
  for $start..$length - 1 -> $end {
    my $substring = $string.substr($start, $length - $end);
    my $test = $substring;
    $test ~~ s:g/\W+//;
    $test .= lc;
    if $test eq $test.flip && $substring.chars > $found.chars {
      $found = $substring;
    }
  }
}

if $found {
  say "The longest substring is $found";
} else {
  say "No palindromic substrings found";
}
