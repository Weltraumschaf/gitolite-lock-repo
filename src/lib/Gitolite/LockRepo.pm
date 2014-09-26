package Gitolite::LockRepo;

# Common functions for lock-repo command and update hook.
# -------------------------------------------------------

#<<<
@EXPORT = qw(
    LOCK_FILE
    get_lock
    put_lock
    error
);
#>>>
use Exporter 'import';

use strict;
use warnings;

use Gitolite::Rc;
use Gitolite::Common;
use Gitolite::Conf::Load;

# ----------------------------------------------------------------------

use constant LOCK_FILE => "gl-lockrepo";          ## no critic

use constant CMD_LOCK        => 'lock';           ## no critic
use constant CMD_UNLOCK      => 'unlock';         ## no critic
use constant CMD_EXTERMINATE => 'exterminate';    ## no critic
use constant CMD_STATUS      => 'status';         ## no critic

sub get_lock {
    my ($filename) = @_;

    if ( -f $filename ) {
        our %lock = ();

        my $t = slurp($filename);
        eval $t;    ## no critic
        error("Read '${filename}' failed with '${@}', contact your administrator!") if $@;

        return %lock;
    }

    return ();
}

sub put_lock {
    my ($filename, %lock) = @_;

    use Data::Dumper;
    $Data::Dumper::Indent   = 1;
    $Data::Dumper::Sortkeys = 1;

    my $dumped_data = Data::Dumper->Dump( [ \%lock ], [qw(*lock)] );
    _print( $filename, $dumped_data );

    return;
}

sub error {
    my($message) = @_;
    _die($message);
}

1;
