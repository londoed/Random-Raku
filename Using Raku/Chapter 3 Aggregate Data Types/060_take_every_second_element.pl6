# Form a new array by placing every second element from the original array #
my @data = 20..30;
my @selected = @data[1, 3 ... *];
say @selected; #=> [21 23 25 27 29]

# Slicing example #
say @data[2, 3, 5]; #=> (22 23 25)
