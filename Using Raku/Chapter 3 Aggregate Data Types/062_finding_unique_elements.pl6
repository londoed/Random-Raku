# Print all unique elements of the given array #
my @a = (2, 3, 7, 4, 5, 5, 6, 2, 10, 7);
say @a.unique; #=> (2 3 7 4 5 6 10)

# To change the default comparison method #
<1.1 1.3 2.2 2.5 3.6>.unique(with => { $^a.Int == $^b.Int }).say; #=> (1.1, 2.2, 3.6)

# Alternative solution #
unique(@data, with => -> $x, $y { $x.int == $y.Int}).say; #=> (1.1, 2.2, 3.6)
