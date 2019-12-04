# Print the squares of the numbers from 1 to 10 #
say $_**2 for 1..10;

# Using a for-loop #
for 1..10 -> $x {
  say $x * $x;
}

# Using the map() function #
.say for map({ $_**2 }, 1..10);
