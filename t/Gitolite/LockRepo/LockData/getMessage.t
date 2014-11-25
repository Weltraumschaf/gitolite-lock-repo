#!/usr/bin/env perl

use strict;
use warnings;

use lib $ENV{GL_LIBDIR};

use Test::More;
use Gitolite::LockRepo::LockData;

is( getMessage(()), '', 'Empty string expected for undef hash.');

my %myData = setMessage('message', ());
is( getMessage(%myData), 'message', 'Message expected.');

done_testing();
