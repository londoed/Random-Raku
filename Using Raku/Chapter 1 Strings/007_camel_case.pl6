# Create a camel-case identifier from a given phrase #
my $text = prompt("Enter short text: ");
my $CamelName = $text.comb(/\w+/).map({ .tclc }).join('');
say $CamelName;
