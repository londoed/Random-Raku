# Print the first ten odd numbers. Print the first ten even numbers #
.say if $_ % 2 for 1..20; #=> odd numbers

.say unless $_ % 2 for 1..20; #=> even numbers

# Using filtering with the grep() function #
.say for grep({ $_ % 2 }, 1..20); #=> even numbers

.say for grep({ $_ %% 2 }, 1..20); #=> odd numbers

# Using a sequence #
my @odd = 1, 3 ... *;
say @odd[^10];

my @even = 2, 4 ... *;
say @even[^10];
