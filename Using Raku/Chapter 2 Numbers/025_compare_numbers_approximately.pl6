# Compare the two non-integer values approximately #
say 1/1000 =~= 1/1001; #=> False
say 1/1e20 =~= 1/(1e20 + 1); #=> True

# TOLERANEC IS SET TO 1e-15 #

# Rational numbers are stored as two integers as a fraction #
say 0.1 + 0.2 - 0.3; #=> 0

# Raku prints an exact zero even with many digits requested #
'%.20f'.print(0.1 + 0.2 - 0.3); #=> 0.00000000000000000000

# OR #
print(0.1 + 0.2 - 0.3).fmt('%.20f'); #=> 0.00000000000000000000
