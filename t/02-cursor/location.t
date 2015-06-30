#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/main.cpp');
my $cursr = $tunit -> cursor;
my $cursors = $cursr -> children;

my @locations = map { join ' ', $_ -> location } @$cursors;
my @expected     = (
	't/fragments/person.h 4 7 13 2',
	't/fragments/main.cpp 3 5 5 2'
);
is_deeply(\@locations, \@expected);

done_testing;
