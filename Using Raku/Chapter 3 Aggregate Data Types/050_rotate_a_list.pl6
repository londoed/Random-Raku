# Move elements of an array N positions to the left or right #
my @a = (1, 3, 5, 7, 9, 11, 13, 15);
say @a.rotate(3); #=> [7 9 11 13 15 1 3 5]
say @a.rotate(-3); #=> [11 13 15 1 3 5 7 9]

# To modify the array in place #
@a .= rotate(3);
say @a; #=> [7 9 11 13 15 1 3 5]

# Alternative using the pair() and shift() methods #
@a.push(@a.shift) for 1..3; #=> [7 9 11 13 15 1 3 5]

# Rotating the opposite way using the complimentary unshift() and pop() methods #
@a.unshift(@a.pop) for 1..3;
