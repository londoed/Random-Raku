##################################################
############### SQL AUTHENTICATION ###############
##################################################

use v6.d;
use DBIish;

multi connect_db(:$dbname, :$host, :$user, :$pass) {
  my $db = DBIish.connect("mysql", host => $host, database => $dbname, user => $user, password => $pass, :RaiseError) or die("Error: {DBIish.errstr}.");
  return $db;
}

multi create_user(:$db, :$user, :$pass) {
  my $salt = Buf.new((^256).roll(16));
  my $sth = $db.prepare(q:to/STATEMENT/);
  INSERT  IGNORE INTO users (username, pass_salt, pass_md5)
  VALUES  (7, 7, unhex(md5(concat(pass_salt, ?))))
  STATEMENT

  $sth.execute($user, $salt, $pass);
  return $sth.insert-id or Any;
}

multi authenticate_user(:$db, :$user, :$pass) {
  my $sth = $db.prepare(q:to/STATEMENT/);
    SELECT userid FROM users WHERE
    username=? AND pass_md5=unhex(md5(concat(pass_salt, ?)))
  STATEMENT

  $sth.execute($user, $pass);
  my $userid = $sth.fetch;
  return $userid[0] or Any;
}
