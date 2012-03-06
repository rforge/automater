#source of tests:
PKG=EvalEst

# The directory UpdateTests does not need to exist, but if it does then the
# Makefile in the directory default should get the *.R files for tests and put 
# them in the parent directory. 

#  Beware, putting files in the parent dir is a bit unusual!

# Also, if it puts a DESCRIPTION file in the parent directory then that file
# will be used to set $(DESC_DEPENDS) and $(DESC_SUGGESTS), which are not used
# directly, but can be used in $(PKG)/Makevars.in to set DEPENDS_PKGS

VPATH=FLAGS/

include    ../Makevars.in
include ../../Makevars

default: update

include ../../Makerules

update: FLAGS/$(PKG)
	cp FLAGS/$(PKG)/tests/*.[Rr]  ../
	cp FLAGS/$(PKG)/DESCRIPTION   ../
	touch FLAGS/update
