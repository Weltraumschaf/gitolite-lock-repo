package Gitolite::LockRepo::LockData;

# Common functions for lock data.
# -------------------------------

#<<<
@EXPORT = qw(
    KEY_MESSAGE     KEY_TIME    KEY_USER    KEY_BRANCHES

    load            save
    hasGeneralLock  setGeneralLock  removeGeneralLock
    hasBranchLock   getBranchLock   setBranchLock   removeBranchLock

    hasMessage  getMessage  setMessage  removeMessage
    hasTime     getTime     setTime     removeTime
    hasUser     getUser     setUser     removeUser

    hasBranches
);
#>>>
use Exporter 'import';

use strict;
use warnings;

use constant KEY_MESSAGE        => 'MESSAGE';        ## no critic
use constant KEY_TIME           => 'TIME';           ## no critic
use constant KEY_USER           => 'USER';           ## no critic
use constant KEY_BRANCHES       => 'BRANCHES';       ## no critic

sub load {
    my ($filename) = @_;

    return {};
}

sub save {
    my ($filename, $data) = @_;

    return $data;
}

sub hasGeneralLock {
    my (%data) = @_;

    return 0 unless hasMessage( %data );
    return 0 unless hasTime( %data );
    return 0 unless hasUser( %data );

    return 1;
}

sub setGeneralLock {
    my ($user, $time, $message, %data) = @_;

    %data = setUser($user, %data);
    %data = setTime($time, %data);
    %data = setMessage($message, %data);

    return %data;
}

sub removeGeneralLock {
    my (%data) = @_;

    %data = removeUser(%data);
    %data = removeTime(%data);
    %data = removeMessage(%data);

    return %data;
}

sub hasBranchLock {
    my ($branchname, %data) = @_;

    return 0 unless hasBranches( %data );
    return 0 unless exists $data{KEY_BRANCHES}{$branchname};
    return 0;
}

sub setBranchLock {
    my ($branchname, $user, $time, $message, %data) = @_;

    my %branch = setUser($user, ());
    %branch = setTime($time, %branch);
    %branch = setMessage($message, %branch);
    $data{KEY_BRANCHES}{$branchname} = %branch;

    return %data;
}

sub removeBranchLock {
    my ($branchname, %data) = @_;

    delete $data{KEY_BRANCHES}{$branchname};

    return %data;
}

sub getBranchLock {
    my ($branchname, %data) = @_;

    if (exists $data{KEY_BRANCHES}{$branchname}) {
        return %{$data{KEY_BRANCHES}{$branchname}};
    }

    return ();
}

sub hasMessage {
    my (%data) = @_;
    return exists $data{KEY_MESSAGE};
}

sub getMessage {
    my (%data) = @_;

    if ( hasMessage(%data) ) {
        return $data{KEY_MESSAGE};
    }

    return '';
}

sub setMessage {
    my ($message, %data) = @_;

    $data{KEY_MESSAGE} = $message;

    return %data;
}

sub removeMessage {
    my (%data) = @_;

    delete $data{KEY_MESSAGE};

    return %data;
}

sub hasTime {
    my (%data) = @_;
    return exists $data{KEY_TIME};
}

sub getTime {
    my (%data) = @_;

    if ( hasTime(%data) ) {
        return $data{KEY_TIME};
    }

    return 0;
}

sub setTime {
    my ($time, %data) = @_;

    $data{KEY_TIME} = $time;

    return %data;
}

sub removeTime {
    my (%data) = @_;

    delete $data{KEY_TIME};

    return %data;
}

sub hasUser {
    my (%data) = @_;
    return exists $data{KEY_USER};
}

sub getUser {
    my (%data) = @_;

    if ( hasUser(%data) ) {
        return $data{KEY_USER};
    }

    return '';
}

sub setUser {
    my ($user, %data) = @_;

    $data{KEY_USER} = $user;

    return %data;
}

sub removeUser {
    my (%data) = @_;

    delete $data{KEY_USER};

    return %data;
}

sub hasBranches {
    my (%data) = @_;
    return exists $data{KEY_BRANCHES};
}

1;