# Print unique digits from a given number #
my $number = prompt("Enter number: ")
say $number.comb.unique.sort.join(", ");

# OR #
$number.comb.unique.sort.join(', ').say;
