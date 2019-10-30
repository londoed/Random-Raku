####################################
############### HTTP ###############
####################################

use Cro::HTTP::Router;
use Cro::HTTP::Server;

my $application = route {
  get -> 'greet', $name {
    content('text/plain', "Hello, $name!");
  }
}

my Cro::Service $hello = Cro::HTTP::Server.new(:host<location>, :port<10000>, :$application);
$hello.start;
react whenver signal(SIGINT) {
  $hello.stop;
  exit;
}

##########################################
############### WEBSOCKETS ###############
##########################################

my Supplier $chat .= new;

get -> 'chat' {
  web-socket -> $incoming {
    supply {
      whenever $incoming -> $message {
        $chat.emit(await $message.body-text);
      }
      whenever $chat -> $text {
        emit($text);
      }
    }
  }
}
