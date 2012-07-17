MODULE = Clang				PACKAGE = Clang::Type

CXCursor *
declaration(self)
	CXType *self

	CODE:
		CXCursor *retval = malloc(sizeof(CXCursor));
		CXCursor cursor  = clang_getTypeDeclaration(*self);
		*retval = cursor;

		RETVAL = retval;

	OUTPUT:
		RETVAL

enum CXTypeKind
kind(self)
	CXType *self

	CODE:
		RETVAL = self -> kind;
	
	OUTPUT:
		RETVAL

SV *
is_const(self)
	CXType *self

	CODE:
		RETVAL = clang_isConstQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_volatile(self)
	CXType *self

	CODE:
		RETVAL = clang_isVolatileQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

SV *
is_restrict(self)
	CXType *self

	CODE:
		RETVAL = clang_isRestrictQualifiedType(*self) ?
			&PL_sv_yes : &PL_sv_no;

	OUTPUT:
		RETVAL

void
DESTROY(self)
	CXType *self

	CODE:
		free(self);
