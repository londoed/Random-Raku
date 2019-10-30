##########################################
############### MERGE SORT ###############
##########################################

sub merge(@a1, @a2) {
  my @ret;

  loop {
    if @a1 ~~ Nil {
      return @ret + @a2;
    }

    if @a2 ~~ Nil {
      return @ret + @a1;
    }

    if @ai[0] < @a2[0] {
      @ret.push(@a1[0]);
      @a1 = @a1[1..@a1.elems];
    } else {
      @ret.push(@a2[0]);
      @a2 = @a2[1..@a2.elems];
    }
  }
}

sub merge_sort(@a) {
  my $size = @a.elems;

  if $size == 0 {
    return ();
  } elsif $size == 1 {
    return @a;
  } elsif $size == 2 {
    if @a[0] > @a[1] {
      (@a[0], @a[1]) = (@a[1], @a[0]);
    }
    return @a;
  }

  my $size1 = ($size / 2).Int;
  my $size2 = @a[$size1..$size];
  my @a1 = @a[0..$size1];
  my @a2 = @a[$size1..$size];

  @a1 = merge_sort(@a1);
  @a2 = merge_sort(@a2);

  return merge(@a1, @a2);
}
