#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use Clang;

sub filhos{
	my ($children) = @_;

	my @childre = @{$children};

	foreach my $child(@childre){
		if(!$child->is_system_header){
            print "    ",$child -> spelling, ' ', $child-> kind -> spelling;
			print "\n";
        }
        filhos($child-> children);
    }
}

sub metodo{
	my ($children) = @_;

	my @childre = @{$children};

	foreach my $child(@childre){
		if(!$child->is_system_header){
			#print $child -> spelling, ' ', $child-> kind -> spelling;
			#print "\n";
		}
        if($child-> kind-> spelling eq "CallExpr" && !$child->is_system_header){
            my $referenced = $child->get_cursor_referenced();
            if (!($referenced-> is_system_header)){
	            print "Oi\n";
	            print $child-> spelling, " System header: ",$child-> is_system_header, "\n";
	            print "referencia = ", $referenced->spelling, "\n";
	            print "kind = ", $referenced->kind->spelling, "\n";
            }
            #filhos($child-> children);
        }
		metodo($child-> children);
	}

}

my $index = Clang::Index -> new (0);
my $tunit = $index->parse('sum.cpp');
my $cursr = $tunit -> cursor;

metodo($cursr -> children);
