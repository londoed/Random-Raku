####################################################
############### FINITE STATE MACHINE ###############
####################################################

class StateMachine {
  class State {...}
  class Transition {...}

  has State %!state;
  has &.choose_transition is rw;

  method add_state(Str $id, &action) {
    %!state{$id} = State.new(:$id, :&action);
  }

  multi method add_transition(Str $from, Str $to) {
    %!state{$from}.implicit-next = %!state{$to};
  }

  multi method add_transition(Str $from, $id, Str $to) {
    %!state{$from}.explicit-next.push: Transition.new(:$id, to => %!state{$to});
  }

  method run(Str $initial_state) {
    my $state = %!state{$initial_state};

    loop {
      $state.action.();
      if $state.implicit-next -> $_ {
        $state = $_;
      } elsif $state.explicit-next -> $_ {
        $state = &.choose_transition.(|$_).to;
      } else {
        last;
      }
    }

  class Transition {
    has $.id;
    has State $.to;
  }

  class State {
    has $.id;
    has &.action;
    has State $.implicit-next is rw;
    has Transition @.explicit-next;
  }
}

my StateMachine $machine .= new;

$machine.choose_transition = sub (*@transitions) {
  say "[{.key + 1}] {.value.id}" for @transitions.pairs;

  loop {
    my $n = val get;
    return @transitions[$n - 1] if n ~~ Int && $n ~~ 1..@transitions;
    say "Invalid input: try again...";
  }
}

$machine.add_state("ready",     { say "Please deposit coins.";                     });
$machine.add_state("waiting",   { say "Please select a product.";                  });
$machine.add_state("dispense",  { sleep 2; say "Please remove product from tray."; });
$machine.add_state("refunding", { sleep 1; say "Refunding money...";               });
$machine.add_state("exit",      { say "Shutting down...";                          });

$machine.add_transition("ready",     "quit",    "exit");
$machine.add_transition("ready",     "deposit", "waiting");
$machine.add_transition("waiting",   "select",  "dispense");
$machine.add_transition("waiting",   "refund",  "refunding");
$machine.add_transition("dispense",  "remove",  "ready");
$machine.add_transition("refunding",            "ready");

$machine.run("ready");
