#############################################
############### BASE64 ENCODE ###############
#############################################

my $e64 = '
VG8gZXJyIGlzIGh1bWFuLCBidXQgdG8gcmVhbGx5IGZvdWwgdGhpbmdzIHVwIHlvdSBuZWVkIGEgY2
9tcHV0ZXIuCiAgICAtLSBQYXVsIFIuIEVocmxpY2g=
';

my @base64map = flat('A'..'Z', 'a'..'z', ^10, '+', '/');
my %base64 is default(0) = @base64map.pairs.invert;

sub base64_decode_slow($enc) {
  my $buf = Buf.new;

  for $enc.subst(/\s/. '', :g).comb(4) -> $chunk {
    $buf.append(|(sprintf("%06d%06d%06d%06d"), |$chunk.comb.map({ %base64{$_}.base(2) })).comb(8).map({ :2($_) }));
  }
  return $buf;
}

say "Slow: ";
say base64_decode_slow($e64).decode('utf8');

say "\nFast: ";
use Base64::Native;
say base64-decode($e64).decode("utf8");
