use strict;
use warnings;

use Test::More;
use Test::Command::Simple;
use Test::TempDir::Tiny;

my $CMD = 'ttftotype42';
my $dir;

my $CFF = '/usr/share/fonts/opentype/artemisia/GFSArtemisia.otf';
my $TTF = '/usr/share/fonts/truetype/font-awesome/fontawesome-webfont.ttf';

run_ok $CMD, qw/--version/;
like stdout, qr/$CMD \(LCDF typetools\) [0-9.]+/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

run_ok $CMD, qw/--help/;
like stdout, qr/Usage: $CMD/, 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';

$dir = tempdir('CFF');
run_ok 1, $CMD, '--output', "$dir/font", $CFF;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', "ttftotype42: /usr/share/fonts/opentype/artemisia/GFSArtemisia.otf: CFF-flavored OpenType font not suitable for Type 42\n", 'Testing stderr';
is -f "$dir/font", undef, 'Font file not created';

$dir = tempdir('TTF');
run_ok $CMD, '--output', "$dir/font", $TTF;
cmp_ok stdout, 'eq', '', 'Testing stdout';
cmp_ok stderr, 'eq', '', 'Testing stderr';
is -f "$dir/font", 1, 'Font file created';

done_testing;
