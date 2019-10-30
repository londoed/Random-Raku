###########################################
############### USER SEARCH ###############
###########################################

use v6.d;
use Cro::LDAP::Client;

my $client = await Cro::LDAP::Client.connect('ldap://ldap.forumsys.com');
my $bind = await $client.bind(name => 'cn=read-only-admin,dc=example,dc=com', password => 'password');

die($bind.error-message if $bind.result-code);

my $resp = $client.search(:dn<dc-example,dc=com>, base => "ou=mathematicians", filter => '(&(uid=gauss))');

react {
  whenever $resp -> $entry {
    for $entry.attributes.kv -> $k, $v {
      my $value_str = $v ~~ Blob ?? $v.decode !! $v.map(*.decode);
      note("$k -> $value_str");
    }
  }
}
