use strict;
use warnings;

use Test::More;
use Test::Command::Simple;

my $CMD = 'otfinfo';

my $CFF = '/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf';
my $TTF = '/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf';

run_ok $CMD, qw/--version/;
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
is length stderr, 0, 'No stderr';

run_ok $CMD, qw/--help/;
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--scripts/, $CFF;
like stdout, qr/^grek\t+Greek$/m, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--features/, $CFF;
like stdout, qr/^hist\t+Historical Forms$/m, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--tables/, $CFF;
like stdout, qr/^\s*\d+ CFF$/m, 'Has CFF table';
unlike stdout, qr/^\s*\d+ glyf$/m, 'Had no glyf table';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--tables/, $TTF;
unlike stdout, qr/^\s*\d+ CFF$/m, 'Has no CFF table';
like stdout, qr/^\s*\d+ glyf$/m, 'Had glyf table';
cmp_ok stderr, 'eq', '', 'Testing stderr';

done_testing;
