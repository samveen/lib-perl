package in::Samveen::Logger;

use strict;
use warnings;
use POSIX qw(strftime);

use vars qw(@ISA @EXPORT);

require Exporter;
@ISA = qw(Exporter);

@EXPORT = qw(
logger
set_log_level

ERROR
INFO
DEBUG
);

# definitions for logging system
my @LOG_LEVEL_NAMES= qw(ERROR INFO DEBUG);

sub ERROR {0}
sub INFO  {1}
sub DEBUG {2}

# Variable to maintain log level
my $LOG_LEVEL = INFO;

# function to set log level. can be called multiple times.
sub set_log_level($){
    my ($log_level) = @_;
    if (defined ($log_level)) {
        for(my $i=0;$i<scalar @LOG_LEVEL_NAMES;++$i) {
            $LOG_LEVEL = $i if ($log_level =~ /$LOG_LEVEL_NAMES[$i]/i);
        }
    }
}

# function to handle logging
sub logger ($$) {
    my ($type,$mesg) = @_;
    my $now_string = strftime "%a %b %e %H:%M:%S %Y", localtime;
    print "[$now_string] $0: $LOG_LEVEL_NAMES[$type] $mesg\n" if ($type<=$LOG_LEVEL);
}

1;
