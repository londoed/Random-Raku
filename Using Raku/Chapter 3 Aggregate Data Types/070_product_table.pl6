# Generate and print the product table for the values from 1 to 10 #
say "$_[0]x$_[1] = {[*] @$_}" for 1..10 X 1..10; #=> 1x1 = 1
                                                    #1x2 = 2...
# Printing in the form of a table #
for 1..10 -> $x {
  for 1..10 -> $y {
    print $x * $y ~ "\t";
  }
  print "\n";
}

# Optimizing it #
for 1..10 -> $x {
  print "{$x * $_}\t" for 1..10;
  print "\n";
}

# Joining the output with the join() function #
for 1..10 -> $x {
  say join("\t", map: { $x * $_ }, 1..10);
}

# Written a less conventional way: #
for 1..10 -> $x {
  (1..10).map({ $x * $_ }).join("\t").say;
}

#=>
#   1  2  3  4  5  6  7  8  9  10
#   2  4  6  8  10 12 14 16 18 20
#   3  6  9  12 15 18 21 24 27 30
#   ...
