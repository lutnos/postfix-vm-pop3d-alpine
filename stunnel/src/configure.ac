dnl Process this file with autoconf to produce a configure script.
AC_INIT
AC_CONFIG_SRCDIR([execwait.c])
AC_CANONICAL_TARGET

dnl Checks for programs.
AC_PROG_CC
AC_PROG_INSTALL

dnl Check for extra defines
case "$target_os" in
    *solaris*)
	CFLAGS="$CFLAGS -D__EXTENSIONS__"
    ;;
    *)
	CFLAGS="-ansi $CFLAGS"
    ;;
esac

dnl Checks for header files.
AC_HEADER_SYS_WAIT
AC_CHECK_HEADERS([sys/types.h sys/wait.h])
AC_CHECK_HEADERS([unistd.h])

AC_CHECK_DECL(UINT16_MAX,[],[AC_DEFINE(UINT16_MAX, [65535], [Define this if system not provide it for us])],[])

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_STRUCT_TM
AC_TYPE_SIZE_T
AC_TYPE_UID_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_REALLOC

dnl Checks for library functions.
AC_CHECK_FUNCS([execl fork perror waitpid])

dnl AC_SUBST(LIBOBJS)

AC_ARG_ENABLE(debug,
[  --enable-debug             enable debugging messages and logging.],
[
AC_MSG_RESULT(debugging enabled)
AC_DEFINE(DEBUG, [], [Enable debugging support])
CFLAGS="$CFLAGS -g"
],)

AC_SUBST(EXTRA_CFLAGS)
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
