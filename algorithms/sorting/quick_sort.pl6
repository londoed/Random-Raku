##########################################
############### QUICK SORT ###############
##########################################

sub quick_sort(@data) {
  return @data if @data.elems <= 1;

  my $pivot = @data[0];
  my @left;
  my @right;

  for @data[1..*] -> $x {
    if $x < $pivot {
      @left.push($x);
    } else {
      @right.push($x);
    }
  }
  return flat(quick_sort(@left), $pivot, quick_sort(@right));
}

my @data = <4 5 7 1 46 78 2 2 1 9 10>;
say quick_sort(@data);
