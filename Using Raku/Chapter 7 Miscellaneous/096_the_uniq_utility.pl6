# Create a simple equivalent of the UNIX uniq utility, which only prints the lines from the STDIN input, which are not repeating the previous line #
my $previous = '';
while (my $line = $*IN.get) {
  say $line unless $line eq $previous;
  $previous = $line;
}

# Modification that makes it only print the unique lines per whole input stream #
my %seen;
while (my $line = $*IN.get) {
  next if %seen{$line};
  say $line;
  %sen{$line} = 1;
}
