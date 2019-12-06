# Implement the Sleep Sort algorithm for a few small positive integers #
await gather for @*ARGS -> $value {
  take start {
    sleep($value / 10);
    say $value;
  }
}
