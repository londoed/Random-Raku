#########################################################
############### SEARCH IN A SORTED MATRIX ###############
#########################################################

sub search_in_a_sorted_matrix(@matrix, $m, $n, $key, $check $found=False) {
  my $i = $m - 1;
  my $j = 0;

  while $i >= 0 && $j < $n && $check != False {
    if $key = @matrix[$i][$j] {
      say "Key: $key found at row: {$i + 1} column {$j + 1}";
      return;
    }

    if $key < @matrix[$i][$j] {
      $i--;
    } else {
      $j++;
    }
  }
  say "Key $key not found...";
}

sub MAIN() {
  my @matrix = (
    (2, 5, 7),
    (4, 8, 13),
    (9, 11, 15),
    (12, 17, 20)
  );

  my $x = prompt("Enter a number to be searched: ").Int;
  say @matrix;
  search_in_a_sorted_matrix(@matrix, @matrix.elems, @matrix[0].elems, $x);
}
