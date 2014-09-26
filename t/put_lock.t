#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${FindBin::RealBin}/../src/lib"; }

use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
#use Gitolite::LockRepo;

ok(1 == 1);

done_testing();
