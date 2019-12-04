# Shuffle the elements of an array in random order #
my @a = 1..20;
say @a.pick(@a);
# OR @
say @a.pick(@a.elems);

# Update the array in place #
@a .= pick(@a);

# Using the roll() method, NOTE: roll() does not guarantee that elements are not repeated #
say @a.roll(@a);
