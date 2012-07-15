package Clang;

use strict;
use warnings;

require XSLoader;
XSLoader::load('Clang', $Clang::VERSION);

=head1 NAME

Clang - Perl bindings to the Clang library

=head1 DESCRIPTION

Clang is a compiler front end for the C, C++, Objective-C, and Objective-C++
programming languages which uses LLVM as its back end.

This distributions provides Perl bindindings for the libclang library, which
exposes Clang's functionality through a C/C++ API.

=over 4

=item * L<Clang::Index> - Perl bindings to the Clang Index interface

=back

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
