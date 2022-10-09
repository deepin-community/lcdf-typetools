use strict;
use warnings;

use Test::More;
use Test::Command::Simple;

my $CMD = 'mmafm';

run_ok $CMD, qw/--version/;
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
is length stderr, 0, 'No stderr';

run_ok $CMD, qw/--help/;
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

done_testing;
