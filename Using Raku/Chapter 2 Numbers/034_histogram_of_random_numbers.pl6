# Test the quality of the random generator by using a histogram to visualize the distribution #
my @histogram;
@histogram[10 * rand]++ for 1..100_000;
say @histogram; #=> [10062 9818 10057 9922 10002 10118 9978 9959 10013 10071]
                    #[9959 9957 9813 9933 10160 10030 10036 10032 10059 10021]
