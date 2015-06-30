#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/main.cpp');
my $cursr = $tunit -> cursor;

my $num_arguments = 0;
_visit_node_arguments($cursr);

sub _visit_node_arguments {
	my $node = shift;
	if($node->kind->spelling() eq "FunctionDecl"){
		$num_arguments = $node->num_arguments;
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node_arguments($child);
	}
}
is($num_arguments, 2);

done_testing;
