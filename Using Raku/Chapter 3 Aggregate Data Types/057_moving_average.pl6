# Calculate the moving average for the given array of numbers #
my @data = map: { rand }, 1..100;

my @averages = map: { (sum(@data)[$_ - 3..$_ + 3]) / 7 }, 3..96;
