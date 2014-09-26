#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
BEGIN { $ENV{LOCKREPO_LIBDIR} = "${FindBin::RealBin}/../src/lib"; }

use lib $ENV{GL_LIBDIR};
use lib $ENV{LOCKREPO_LIBDIR};

use Test::More;
use File::Temp qw/ tempfile tempdir /;
use Gitolite::LockRepo;

my($fh, $filename) = tempfile();

#print "fh: ${fh}\n";
#print "filename: ${filename}\n";

ok(1 == 1);

done_testing();
