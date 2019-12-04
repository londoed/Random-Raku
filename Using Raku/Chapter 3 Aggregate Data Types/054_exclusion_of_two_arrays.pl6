# From the given two arrays, find the elements of the first array which do not appear in the second one #
my @a = (2, 5, 7, 8, 10);
my @b = (1, 3, 5, 7, 9);

.say for (@a (-) @b).keys; #=> (2 8 10)

# To preserve order of arrays #
.say for grep: { * |(<) @b, @a }; #=> (2 8 10)

# Equivalent to: #
.say for grep: { $_ |(<) @b, @a }; #=> (2 8 10)
