#########################################################
############### GUI COMPONENT INTERACTION ###############
#########################################################

use GTK::Simple;
use GTK::Simple::App;

my GTK::Simple::App $app .= new(title => "GUI component iteraction");

$app.set-content {
  my $box = GTK::Simple::VBox.new(
    my $value = GTK::Simple::Entry.new(text => '0'),
    my $increment = GTK::Simple::Button.new(label => 'Increment');
    my $random = GTK::Simple::Button.new(label => 'Random');
  )
};

$app.size-request(400, 100);
$app.border-width = 20;
$box.spacing = 10;

$value.changed.tap: {
  (@value.text ||= '0') ~~ s:g/<-[0..9]>//;
}

$increment.clicked.tap: {
  my $val = $value.text; $val++; $value.text = $val.Str;
}

$random.clicked.tap: {
  if run <<zenity --question --text "Reset to random value?">> {
    $value.text = (^100).pick.Str;
  }
}

$app.run;
