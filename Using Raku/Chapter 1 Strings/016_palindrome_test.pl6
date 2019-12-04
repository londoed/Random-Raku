# Check if the entered string is palindromic #
my $string = prompt("Enter a string: ");
$string ~~ s:g/\W+//;
$string .= lc;
my $is_palindrome = $string eq $string.flip;

say "The string is " ~ (!$is_palindrome ?? "not " !! '') ~ 'palindromic';

# With interpolation #
my $not = $is_palindrome ?? '' !! ' not';
say "The string is$not palindromic";
