package Clang::Cursor;

use strict;
use warnings;

=head1 NAME

Clang::Cursor - Clang cursor class

=head1 DESCRIPTION

A C<Clang::Cursor> represents an element in the abstract syntax tree of a
translation unit.

=head1 METHODS

=head2 kind( )

Retrieve the L<Clang::CursorKind> of the given cursor.

=head2 type( )

Retrieve the L<Clang::Type> of the entity referenced by the given cursor.

=head2 spelling( )

Retrieve the name for the entity referenced by the given cursor.

=head2 displayname( )

Return the display name for the entity referenced by the given cursor.

=head2 children( )

Retrieve a list of the children of the given cursor. The children are
C<Clang::Cursor> objects too.

=head2 location( )

Retrieve the location of the given cursor. This function returns three values,
a string containing the source file name, an integer containing the line number
and another integer containing the column number.

=head2 get_access_specifier( )

Retrieve the access of the given cursor. This function returns a string with
the name of the access: invalid, public, protected and private. The C functions
will return invalid for this function.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2012 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Clang::Cursor
