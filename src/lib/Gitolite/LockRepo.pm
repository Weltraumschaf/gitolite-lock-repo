package Gitolite::LockRepo;

# Common functions for lock-repo command and update hook.
# -------------------------------------------------------

#<<<
@EXPORT = qw(
    LOCK_FILE
    get_lock
    put_lock
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

sub get_lock {
    my ($filename) = @_;

    if ( -f $filename ) {
        our %lock;

        my $t = slurp($filename);
        eval $t;    ## no critic
        _die "Do '${filename}' failed with '$@', contact your administrator!" if $@;

        return %lock;
    }

    return ();
}

sub put_lock {
    #my %lock = @_;
    my %lock = ();
    $lock{USER}    = 'user';
    $lock{TIME}    = time;
    $lock{MESSAGE} = 'message';

    use Data::Dumper;
    $Data::Dumper::Indent   = 1;
    $Data::Dumper::Sortkeys = 1;

    my $dumped_data = Data::Dumper->Dump( [ \%lock ], [qw(*lock)] );
    _print( LOCK_FILE, $dumped_data );

    return;
}

1;
