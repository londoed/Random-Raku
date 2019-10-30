#!/usr/bin/env perl6

###############################################
############### DATA ENCRYPTION ###############
###############################################

use v6.d;
use OpenSSL::CryptTools;

our $block_size;

class Mode {
  has $.type;
}

sub pad($s) {
  my $b = Buf.new("\0");
  return $s + $b * ($block_size - $s.chars % $block_size);
}

sub _encrypt($msg, $key) {
  $msg = pad($msg);
  my $iv = ('0' x 16).encode;
  my $cipher = encrypt($msg, :aes356, :$iv, :$key);
  return $cipher;
}

sub _decrypt($msg, $key) {
  my $iv = $msg[..$block_size];
  my $cipher = decrypt($msg, :aes256, :$iv, :$key);
  return $cipher.decode;
}

sub encrypt_file($file, $key) {
  my $data = slurp($file, :r);
  say "Encrypting $file...";
  my $e = _encrypt($data, $key);
  spurt($file, $e);
}

sub encrypt_dir($dir, $key) {
  for $dir.dir -> $file {
    if $file.IO.f {
      encrypt_file($file, $key);
    } elsif $file.IO.d {
      encrypt_dir($file, $key)
    }
  }
}

sub decrypt_file($file, $key) {
  my $data = slurp($file, :r);
  say "Decrypting $file...";
  my $d = _decrypt($data, $key);
  spurt($file, $d);
}

sub decrypt_dir($dir, $key) {
  for $dir.dir -> $file {
    if $file.IO.f {
      decrypt_file($file, $key);
    } elsif $file.IO.d {
      decrypt_dir($file, $key);
    }
  }
}

sub generate_random_key($file) {
  my $key = 99999999999999999999999999999999.rand.Int;
  say "Saving key to $file...";
  spurt($file, $key);
  return $key;
}

sub get_key($file) {
  my $key = slurp($file, :r);
  return $key if $key.elems == 32;
  return Nil;
}

sub usage() {
  say("\n  Usage: " + @*ARGV[0] + " <options> <files or directories>\n");
  say("  Options:\n"
      "\t-k, --key    <file> : file which contains the 256 bits secret key\n"
      "\t-o, --out    <file> : if no key file is specified for encryption\n"
      "\t                      a 256 bits key will be auto-generated\n"
      "\t                      and written in this new file\n"
      "\t-e, --encrypt       : encrypt files\n"
      "\t-d, --decrypt       : decrypt files\n");
}

sub _run(@files, $mode, $key) {
  for @files -> $i {
    if $i.IO.f {
      if $mode.type == "ENCRYPT" {
        encrypt_file($i, $key);
      } elsif $mode.type == "DECRYPT" {
        decrypt_file($i, $key);
      }
    } elsif $i.IO.d {
      if $mode.type == "ENCRYPT" {
        encrypt_dir($i, $key);
      } elsif $mode.type == "DECRYPT" {
        decrypt_dir($i, $key);
      }
    }
  }
}

sub MAIN(@opts, @args) {
  my $key;
  my $gen;
  my $mode;
  my @files;

  $mode.type == "UNDEFINED";

  for @opts -> $opt, $arg {
    if $opt ~~ "-h" || "-help" {
      exit();
    } elsif $opt ~~ "-k" || "--key" {
      if $gen ~~ Nil {
        exit();
      }
      $key = get_key($arg);
    } elsif $opt ~~ "-o" || "--out" {
      if !$key ~~ Nil {
        exit();
      }
      $gen = $arg;
    } elsif $opt ~~ "-e" || "--encrypt" {
      if $mode.type != "UNDEFINED" {
        exit();
      }
      $mode.type = "ENCRYPT";
    } elsif $opt ~~ "-d" || "-decrypt" {
      if $mode.type != "UNDEFINED" {
        exit();
      }
      $mode.type = "DECRYPT";
    }
  }

  for @args -> $arg {
    @files.push($arg);
  }

  if $mode.type == "ENCRYPT" && $key ~~ Nil && !$gen ~~ Nil {
    $key = generate_random_key($gen);
  }

  if @files.elems < 1 || $mode.type == "UNDEFINED" || $key ~~ Nil {
    exit();
  }

  _run(@files, $mode, $key);
}
