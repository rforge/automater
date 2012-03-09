# source of tests:
PKG=TSMySQL
PROJECT=tsdbi

# The directory UpdateTests does not need to exist, but if it does then the
# Makefile in the directory default should get the *.R files for tests and put 
# them in the parent directory. 

#  Beware, putting files in the parent dir is a bit unusual!

# Also, if it puts a DESCRIPTION file in the parent directory then that file
# will be used to set $(DESC_DEPENDS) and $(DESC_SUGGESTS), which are not used
# directly, but can be used in $(PKG)/Makevars.in to set DEPENDS_PKGS

VPATH=FLAGS/

#  ../ sometimes goes up real path not the link if this directory
#     is a soft link, so next works even it that case.
TSTPKG=${shell cd ../ ; pwd}
TST=${shell cd ../../ ; pwd}

-include    $(TSTPKG)/Makevars.in
include     $(TST)/Makevars

default: update

include $(TST)/Makerules

update: FLAGS/SVN/$(PKG)
	cp FLAGS/SVN/$(PKG)/tests/*.[Rr]  $(TSTPKG)
	cp FLAGS/SVN/$(PKG)/DESCRIPTION   $(TSTPKG)
	touch FLAGS/update
