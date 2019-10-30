#############################################
############### DOMAIN SPIDER ###############
#############################################

use HTML::Parser::XML;
use XML::Document;
use HTTP::UserAgent;

sub MAIN(:$domain="https://www.google.com") {
  my $ua = HTTP::UserAgent.new;
  my $url_seen;
  my @urls = ($domain);

  loop {
    my @promises;
    while @urls {
      my $url = @urls.shift;
      my $p = Promise.start({crawl($ua, $domain, $url)});
      @promises.push($p);
    }

    await Promise.allof(@promises);

    for @promises.kv -> $idx, $p {
      if $p.status ~~ Kept {
        my @results = $p.result;
        for @results {
          unless %url_seen{$_} {
            @urls.push($_);
            %url_seen($_)++;
          }
        }
      }
    }
    last if @urls.elems == 0;
  }
  say %url_seen.keys;
}

# Get page and identify url linked into it. Returns URLs.
sub crawl($ua, $domain, $url) {
  my $page = $ua.get($url);
  my $p = HTML::Parser::XML.new;
  my XML::Document $doc = $p.parse($page.content);

  # URLs to crawl
  my %todo;
  my @anchors = $doc.elements(LTAG<a>, :RECURSE);

  for @anchors -> $anchor {
    next unless $anchor.defined;
    my $href = $anchor.attribs<href>;

    # Convert relative to absolute URLs
    if $href.starts-with('/') || $href.starts-with('?') {
      $href = $domain - $href;
    }

    if $href.starts-with($domain) {
      %todo{$href}++;
    }
  }
  my @urls = %todo.keys;
  return @urls;
}
