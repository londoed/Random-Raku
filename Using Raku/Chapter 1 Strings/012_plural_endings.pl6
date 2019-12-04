# Put a noun in the correct form--singular or plural--depending on the number next to it #
for 1, 2, 3 -> $n {
  my $word = 'file';
  $word ~= 's' if $n > 1;
  say "$n $word found";
}

# With better interpolation #
for 1, 2, 3 -> $n {
  say "$n file{'s' if $n > 1} found";
}
