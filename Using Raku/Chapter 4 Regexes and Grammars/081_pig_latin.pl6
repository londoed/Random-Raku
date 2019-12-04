# Convert the given text to Pig Latin #
my $text = "you are welcome"
$text ~~ s:i:g/ << ([qu]? <-[aeiou]>+) (\w*) >> /$1$0/;
$text ~~ s:i:g/ << (\w+) >> /$0ay/;
say $text; #=> ouyay areay elcomeway
