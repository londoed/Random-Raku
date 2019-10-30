##########################################
############### SEND EMAIL ###############
##########################################

use Email::Simple;

sub send_email(Str $to, Str $from, Str $subject, Str $body, Str $smtp_server, Int $smtp_port) {

  my $email = Email::Simple.create(:header[["To", $to], ["From", $from], ["Subject", $subject]], :body($body));

  say ~$email;

  await IO::Socket::Async.connect($smtp_server, $smtp_port).then(
    -> $smtp {
      if $smtp.status {
        given $smtp.result {
          react {
            whenever .Supply() -> $response {
              if $response ~~ /^220/ {
                .print(join("\r\n"),
                "EHLO $smtp_server",
                "MAIL FROM:<{$email.from}>",
                "RCPT TO<{$email.to}>",
                "DATA", $email.body,
                '-', '');
              } elsif $response ~~ /^250/ {
                .print("QUIT\r\n");
                done;
              } else {
                say "Send email failed with: $response";
                done;
              }
            }
            .close;
          }
        }
      }
    }
  )
}

my $to = "mail@example.com";
my $from = "londoed@comcast.net";
my $subject = "Spoof email";
my $body = "This is a spoofed email from RAKU";
my $smtp_server = "smtp.example.com";
my $smtp_port = 25;

send_email($to, $from, $subject, $body, $smtp_server, $smtp_port);
