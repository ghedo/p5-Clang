#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/test.c');
my $cursr = $tunit -> cursor;

#if there is spelling, there is kind
is($cursr -> kind -> spelling, 'TranslationUnit');

done_testing;
