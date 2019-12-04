# Take a matrix and print its transposed version #
my @matrix = (
  [1, 2], [3, 4]
);

my @transposed = [Z] @matrix;
say @transposed; #=> [(1 3) (2, 4)]
# OR #
my $transposed = [1, 2] Z [3, 4];
say @transposed; #=> [(1 3) (2, 4)]
