# In a given string, double each alphanumeric character and print the result. Punctuation and spaces should stay untouched #
my $string = "Hello, 1 World!";
$string ~~ s:g/(\w)/$0$0/;
say $string; #=> HHeelllloo, 11 WWoorrlldd!

# Doubling every character except 'r' #
$string ~~ s:g/(<[\w] - [r]>)/$0$0/;
say $string; #=> HHeelllloo, 11 WWoorlldd!
