# Find the average value of the given array of numbers #
my @data = (7, 11, 34, 50, 200);
say sum(@data) / @data;
# OR #
say @data.sum / @data.elems;

# Using the reduction operator, NOTE: parenthesis are needed in this example! #
say ([+] @data / @data);
