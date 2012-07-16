package Clang;

use strict;
use warnings;

require XSLoader;
XSLoader::load('Clang', $Clang::VERSION);

=head1 NAME

Clang - Perl bindings to the Clang compiler's programming interface

=head1 SYNOPSIS

    use Clang;

    my $index = Clang::Index -> new(1);

    my $tunit = $index -> parse('file.c');
    my @cursors = $tunit -> cursor -> children;

    foreach my $cursor (@cursors) {
        say $cursor -> spelling;
        say $cursor -> kind -> spelling;
    }

=head1 DESCRIPTION

Clang is a compiler front end for the C, C++, Objective-C, and Objective-C++
programming languages which uses LLVM as its back end.

B<Clang::Index> provides Perl bindings to the Clang indexing interface, used
for extracting high-level symbol information from source files without exposing
the full Clang C++ API.

B<Attention>: note that this module is still under development and currently
lacks most of the functionality needed to make it useful.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Clang
