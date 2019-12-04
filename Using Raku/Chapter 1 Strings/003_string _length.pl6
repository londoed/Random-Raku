# Print the length of a string #

say 'hello'.chars; #=> 5
say 'café'.chars; #=> 4
say 'привет'.chars; #=> 6

# USING CODES #
say 'hello'.codes; #=> 5
say 'café'.codes; #=> 4
say 'привет'.chars; #=> 6

# WITH LATIN LETTER X x #
say 'x'.chars; #=> 1
say 'x'.codes; #=> 2

# SPECIFYING THE CODEPOINT OF THE COMBINING CHARACTER #
say "x\x[0328]".chars; #=> 1
say "x\x[0328]".codes; #=> 2

# SAME COMBINING CHARACTER #
say 'ę'.chars; #=> 1
say 'ę'.codes; #=> 1
