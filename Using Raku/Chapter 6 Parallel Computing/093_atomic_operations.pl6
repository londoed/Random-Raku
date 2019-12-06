# Using the solution for Task 38, the Monte Carlo method, create a program that calculates the result using multiple threads #
my atomicint $inside = 0;

my $n = 5_000;
my $p = 4;

await gather for 1..$p {
  take start {
    for 1..$n {
      my @point = map: { 2.rand - 1 }, 1..2;
      atomic-fetch-inc($inside) if sqrt([+] map: * **2, @point) <= 1;
    }
  }
}

say "approximately {4 * $inside / $p / $n}"; #=> approximately 3.141524
