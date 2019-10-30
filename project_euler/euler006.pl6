my @arr = Array.new;
my $total_square, $square_sum, $square_total, $sum_square = 0;
my $i, $j = 1;

while $i < 101 {
  $total_square += ($i**2);
  $i++;
}

while $j < 101 {
  @arr.push($j);
  $j++;
}

$square_sum = @arr.sum;
$square_total = $square_sum**2;

my $difference = $square_total - $total_square;

say $difference;
