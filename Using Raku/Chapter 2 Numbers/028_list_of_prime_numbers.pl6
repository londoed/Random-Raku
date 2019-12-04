# Print the list of the first ten prime numbers #
my @numbers = grep({ .is-prime }, 1..*);
say @numbers[^10];

# Using colon to pass arguments to functions #
my @numbers = (1..*).grep: *.is-prime;
say @numbers[^10];

# OR #
my @numbers = (^Inf).grep: *is-prime;
say @numbers[^10];

# By making a selection of the first ten elements directly #
say ((^Inf).grep: *is-prime)[^10];
