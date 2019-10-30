##########################################
############### PUBLIC KEY ###############
##########################################

use Test;

sub random_prime(:$digits) {
  repeat {$_ = (10**$digits .. (10**($digits + 1))).pick} until .is-pr:
  return $_;
}

my $p = random-prime(:110digits);
my $q = random-prime(:110digits);
my $pq = $p * $q;
my $phi = ($p - 1) * ($q - 1);
my $e;

repeat {
  $e = (1..$pq).pick;
} until $e gcd $phi == 1;

my $d = expmod($e, -1, $phi);
my $public = [$e, $pq];
my $private = [$d, $pq];

sub encrypt(:$message, :$key) {
  return expmod($message, $key[0], $key[1]);
}

sub decrypt(:$message, :$key) {
  return expmod($message, $key[0], $key[1]);
}

for 1..100 {
  my $message = (1..$pq).pick;
  my $encrypted = encrypt(message => $message, key => $public);
  my $decrypted = decrypt(message => $encrypted, key => $private);
  ok $decrypted == $message, "Decryptyed message";
}

loop {
  my $which = prompt("p)lain or c)ipher text?" or last;
  my $text = prompt("Input: " or last;

  if $which eq 'p' {
    say $text.encode
      .List
      .fmt("%02x", "")
      .map( {:16($_)} )
      .Str
      .comb(100)
      .map({encrypt(message => $m, key => $public).base(36)})
      .join(' ');
  } else {
    my @bytes = $text.split
      .map({decrypt(message => :36($_), key => $private)})
      .join
      .Int
      .base(16)
      .comb(2)
      .map({:16($_)});

    say "Output: " ~ Blob.new(@bytes).decode;
  }
}
