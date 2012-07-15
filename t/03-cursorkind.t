#!perl -T

use Test::More;

use Clang::Index;

my $index = Clang::Index -> new(1);
my $tunit = $index -> parse('test.c');
my $kind  = $tunit -> cursor -> kind;

is($kind -> spelling, 'TranslationUnit');

done_testing;

