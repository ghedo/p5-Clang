#!perl -T

use Test::More;

use Clang;
use strict;
use warnings;

my $index = Clang::Index -> new(0);
my $tunit = $index -> parse('t/header/test_system_header.cpp');
my $cursr = $tunit -> cursor;
my $check_system_header = 0;

_visit_node($cursr -> children);

sub _visit_node {
    my ($node) = @_;
    my @children = @{$node};
    foreach my $child(@children) {
        if($child->is_system_header and $child->spelling eq "sqrt"){
            $check_system_header = 1;
        }
     _visit_node($child->children);
    }
}
is($check_system_header,1);
done_testing;
