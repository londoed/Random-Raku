#!/usr/bin/env perl6

############################################
############### KILL PROCESS ###############
############################################

my $max_time = 300;
my $ps_list = "ps h -eo cputime, pcpu, pid, user, cmd";

my @list = $ps_list.split(/\n/);

for @list -> $p {
  my @process = $p.split;
  @process[0] ~~ /(\d+):(\d+):(\d+)/;
  my $cpu_time = $0 * 3_600 + $1 * 60 + $2;
  next if $cpu_time < $max_time;
  next if @process[3] eq "root" || @process[3] eq "postfix";
  next if @process[4] eq "kdeinit";

  try {
    my $choice = prompt("[*] Would you like to kill: {@process[4]} [Y/n]? ");
    if $choice.lc eq "y" {
      Process.kill(:TERM, @process[2]);
    }
  } CATCH {
    die("[-] Couldn't kill the process...check permissions");
  }
}
