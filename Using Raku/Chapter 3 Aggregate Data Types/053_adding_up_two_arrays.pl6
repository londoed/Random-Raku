# Take two arrays and create a new one whose elements are the sums of the corresponding items of the initial arrays #

# Assuming the arrays are of the same length #
my @a = 10..20;
my @b = 30..40;

my @sum = @a <<+>> @b;
say @sum; #=> [40 42 44 46 48 50 52 54 56 58 60]

# With different lengths #
my @long = (1, 2, 3, 4);
my @short = (10, 20);

say @long <<+<< @short; #=> [11 22]
say @long >>+>> @short; #=> [11 22 13 24]
say @long <<+>> @short; #=> [11, 22, 13, 24]
say @long >>+<< @short; #=> RUNTIME ERROR: Arrays must be the same length
