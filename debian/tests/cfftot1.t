use strict;
use warnings;

use Test::More;
use Test::Command::Simple;
use Test::TempDir::Tiny;

my $CMD = 'cfftot1';
my $dir;

my $CFF = '/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf';
my $TTF = '/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf';

run_ok $CMD, '--version';
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
is length stderr, 0, 'No stderr';

run_ok $CMD, '--help';
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

$dir = tempdir('CFF');
run_ok $CMD, '--output', "$dir/font", $CFF;
cmp_ok stderr, 'eq', '', 'Testing stderr';
is -f "$dir/font", 1, 'Font file created';

$dir = tempdir('TTF');
run_ok 1, $CMD, '--output', "$dir/font", $TTF;
cmp_ok stderr, 'eq', "cfftot1: /usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf: not a CFF or OpenType/CFF font\n", 'Testing stderr';
is -f "$dir/font", undef, 'Font file not created';

$dir = tempdir('wrong');
run_ok 1, $CMD, qw/--name FooBar --output/, "$dir/font", $CFF;
cmp_ok stderr, 'eq', "cfftot1: While processing /usr/share/fonts/opentype/artemisia/GFSArtemisia.otf:\ncfftot1: font 'FooBar' not found\n", 'Testing stderr';
is -f "$dir/font", undef, 'Font file created';

done_testing;
