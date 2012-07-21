MODULE = Clang				PACKAGE = Clang::TUnit

Cursor
cursor(self)
	TUnit self

	CODE:
		Cursor retval = malloc(sizeof(CXCursor));
		CXCursor cursor = clang_getTranslationUnitCursor(self);
		*retval = cursor;
		RETVAL = retval;

	OUTPUT:
		RETVAL

SV *
spelling(self)
	TUnit self

	CODE:
		CXString spelling = clang_getTranslationUnitSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL

void
DESTROY(self)
	TUnit self

	CODE:
		clang_disposeTranslationUnit(self);
