#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/test.c');
my $cursr = $tunit -> cursor;

is($cursr -> spelling, 't/test.c');
is($cursr -> displayname, 't/test.c');

done_testing;
