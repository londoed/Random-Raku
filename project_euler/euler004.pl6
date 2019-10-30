sub largest_palindrome($n) {
  my @arr = Array.new;
  my $product;
  my $max_pal;

  for 900..$n -> $i {
    for 900..$n -> $j {
      $product = $j * $i;
      if $product.Str == $product.Str.reverse {
        @arr.push($product);
      }
    }
  }
  $max_pal = @arr.tail;
  return $max_pal;
}

say largest_palindrome(999);
