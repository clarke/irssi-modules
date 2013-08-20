use Irssi;
use strict;

use vars qw($VERSION %IRSSI);

$VERSION="0.0.1";
%IRSSI = (
	authors     => 'Clarke Retzer',
	contact     => 'clarkeretzer@gmail.com',
	name        => 'adios',
	description => 'Set away with a message and change the nick to zz_<nick>',
	license     => 'GPL v2',
);

# USAGE: /ADIOS <away message>
# If an away message is passed, you will be marked as away. Otherwise,
# you will be marked as not away.
sub cmd_adios {
    # data - contains the parameters for /HELLO
    # server - the active server in window
    # witem - the active window item (eg. channel, query)
    #         or undef if the window is empty
    my ($data, $server, $witem) = @_;

    if (!$server || !$server->{connected}) {
      Irssi::print("Not connected to server");
      return;
    }

    $server->{nick} =~ /^zz_(.*)$/;

    if ($data) {
      # Set as away
      $server->command("AWAY $data");

      # Change the nick to zz_ if it doesn't already have it
      unless ($1) {
        $server->command("NICK zz_" . $server->{nick});
      }
    } else {
      # If the nick starts with zz_, change back to the original nick
      if ($1) {
        $server->command("NICK " . $1);
      }

      # Mark as not away
      $server->command("AWAY");
    }
}


Irssi::command_bind('adios', 'cmd_adios');
