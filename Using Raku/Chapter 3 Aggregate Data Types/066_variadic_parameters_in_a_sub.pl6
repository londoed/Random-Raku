# Pass a few scalars to a sub and work with them as with an array inside the sub #
sub h($sep, *@data) {
  @data.join($sep).say;
}

h(', ', 'red', 'green', 'blue'); #=> red, green, blue

# Inserting other values to the 'slurpy' operator #
h(', ', 'apple'); #=> apple
h(', ', 1, 2, 3, 4, 5); #=> 1, 2, 3, 4, 5

# You can even use a range of values #
h(', ', 'a'..'z'); #=> a, b, c,..., z

# NOTE: You must put required parameters like '$sep' before variadic parameters #
