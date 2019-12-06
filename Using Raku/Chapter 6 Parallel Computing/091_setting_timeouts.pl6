# Do not wait for a slow code block if it takes too long #
my $timeout = Promise.in(2).then({ say "Timeout after 2 seconds" });

my $code = start {
  sleep(5);

  say "Done after 5 seconds";
}

await Promise.anyof($timeout, $code);
say "All done";
sleep(20);
