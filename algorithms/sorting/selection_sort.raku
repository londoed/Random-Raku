##############################################
############### SELECTION SORT ###############
##############################################

sub selection_sort(@a) {
  for @a.kv -> $idx, $_ {
    my $min_idx = min_index(@a, $idx);
    (@a[$idx], @a[$min_idx]) = (@a[$min_idx], @a[$idx]);
  }
  return @a;
}

sub min_index(@subset, $from) {
  my $min_val = @subset[$from..-1].min;
  my $min_idx = @subset[$from..-1].index($min_val) + $from;
  return $min_idx;
}
