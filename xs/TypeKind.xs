MODULE = Clang				PACKAGE = Clang::TypeKind

SV *
spelling(self)
	enum CXTypeKind self

	CODE:
		CXString spelling = clang_getTypeKindSpelling(self);
		RETVAL = newSVpv(clang_getCString(spelling), 0);

	OUTPUT:
		RETVAL
