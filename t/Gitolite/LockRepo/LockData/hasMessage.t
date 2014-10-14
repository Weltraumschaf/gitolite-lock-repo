#!/usr/bin/perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

my %myData = ();
is( hasMessage(%myData), 0, 'Empty hash.');

%myData = setMessage('message', %myData);
is( hasMessage(%myData), 1, 'Message set.');

done_testing();
