# Increment each element in an array #
@data = 1..10;
@data>>++;
say @data; #=> [2 3 4 5 6 7 8 9 10 11]

# Alternative form using += operator #
@data <<+=>> 1;
@data >>+=>> 1;

# By ommitting the = sign, the original data is not modified #
my @data = 1..10;
my @new_data = @data >>+>> 1;
say @data; #=> [1 2 3 4 5 6 7 8 9 10]
say @new_data; #=> [2 3 4 5 6 7 8 9 10 11]
