MODULE = Clang				PACKAGE = Clang::TUnit

CXCursor *
cursor(self)
	CXTranslationUnit self

	CODE:
		CXCursor *retval = malloc(sizeof(CXCursor));
		CXCursor cursor = clang_getTranslationUnitCursor(self);
		*retval = cursor;
		RETVAL = retval;

	OUTPUT:
		RETVAL

SV *
spelling(self)
	CXTranslationUnit self

	CODE:
		CXString spelling = clang_getTranslationUnitSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL

void
DESTROY(self)
	CXTranslationUnit self

	CODE:
		clang_disposeTranslationUnit(self);
