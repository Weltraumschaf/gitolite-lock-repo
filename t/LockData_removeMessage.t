#!/usr/bin/perl

use strict;
use warnings;

use FindBin qw( $RealBin );
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${RealBin}/../src/lib"; }
use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = setMessage('message', ());
is( hasMessage(%myData), 1, 'Message set.');

%myData = removeMessage(%myData);
is( hasMessage(%myData), 0, 'Message removed.');

done_testing();