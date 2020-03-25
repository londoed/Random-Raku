sub bisect(@word_list, Str $word) {
  my $index = (@word_list.elems / 2).Int;
  return False if $index == 0 and @word_list[$index] ne $word;

  my $found = @word_list[$index];

  if $word lt $found {
    return bisect(@word_list[0..$index - 1], $word);
  } elsif $word gt $found {
    return bisect(@word_list[$index..*-1], $word);
  }

  return True;
}

for <a f w e q ab ce> -> $search {
  if bisect([<a b d c e f g>], $search) {
    say "[!] SUCCESS: Found $search!";
  } else {
    say "[!] ERROR: Did not find $search...";
  }
}
