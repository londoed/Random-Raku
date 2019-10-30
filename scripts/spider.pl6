##########################################
############### WEB SPIDER ###############
##########################################

use v6.d;
use LWP::Simple;

my $domain = "https://google.com";
say "Crawling $domain";
my $page = LWP::Simple.get($domain);
my @urls = extract_links($domain, $page);
my @promises;

for @urls -> $url {
  push @promises start {
    &crawl($url);
  };
}

my $finished = Promise.allof(@promises);
await $finished;

for @promises -> $p {
  my @urls = extract_links($domain, $p.result);
  say @urls;
  say "------------";
}

say "Done!";
