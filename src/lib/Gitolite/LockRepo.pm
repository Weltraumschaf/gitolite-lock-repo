package Gitolite::LockRepo;

# Common functions for lock-repo command and update hook.
# Everything below assumes we have already chdir'd to "$repo.git".
# -------------------------------------------------------

#<<<
@EXPORT = qw(
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
    if ( -f LOCK_FILE ) {
        our %lock;

        my $t = slurp(LOCK_FILE);
        eval $t;    ## no critic
        _die "Do '" . LOCK_FILE . "' failed with '$@', contact your administrator!"
          if $@;

        return %lock;
    }

    return ();
}

sub put_lock {
    my %lock = @_;

    use Data::Dumper;
    $Data::Dumper::Indent   = 1;
    $Data::Dumper::Sortkeys = 1;

    my $dumped_data = Data::Dumper->Dump( [ \%lock ], [qw(*lock)] );
    _print( LOCK_FILE, $dumped_data );

    return;
}

1;
