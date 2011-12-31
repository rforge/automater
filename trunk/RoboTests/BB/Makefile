# these set dependencies in the default Makefile:
# $(SITE_PKGS:%=$(RPATH)/site-library/%)

#SITE_PKGS=RMySQL DBI
PKG=BB

WGET_RFORGE="https://r-forge.r-project.org/src/contrib/$(PKG)_2011.12-2.tar.gz"

VPATH=FLAGS/

tests: gettests $(TESTS:%=%out)

testz: 
	echo $(TESTS)

include ../Makevars

include ../Makerules

gettests: FLAGS/$(PKG)
	cp FLAGS/$(PKG)/tests/*.[Rr]  ./
	touch FLAGS/gettests

FLAGS/$(PKG): FLAGS/$(PKG).tar
	(cd FLAGS ; tar xf $(PKG).tar )
	 touch FLAGS/$(PKG)

FLAGS/$(PKG).tar: FLAGS/$(PKG).tar.gz
	gunzip -c FLAGS/$(PKG).tar.gz >$@

FLAGS/$(PKG).tar.gz:
	$(MKDIR) FLAGS
	(cd FLAGS ; wget --timestamping "$(WGET_RFORGE)" )
	@# the version number complicates things
	(cd FLAGS ; mv  $(PKG)*.tar.gz  $(PKG).tar.gz )

