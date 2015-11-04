#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/fragments/person.cpp');
my $cursr = $tunit -> cursor;

my $check_usr = 'c:@S@Person@F@walk#I#f#';

_visit_node_usr($cursr);

sub _visit_node_usr {
	my $node = shift;
	if($node->spelling eq 'walk'){
		my $usr_name = $node->USR;
		is($usr_name, $check_usr);
	}
	my $children = $node->children;
	foreach my $child(@$children) {
		_visit_node_usr($child);
	}
}

done_testing;
