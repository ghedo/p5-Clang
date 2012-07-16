#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/test.c');
my $kind  = $tunit -> cursor -> kind;

is($kind -> spelling, 'TranslationUnit');

done_testing;
