# Count the number of words in a text #
my $text = prompt("Enter text: ");
say $text.comb(/\w+/).elems;

# More traditional match syntax #
$text ~~ m:g/(\w+)/;
say $/.elems;
