# For commas between the three-digit groups in a large number #
my $num = 1234567890;
$num ~~ s/<?after \d> (\d ** 3)+ $/{$0.map(',' ~ *),join}/;
say $num; #=> 1,234,567,890
