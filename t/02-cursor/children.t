#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/test.c');
my $cursr = $tunit -> cursor;

my $cursors = $cursr -> children;

my @spellings = map { $_ -> spelling } @$cursors;
my @expected  = qw(
	foo
	main
);

is_deeply(\@spellings, \@expected);

done_testing;
