#############################################
############### ACTIVE OBJECT ###############
#############################################

class Integrator {
  has $.f is rw = sub($t) { 0 };
  has $.now is rw;
  has $.value is rw = 0;
  has $.integrator is rw;

  method init() {
    self.value = &(self.f)(0);
    self.integrator = Thread.new(
      :code({
        loop {
          my $t1 = now;
          self.value += (&(self.f)(self.now) + &(self.f)($t1)) * ($t1 - self.now) / 2;
          self.now = $t1;
          sleep(0.001);
        }
      }),
      :app_lifetime(True);
    ).run;
  }

  method input(&f_of_t) {
    self.f = &f_of_t;
    self.now = now;
    self.init;
  }

  method output {
    return self.value;
  }
}

my Integrator $a .= new;
$a.input(sub ($t) { sin(2 * pi * 0.5 * $t) });

say "Initial value: {$a.output}";
sleep(2);

say "After 2 seconds: {$a.output}";
$a.input(sub ($t) { 0 });
sleep(0.5);

say "f(0): {$a.output}";
