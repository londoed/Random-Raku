# Given the list of integers, compose the largest profile number by concatenating them #
my @a = (67, 8, 1, 5, 45);
say @a.sort({ $^b.Str cmp $^a.Str }).join; #=> 8675451
