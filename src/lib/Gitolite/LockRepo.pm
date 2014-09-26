package Gitolite::LockRepo;

use strict;
use warnings;

# Common functions for lock-repo command and update hook.
# -------------------------------------------------------

#<<<
@EXPORT = qw(
    f_lock
    f_unlock
    f_exterminate
    f_status
);
#>>>
use Exporter 'import';

# ----------------------------------------------------------------
# everything below assumes we have already chdir'd to "$repo.git".

sub f_lock {
    my ( $repo, $message ) = @_;

    my %lock = get_lock();

    if ( $lock{USER} ) {
        _die "Repo '$repo' locked by '$lock{USER}' since " . localtime( $lock{TIME} ) . " with message: $lock{MESSAGE}";
    }

    $lock{USER}    = $ENV{GL_USER};
    $lock{TIME}    = time;
    $lock{MESSAGE} = $message;
    put_lock(%lock);
    say "Repo locked for '$ENV{GL_USER}'.";

    return;
}

sub f_unlock {
    my ($repo) = @_;

    my %lock = get_lock();

    _die "Repo '$repo' was not locked!" unless $lock{USER};

    if ( $lock{USER} ne $ENV{GL_USER} ) {
        _die "Repo '${repo}' not locked by '$ENV{GL_USER}' but by '$lock{USER}'!";
    }

    delete $lock{USER};
    delete $lock{TIME};
    delete $lock{MESSAGE};
    put_lock(%lock);
    say "Repo unlocked.";

    return;
}

sub f_exterminate {
    my ( $repo, $message ) = @_;

    my %lock = get_lock();

    _die "Repo '$repo' was not locked!" unless $lock{USER};

    my $user = $lock{USER};
    my $now  = localtime(time);
    my $time = -1;

    if ( defined( $lock{TIME} ) ) {
        $time = localtime( $lock{TIME} );
    }

    push @{ $lock{EXTERMINATES} }, "${now} $ENV{GL_USER} broke lock: ${user} ${time} with: ${message}";
    delete $lock{USER};
    delete $lock{TIME};
    delete $lock{MESSAGE};
    put_lock(%lock);
    say "Repo lock from '$user' broken.";

    return;
}

sub f_status {
    my ($repo) = @_;

    my %lock = get_lock();

    if ( $lock{USER} ) {
        my $time = -1;

        if ( defined( $lock{TIME} ) ) {
            $time = localtime( $lock{TIME} );
        }

        my $mesage = "";

        if ( defined( $lock{MESSAGE} ) ) {
            $mesage = $lock{MESSAGE};
        }

        say "Repository locked by '$lock{USER}' since ${time} with message: ${mesage} ";
    } else {
        say "Repo '${repo}' is not locked.";
    }

    return;
}

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
